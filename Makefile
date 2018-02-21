include .make/Makefile.inc

CLUSTER		?= cluster-6
NS			:= default
TIME		:= $(shell date +"%Y-%m-%d_%H%M%S")
MODULES		:=  k8-byexamples-elasticsearch-cluster 	\
				k8-byexamples-kibana 					\
				k8-byexamples-mysql 					\
				k8-byexamples-fluentd-collector			\
				k8-byexamples-monitoring-grafana 		\
				k8-byexamples-monitoring-prometheus
export

rollout:

	$(MAKE) -C modules/k8-byexamples-elasticsearch-cluster 	install
	$(MAKE) -C modules/k8-byexamples-kibana 				install
	$(MAKE) -C modules/k8-byexamples-mysql 					install
	$(MAKE) -C modules/k8-byexamples-fluentd-collector 		install
	$(MAKE) -C modules/k8-byexamples-monitoring-grafana 	install
	$(MAKE) -C modules/k8-byexamples-monitoring-prometheus 	install

test:

	$(MAKE) -C modules/k8-byexamples-elasticsearch-cluster 	test
	$(MAKE) -C modules/k8-byexamples-kibana 				test
	$(MAKE) -C modules/k8-byexamples-mysql 					test
	$(MAKE) -C modules/k8-byexamples-monitoring-grafana 	test
	$(MAKE) -C modules/k8-byexamples-monitoring-prometheus 	test


#
#
#

## Output list of submodules & repositories
dump: 

	@printf "$(YELLOW)\n%-46s%s\n\n$(BLUE)" "Submodule Name" "Submodule Repository" 
	@for F in $(MODULES); do	printf "%-45s@%s\n" $$F https://github.com/mateothegreat/$$F | sed -e 's/ /./g' -e 's/@/ /' -e 's/-/ /'; done
	@printf "\n"

setup/cluster:

	gcloud alpha container 	--project "streaming-platform-devqa" 	\
							clusters create "$(CLUSTER)"			\
							--zone "us-central1-a" 					\
							--username "admin" 						\
							--cluster-version "1.9.2-gke.1" 		\
							--machine-type "n1-standard-2" 			\
							--image-type "UBUNTU"					\
							--disk-size "100" 						\
							--scopes "https://www.googleapis.com/auth/dns","https://www.googleapis.com/auth/compute","https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
							--num-nodes "2" 						\
							--network "vpc-01-devqa" 				\`
							--enable-cloud-logging 					\
							--enable-cloud-monitoring 				\
							--cluster-ipv4-cidr "10.11.0.0/16" 		\
							--subnetwork "private-internal" 		\

	gcloud container clusters get-credentials $(CLUSTER)

# 	@printf "%-45s@%s\n" $(@F) https://github.com/mateothegreat/$(@F) | sed -e 's/ /./g' -e 's/@/ /' 
git/add-%: 				; git submodule add -b master git@github.com:mateothegreat/k8-byexamples-$* modules/k8-byexamples-$*; cd modules/k8-byexamples-$* ; git submodule update --init
git/init: 				; @git submodule update --init
git/init-modules: init 	; @for F in $(MODULES); do $(MAKE) init-submodule-$$F; done
git/init-submodule-%:	; @echo $*; if [ -d modules/$*/.make ]; then cd modules/$* && git submodule update --init; else cd modules/$* && git submodule add -b master git@github.com:mateothegreat/.make.git; fi

git/backup: 			; @echo $(TIME); tar -czf ../.backup/modules.$(TIME).tar .
git/clean: 	git/backup	; rm -rf modules/.make; rm -rf modules/*
git/commit: git/backup	; @for F in $(MODULES); do echo "$(YELLOW)/modules/$$F$(BLUE)" && cd $(PWD)/modules/$$F && git add . && git commit -am'$$MESSAGE' && git push origin HEAD:master; done

git/status: 			; git submodule status --recursive

git/fix-tracking: git/backup	;

	@for F in $(MODULES); do echo "$(YELLOW)/modules/$$F$(BLUE)" && cd $(PWD)/modules/$$F && git config -f .gitmodules submodule..make.branch master && git branch -u origin/master master && git checkout master; done

git/.make-up: git/backup

	@for F in $(MODULES); do echo "$(YELLOW)/modules/$$F$(BLUE)" && cd $(PWD)/modules/$$F/.make && git checkout master && cd .. && git add . && git commit -am'bump' && git push; done
<!--
#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
#-->

[![Clickity click](https://img.shields.io/badge/k8s%20by%20example%20yo-limit%20time-ff69b4.svg?style=flat-square)](https://k8.matthewdavis.io)
[![Twitter Follow](https://img.shields.io/twitter/follow/yomateod.svg?label=Follow&style=flat-square)](https://twitter.com/yomateod) [![Skype Contact](https://img.shields.io/badge/skype%20id-appsoa-blue.svg?style=flat-square)](skype:appsoa?chat)

# Complete cluster built with k8-byexamples

> k8 by example -- straight to the point, simple execution.

# Getting started
Clone this repo using --recurse-submodules to automatically checkout the submodules for you.

## Dumping the list of modules

```sh

$  make dump

Submodule Name                                Submodule Repository

k8 byexamples-elasticsearch-cluster.......... https://github.com/mateothegreat/k8-byexamples-elasticsearch-cluster
k8 byexamples-kibana......................... https://github.com/mateothegreat/k8-byexamples-kibana
k8 byexamples-mysql.......................... https://github.com/mateothegreat/k8-byexamples-mysql
k8 byexamples-fluentd-collector.............. https://github.com/mateothegreat/k8-byexamples-fluentd-collector
k8 byexamples-monitoring-grafana............. https://github.com/mateothegreat/k8-byexamples-monitoring-grafana
k8 byexamples-monitoring-prometheus.......... https://github.com/mateothegreat/k8-byexamples-monitoring-prometheus
```

## Install

```sh

$ make rollout
make -C modules/k8-byexamples-elasticsearch-cluster install
make[1]: Entering directory '/mnt/c/workspace/k8/k8-cluster-monitoring/modules/k8-byexamples-elasticsearch-cluster'

[ INSTALLING MANIFESTS/ES-CLIENT.YAML ]: deployment "es-client" created
[ INSTALLING MANIFESTS/ES-DATA.YAML ]: deployment "es-data" created
[ INSTALLING MANIFESTS/ES-DISCOVERY-SVC.YAML ]: service "elasticsearch-discovery" created
[ INSTALLING MANIFESTS/ES-MASTER.YAML ]: deployment "es-master" created
[ INSTALLING MANIFESTS/ES-SVC.YAML ]: service "elasticsearch" created

make[1]: Leaving directory '/mnt/c/workspace/k8/k8-cluster-monitoring/modules/k8-byexamples-elasticsearch-cluster'
make -C modules/k8-byexamples-kibana install
make[1]: Entering directory '/mnt/c/workspace/k8/k8-cluster-monitoring/modules/k8-byexamples-kibana'

[ INSTALLING MANIFESTS/DEPLOYMENT.YAML ]: deployment "kibana" created
[ INSTALLING MANIFESTS/SERVICE.YAML ]: service "kibana" created

make[1]: Leaving directory '/mnt/c/workspace/k8/k8-cluster-monitoring/modules/k8-byexamples-kibana'
make -C modules/k8-byexamples-mysql install
make[1]: Entering directory '/mnt/c/workspace/k8/k8-cluster-monitoring/modules/k8-byexamples-mysql'

[ INSTALLING MANIFESTS/DEPLOYMENT.YAML ]: deployment "mysql" unchanged
[ INSTALLING MANIFESTS/PERSISTENTVOLUMECLAIM.YAML ]: persistentvolumeclaim "mysql" unchanged
[ INSTALLING MANIFESTS/SERVICE.YAML ]: service "mysql" unchanged

make[1]: Leaving directory '/mnt/c/workspace/k8/k8-cluster-monitoring/modules/k8-byexamples-mysql'
make -C modules/k8-byexamples-fluentd-collector install
make[1]: Entering directory '/mnt/c/workspace/k8/k8-cluster-monitoring/modules/k8-byexamples-fluentd-collector'

[ INSTALLING MANIFESTS/DAEMONSET.YAML ]: daemonset "fluentd" created
[ INSTALLING MANIFESTS/FLUENTD-CONFIG-CONFIGMAP.YAML ]: configmap "fluentd-configmap" created
[ INSTALLING MANIFESTS/RBAC-CLUSTER-ROLE-BINDING.YAML ]: clusterrolebinding "fluentd-service-account" created
[ INSTALLING MANIFESTS/RBAC-CLUSTER-ROLE.YAML ]: clusterrole "fluentd-service-account" created
[ INSTALLING MANIFESTS/RBAC-SERVICE-ACCOUNT.YAML ]: serviceaccount "fluentd-service-account" created

make[1]: Leaving directory '/mnt/c/workspace/k8/k8-cluster-monitoring/modules/k8-byexamples-fluentd-collector'
make -C modules/k8-byexamples-monitoring-grafana install
make[1]: Entering directory '/mnt/c/workspace/k8/k8-cluster-monitoring/modules/k8-byexamples-monitoring-grafana'

[ INSTALLING MANIFESTS/DASHBOARDS-CONFIGMAP.YAML ]: configmap "grafana-import-dashboards" created
[ INSTALLING MANIFESTS/DASHBOARDS-JOB.YAML ]: job "grafana-import-dashboards" created
[ INSTALLING MANIFESTS/DEPLOYMENT.YAML ]: deployment "grafana-core" created
[ INSTALLING MANIFESTS/INGRESS.YAML ]: error: no objects passed to apply
[ INSTALLING MANIFESTS/PERSISTENTVOLUMECLAIM.YAML ]: persistentvolumeclaim "grafana-persistent-storage" created
[ INSTALLING MANIFESTS/SERVICE.YAML ]: service "grafana" created

make[1]: Leaving directory '/mnt/c/workspace/k8/k8-cluster-monitoring/modules/k8-byexamples-monitoring-grafana'
make -C modules/k8-byexamples-monitoring-prometheus install
make[1]: Entering directory '/mnt/c/workspace/k8/k8-cluster-monitoring/modules/k8-byexamples-monitoring-prometheus'
configmap "prometheus-core" created
clusterrolebinding "prometheus" created
clusterrole "prometheus" created
serviceaccount "prometheus-k8s" created
configmap "prometheus-rules" created
deployment "prometheus-core" created
service "prometheus" created
daemonset "prometheus-node-exporter" created
service "prometheus-node-exporter" created
daemonset "node-directory-size-metrics" created
serviceaccount "kube-state-metrics" created
role "kube-state-metrics-resizer" created
rolebinding "kube-state-metrics" created
clusterrole "kube-state-metrics" created
clusterrolebinding "kube-state-metrics" created
deployment "kube-state-metrics" created
service "kube-state-metrics" created
make[1]: Leaving directory '/mnt/c/workspace/k8/k8-cluster-monitoring/modules/k8-byexamples-monitoring-prometheus'
```

## Testing

```sh
$ make test
make -C modules/k8-byexamples-elasticsearch-cluster     test
make[1]: Entering directory '/mnt/c/workspace/k8/k8-cluster-monitoring/modules/k8-byexamples-elasticsearch-cluster'

nslookup elasticsearch
Server:         10.11.240.10
Address:        10.11.240.10#53

Non-authoritative answer:
Name:   elasticsearch.default.svc.cluster.local
Address: 10.11.248.7

curl http://elasticsearch:9200/
{
  "name" : "es-client-798db99ff-5bx4z",
  "cluster_name" : "cluster",
  "cluster_uuid" : "PpUmoZn-SXCPqQwLAm1esQ",
  "version" : {
    "number" : "6.1.2",
    "build_hash" : "5b1fea5",
    "build_date" : "2018-01-10T02:35:59.208Z",
    "build_snapshot" : false,
    "lucene_version" : "7.1.0",
    "minimum_wire_compatibility_version" : "5.6.0",
    "minimum_index_compatibility_version" : "5.0.0"
  },
  "tagline" : "You Know, for Search"
}
curl http://elasticsearch:9200/_cat/indices?pretty
green open logstash-2018.02.21 PaxcIjdxTOmWMRqs94EjDQ 5 1 27036 0 20.1mb 10mb

make[1]: Leaving directory '/mnt/c/workspace/k8/k8-cluster-monitoring/modules/k8-byexamples-elasticsearch-cluster'
make -C modules/k8-byexamples-kibana                            test
make[1]: Entering directory '/mnt/c/workspace/k8/k8-cluster-monitoring/modules/k8-byexamples-kibana'

nslookup kibana
Server:         10.11.240.10
Address:        10.11.240.10#53

Name:   kibana.default.svc.cluster.local
Address: 10.11.252.202


make[1]: Leaving directory '/mnt/c/workspace/k8/k8-cluster-monitoring/modules/k8-byexamples-kibana'
make -C modules/k8-byexamples-mysql                                     test
make[1]: Entering directory '/mnt/c/workspace/k8/k8-cluster-monitoring/modules/k8-byexamples-mysql'

nslookup mysql
Server:         10.11.240.10
Address:        10.11.240.10#53

Non-authoritative answer:
Name:   mysql.default.svc.cluster.local
Address: 10.11.245.74


make[1]: Leaving directory '/mnt/c/workspace/k8/k8-cluster-monitoring/modules/k8-byexamples-mysql'
make -C modules/k8-byexamples-monitoring-grafana        test
make[1]: Entering directory '/mnt/c/workspace/k8/k8-cluster-monitoring/modules/k8-byexamples-monitoring-grafana'

nslookup grafana
Server:         10.11.240.10
Address:        10.11.240.10#53

Name:   grafana.default.svc.cluster.local
Address: 10.11.244.231


make[1]: Leaving directory '/mnt/c/workspace/k8/k8-cluster-monitoring/modules/k8-byexamples-monitoring-grafana'
make -C modules/k8-byexamples-monitoring-prometheus     test
make[1]: Entering directory '/mnt/c/workspace/k8/k8-cluster-monitoring/modules/k8-byexamples-monitoring-prometheus'

nslookup prometheus
Server:         10.11.240.10
Address:        10.11.240.10#53

Name:   prometheus.default.svc.cluster.local
Address: 10.11.240.154


make[1]: Leaving directory '/mnt/c/workspace/k8/k8-cluster-monitoring/modules/k8-byexamples-monitoring-prometheus'
```
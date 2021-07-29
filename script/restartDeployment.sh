#!/bin/sh
KUBE_TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
NAMESPACE=$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace)
DEPLOYMENT=$(echo $HOSTNAME  | sed   '$s/-\w*$//g'  | sed   '$s/-\w*$//g')
deployment_status=$(kubectl rollout status deploy $DEPLOYMENT  --watch=false)


echo $deployment_status | grep  'successfully rolled out'

if [ $? == 0 ] ; then
  echo "restarting deployment"
  kubectl rollout restart deploy $DEPLOYMENT
else
  echo "rollout already inprogress. skipping"

fi

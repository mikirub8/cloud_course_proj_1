helm repo add jenkins https://charts.jenkins.io
helm repo update
helm install jenkins
kubectl exec --namespace default -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/
additional/chart-admin-password && echo
kubectl port-forward svc/jenkins 8080:8080 &


helm install rabbitmq bitnami/rabbitmq -f rabbitmq-values.yaml
helm install consumer consumer-chart/
helm install producer producer-chart/
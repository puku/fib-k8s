docker build --tag puku/complex-client:latest --tag puku/complex-client:$SHA ./client
docker build --tag puku/complex-server:latest --tag puku/complex-server:$SHA ./server
docker build --tag puku/complex-worker:latest --tag puku/complex-worker:$SHA ./worker

docker push puku/complex-client:latest
docker push puku/complex-client:$SHA

docker push puku/complex-server:latest
docker push puku/complex-server:$SHA

docker push puku/complex-worker:latest
docker push puku/complex-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=puku/complex-server:$SHA
kubectl set image deployment/client-deployment client=puku/complex-client:$SHA
kubectl set image deployment/worker-deployment worker=puku/complex-worker:$SHA
docker build -t kronos292/multi-client:latest -t kronos292/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kronos292/multi-server:latest -t kronos292/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kronos292/multi-worker:latest -t kronos292/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kronos292/multi-client:latest
docker push kronos292/multi-server:latest
docker push kronos292/multi-worker:latest

docker push kronos292/multi-client:$SHA
docker push kronos292/multi-server:$SHA
docker push kronos292/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kronos292/multi-server:$SHA
kubectl set image deployments/client-deployment client=kronos292/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kronos292/multi-worker:$SHA
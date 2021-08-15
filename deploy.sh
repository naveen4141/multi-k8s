docker build -t naveen4141/multi-client:latest -t naveen4141/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t naveen4141/multi-server:latest -t naveen4141/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t naveen4141/multi-worker:latest -t naveen4141/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push naveen4141/multi-client:latest
docker push naveen4141/multi-server:latest
docker push naveen4141/multi-worker:latest

docker push naveen4141/multi-client:$SHA
docker push naveen4141/multi-server:$SHA
docker push naveen4141/multi-worker:$SHA

kubectl set image deployments/server-deployment server=naveen4141/multi-server:$SHA
kubectl set image deployments/client-deployment client=naveen4141/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=naveen4141/multi-worker:$SHA
kubectl apply -f k8s

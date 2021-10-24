docker build -t khofesh/multi-client:latest -t khofesh/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t khofesh/multi-server:latest -t khofesh/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t khofesh/multi-worker:latest -t khofesh/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push khofesh/multi-client:latest
docker push khofesh/multi-server:latest
docker push khofesh/multi-worker:latest

docker push khofesh/multi-client:$GIT_SHA
docker push khofesh/multi-server:$GIT_SHA
docker push khofesh/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=khofesh/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=khofesh/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=khofesh/multi-worker:$GIT_SHA

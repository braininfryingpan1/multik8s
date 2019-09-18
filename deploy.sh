docker build -t braininfryingpan/multi-container-client:latest -t braininfryingpan/multi-container-client:$SHA -f ./client/Dockerfile ./client
docker build -t braininfryingpan/multi-container-server:latest -t braininfryingpan/multi-container-server:$SHA -f ./server/Dockerfile ./server
docker build -t braininfryingpan/multi-container-worker:latest -t braininfryingpan/multi-container-worker:$SHA -f ./worker/Dockerfile ./worker

docker push braininfryingpan/multi-container-client:latest
docker push braininfryingpan/multi-container-server:latest
docker push braininfryingpan/multi-container-worker:latest

docker push braininfryingpan/multi-container-client:$SHA
docker push braininfryingpan/multi-container-server:$SHA
docker push braininfryingpan/multi-container-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=braininfryingpan/multi-container-server:$SHA
kubectl set image deployments/client-deployment server=braininfryingpan/multi-container-client:$SHA
kubectl set image deployments/worker-deployment server=braininfryingpan/multi-container-worker:$SHA

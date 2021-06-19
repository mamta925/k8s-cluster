docker build -t mamta9256/multi-client:latest -t mamta9256/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mamta9256/multi-server:latest -t mamta9256/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t mamta9256/multi-worker:latest -t mamta9256/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push mamta9256/multi-client:latest
docker push mamta9256/multi-server:latest
docker push mamta9256/multi-worker:latest

docker push mamta9256/multi-client:$SHA
docker push mamta9256/multi-server:$SHA
docker push mamta9256/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=mamta9256/multi-server:$SHA
kubectl set image deployment/client-deployment client=mamta9256/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=mamta9256/multi-worker:$SHA
docker build -t vkingmaker/multi-client:latest -t vkingmaker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vkingmaker/multi-server:latest -t vkingmaker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vkingmaker/multi-worker:latest -t vkingmaker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vkingmaker/multi-client:latest
docker push vkingmaker/multi-server:latest
docker push vkingmaker/multi-worker:latest

docker push vkingmaker/multi-client:$SHA
docker push vkingmaker/multi-server:$SHA
docker push vkingmaker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vkingmaker/multi-server:$SHA
kubectl set image deployments/client-deployment client=vkingmaker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vkingmaker/multi-worker:$SHA
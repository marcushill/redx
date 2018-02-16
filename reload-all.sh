docker kill redx
docker rm redx
docker run --net=host -p 8080:8080 -p 8081:8081 --name redx -d --env-file .env redx

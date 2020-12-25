# develop stage
FROM node:alpine as develop-stage
WORKDIR /app
COPY package*.json ./
COPY package-lock*.json ./
RUN npm install
COPY . .

# build stage
FROM develop-stage as build-stage
RUN npm run build

# production stage
FROM nginx:alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 90
CMD ["nginx", "-g", "daemon off;"]


#1.sudo docker build -t news-website .
#2.sudo docker run -p 90:80 news-website

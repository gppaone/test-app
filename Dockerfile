FROM node:20-alpine as builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build
RUN ls -la /app
FROM nginx:alpine
COPY --from=builder /app/.svelte-kit/output/client /usr/share/nginx/html
RUN rm -f /etc/nginx/conf.d/defaut.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
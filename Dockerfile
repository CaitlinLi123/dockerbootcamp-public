#build phase
FROM node:16-alpine as builder
#tag the name to the phase
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build <-- has all the stuff we care about

#run phase
FROM nginx
#copy over something from builder phase to /usr/share/nginx/html path
COPY --from=builder /app/build /usr/share/nginx/html

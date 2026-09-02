FROM node:20-alpine3.22 AS build

WORKDIR /usr/src/app

COPY package.json yarn.lock ./

RUN yarn install

COPY . .

RUN yarn run build

FROM node:20-alpine3.22 

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/node_modules./node_modules

EXPOSE 3000

CMD ["yarn", "run", "start"]
# Etapa de instalación de dependencias de desarrollo
FROM node:19 as dev-deps
WORKDIR /app
COPY package.json package.json
RUN yarn install --frozen-lockfile

# Etapa de construcción
FROM node:19 as builder
WORKDIR /app
COPY --from=dev-deps /app/node_modules ./node_modules
COPY . .
RUN yarn build

# Etapa de instalación de dependencias de producción
FROM node:19 as prod-deps
WORKDIR /app
COPY package.json package.json
RUN yarn install --prod --frozen-lockfile

# Etapa final: producción
FROM node:19 as prod
WORKDIR /app
ENV APP_VERSION=${APP_VERSION}
COPY --from=prod-deps /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
EXPOSE 3000
CMD ["node", "dist/main.js"]

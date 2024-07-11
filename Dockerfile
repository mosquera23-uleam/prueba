FROM node:14
# Establece el directorio de trabajo en el contenedor
WORKDIR /app
# Copia el package.json y package-lock.json para instalar dependencias
COPY package*.json ./
# Instala las dependencias de la aplicación
RUN npm install
# Copia el resto del código de la aplicación
COPY . .
# Expone el puerto en el que correrá la aplicación
EXPOSE 3000
# Define el comando para correr la aplicación
CMD ["node", "app.js"]

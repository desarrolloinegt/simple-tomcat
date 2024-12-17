
# Tomcat Deployment with Docker Compose

Este proyecto utiliza Docker Compose y un Dockerfile personalizado para desplegar aplicaciones en Tomcat. Permite desplegar un archivo WAR de forma sencilla y reiniciar el contenedor para aplicar los cambios.

## Requisitos previos

- Docker instalado en tu sistema ([Instrucciones de instalación](https://docs.docker.com/get-docker/)).
- Docker Compose instalado ([Instrucciones de instalación](https://docs.docker.com/compose/install/)).
- Archivo `.war` de la aplicación que deseas desplegar.

## Configuración

1. **Clona este repositorio**:
   ```bash
   git clone https://github.com/desarrolloine/tomcat-docker.git
   cd tomcat-docker
   ```

2. **Crea un archivo `.env`** en la raíz del proyecto con las siguientes variables:
   ```env
   TOMCAT_VERSION=10.1-jdk21
   HOST_PORT=8081
   ```

   - `TOMCAT_VERSION`: Versión de Tomcat que deseas usar.
   - `HOST_PORT`: Puerto del host donde estará disponible la aplicación.

## Estructura del proyecto

- **`docker-compose.yml`**: Define los servicios, el volumen y los puertos.
- **`Dockerfile`**: Construye una imagen personalizada basada en Tomcat.
- **`logs/`**: Carpeta donde se almacenan los logs del servidor.
- **`webapps/`**: Carpeta donde se espera el archivo `ROOT.war` (desplegado como la aplicación principal).

## Pasos para desplegar una aplicación

1. **Coloca tu archivo WAR**:
   Copia el archivo `ROOT.war` de tu aplicación en la carpeta `webapps/`.

2. **Construye y ejecuta los servicios**:
   ```bash
   docker-compose up --build -d
   ```

   Esto construirá la imagen de Docker y levantará el contenedor.

3. **Actualizar la aplicación (despliegue continuo)**:
   - Copia el nuevo archivo `ROOT.war` directamente al volumen:
     ```bash
     cp ROOT.war ./webapps/ROOT.war 
     ```
   - Reinicia el contenedor para aplicar los cambios:
     ```bash
     docker restart tomcat 
     ```

## Personalización

- Puedes cambiar la versión de Tomcat modificando la variable `TOMCAT_VERSION` en el archivo `.env`.
- Para usar un puerto diferente en el host, ajusta la variable `HOST_PORT` en el archivo `.env`.

## Logs del servidor

Los logs de Tomcat se almacenan en la carpeta `logs/` del host. Puedes revisar los logs para diagnosticar problemas:
```bash
tail -f logs/catalina.out
```

## Notas importantes

1. **Reinicio del contenedor**: Es obligatorio reiniciar el contenedor después de actualizar el archivo `ROOT.war`.
2. **Entornos de producción**: Este enfoque es ideal para desarrollo o entornos pequeños. Para producción, considera empaquetar tu aplicación como una imagen Docker para un despliegue más eficiente.
3. **Rollback**: Mantén versiones anteriores de tu archivo WAR para realizar un rollback en caso de errores.

# Usa la versión de Tomcat especificada como argumento
ARG TOMCAT_VERSION
FROM tomcat:${TOMCAT_VERSION}

# Configura el directorio de trabajo en el contenedor
WORKDIR /usr/local/tomcat

# Elimina la aplicación por defecto de Tomcat (opcional)
RUN rm -rf webapps/*

# Exponer el puerto que usará Tomcat
EXPOSE 8080

# Inicia Tomcat
CMD ["catalina.sh", "run"]

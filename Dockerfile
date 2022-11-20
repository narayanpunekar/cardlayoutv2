FROM frolvlad/alpine-java 
LABEL maintainer="Narayan Punekar"
LABEL description="This Dockerfile installs cardlayout"
COPY ./target/layout-1.0-SNAPSHOT.jar cardlayout-app.jar  
ENTRYPOINT ["java", "-jar", "cardlayout-app.jar"] 

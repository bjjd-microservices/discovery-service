FROM openjdk:11
copy target/eureka-server-*.jar eureka-server-0.0.1-RELEASE.jar
EXPOSE 8761
CMD ["java","-jar","/eureka-server-0.0.1-RELEASE.jar"]
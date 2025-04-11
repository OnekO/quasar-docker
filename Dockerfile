FROM ghcr.io/oneko/alpine-nonroot:latest

ARG PROJECT_NAME="my-project"
ENV PROJECT_NAME ${PROJECT_NAME}
ARG PROJECT_DESCRIPTION="My Project"
ARG PRODUCT_NAME="Product Name"
ARG AUTHOR="Author <author@i.am>"
COPY config ${PROJECT_NAME}
WORKDIR ${HOME}/${PROJECT_NAME}
COPY entrypoint.sh .
USER root
RUN chmod +x entrypoint.sh
RUN sed -i "s/%%project-name%%/${PROJECT_NAME}/g" ./package.json && \
    sed -i "s/%%project-description%%/${PROJECT_DESCRIPTION}/g" ./package.json && \
    sed -i "s/%%product-name%%/${PRODUCT_NAME}/g" ./package.json && \
    sed -i "s/%%author%%/${AUTHOR}/g" ./package.json
RUN apk add nodejs npm
RUN npm i -g @quasar/cli 
USER ${USER}
RUN npm i
EXPOSE 4000
ENTRYPOINT ${HOME}/${PROJECT_NAME}/entrypoint.sh

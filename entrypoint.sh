#!/bin/sh
cd ${HOME}/${PROJECT_NAME} && pwd
quasar build
quasar serve

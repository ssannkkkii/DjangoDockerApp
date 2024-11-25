DC = docker compose 
EXEC = docker exec -it
LOGS = docker logs 
ENV_FILE = --env-file .env
APP_FILE = docker_compose/app.yaml
STORAGE_FILE = docker_compose/storages.yaml
APP_CONTAINER = main-app
MANAGE_PY = python manage.py

.PHONY: app
app:
	${DC} -f ${APP_FILE} -f ${STORAGE_FILE} ${ENV_FILE} up -d

.PHONY: app-logs
app-logs:
	${LOGS} ${APP_CONTAINER} -f

.PHONY: migrate
migrate:
	${EXEC} ${APP_CONTAINER} ${MANAGE_PY} migrate

.PHONY: makemigrations
makemigrations:
	${EXEC} ${APP_CONTAINER} ${MANAGE_PY} makemigrations

.PHONY: superuser
superuser:
	${EXEC} ${APP_CONTAINER} ${MANAGE_PY} createsuperuser

.PHONY: collectstatic
collectstatic:
	${EXEC} ${APP_CONTAINER} ${MANAGE_PY} collectstatic

.PHONY: db-reset
db-reset:
	${DC} -f ${APP_FILE} -f ${STORAGE_FILE} ${ENV_FILE} down --volumes
	${DC} -f ${APP_FILE} -f ${STORAGE_FILE} ${ENV_FILE} up -d
	${EXEC} ${APP_CONTAINER} ${MANAGE_PY} migrate

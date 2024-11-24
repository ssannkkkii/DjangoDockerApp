FROM python:3.12.7-slim-bullseye

ENV PYTHONDONTWRITEBYBITECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

RUN apt update -y && \
    apt install -y python3-dev

ADD pyproject.toml /app

RUN pip install --update pip    
RUN pip install poetry

RUN poetry config virtualenvs.create false
RUN poetry install --no-root --no-interaction --no-ansi

COPY . /app/
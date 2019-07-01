FROM python:3.6 AS base
RUN apt-get update -y
RUN apt-get install -y python-pip python-dev build-essential
WORKDIR /app
EXPOSE 5000

FROM python:3.6 AS build
WORKDIR /app
EXPOSE 5000
RUN apt-get update -y
RUN apt-get install -y python-pip python-dev build-essential
COPY . /app
RUN pip install --pre pybuilder
RUN pip install -r requirements.txt
RUN pyb
RUN ls
RUN pwd

FROM base AS final
WORKDIR /app
COPY --from=build /app/target/dist/hello_world_flask* /app
RUN pip install /app

EXPOSE 5000
ENTRYPOINT ["python"]
CMD ["/app/api/run.py"]

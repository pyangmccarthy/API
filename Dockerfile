FROM python:3.9.6

WORKDIR /app

# Install Python dependencies
COPY ./requirements.txt /app
RUN pip3 install --upgrade pip -r requirements.txt

# Add the rest of the code
COPY . /app

RUN mkdir /app/staticfiles

RUN DJANGO_SETTINGS_MODULE=api.settings \
  SECRET_KEY=somethingsupersecret \
  python3 manage.py collectstatic --noinput

EXPOSE 8000

CMD gunicorn api.wsgi:application --bind 0.0.0.0:8000

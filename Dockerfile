# NOTA: el requirements.txt de este componente fue generado con `pip freeze`
# en un entorno con Python 3.12 e incluye dependencias dev (pipreqs, pip-chill,
# jupyter-*, nbconvert, ipython, etc.) que limitan la versión de Python.
# En concreto, pipreqs==0.5.0 requiere Python <3.13, por lo que usamos 3.12-slim.
FROM python:3.12-slim

WORKDIR /app

# Instalar dependencias del sistema mínimas (necesarias para algunos wheels)
RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential curl \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8001

# El AI-component es un FastAPI levantado con uvicorn en el puerto 8001
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8001"]

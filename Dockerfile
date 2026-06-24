# 1. Imagen base oficial y liviana
FROM python:3.12-slim

# 2. Crear un usuario que no sea root por seguridad
RUN adduser --disabled-password --gecos '' appuser

# 3. Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# 4. Copiar solo el archivo de dependencias primero para aprovechar la caché de Docker
COPY requirements.txt .

# 5. Instalar las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# 6. Copiar el resto del código de la aplicación
COPY ./app ./app

# 7. Cambiar al usuario seguro que creamos
USER appuser

# 8. Exponer el puerto asignado para el bonos-service
EXPOSE 8004

# 9. Comando para levantar FastAPI
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8004"]
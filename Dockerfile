# using an official Python runtime as a base image
FROM python:3.9-slim

# Set environment variables to reduce Python package installation warnings
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    libc-dev \
    libffi-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Seting the working directory in the container
WORKDIR /app

# Adding the current directory contents into the container at /app
ADD . /app

# Installing packages specified in requirements
RUN pip install --no-cache-dir -r requirements.txt

# Installing Jupyter
RUN pip install jupyter

# making port 8888 available 
EXPOSE 8888

# Definign environment variable
ENV NAME final_exam

# Runing Jupyter Notebook when the container launches
CMD ["jupyter", "notebook", "--ip='*'", "--port=8888", "--no-browser", "--allow-root"]

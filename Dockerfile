FROM conda/miniconda3

SHELL ["/bin/bash", "-c"]

#RUN echo -e 'LANG=en_US.UTF-8\nLC_ALL=en_US.UTF-8' > /etc/default/locale

RUN groupadd -r student && \
    useradd -u 1000 -r -M -d /student -g student -s /bin/false student && \
    # Add required packages
    apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      git

# Update conda
RUN conda update conda

# Create environment
COPY environment.yml /tmp/environment.yml
RUN conda env create -n LU -f /tmp/environment.yml && \
    rm /tmp/environment.yml

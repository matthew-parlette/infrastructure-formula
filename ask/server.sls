# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "ask/map.jinja" import ask with context %}

{{ ask.data_path }}:
  file.directory:
    - name: {{ ask.data_path }}
    - makedirs: True

{{ ask.image }}:
  dockerng.image_present

{{ ask.image }}-running:
  dockerng.running:
    - name: {{ ask.name }}
    - image: {{ ask.image }}
    - port_bindings:
      - {{ ask.port }}:80
    - binds:
      - {{ ask.data_path }}:/data
    - require:
      - file: {{ ask.data_path }}
      - dockerng: {{ ask.image }}

# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "slate/map.jinja" import slate with context %}

{{ slate.data_path }}:
  file.directory:
    - name: {{ slate.data_path }}
    - makedirs: True

{{ slate.image }}:
  dockerng.image_present

{{ slate.image }}-running:
  dockerng.running:
    - name: {{ slate.name }}
    - image: {{ slate.image }}
    - port_bindings:
      - {{ slate.port }}:4567
    - binds:
      - {{ slate.data_path }}:/app/source
    - require:
      - file: {{ slate.data_path }}
      - dockerng: {{ slate.image }}

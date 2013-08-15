{% from "salt/package-map.jinja" import pkgs with context %}

mysqld:
  pkg:
    - installed
    - name: {{ pkgs['mysql-server'] }}
  service:
    - running
    - name: {{ services['mysql'] }}
    - enable: True
    - watch:
      - pkg: mysqld

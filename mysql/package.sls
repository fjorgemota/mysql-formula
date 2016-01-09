include:
  - mysql.config
  - mysql.server
  - mysql.client

python-apt:
  pkg.installed:
    - pkgs:
      - python-software-properties
      - python-pycurl
      - python-apt 

perl-deps:
  pkg.installed:
    - pkgs:
      - perl
      - pwgen

mysql-official-repo:
  pkgrepo.managed:
    - humanname: mysql apt repo
    - name: deb http://repo.mysql.com/apt/{{ grains['os'].lower() }} {{ grains['oscodename'] }} mysql-5.7
    - file: /etc/apt/sources.list.d/mysql.list
    - keyid:  A4A9406876FCBD3C456770C88C718D3B5072E1F5
    - keyserver: ha.pool.sks-keyservers.net
    - require_in: 
      - pkg: mysqld
      - pkg: mysql
    - require:
      - pkg: python-apt
      - pkg: perl-deps

mysql-official-config:
  file.replace:
    - name: /etc/mysql/my.cnf
    - pattern: pid_file
    - repl: pid-file
    - show_changes: True
    - backup: bak
    - require:
      - file: mysql_config
    - require_in:
      - pkg: mysqld
      - pkg: mysql
##mongodb/server/users.sls
# -*- coding: utf-8 -*-
# vim: ft=yaml

{% from 'mongodb/map.jinja' import mongodb with context %}

mongodb_disable_auth:
# Comment authentication items in mongod service config
  file.comment:
    - name: /etc/mongod.conf
    - regex: '^\s*(security|authorization):'
    - char: '#'
    - backup: '.noauth.bak'

# Force restart mongod service
  test.succeed_with_changes:
    - watch_in:
        - service: mongodb_disable_auth
  service.running:
    - name: 'mongod'
    - enable: True

mongodb_create_users_script:
  file.managed:
    - name: '/tmp/mongodb-install/create_users.js'
    - source: 'salt://mongodb/files/mongodb.users.js.jinja'
    - makedirs: True
    - user: root
    - template: jinja

mongodb_execute_create_users_script:
  cmd.run:
    - name: '/bin/mongo /tmp/mongodb-install/create_users.js'
    - runas: root
    - require:
        - file: mongodb_create_users_script
        - file: mongodb_disable_auth

mongodb_create_users_clean:
  file.absent:
    - name: '/tmp/mongodb-install'
    - require:
        - cmd: mongodb_execute_create_users_script

mongodb_restore_conf:
# Restore mongod config file backup
  file.rename:
    - name: '/etc/mongod.conf'
    - source: '/etc/mongod.conf.noauth.bak'
    - force: True

# Force restart mongod service
  test.succeed_with_changes:
    - watch_in:
        - service: mongodb_restore_conf
  service.running:
    - name: 'mongod'
    - enable: True

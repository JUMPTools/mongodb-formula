# -*- coding: utf-8 -*-
# vim: ft=yaml
---
mongodb:
  robo3t:
    version: 1.2.1
    # yamllint disable-line rule:line-length
    source_hash: sha512=ead2c4847dc1cd4024f60f34a142af6c6818f90a37b5ae075c8b65414ee8ca8074355446c9e264094f776f7798bfba37a7c7018f94d0bec109715061ab3a57c3
  compass:
    version: 1.17.0
  server:
    package: mongodb-org
    version: 4.2
    use_repo: true
    repo:
      # `keyid` for version `4.2` (Debian-based)
      keyid: E162F504A20CDF15827F718D4B7C549A058F8B6B
    use_archive: false
  bic:
    version: 2.7.0
    use_repo: false
    use_archive: true

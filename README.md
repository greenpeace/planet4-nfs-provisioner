# Planet4 NFS Server Provisioner

***
NOT INTENDED TO BE DEPLOYED BY HAND
***

This repository is intended to be used via [CircleCI](https://circleci.com/gh/greenpeace/planet4-nfs-provisioner)

Commits to the develop branch affect the development cluster, commits to the master branch affect the production cluster.

---

```
# Ensure the configuration is valid
make lint

# Upgrade / deploy to the development cluster
make dev

# or the production cluster
make prod
```

SHELL := /bin/bash

CHART_VERSION ?= 0.2.1
CHART_NAME ?= stable/nfs-server-provisioner

RELEASE_NAME ?= p4-nfs
RELEASE_NAMESPACE ?= nfs

DEV_CLUSTER ?= p4-development
DEV_PROJECT ?= planet-4-151612
DEV_ZONE ?= us-central1-a

PROD_CLUSTER ?= planet4-production
PROD_PROJECT ?= planet4-production
PROD_ZONE ?= us-central1-a

lint:
	yamllint .circleci/config.yml

dev: lint
ifndef CI
	$(error Not in CI? No cake for you)
endif
	gcloud config set project $(DEV_PROJECT)
	gcloud container clusters get-credentials $(DEV_CLUSTER) --zone $(DEV_ZONE) --project $(DEV_PROJECT)
	helm init --client-only
	helm repo update
	helm upgrade --install --force --wait $(RELEASE_NAME) \
		--namespace=$(RELEASE_NAMESPACE) \
		--version $(CHART_VERSION) \
		--values values.yaml \
		$(CHART_NAME)

prod: lint
ifndef CI
	$(error Not in CI? No cake for you)
endif
	gcloud config set project $(PROD_PROJECT)
	gcloud container clusters get-credentials $(PROD_CLUSTER) --zone $(PROD_ZONE) --project $(PROD_PROJECT)
	helm init --client-only
	helm repo update
	helm upgrade --install --force --wait $(RELEASE_NAME) \
		--namespace=$(RELEASE_NAMESPACE) \
		--version $(CHART_VERSION) \
		--values values.yaml \
		$(CHART_NAME)

history:
	helm history $(RELEASE_NAME) --max=10

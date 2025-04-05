# context:=kind-$(shell kind get clusters | gum choose)

create-prod-cluster: 
	kind delete cluster --name prod || true
	kind create cluster --name prod
	$(MAKE) install-kluctl context=kind-prod

create-staging-cluster:
	kind delete cluster --name staging || true
	kind create cluster --name staging
	$(MAKE) install-kluctl context=kind-staging

install-kluctl:
	cd bootstrap && kluctl deploy -y --context $(context)

install-root-gitops:
	cd gitops && kluctl deploy -y -t $(target) --context $(context)

create-clusters: create-prod-cluster create-staging-cluster
IMAGE=odahub/streamlit-cc:$(shell git describe --tags --always)

default: deploy

build: 
	docker build . -t $(IMAGE)

push: build
	docker push $(IMAGE)

run: build
	docker run -it -p 8000:8000 $(IMAGE)

deploy: push
	helm upgrade --install  streamlit-cc . \
	    	-n streamlit-cc \
		-f values-unige-dstic-production.yaml \
		--set image.tag="$(shell git describe --tags --always)" 

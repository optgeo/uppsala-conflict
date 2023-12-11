zip_fn = ged231-csv.zip
csv_fn = GEDEvent_v23_1.csv
pmtiles_fn = a.pmtiles
url = https://ucdp.uu.se/downloads/ged/$(zip_fn)

world: clean download build add

download: 
	curl -OL $(url)
	unzip $(zip_fn)

build:
	ruby build.rb $(csv_fn) | \
	tippecanoe --drop-densest-as-needed --maximum-zoom=12 \
	-f -o $(pmtiles_fn)

add:
	ipfs add --progress $(pmtiles_fn)

clean:
	-rm $(zip_fn)
	-rm $(csv_fn)
	-rm $(pmtiles_fn)


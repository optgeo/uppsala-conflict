zip_fn = ged231-csv.zip
csv_fn = GEDEvent_v23_1.csv
url = https://ucdp.uu.se/downloads/ged/$(zip_fn)

world: clean download build

download: 
	curl -OL $(url)
	unzip $(zip_fn)

build:
	ruby build.rb $(csv_fn) | \
	tippecanoe --drop-densest-as-needed --maximum-zoom=12 \
	-f -o a.pmtiles

clean:
	-rm $(zip_fn)
	-rm $(csv_fn)


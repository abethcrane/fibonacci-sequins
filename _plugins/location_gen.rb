module Jekyll
  class LocationIndex < Page
    def initialize(site, base, dir, location)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'location_page.html')
      self.data['location'] = location
    end
  end
  class LocationGenerator < Generator
    safe true
    def generate(site)
      if site.layouts.key? 'location_page'
        site.config['locations'].each do |location|
            write_location_index(site, File.join('locations', location.downcase), location)
        end
      end
    end
    def write_location_index(site, dir, location)
      index = LocationIndex.new(site, site.source, dir, location)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.pages << index
    end
  end
end
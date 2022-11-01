module Jekyll
  class FieldIndex < Page
    def initialize(site, base, dir, field)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'field_page.html')
      self.data['field'] = field
    end
  end
  class FieldGenerator < Generator
    safe true
    def generate(site)
      if site.layouts.key? 'field_page'
        site.config['fields'].each do |field|
            write_field_index(site, File.join('fields', field.downcase), field)
        end
      end
    end
    def write_field_index(site, dir, field)
      index = FieldIndex.new(site, site.source, dir, field)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.pages << index
    end
  end
end
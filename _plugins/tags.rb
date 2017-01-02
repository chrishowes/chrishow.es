module Jekyll

  class TagPage < Page
    def initialize(site, tag_name, pages)
      @site = site
      @base = site.source
      @dir = File.join('tag')
      @name = tag_name + ".html"

      self.process(@name)
      self.read_yaml(File.join(@base, '_layouts'), 'tag.html')

      self.data['tag_name'] = tag_name

    end
  end

  class TagPageGenerator < Jekyll::Generator
    safe true
    def generate(site)
      site.tags.each do |tag_name, pages|
        site.pages << TagPage.new(site, tag_name, pages)
      end
    end
  end
end

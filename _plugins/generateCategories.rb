
module Jekyll

  class CategoryPage < Page
    def initialize(site, base, dir, categories)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'event_index.html')
      self.data['category'] = categories.last
 
      #category_title_prefix = site.config['category_title_prefix'] || 'Category: '
      #self.data['title'] = "#{category_title_prefix}#{categories.join('-').split('-').map(&:capitalize).join(' ')}"
      self.data['title'] = "#{categories.join('-').split('-').map(&:capitalize).join(' ')}"
      self.data['dir_path'] = dir
    end
  end

  class CategoryPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'event_index'
        dir = site.config['category_dir'] || 'categories'

        site.posts.each do |post|
          site.pages << CategoryPage.new(site, site.source, File.join(post.categories.join('/')), post.categories)
          post.categories.push(post.date.strftime("%Y"))
          site.pages << CategoryPage.new(site, site.source, File.join(post.categories.join('/')), post.categories)
        end
      end
    end
  end

end
class WorldsBestRestaurants::Restaurant

  attr_accessor :name, :position, :location, :url, :head_chef, :website_url, :food_style, :best_dish, :contact, :description

  @@all = []

  def self.new_from_index_page(r)
    self.new(
      r.css("h2").text,
      "https://www.theworlds50best.com#{r.attribute("href").text}",
      r.css("p")[1].text,
      r.css(".position").text
      )
  end

  def initialize(name=nil, url=nil, location=nil, position=nil)
    @name = name
    @url = url
    @location = location
    @position = position
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find(id)
    self.all[id-1]
  end

  def intro_quote #DONE
    @bintro_quote ||= doc.css("h3.intro-quote").text
    # @best_dish ||= doc.xpath("//div[@class='c-4 nr nt']/ul[3]/li").text
  end

  def food_style
    
    @food_style ||= doc.css("div.content.profile").css('p')[6].text
    # @food_style ||= doc.xpath("//div[@class='c-4 nr nt']/ul[2]/li").text
  end

  def contact #DONE
    @contact ||= doc.css("p.location").text
    # @contact ||= doc.xpath("//div[@class='c-4 nr nt']/ul[4]/li[1]").text.split("+").join(". Tel: +")
  end

  def phone #DONE
    @phone ||= doc.css("a.telephone").text
    # @contact ||= doc.xpath("//div[@class='c-4 nr nt']/ul[4]/li[1]").text.split("+").join(". Tel: +")
  end

  def head_chef #DONE
    @head_chef ||= doc.css("div.on-the-pass").css('p')[0].text
    # @head_chef ||= doc.xpath("//div[@class='c-4 nr nt']/ul[1]/li").text.split(" (pictured)").join("")
  end

  def website_url #DONE
    @website_url ||= doc.css("a.website").text
    # @website_url ||= doc.xpath("//div[@class='c-4 nr nt']/ul[4]/li[2]/a").text
  end

  def description #DONE
    @description ||= doc.css("div.content.profile").css('p')[4].text
    # @description ||= doc.xpath("//div[@class='c-8 nl nt']/p[3]").text
  end

  def doc
    @doc ||= Nokogiri::HTML(open(self.url))
  end
end

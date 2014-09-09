class Client < ActiveRecord::Base

  has_one :country
  has_one :currency

  def self.tokens(query)
    where("first_name like ?", "%#{query}%")
  end

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(first_name: $1).id }
    tokens.split(',')
  end

end

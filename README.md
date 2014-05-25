# TagCloud

generate tag cloud for ruby

## Installation

Add this line to your application's Gemfile:

    gem 'tag_cloud'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tag_cloud

## Usage

tag_cloud = TagCloud.new(tags_with_count)

tag_cloud.each do |tag, font_size|
  puts "tag name : #{tag}"
  puts "font size : #{font_size}"
end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

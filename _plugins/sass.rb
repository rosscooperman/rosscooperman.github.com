module Jekyll
  require 'sass'
  class SassConverter < Converter
    safe true
    priority :low

    def initialize(config = {})
      @config = config
    end

    def matches(ext)
      ext =~ /scss/i
    end

    def output_ext(ext)
      ".css"
    end

    def convert(content)
      begin
        engine = Sass::Engine.new(content, {
          :syntax     => :scss,
          :load_paths => [ File.join(@config['source'], '_style') ]
        })
        engine.render
      rescue StandardError => e
        "!!! SASS Error: " + e.message
      end
    end
  end
end

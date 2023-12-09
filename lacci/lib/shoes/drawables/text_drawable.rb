# frozen_string_literal: true

class Shoes
  # TextDrawable is the parent class of various classes of
  # text that can go inside a para. This includes normal
  # text, but also links, italic text, bold text, etc.
  class TextDrawable < Shoes::Drawable
    class << self
      # rubocop:disable Lint/MissingSuper
      def inherited(subclass)
        Shoes::Drawable.drawable_classes ||= []
        Shoes::Drawable.drawable_classes << subclass

        Shoes::Drawable.drawable_default_styles ||= {}
        Shoes::Drawable.drawable_default_styles[subclass] = {}
      end
      # rubocop:enable Lint/MissingSuper
    end

    shoes_events # No TextDrawable-specific events yet
  end

  class << self
    def default_text_drawable_with(element)
      class_name = element.capitalize

      drawable_class = Class.new(Shoes::TextDrawable) do
        # Can we just change content to text to match the Shoes API?
        shoes_style :content

        init_args # We're going to pass an empty array to super
        def initialize(content)
          super()

          @content = content

          create_display_drawable
        end

        def text
          content
        end

        def to_s
          content
        end

        def text=(new_text)
          self.content = new_text
        end
      end
      Shoes.const_set class_name, drawable_class
      drawable_class.class_eval do
        shoes_style :content

        shoes_events # No specific events
      end
    end
  end
end

Shoes.default_text_drawable_with(:code)
Shoes.default_text_drawable_with(:em)
Shoes.default_text_drawable_with(:strong)

require 'paper_trail'

module Globalize
  module Versioning
    module PaperTrail
      # At present this isn't used but we may use something similar in paper trail
      # shortly, so leaving it around to reference easily.
      # def versioned_columns
      # super + self.class.translated_attribute_names
      # end
    end
  end
end

ActiveRecord::Base.class_eval do
  class << self
    def has_paper_trail_with_globalize(*args)
      has_paper_trail_without_globalize(*args)
      include Globalize::Versioning::PaperTrail
    end
    alias_method :has_paper_trail_without_globalize, :has_paper_trail
    alias_method :has_paper_trail, :has_paper_trail_with_globalize
  end
end

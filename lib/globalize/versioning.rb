require 'globalize'

module Globalize::Versioning
  autoload :PaperTrail, 'globalize/versioning/paper_trail'
  autoload :InstanceMethods, 'globalize/versioning/instance_methods'
end

Globalize::ActiveRecord::ActMacro.module_eval do
  def setup_translates_with_versioning!(options)
    setup_translates_without_versioning!(options)

    return unless options[:versioning]

    include Globalize::Versioning::InstanceMethods

    # hard-coded for now
    class_attribute :versioning_gem, instance_accessor: false
    self.versioning_gem = :paper_trail

    ::ActiveRecord::Base.extend(Globalize::Versioning::PaperTrail)
    if options[:versioning].is_a?(Hash)
      translation_class.has_paper_trail(options[:versioning][:options])
    elsif options[:versioning] == :paper_trail
      translation_class.has_paper_trail
    end
  end

  alias_method :setup_translates_without_versioning!, :setup_translates!
  alias_method :setup_translates!, :setup_translates_with_versioning!
end

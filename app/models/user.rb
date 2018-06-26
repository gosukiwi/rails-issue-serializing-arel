class User < ApplicationRecord
  serialize :settings, Array

  class << self
    def search_by_settings(settings)
      query = user_table[:settings].matches_any serialize_settings(settings)
      User.where query
    end

    private

    def serialize_settings(settings)
      settings.map do |setting|
        serialize setting, with_like_operator: true
      end
    end

    def user_table
      User.arel_table
    end

    def serialize(value, with_like_operator: false)
      if with_like_operator
        "% #{value}\n%"
      else
        " #{value}\n"
      end
    end
  end
end

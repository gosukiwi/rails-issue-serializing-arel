# Issue when searching a serialized field with Arel

When serializing a field, I cannot use Arel to filter it's results:

```ruby
class User < ApplicationRecord
  serialize :settings, Array

  class << self
    def search_by_settings(settings)
      query = user_table[:settings].matches_any serialize_settings(settings)
      User.where query
    end
    # ...
  end
end

# ... in console
User.create name: "Mike", settings: [1, 2, 3]
# Ok
User.search_by_settings [1]
# This raises an exception
ActiveRecord::SerializationTypeMismatch: Attribute was supposed to be a Array, but was a String. -- "% 1\n%"
```

This seemed to just work with Rails 4.x but I can't seem to find any related
documentation on what changed, if any. Maybe it was working because of a bug or
something?

If I remove the serialization, it won't raise the exception.

You can see the full model at [here](app/models/user.rb).

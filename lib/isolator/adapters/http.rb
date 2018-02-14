# frozen_string_literal: true

require "sniffer"

Sniffer.config do |c|
  # Disable Sniffer logger
  c.logger = Logger.new(IO::NULL)
end

Isolator.isolate :http, Sniffer.singleton_class,
                 :store, exception_class: Isolator::NetworkRequestError

Isolator.before_isolate do
  Sniffer.enable!
end

Isolator.after_isolate do
  Sniffer.clear!
  Sniffer.disable!
end

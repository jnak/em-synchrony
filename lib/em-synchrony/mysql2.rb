begin
  require "mysql2/em_fiber"
rescue LoadError => error
  raise "Missing EM-Synchrony dependency: gem install mysql2"
end

module Mysql2
  module EM
    module Fiber
      class Client < ::Mysql2::EM::Client
        def query_id(sql, opts={})
          query(sql, opts)
          query('SELECT LAST_INSERT_ID() AS last_id;', opts)
        end
      end
    end
  end
end

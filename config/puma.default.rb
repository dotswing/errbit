# https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server

workers 1#Integer(ENV['WEB_CONCURRENCY'] || 2)
# threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads 1, 10 #threads_count, threads_count

preload_app!

bind 'unix:///tmp/errbit/errbit-puma.sock'
# rackup DefaultRackup
# port ENV['PORT'] || 8080
# environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

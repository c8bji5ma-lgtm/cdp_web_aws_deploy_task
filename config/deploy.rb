lock "~> 3.20"

set :application, "blog_app"

set :repo_url, "https://github.com/c8bji5ma-lgtm/cdp_web_aws_deploy_task.git"

set :branch, "master"

set :deploy_to, "/var/www/blog_app"

set :rails_env, "production"

set :keep_releases, 5

set :rbenv_type, :user
set :rbenv_ruby, "4.0.5"

set :bundle_version, "4.0.17"

append :linked_dirs,
       ".bundle",
       "log",
       "tmp/pids",
       "tmp/cache",
       "tmp/sockets",
       "storage"

set :default_env, {
  "RAILS_ENV" => "production",
  "NODE_OPTIONS" => "--openssl-legacy-provider"
}

namespace :deploy do
  desc "Install JavaScript dependencies"
  task :yarn_install do
    on roles(:web) do
      within release_path do
        execute :yarn, "install", "--frozen-lockfile"
      end
    end
  end

  before "deploy:assets:precompile", "deploy:yarn_install"

  desc "Restart Puma"
  task :restart_puma do
    on roles(:app) do
      execute :sudo, "/usr/bin/systemctl", "restart", "puma.service"
    end
  end

  after :publishing, :restart_puma
end

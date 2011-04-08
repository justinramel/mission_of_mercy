set :application, "mom"
set :repository,  "git@github.com:CTMissionofMercy/mission_of_mercy.git"

set :scm, :git
set :user, "deploy"

set :deploy_to, "/home/deploy/#{application}"
set :use_sudo, false

server "mom.integrityss.com", :app, :web, :db, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after 'deploy:update_code' do
  { "database.yml" => "config/database.yml",
    "mom.yml"      => "config/mom.yml"}.
   each do |from, to|
     run "ln -nfs #{shared_path}/#{from} #{release_path}/#{to}"
   end
end
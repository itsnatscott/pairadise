require 'sinatra'
require 'SQLite3'
db = SQLite3::Database.new "xmen.db"

rows = db.execute <<-SQL
create table if not exists xmen (
	id INTEGER PRIMARY KEY,
	name TEXT)
);
SQL
get '/' do
redirect('/mutants')

get "/mutants" do 
	erb :index.html, 




#
require 'sinatra'
require 'SQLite3'
db = SQLite3::Database.new "xmen.db"

rows = db.execute <<-SQL
create table if not exists xmen (
	id INTEGER PRIMARY KEY,
	realname TEXT, alias TEXT
);
SQL





get '/' do
redirect('/mutants')
end

get "/mutants" do 
	mutant_list= db.execute("SELECT * FROM xmen;")

	erb :index, locals: {muts: mutant_list}
end

get "/mutants/:id" do
	id = params[:id].to_i
	mutant= db.execute("SELECT * FROM xmen WHERE id = ?", id)
	erb :show, locals: {mut: mutant[0]}
end

post "/mutants" do
	db.execute("INSERT INTO xmen (realname, alias) VALUES (?,?);", params[:new_name], params[:new_alias])
	redirect('/')
end

put "/mutants/:id" do
	id=params[:id].to_i
	puts params[:newname]
	e_mutant= db.execute("UPDATE xmen SET realname= ?, alias= ? WHERE id=?;", params[:newname], params[:newalias], id)
	redirect("/mutants/#{id}")
end

delete "/mutants/:id" do 
	id=params[:id].to_i
	d_mutant= db.execute("DELETE FROM xmen WHERE id=?;", id)
	redirect('/')
end
#
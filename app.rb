require 'sinatra'
class Todo 
	attr_accessor :task, :done, :imp, :urgent
	def initialize task
		@task=task
		@done=false
		@imp=false
		@urgent=false
	end
end
tasks=[]
get '/' do 
	data=Hash.new
	data[:tasks]=tasks
	erb :index, locals: data
end
post '/add' do
	puts params
	task=params["task"]
	todo=Todo.new task
	tasks << todo
	return redirect '/'
end
post '/checkimp' do
	input_item=params['task']
  input_prio_imp=params['importance']
  input_prio_urg=params['urgent']
  tasks.each do |i|
    if i.task==input_item
      if input_prio_imp=="on"
        if input_prio_urg=="on" #red
          i.imp = !i.imp
          i.urgent = !i.urgent
        else
          i.imp = !i.imp #yellow
          i.urgent = i.urgent
        end
      else
        if input_prio_urg=="on" #green
          i.imp = i.imp
          i.urgent = !i.urgent
        else                #grey
          i.imp = i.imp
          i.urgent = i.urgent
        end
      end


    end
  end
	return redirect '/'
end
post '/done' do
	task=params["task"]
	tasks.each do |todo|
		if todo.task== task
			todo.done=!todo.done
		end
	end

	return redirect '/'
end
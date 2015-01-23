# # RedisNotifications
# ### extends [NPM:MPBasic](https://cdn.rawgit.com/mpneuried/mpbaisc/master/_docs/index.coffee.html)
#
# ### Exports: *Class*
#
# Main Module to init the notifications to redis
# 

# **internal modules**
# [RNWorker](./worker.coffee.html)
Worker = require( "./worker" ) 

class RedisNotifications extends require( "mpbasic" )()

	# ## defaults
	default: =>
		@extend super, 
			# **options.queuename** *String* The queuename to use for the worker
			queuename: "notifications"
			# **options.interval** *Number[]* An Array of increasing wait times in seconds
			interval: [ 0, 1, 5, 10 ]

			# **options.host** *String* Redis host name
			host: "localhost"
			# **options.port** *Number* Redis port
			port: 6379
			# **options.options** *Object* Redis options
			options: {}
			# **options.client** *RedisClient* Exsiting redis client instance
			client: null
			# **options.prefix** *String* A general redis prefix
			prefix: "notifications"

	###	
	## constructor 
	###
	constructor: ( options )->
		super
		@worker = new RSMQWorker( @config.queuename, @config )

		@start()
		# wrap start method to only be active until the connection is established
		@start = @_waitUntil( @_start, "connected" )
		return

	_start: =>
		@worker.on "message", @

		@debug "START"
		return

#export this class
module.exports = RedisNotifications
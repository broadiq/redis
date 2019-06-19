# Redis


# How to use this image

This image is meant to be used with [BroadIQ](https://www.broadiq.com).  Please go to BroadIQ and create an account if you don't have one.  Then you can use BroadIQ's tools to deploy the image.


Running the Redis server
------------------------

The process of running this image is simplified by using the [BroadIQ](https://www.broadiq.com) plaform and selecting `Redis` from the application marketplace.  

This image can also be run as a Docker container by following the instructions below.

If you want to use a preset password instead of a random generated one, you can
set the environment variable `REDIS_PASS` to your specific password when running the container:

	docker run -d -p 6379:6379 -e REDIS_PASS="mypass" broadiq/redis

You can now test your deployment:

	redis-cli -a mypass

If you want to disable password authentication, you can set `REDIS_PASS` to `**empty**`:

    docker run -d -p 6379:6379 -e REDIS_PASS="**empty**" broadiq/redis


If you run this docker image without a `REDIS_PASS` variable, a new random password will be set.

o get the password, check the logs of the container by running:

	docker logs <CONTAINER_ID>

You will see an output like the following:

	========================================================================
	You can now connect to this Redis server using:

	    redis-cli -a 5elsT6KtjrqVtOitprnDm7M9Vgz0MGgu -h <host> -p <port>

	Please remember to change the above password as soon as possible!
	========================================================================

In this case, `5elsT6KtjrqVtOitprnDm7M9Vgz0MGgu` is the password set.
You can then connect to Redis:

	redis-cli -a 5elsT6KtjrqVtOitprnDm7M9Vgz0MGgu



Configuring Redis
-----------------

If you want to pass in any configuration variable to redis, set it as an environment variable with a `REDIS_` prefix. For example, if you want to set `tcp-keepalive 60`, execute the following:

	docker run -d -p 6379:6379 -e REDIS_TCP_KEEPALIVE=60 broadiq/redis

For a full list of configuration options, check [this commented redis.conf file](https://raw.githubusercontent.com/antirez/redis/2.8/redis.conf)


Configuring Redis as a LRU cache
--------------------------------

In order to run Redis as a cache that will delete older entries when the memory fills up
provide the following additional environment variables:

	docker run -d -p 6379:6379 -e REDIS_MAXMEMORY_POLICY="allkeys-lru" -e REDIS_MAXMEMORY="256mb" broadiq/redis

More info at [redis.io](http://redis.io/topics/lru-cache)


Configuring Redis to use AOF
----------------------------

If you want Redis to store data in a volume to prevent data from disappearing should you restart the container, set the following environment variables:

	docker run -d -p 6379:6379 -e REDIS_APPENDONLY=yes -e REDIS_APPENDFSYNC=always broadiq/redis

Please note that this will impact performance. For a more lightweight persistence by saving every second instead of every instruction, use `REDIS_APPENDFSYNC=everysec` instead. More info at [redis.io](http://redis.io/topics/persistence)

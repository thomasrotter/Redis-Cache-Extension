<cfcomponent extends="Cache">
	<cfset fields = array(
		field(displayName = "Master name",
			name = "masterName",
			defaultValue = "",
			required = true,
			description = "Sentinel master name",
			type = "text"
			),
		field(displayName = "Sentinels",
			name = "sentinels",
			defaultValue = "localhost:6379",
			required = true,
			description = "Sentinels",
			type = "textarea"
			),
		field(
			displayName = "Namespace",
			name = "namespace",
			defaultValue = "lucee:cache",
			required = true,
			description = "Keys namespace. Be sure that any cache use a unique namespace to avoid keys names clashing."
			   )
			)>

	<cffunction name="getClass" returntype="string">
		<cfreturn "lucee.extension.io.cache.redis.RedisSentinelCache">
	</cffunction>

	<cffunction name="getLabel" returntype="string" output="no">
		<cfreturn "RedisSentinelCache">
	</cffunction>

	<cffunction name="getDescription" returntype="string" output="no">
		<cfset var c = "">
		<cfsavecontent variable="c">
			This is the Redis Cache implementation for Lucee. This allows you to cache objects, primitives and queries in a Redis server that can be used as a cache.
		</cfsavecontent>
		<cfreturn trim(c)>
	</cffunction>

</cfcomponent>
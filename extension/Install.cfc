<cfcomponent>

	<cfscript>
		variables.name = "RedisCache";
		variables.id = "lucee.extension.io.cache.RedisCache";
		variables.jar = "redis-cache.jar";
		variables.driver = "RedisCache.cfc";
		variables.jars = "#variables.jar#,jedis-2.1.0.jar,commons-pool-1.5.5.jar";
	</cfscript>

    <cffunction name="validate" returntype="void" output="no"
    	hint="called to validate values">
    	<cfargument name="error" type="struct">
        <cfargument name="path" type="string">
        <cfargument name="config" type="struct">
        <cfargument name="step" type="numeric">

    </cffunction>

    <cffunction name="install" returntype="string" output="no"
    	hint="called from Lucee to install application">
    	<cfargument name="error" type="struct">
        <cfargument name="path" type="string">
        <cfargument name="config" type="struct">


		<cfloop list="#variables.jars#" index="i">
            <cffile
            action="copy"
            source="#path#lib/#i#"
            destination="#getContextPath()#/lib/#i#">
		</cfloop>

		<cffile action="copy"
		        source="#path#driver/#variables.driver#"
		        destination="#expandPath('{lucee-web}')#/context/admin/cdriver/" />

        <!---
        <cfadmin
        	action="updateContext"
            type="#request.adminType#"
            password="#session["password"&request.adminType]#"
            source="#path#driver/#variables.driver#"
            destination="admin/cdriver/#variables.driver#">
        --->

        <cfreturn '#variables.name# is now successfully installed'>

	</cffunction>

     <cffunction name="update" returntype="string" output="no"
    	hint="called from Lucee to update a existing application">
    	<cfargument name="error" type="struct">
        <cfargument name="path" type="string">
        <cfargument name="config" type="struct">
        <cfset uninstall(path,config)>
		<cfreturn install(argumentCollection=arguments)>
    </cffunction>


    <cffunction name="uninstall" returntype="string" output="no"
    	hint="called from Lucee to uninstall application">
    	<cfargument name="path" type="string">
        <cfargument name="config" type="struct">

		<cfloop list="#variables.jars#" index="i">
            <cffile
            action="delete"
            file="#getContextPath()#/lib/#i#">
		</cfloop>

        <cfadmin
        	action="removeContext"
            type="#request.adminType#"
            password="#session["password"&request.adminType]#"
            destination="admin/cdriver/#variables.driver#">

        <cfreturn '#variables.name# is now successfully removed'>

    </cffunction>

    <cffunction name="hasExtension" returntype="boolean">
        <cfargument name="name" type="string" required="yes">
        <cfset var extensions="">
        <cfadmin
            action="getExtensions"
            type="#request.adminType#"
            password="#session["password"&request.adminType]#"
            returnVariable="extensions">
         <cfloop query="extensions">
            <cfif extensions.name EQ arguments.name>
                <cfreturn true>
            </cfif>
         </cfloop>
         <cfreturn false>
    </cffunction>

    <cffunction name="getContextPath" access="private" returntype="string">

        <cfswitch expression="#request.adminType#">
            <cfcase value="web">
                <cfreturn expandPath('{lucee-web}') />
            </cfcase>
            <cfcase value="server">
                <cfreturn expandPath('{lucee-server}') />
            </cfcase>
        </cfswitch>

    </cffunction>

</cfcomponent>
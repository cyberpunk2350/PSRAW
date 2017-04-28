<#	
	.NOTES
	===========================================================================
	 Created with:  VSCode
	 Created on:    4/26/2017 3:37 PM
	 Edited on:     4/28/2017
	 Created by:    Mark Kraus
	 Organization: 	
	 Filename:      RedditApplication.ps1
	===========================================================================
	.DESCRIPTION
		RedditApplication Class
#>
# Import RedditApplicationType Enum
Using module '..\Enums\RedditApplicationType.psm1'
Using module '..\Classes\RedditScope.psm1'

Class RedditApplication {
	[String]$Name
	[String]$Description
	[uri]$RedirectUri
	[String]$UserAgent
	[RedditApplicationType]$Type
	[String]$ClientID
	[guid]$GUID = [guid]::NewGuid()
	[string]$ExportPath
	[String]$ScriptUser
	[RedditScope[]]$Scope
	hidden [System.Management.Automation.PSCredential]$ClientCredential
	hidden [System.Management.Automation.PSCredential]$UserCredential
	
	#Default constructor provided for compatibility only
	RedditApplication () {
		throw [System.NotImplementedException]::New()
	}

	#Hijack Hashtable Coverter
	RedditApplication ([System.Collections.Hashtable]$InitHash) {
		$This._init($InitHash)
	}

	hidden [void] _init ([System.Collections.Hashtable]$InitHash){
		if(-not (
				$InitHash.Type.toString() -and $InitHash.ClientCredential -and 
				$InitHash.RedirectUri -and $InitHash.UserAgent
			)){
			throw [System.ArgumentException]::New(
				"'Type', 'ClientCredential', 'UserAgent', and 'RedirectUri' are required."
			)
		}
		if($InitHash.Type -like 'Script' -and -not $InitHash.UserCredential){
			throw [System.ArgumentException]::New(
				"'UserCredential' required for 'Script' type"
			)
		}
		foreach($Item in $InitHash.GetEnumerator()){
			$This.$($Item.name) = $Item.Value
		}
		$This.ClientID = $This.ClientCredential.UserName
		if($This.Type -eq [RedditApplicationType]::Script){
			$This.ScriptUser = $This.UserCredential.UserName
		}
		else{
			$This.ScriptUser = $This.ClientID
		}
	}
}
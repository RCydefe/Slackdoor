# --------------------------**Slackdoor**--------------------------

## **What is Slackdoor?**

Slackdoor is a powershell script that calls out to a designated slack message for C2. After the command is ran Slackdoor send its results back to the slack workspace. 
If the red team member wants to change what Slackdoor is doing they simply need to edit the desiganted message Slackdoor checks. 

## **What should I know before I start?**
1) For persistence a scheduled needs to be created that runs Slackdoor.  
2) An app will need to be added to the slack workspace used for C2. This can be done at https://api.slack.com/apps 
3) Once the app is created it will need a token made in the OAth section of the app and the scopes of channels:read, channels:history, and 
incoming-webhook added.
4) To discover the channel ID run Invoke-WebRequest https://slack.com/api/channels.list?token=insert_app_OAth_token_here | select-object -Property content -ExpandProperty content
5) To discver a messages ts run Invoke-WebRequest https://slack.com/api/converstation.history?token=insert_app_OAth_token_here"&"channel=insert_channel_id_here | select-object -Property content -ExpandProperty content

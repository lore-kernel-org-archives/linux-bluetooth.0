Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43EE5A8F.6090303@cs.bgu.ac.il>
From: Niv <nivv@cs.bgu.ac.il>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] a2play stops when scanning
References: <Pine.LNX.4.44.0602082335310.13414-100000@lvs-rs3> <43EA8708.1060302@xmission.com>
In-Reply-To: <43EA8708.1060302@xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 11 Feb 2006 23:43:43 +0200

I tried to recreate it.
managed to stop the audio when I ran the scan, but afterward it came back.
I will test it better soon
can you pls test if you can hear this mp3 using:
mpg321 --au - Letters.mp3 |/uar/bin/a2play <bdaddr>

http://www.cs.bgu.ac.il/~nivv/Letters.mp3

It brakes up here.
Niv

Brad Midgley wrote:

>NIV
>
>Can I get the exact error message? Strange that sdp should even be
>concerned after it's playing... is a2play telling you that or hcitool?
>
>Brad
>
>  
>
>>Hi Brad,
>>I am sure it was reported before, but just to make sure:
>>while playing mpg321 ->a2play I ran hcitool
>>that caused a2play to exit and tell me that the SDP returned bad value.
>>I can quote the excat phrase if you need it, but the idea is that a 
>>discovery drops a2play.
>>In windows it is suggested this may cause disturbance.
>>
>>
>>Thanks again for allowing me to listen to BT , while my room-mate goes to 
>>sleep :->
>>
>>Niv
>>
>>P.S.
>>the Ekiga issue aint btsco fault.
>>
>>
>>
>>
>>-------------------------------------------------------
>>This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
>>for problems?  Stop!  Download the new AJAX search engine that makes
>>searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
>>http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
>>_______________________________________________
>>Bluez-users mailing list
>>Bluez-users@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/bluez-users
>>    
>>
>
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
>for problems?  Stop!  Download the new AJAX search engine that makes
>searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
>http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>  
>



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

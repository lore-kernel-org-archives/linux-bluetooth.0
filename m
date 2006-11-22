Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <001401c70e33$e411ef10$6501a8c0@den>
From: "Dave sailer" <d.sailer@comcast.net>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
References: <4563C044.3030200@comcast.net>
	<1164178798.23477.23.camel@localhost>
Date: Wed, 22 Nov 2006 07:44:02 -0500
MIME-Version: 1.0
Subject: Re: [Bluez-users] hcid.conf multiple dongles
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

thanks for the info. Can you elaborate a bit? Regarding what the kb/mouse 
connect to, does that mean I'll reconnect to the last dongle that had any 
activity? Maybe this is a moot point if I can take advantage of the D-bus 
persistent connection. Regarding that, I googled (and searched here) for 
"persistent dbus bluetooth connection" and didn't come up with much. Can you 
point me at some documentation?

thanks again

----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Sent: Wednesday, November 22, 2006 1:59 AM
Subject: Re: [Bluez-users] hcid.conf multiple dongles


> Hi Dave,
>
>> I have a Microsoft bluetooth keyboard and mouse that has worked well for
>> some time. I bought new bluetooth dongle (Kensington) in hopes of
>> getting my palm to connect via bluetooth (the Microsoft dongle didn't
>> work for this). With this arrangement, how do I control which dongle the
>> keyboard & mouse connect to? (it seems more reliable with Microsoft to
>> Microsoft).
>
> the mouse and keyboard know the address of the last user and will
> reconnect to that dongle.
>
>> Also, the results of "hci tool scan" are confusing me a bit. For
>> example, I get...
>>
>> myth1 ~ # hcitool scan
>> Scanning ...
>>         00:50:F2:7E:11:F1       Myth1 Kensington dongle4
>>
>>
>> firstly, this bdadr is the microsoft dongle. Does this normally return a
>> dongle address? At one point I'm sure it was returning the palm pilot
>> address. Secondly, this name "Myth1 Kensington dongle4" is old. I used
>> to have that in hcid.conf, but changed it and even rebooted the box.
>> Just for history, at one point I had an hcid.conf file with only one
>> device section (no device id's). Now I have the following ... (wasn't
>> sure about the device syntax, but this seems to work. btw, it would be
>> nice if the hcid.conf man page was more clear about the syntax on how to
>> specify multiple devices)
>
> Feel free to send in a patch for the manual page. Nowadays you can do
> persistent settings of the class and device name via D-Bus. It is much
> easier and you don't have to edit any config files.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share 
> your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

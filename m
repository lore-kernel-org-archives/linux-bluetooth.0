Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4564DD54.50500@comcast.net>
Date: Wed, 22 Nov 2006 18:29:24 -0500
From: dave sailer <d.sailer@comcast.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4563C044.3030200@comcast.net>	<1164178798.23477.23.camel@localhost>
	<001401c70e33$e411ef10$6501a8c0@den>
In-Reply-To: <001401c70e33$e411ef10$6501a8c0@den>
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

Dave sailer wrote:
> ----- Original Message ----- 
> From: "Marcel Holtmann" <marcel@holtmann.org>
> To: "BlueZ users" <bluez-users@lists.sourceforge.net>
> Sent: Wednesday, November 22, 2006 1:59 AM
> Subject: Re: [Bluez-users] hcid.conf multiple dongles
>
>
>   
>> Hi Dave,
>>
>>     
>>> I have a Microsoft bluetooth keyboard and mouse that has worked well for
>>> some time. I bought new bluetooth dongle (Kensington) in hopes of
>>> getting my palm to connect via bluetooth (the Microsoft dongle didn't
>>> work for this). With this arrangement, how do I control which dongle the
>>> keyboard & mouse connect to? (it seems more reliable with Microsoft to
>>> Microsoft).
>>>       
>> the mouse and keyboard know the address of the last user and will
>> reconnect to that dongle.
>>
>>     
>>> Also, the results of "hci tool scan" are confusing me a bit. For
>>> example, I get...
>>>
>>> myth1 ~ # hcitool scan
>>> Scanning ...
>>>         00:50:F2:7E:11:F1       Myth1 Kensington dongle4
>>>
>>>
>>> firstly, this bdadr is the microsoft dongle. Does this normally return a
>>> dongle address? At one point I'm sure it was returning the palm pilot
>>> address. Secondly, this name "Myth1 Kensington dongle4" is old. I used
>>> to have that in hcid.conf, but changed it and even rebooted the box.
>>> Just for history, at one point I had an hcid.conf file with only one
>>> device section (no device id's). Now I have the following ... (wasn't
>>> sure about the device syntax, but this seems to work. btw, it would be
>>> nice if the hcid.conf man page was more clear about the syntax on how to
>>> specify multiple devices)
>>>       
>> Feel free to send in a patch for the manual page. Nowadays you can do
>> persistent settings of the class and device name via D-Bus. It is much
>> easier and you don't have to edit any config files.
>>
>> Regards
>>
>> Marcel
>>
>>
>>
>> -------------------------------------------------------------------------
>>
>>     
>
>
>
>   
sorry for the previous top post. ...

any hint here at all? I can't seem to track any more details down on
this. Looked around at bluez.org and freedesk.org and google - couldnt'
find much.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

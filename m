Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] What's the best way to go about device detection?
From: Marcel Holtmann <marcel@holtmann.org>
To: Rob Raper <djrobx@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY14-F18SByh133tYw0004e544@hotmail.com>
References: <BAY14-F18SByh133tYw0004e544@hotmail.com>
Content-Type: text/plain
Message-Id: <1084791892.4109.5.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 17 May 2004 13:04:52 +0200

Hi Rob,

> Without involving any of my source code at alll, I can demonstrate one of my 
> biggest problems.     I'll first create a connection to an existing 
> bluetooth device.  It works fine.  I can get an RSSI value or link value.  
> Then, I'lll try a non-existent device.   I get a connection timed out error 
> fairly quickly.  Great, that's exactly what I want and what I expect.  What 
> follows, however, is what is really causing me problems.  I can no longer 
> connect to the valid bt device.   I just get errors for a long time.  I 
> can't disconnect either.   How can I clear out the failed connection and 
> move on without everything breaking down like this?
> 
> pluto62:~/bluez-utils-2.4/tools# hcitool cc 00:60:57:23:35:15
> pluto62:~/bluez-utils-2.4/tools# hcitool rssi 00:60:57:23:35:15
> RSSI return value: -1
> pluto62:~/bluez-utils-2.4/tools# hcitool dc 00:60:57:23:35:15
> 
> So far so good...Now try an invalid address
> 
> pluto62:~/bluez-utils-2.4/tools# hcitool cc 00:60:57:23:35:14
> Can't create connection: Connection timed out
> 
> As expected.
> 
> pluto62:~/bluez-utils-2.4/tools# hcitool dc 00:60:57:23:35:14
> Disconnect failed: Input/output error
> 
> Why an input/output error?  It's on the con list, how do I get it off?

if create_connection fails no ACL link is in the connection list and
there is no need to disconnect it unless we have a bug in the Bluetooth
core layer. However using the native HCI create_connection and
disconnect functions is not a good idea and the timeout you see is not
from the Bluetooth chip I think. If the create_connection process is
still running you can't disconnect anything and in some cases you
trouble the Bluetooth chip with such actions. Check with hcidump what is
going on.

What kind of Bluetooth modules are you using? Show us "hciconfig -a".

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

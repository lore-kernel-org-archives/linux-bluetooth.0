Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: PIN for Microsoft Mouse (Marcel Holtmann)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <6D4DC8B4AD16D6118E8200D0B76FE2621033CFE5@ont06exm01.comm.mot.com>
References: 
	 <6D4DC8B4AD16D6118E8200D0B76FE2621033CFE5@ont06exm01.comm.mot.com>
Content-Type: text/plain
Message-Id: <1112976112.9783.7.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 08 Apr 2005 18:01:52 +0200

Hi Victor,

> Here's the output of hciconfig as well as some other commands, if you
> have the time
> to read them :)
> 
> As I've mentioned in my first post, I can connect mouse with security
> manager, auth and encryption all off, however the connection does not
> "stay", ie. I need to pair the mouse each time I turn on the computer.

so you are using security mode 3 and in this case this is how it will
be, because the mouse can't store a link key. And actually if you follow
the HID profile then it don't have to.

Use security mode 1/2 and if needed add --encrypt when you start the
hidd server daemon.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

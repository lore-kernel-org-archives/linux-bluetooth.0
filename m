Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BT3030
From: Marcel Holtmann <marcel@holtmann.org>
To: =?koi8-r?Q?=E8=C5=C4=C9=CE?= <hedin@hiervard.ru>
Cc: bluez-users@lists.sf.net
In-Reply-To: <200405192102.06654.hedin@hiervard.ru>
References: <200405192102.06654.hedin@hiervard.ru>
Content-Type: text/plain
Message-Id: <1084975835.4327.70.camel@pegasus>
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
Date: Wed, 19 May 2004 16:10:35 +0200

Hi,

> Still can't understand. I got /sys, put firmware.agent to /etc/hotpug 
> (installed linux-hotplug package) and .BIN and .HEX files to 
> /usr/lib/hotplug/firware.
> 
> After plugging in the device and loading the module `bcm203x' it still gives 
> an -5 error about failing to load some mini-driver.

is CONFIG_HOTPLUG enabled in your kernel? Are the executable bits of
/etc/hotplug/firmware.agent set? For more detailed logs enable the debug
option in your hotplug scripts.

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

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: one more thing (was Re: [Bluez-users] apple wireless mouse on
	apple ibook (g4, builtin	usb))
From: Marcel Holtmann <marcel@holtmann.org>
To: Sunnan <sunnan@handgranat.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <402D56EB.9010600@handgranat.org>
References: <402D07B8.8030504@handgranat.org>
	 <1076694675.2671.191.camel@pegasus>  <402D1E8C.6020301@handgranat.org>
	 <1076702197.18588.11.camel@pegasus>  <402D381D.1000306@handgranat.org>
	 <1076709007.18588.39.camel@pegasus>  <402D4959.10704@handgranat.org>
	 <1076711341.18588.57.camel@pegasus>  <402D56EB.9010600@handgranat.org>
Content-Type: text/plain
Message-Id: <1076714576.18588.98.camel@pegasus>
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
Date: Sat, 14 Feb 2004 00:22:56 +0100

Hi Sunnan,

> slowstorm/home/sunnan% hcitool inq
> Inquiring ...

make sure your mouse is visible.

> slowstorm/home/sunnan% hcitool dev
> Devices:
>          hci0    00:0D:93:04:19:15
> slowstorm/home/sunnan% hcitool info 00:0D:93:04:19:15
> Device is not available or not connected.

This can't work, because you try to connect to your local device ;)

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] apple wireless mouse on apple ibook (g4, builtin
	usb)
From: Marcel Holtmann <marcel@holtmann.org>
To: Sunnan <sunnan@handgranat.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <402D5EB0.3090601@handgranat.org>
References: <402D07B8.8030504@handgranat.org>
	 <1076694675.2671.191.camel@pegasus>  <402D1E8C.6020301@handgranat.org>
	 <1076702197.18588.11.camel@pegasus>  <402D381D.1000306@handgranat.org>
	 <1076709007.18588.39.camel@pegasus>  <402D4959.10704@handgranat.org>
	 <1076711341.18588.57.camel@pegasus>  <402D5592.3060907@handgranat.org>
	 <1076714464.18588.95.camel@pegasus>  <402D5EB0.3090601@handgranat.org>
Content-Type: text/plain
Message-Id: <1076720052.18588.147.camel@pegasus>
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
Date: Sat, 14 Feb 2004 01:54:12 +0100

Hi Sunnan,

> slowstorm/home/sunnan% grep pin /etc/bluetooth/hcid.conf
>          pin_helper /usr/local/bin/pin-helper.sh;
> 
> slowstorm/home/sunnan% cat /usr/local/bin/pin-helper.sh
> #!/bin/sh
> echo "PIN:0000"
> slowstorm/home/sunnan% cat /etc/bluetooth/pin
> 0000

is the script executable? Do you restarted hcid?

> could it be that the mouse has been used under OS X? The weird OS X ui 
> blathered something about "pairing" and so on. I haven't used it for a 
> few months so I don't really remember how it was.

Could be, but in general it would pair again in this case.

> I do keep my mouse close at hand, and I've tried turning it on and off 
> and clicking and moving. I don't see what is supposed to happen.

We really need a full binary hcidump to see what is going on.

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

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problem with pppd through bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: igorluiz@magiclink.com.br
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1077878878.21031.13.camel@emerald>
References: <1077831499.7219.34.camel@emerald>
	 <1077843554.2843.19.camel@pegasus>  <1077878878.21031.13.camel@emerald>
Content-Type: text/plain
Message-Id: <1077890137.2843.42.camel@pegasus>
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
Date: Fri, 27 Feb 2004 14:55:37 +0100

Hi Igor,

> Sorry about my innocence :-)))), but when you say "use the kernel RFCOMM
> layer", you mean load the module "rfcomm" (or even have it built in the
> kernel) ???
> If so, I already have the module(rfcomm) loaded...

loading the kernel module is enough, but it seems that you have you have
the wrong rfcomm utility. The BlueZ utils packages also contains a
rfcomm program that can be used to setup /dev/rfcomm0 TTY devices that
work exactly like a serial port. Of course you have to create the device
nodes first.

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

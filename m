Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluez on Axis DevBoard 82
From: Marcel Holtmann <marcel@holtmann.org>
To: Tobias Sprafke <webmaster@baxter-net.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <DGELJAKAPGMFDACACGBEGEHNCCAA.webmaster@baxter-net.de>
References: <DGELJAKAPGMFDACACGBEGEHNCCAA.webmaster@baxter-net.de>
Content-Type: text/plain
Message-Id: <1078323872.2787.105.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 03 Mar 2004 15:24:32 +0100

Hi Tobias,

> we need help to compile and install Bluez on the Axis Devboard 82 with a
> cross-compiler.
> 
> The DevBoard-Software is running on our computer and we flashed the new
> kernel on the DevBoard successful.
> 
> We solved the kernel part of bluez as well, but we don't know, how to
> configure and install the other parts.

what are you talking about? What do you have solved?

> We need the packages bluez-libs, -utils, -sdp and -pan on the DevBoard.
> 
> Can somebody give as an example for how to compile such a package with
> cris-gcc?

In general it should be enough to set some environment variables like CC
and LD and then call configure with it.

	env CC="cris-gcc" LD="cris-ld" ./configure

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Bluez on Axis DevBoard 82
From: Marcel Holtmann <marcel@holtmann.org>
To: Tobias Sprafke <webmaster@baxter-net.de>
Cc: Eric Chapman <eric@lnt.uni-saarland.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <DGELJAKAPGMFDACACGBEKEJECCAA.webmaster@baxter-net.de>
References: <DGELJAKAPGMFDACACGBEKEJECCAA.webmaster@baxter-net.de>
Content-Type: text/plain
Message-Id: <1078765296.10671.14.camel@pegasus>
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
Date: Mon, 08 Mar 2004 18:01:36 +0100

Hi Tobias,

> with "kernel part of bluez" I really mean this part of bluez,
> which could be configured in the linux kernel.
> After installing the Axis-DevBoard-Software, there isn't a submenu for
> Bluetooth anymore
> when running "make xconfig" ...

this must be a bug. What kernel do you use? Maybe it is some Axis OpenBT
specific cruft of the Cris architecture. If so, it must be removed and
patches are welcome.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Where do I report a kernel OOPS?
From: Marcel Holtmann <marcel@holtmann.org>
To: cybermans@xs4all.nl
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1081178729.13350.8.camel@localhost>
References: <1081178729.13350.8.camel@localhost>
Content-Type: text/plain
Message-Id: <1081179303.2843.3.camel@pegasus>
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
Date: Mon, 05 Apr 2004 17:35:03 +0200

Hi Mans,

> When shutting down my PC with my dongle attached the kernel generates an
> OOPS and completely freezes. Without dongle everything is ok. Also when
> removing the dongle during runtime it will lock. The problem start
> showing up since I moved from 2.4 kernels to 2.6 stock kernels. Is this
> a known problem? If yes, is there a patch?

this problem is known, but it is not a Bluetooth problem. Ask the USB
guys about a patch for it.

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

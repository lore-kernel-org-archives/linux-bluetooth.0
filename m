Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Fix to enable bluez SCO USB urbs.
From: Marcel Holtmann <marcel@holtmann.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <403FD968.6010004@superbug.demon.co.uk>
References: <403FD968.6010004@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1077972736.2843.60.camel@pegasus>
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
Date: Sat, 28 Feb 2004 13:52:16 +0100

Hi James,

> Here is a patch for /usr/src/linux-2.6.3/drivers/bluetooth/hci_usb.c
> 
> Without the interval set, the latest kernel 2.6.3 usb code will reject 
> the usb_submit_urb().
> 
> Without this patch no ISOC urbs are submitted, and thus no SCO data is 
> passed.

the same patch is already in 2.6.4-rc1.

> The proper fix would really be to only enable these when a SCO 
> connection is actually open.

Of course. Send me patches for it.

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

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problem with BlueLogic WingKey Keyboard
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <423F5E1C.8030301@rz-zw.fh-kl.de>
References: <200503202301.49376.tv@rz-zw.fh-kl.de>
	 <1111408373.22872.54.camel@pegasus> <423F5B7F.9060200@rz-zw.fh-kl.de>
	 <423F5E1C.8030301@rz-zw.fh-kl.de>
Content-Type: text/plain
Message-Id: <1111453185.22872.84.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 22 Mar 2005 01:59:45 +0100

Hi Timo,

> Hm if I try to patch the gentoo-dev-sources kernel I get this:
> 
> tristan linux # zcat /home/timo/tmp/patch-2.6.11-mh2.gz | patch -p1 
> --dry-run
> patching file drivers/bluetooth/bluecard_cs.c
> patching file drivers/bluetooth/hci_bcsp.c
> patching file drivers/bluetooth/hci_usb.c
> patching file include/net/bluetooth/hci_core.h
> patching file MAINTAINERS
> patching file Makefile
> Hunk #1 FAILED at 1.
> 1 out of 1 hunk FAILED -- saving rejects to file Makefile.rej
> patching file net/bluetooth/hci_conn.c
> patching file net/bluetooth/hci_event.c
> patching file net/bluetooth/hci_sysfs.c
> patching file net/bluetooth/hidp/core.c
> patching file net/bluetooth/hidp/hid.c
> patching file net/bluetooth/hidp/hid.h
> patching file net/bluetooth/hidp/hidp.h
> patching file net/bluetooth/hidp/Makefile
> patching file net/bluetooth/rfcomm/core.c
> 
> There is one failure. Should I use vanilla sources or is this ok? I 
> found a little HOWTO in the gentoo forums where a similar failure was 
> described as "normal".

a clash with the Makefile is fine. If you look at Makefile.rej you will
see why this must happen ;)

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Unable to get hciattach to work...
From: Marcel Holtmann <marcel@holtmann.org>
To: Michael Frey <mfrey@pepper.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <E09DAEFD-93A2-11D8-88A9-00039390D626@pepper.com>
References: <E09DAEFD-93A2-11D8-88A9-00039390D626@pepper.com>
Content-Type: text/plain
Message-Id: <1082559461.23959.37.camel@pegasus>
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
Date: Wed, 21 Apr 2004 16:57:41 +0200

Hi Michael,

> I just recently upgraded my kernel from 2.4.18 to 2.4.20 and am trying 
> to get my bluetooth module to work.  I have been using bluez with great 
> success with my 2.4.18 kernel but no luck with 2.4.20.
> 
> When I issue the hciattach command here is what I get.
> ./hciattach /dev/ttyS1 bcsp 115200
> BlueZ HCI UART driver ver 2.0 Copyright (C) 2000,2001 Qualcomm Inc
> Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> insmod: Note: /etc/modules.conf is more recent than 
> /lib/modules/2.4.20_mvl31-dbpxa2xx/modules.dep
> Can't set device: Protocol not supported
> Can't initialize device: Illegal seek
> root@(none):/opt/bluetooth# lsmod
> Module                  Size  Used by    Tainted: P
> hci_uart                5444   0  (autoclean)
> bluez                  34672   1  (autoclean) [hci_uart]
> spectrum_cs            75772   1
> orinoco                33716   0  [spectrum_cs]
> hermes                  4408   0  [spectrum_cs orinoco]
> ide-cs                  3572   1
> ds                      7472   2  [spectrum_cs ide-cs]
> pxa_cs                  9296   2
> pcmcia_core            34672   0  [spectrum_cs ide-cs ds pxa_cs]
> 
> 
> How do I go about debugging this?  I am using the kernel modules that 
> are in the kernel tree.

the plain vanilla 2.4.20 don't includes BCSP support. If you got the
2.4.18 working with BCSP you must have used a patched kernel.

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

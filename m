Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Fighting with SCO
From: Marcel Holtmann <marcel@holtmann.org>
To: Till Harbaum <till@harbaum.org>
Cc: Till Harbaum <harbaum@beecon.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200408262229.26435.till@harbaum.org>
References: <200408261852.56641.harbaum@beecon.de>
	 <200408262000.07077.till@harbaum.org> <1093548184.2581.48.camel@pegasus>
	 <200408262229.26435.till@harbaum.org>
Content-Type: text/plain
Message-Id: <1093552593.2581.69.camel@pegasus>
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
Date: Thu, 26 Aug 2004 22:36:33 +0200

Hi Till,

> > do you played with the PS key settings, because the default for the Acer
> > was sending SCO traffic over the PCM interface. Use the revision command
> > to check where the SCO traffic is routed through.
> No, i didn't. The factory settings of my BT-600 are:

so the guys from Acer learned something ;)

> phobos:/home/harbaum # hciconfig hci0 revision
> hci0:   Type: USB
>         BD Address: 00:02:72:B1:59:03 ACL MTU: 192:8  SCO MTU: 64:8
>         HCI 16.4
>         Chip version: BlueCore02
>         Max key size: 56 bit
>         SCO mapping:  HCI
> 
> But so says the DBT-120 dongle i did not have success with:
> hci0:   Type: USB
>         BD Address: 00:0D:88:C0:3C:E4 ACL MTU: 192:8  SCO MTU: 64:8
>         HCI 15.3
>         Chip version: BlueCore02
>         Max key size: 56 bit
>         SCO mapping:  HCI
> 
> I tried this command at work with the microsoft dongle, but the i only got 
> 16.1 as the hci version and then the program hanged. The kernel log showed 
> some hci timeouts.

Maybe this depends on the USB host controller chip. I got reports that
some ALI chips misbehave when it comes to ISOC transfers. If you have
access to MacOS X you can unpack the firmware update from Apple and use
GenericCSR.dfu and btdfu-0.3 to update your D-Link dongle to HCI 18.1
and HID proxy. Don't try this if it is a revision B4 dongle.

You should also check that the SCO support for the hci_usb driver was
compiled in.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

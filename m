Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bc2 vs bc2es firmware
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200412022343.07311.pavouk@pavouk.org>
References: <200412022343.07311.pavouk@pavouk.org>
Content-Type: text/plain
Message-Id: <1102042602.7350.29.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 03 Dec 2004 03:56:42 +0100

Hi Pavel,

> I see USB dongle with Chip version: BlueCore02 (ES2).
> What means ES2?

this means engineering sample of the BlueCore2.

> Friend tried to flash firmware from manufacturer (rainsun), but it fails.
> btdfu tells ""No such device".
> 
> This is in log:
> ------------------
> Dec  2 23:13:33 a /etc/hotplug/usb.agent: ... no modules for USB product 
> a12/ffff/209
> Dec  2 23:13:47 a kernel: usb 4-2: usbfs: USBDEVFS_CONTROL failed cmd btdfu 
> rqt 33 rq 1 len 1023 ret -32
> Dec  2 23:14:04 a kernel: usb 4-2: usbfs: USBDEVFS_CONTROL failed cmd btdfu 
> rqt 33 rq 1 len 1023 ret -110
> Dec  2 23:14:05 a kernel: usb 4-2: usbfs: USBDEVFS_CONTROL failed cmd btdfu 
> rqt 161 rq 3 len 6 ret -110
> ...
> Dec  2 23:14:12 a /etc/hotplug/usb.agent: Setup bluetooth for USB product 
> a12/1/373
> --------------------

The btdfu is not an official firmware utility. It may work or it may not
work.

> It's possible, that in DFU mode will be other ID?
> a12/1/373 versus a12/ffff/209

In DFU mode the product id 0xffff is used and the version id comes from
the build id of the boot loader. In normal mode it is the firmware build
id.

> Can be this dongle flashed with GENERIC firmware?

This looks like the Billington dongle I flashed some time ago. This
dongle has only 4 Mbit flash and so won't get HCI 18.x on it. In this
case the HCI 16.14 from GenericCSR.dfu was used. And with the new
firmware the ES2 was gone.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

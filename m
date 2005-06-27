Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] ISSC USB dongle patch
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <009401c57b06$7afe3ef0$0132a8c0@AL>
References: <009401c57b06$7afe3ef0$0132a8c0@AL>
Content-Type: text/plain
Message-Id: <1119870848.15397.21.camel@pegasus>
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
Date: Mon, 27 Jun 2005 13:14:08 +0200

Hi Al,

>      I have an ISSC USB dongle and search the last year's archive to find 
> the patch to
> make it work with BlueZ.
> 
>      I just wonder how it works. What's black_ids[] for and the purpose of
> adding .driver_info = HCI_RESET?
> 
> struct usb_device_id bluetooth_ids[]
> struct usb_device_id ignore_ids[] or black_ids[]

in the hci_usb driver from the 2.6.12 kernel we have bluetooth_ids and
blacklist_ids structures. The bluetooth_ids is the MODULE_DEVICE_TABLE
which is used for automatic module loading. It includes the generic
Bluetooth USB class and some weird devices where the class descriptor is
broken. With the blacklist_ids we define needed hacks and workarounds
for dongles that not fully comply to the Bluetooth HCI specification.

One of these workaround (aka quirks) is HCI_RESET. It means that we have
to send an HCI_Reset command first, before continuing with the normal
initialization sequence. In general a HCI_Reset is not needed, because
the device should be in a sane state after the USB plugin.

The case I needed to add the HCI_Reset to the ISSC dongle was that the
inquiry is not working when you don't send it.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

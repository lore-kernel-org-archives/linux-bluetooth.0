Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] timeout after rfcomm or pan connection
From: Marcel Holtmann <marcel@holtmann.org>
To: Christoph Torens <c.torens@web.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <opr4zbdmyoeocfdv@debian>
References: <20040309161702.24407.qmail@web40713.mail.yahoo.com>
	 <opr4mgbutyeocfdv@debian> <1078882388.30990.24.camel@pegasus>
	 <opr4wj0bjgeocfdv@debian> <1079358305.3405.32.camel@pegasus>
	 <opr4zbdmyoeocfdv@debian>
Content-Type: text/plain
Message-Id: <1079482776.3301.7.camel@pegasus>
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
Date: Wed, 17 Mar 2004 01:19:36 +0100

Hi Christoph,

> #
> # USB Host Controller Drivers
> #
> # CONFIG_USB_EHCI_HCD is not set
> # CONFIG_USB_UHCI is not set
> # CONFIG_USB_UHCI_ALT is not set
> # CONFIG_USB_OHCI is not set
> # CONFIG_USB_OHCI_SA1111 is not set
> CONFIG_USB_ISP116x=m

maybe your host controller is a little bit buggy. I don't know anything
about it.

> #
> # Bluetooth device drivers
> #
> CONFIG_BLUEZ_HCIUSB=m
> CONFIG_BLUEZ_USB_SCO=y
> CONFIG_BLUEZ_USB_ZERO_PACKET=y

Disable USB_SCO and USB_ZERO_PACKET if you don't really need it. The
zero packet should not be needed in any case and disabling the SCO
support safes USB bandwith.

> hm, why does the comment say:
> "USB Bluetooth can only be used with disabled Bluetooth subsystem"

It's about the old bluetooth.o kernel module. See archives for more
details.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

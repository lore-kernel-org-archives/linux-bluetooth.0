Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] question: what does this patch from snd-bt-sco
	do?
From: Marcel Holtmann <marcel@holtmann.org>
To: Lars Grunewaldt <lgw@dark-reality.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   linux-usb-users@lists.sourceforge.net
In-Reply-To: <40A9E6CB.4010505@dark-reality.de>
References: <40A9E6CB.4010505@dark-reality.de>
Content-Type: text/plain
Message-Id: <1084877081.5833.102.camel@pegasus>
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
Date: Tue, 18 May 2004 12:44:41 +0200

Hi Lars,

> there's a kernel patch in snd-bt-sco, and it would  be great if someone
> could explain what it does:
> 
> *****
> - --- linux-2.6.4-orig/drivers/bluetooth/hci_usb.c	2004-03-11
> 02:55:44.000000000 +0000
> +++ linux-2.6.4/drivers/bluetooth/hci_usb.c	2004-03-13
> 23:52:27.000000000 +0000
> @@ -851,7 +851,12 @@
> 
> ~ #ifdef CONFIG_BT_HCIUSB_SCO
> ~ 				case USB_ENDPOINT_XFER_ISOC:
> - -					if (ep->desc.wMaxPacketSize < size || a > 2)
> +					/* Use only the 9 byte
> +					  "One voice channel with 8 bit encoding"
> +					  endpoint until there is support for changing
> +					  the endpoint dynamically. See
> +					   Bluetooth 1.1 Part H:2, section 2.1 */
> +					if (ep->desc.wMaxPacketSize != 9)
> ~ 						break;
> ~ 					size = ep->desc.wMaxPacketSize;
> ****

according to the current voice setting (0x0060 by default) and the
number of SCO link the Bluetooth USB driver has to adjust the alternate
setting for the ISOC interface. Currently we don't support this dynamic
adjustment in hci_usb and so I have choosen to use alternate setting 2
as default value in the latest versions of 2.4 and 2.6 kernels. This
means that the voice setting must be 0x0060 and there can be only one
SCO link at the same time. For more information look at the Bluetooth
core specification.

> Also, it would be interesting to know if this patch for kernel 2.6.4 is
> still nessesary for newer kernels (2.6.6 to be specific), because I want
> to "port" snd-bt-sco to alsa 1.0.4 and kernel 2.6.6.

Don't use this patch and accept the default voice setting of 0x0060.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

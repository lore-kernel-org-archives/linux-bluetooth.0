Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Logitech diNovo Media Desktop Laser patch
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1c464970510241454m1f7165ceo51600d8cbf5e9441@mail.gmail.com>
References: <e1c464970510241454m1f7165ceo51600d8cbf5e9441@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1130192694.7840.33.camel@blade>
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
Date: Tue, 25 Oct 2005 00:24:54 +0200

Hi Trevor,

> --- back to the patch
> Simple one-liners, the code just didn't know the ids it seems.
> 
> # bluez-utils patch against CVS ( Oct 21 '05 )
> --- tools/hid2hci.c.orig        2005-10-21 23:40:20.000000000 -0400
> +++ tools/hid2hci.c     2005-10-21 23:52:49.000000000 -0400
> @@ -226,6 +226,7 @@
>         { HCI, 0x046d, 0xc703, switch_logitech },
>         { HCI, 0x046d, 0xc704, switch_logitech },
>         { HCI, 0x046d, 0xc705, switch_logitech },
> +       { HCI, 0x046d, 0x0b02, switch_logitech },
>         { -1 }
>  };

this one is fine and in the CVS now.

> # Kernel patch against 2.6.13-mh2
> --- drivers/bluetooth/hci_usb.orig      2005-10-21 23:37:25.000000000 -0400
> +++ drivers/bluetooth/hci_usb.c 2005-10-21 22:11:02.000000000 -0400
> @@ -119,6 +119,9 @@
>         /* Kensington Bluetooth USB adapter */
>         { USB_DEVICE(0x047d, 0x105d), .driver_info = HCI_RESET },
> 
> +       /* Logitech diNovo Media Desktop Laser Transceiver for Bluetooth 2.0 */
> +        { USB_DEVICE(0x046d, 0xc709), .driver_info = HCI_RESET },
> +
>         /* ISSC Bluetooth Adapter v3.1 */
>         { USB_DEVICE(0x1131, 0x1001), .driver_info = HCI_RESET },

Is this patch really needed?

Show me the content of /proc/bus/usb/devices before and after calling
hid2hci. What does "hciconfig -a" say after the switching?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

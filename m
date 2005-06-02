Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <429E8F28.3010008@gmail.com>
From: David Britton <davidpbritton@gmail.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Early failures with Treo 650
References: <428EDFCA.5070702@gmail.com> <1116842776.30044.33.camel@pegasus>	 <4292938B.2090000@gmail.com> <1116924491.30044.131.camel@pegasus>	 <429553F1.7020604@gmail.com> <1117095364.12036.14.camel@pegasus>	 <429682D6.2020800@gmail.com> <1117177537.12036.90.camel@pegasus>	 <42980599.9040801@gmail.com> <1117287707.12036.138.camel@pegasus>
In-Reply-To: <1117287707.12036.138.camel@pegasus>
Content-Type: multipart/mixed;
 boundary="------------090706090007060805060100"
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
Date: Wed, 01 Jun 2005 23:46:32 -0500

This is a multi-part message in MIME format.
--------------090706090007060805060100
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:
> 
> explain the speed increase to me. I don't understand it. The RESET quirk
> should be enough, because the BCM92035 quirk is only for a very specific
> dongle from Broadcom.
> 
> Check the dmesg output for added and removed USB while you are attaching
> the dongle. You should see a mouse and a keyboard that will disappear
> minutes later.

Well Marcel, as usual, you are correct on this one as well.  The speed
drop is corallated to the mouse/keyboard add somehow.  Once the mouse
and keyboard are removed:

Jun  1 23:37:02 localhost kernel: usb 3-2.2: USB disconnect, address 44
Jun  1 23:37:02 localhost udev[16373]: removing device node
'/dev/input/event3'
Jun  1 23:37:02 localhost hal.hotplug[16386]: DEVPATH is not set
Jun  1 23:37:02 localhost kernel: usb 3-2.3: USB disconnect, address 45
Jun  1 23:37:02 localhost udev[16421]: removing device node
'/dev/input/mouse2'
Jun  1 23:37:02 localhost udev[16423]: removing device node
'/dev/input/event4'

The speed for the hcitool scan returns to normal.  It is not related to
the BCM92035 quirk at all.  FYI, the symptom is that before these
removal messages, "hcitool scan" takes on average 3 seconds longer to
perform a scan.  I did not test any other hci tools.  This must be
related to some contention in the usb code somewhere?

Attached is the patch with just the reset quirk for the Kensington
adapter.  I believe that you are correct in that this is all that is
needed for this adapter to function.

-- 
David Britton <davidpbritton@gmail.com>

--------------090706090007060805060100
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

--- hci_usb.c	2005-06-01 23:41:21.000000000 -0500
+++ hci_usb.c.patch	2005-06-01 23:41:38.000000000 -0500
@@ -107,6 +107,9 @@
 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = HCI_RESET | HCI_BROKEN_ISOC },
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = HCI_BCM92035 },
 
+	/* Kensington Bluetooth USB adapter */
+	{ USB_DEVICE(0x047d, 0x105d), .driver_info = HCI_RESET },
+
 	/* Microsoft Wireless Transceiver for Bluetooth 2.0 */
 	{ USB_DEVICE(0x045e, 0x009c), .driver_info = HCI_RESET },
 

--------------090706090007060805060100--


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

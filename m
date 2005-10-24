Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1c464970510241454m1f7165ceo51600d8cbf5e9441@mail.gmail.com>
From: Trevor Joynson <trevorjoynson@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Logitech diNovo Media Desktop Laser patch
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
Date: Mon, 24 Oct 2005 17:54:14 -0400

Hi. I had to make some changes to the bluez codebase to make the
Logitech diNovo Media Desktop Laser work in HCI mode. The differences
from the original diNovo Media Desktop are that the usb dongle is
Bluetooth 2.0, the mouse is replaced with a MX1000 bluetooth laser
mouse, and the mouse charger is well... only a charger.

I'm also trying to get the LCD screen to work. I've searched every
bluez-user and bluez-devel post with the word 'dinovo' in it, and I've
come across that Marcel Holtmann had reverse-engineered it, but lost
his notes and code somehow.

I'm not much of a coder, but I'll attempt it. I've gathered the
following information:

http://linux.yes.nu/diNovo says something about bluetooth hiddev
support being needed.
> Marcel Holtmann
> it have 6 fields, each 8 bits wide. Logitech uses the same report for
> control of the Mediapad and I already have proven that it works.
It's built on top of HID

Anyone have any other information that could help me?

--- back to the patch
Simple one-liners, the code just didn't know the ids it seems.

# bluez-utils patch against CVS ( Oct 21 '05 )
--- tools/hid2hci.c.orig        2005-10-21 23:40:20.000000000 -0400
+++ tools/hid2hci.c     2005-10-21 23:52:49.000000000 -0400
@@ -226,6 +226,7 @@
        { HCI, 0x046d, 0xc703, switch_logitech },
        { HCI, 0x046d, 0xc704, switch_logitech },
        { HCI, 0x046d, 0xc705, switch_logitech },
+       { HCI, 0x046d, 0x0b02, switch_logitech },
        { -1 }
 };

# Kernel patch against 2.6.13-mh2
--- drivers/bluetooth/hci_usb.orig      2005-10-21 23:37:25.000000000 -0400
+++ drivers/bluetooth/hci_usb.c 2005-10-21 22:11:02.000000000 -0400
@@ -119,6 +119,9 @@
        /* Kensington Bluetooth USB adapter */
        { USB_DEVICE(0x047d, 0x105d), .driver_info =3D HCI_RESET },

+       /* Logitech diNovo Media Desktop Laser Transceiver for Bluetooth 2.=
0 */
+        { USB_DEVICE(0x046d, 0xc709), .driver_info =3D HCI_RESET },
+
        /* ISSC Bluetooth Adapter v3.1 */
        { USB_DEVICE(0x1131, 0x1001), .driver_info =3D HCI_RESET },

--
// Trevor Joynson
\\ http://intheskywithdiamonds.net
// trevorjoynson@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

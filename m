Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <40A9E6CB.4010505@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Cc: linux-usb-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] question: what does this patch from snd-bt-sco do?
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
Date: Tue, 18 May 2004 12:34:51 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

there's a kernel patch in snd-bt-sco, and it would  be great if someone
could explain what it does:

*****
- --- linux-2.6.4-orig/drivers/bluetooth/hci_usb.c	2004-03-11
02:55:44.000000000 +0000
+++ linux-2.6.4/drivers/bluetooth/hci_usb.c	2004-03-13
23:52:27.000000000 +0000
@@ -851,7 +851,12 @@

~ #ifdef CONFIG_BT_HCIUSB_SCO
~ 				case USB_ENDPOINT_XFER_ISOC:
- -					if (ep->desc.wMaxPacketSize < size || a > 2)
+					/* Use only the 9 byte
+					  "One voice channel with 8 bit encoding"
+					  endpoint until there is support for changing
+					  the endpoint dynamically. See
+					   Bluetooth 1.1 Part H:2, section 2.1 */
+					if (ep->desc.wMaxPacketSize != 9)
~ 						break;
~ 					size = ep->desc.wMaxPacketSize;
****

Also, it would be interesting to know if this patch for kernel 2.6.4 is
still nessesary for newer kernels (2.6.6 to be specific), because I want
to "port" snd-bt-sco to alsa 1.0.4 and kernel 2.6.6.

thanks in advance,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAqebKQWC6DTWkDAoRAsATAJ43Iinhsajz11AA15HWB8jgnXhVXQCfUMkU
nAKI5G5kkz+1dLD9A/+SgPo=
=7SjZ
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

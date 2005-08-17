Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43038D0B.1060209@hasborg.com>
From: Joshua Wright <jwright@hasborg.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Reset card
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
Date: Wed, 17 Aug 2005 15:16:27 -0400

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'd like to programatically reset my CSR USB dongle after running
"bdaddr" from bluez-utils, but I haven't found a way to do that (short
of manually removing and inserting the dongle).

I tried "hciconfig hci0 reset", but this does not reflect the changes
from the bdaddr utility, even after hciconfig down/up.  I also tried
"hcitool -i hci0 cmd 0x03 0x0003" (OGF_HOST_CTL, OCF_RESET), but had the
same results with "hciconfig hci0 reset".

I even tried to detach the device manually with libusb and usb_reset()
and usb_detach_kernel_driver_np().  The former causes BlueZ to become
intermittent with the USB dongle until I run a "hciconfig hci0 reset",
but still no BD_ADDR change until I manually remove and reinsert the
card.  The latter causes the system to ignore the USB dongle until I
manually remove and re-insert.

Any suggestions?  Many thanks,

- -Josh
- --
- -Joshua Wright
jwright@hasborg.com

2005-2006 pgpkey: http://802.11ninja.net/pgpkey.htm
fingerprint: F00E 7A42 8375 0C55 964F E5A4 4D2F 22F6 3658 A4BF

Today I stumbled across the world's largest hotspot.  The SSID is "linksys".
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDA40LTS8i9jZYpL8RAjYoAKCITpoODWDNaJSgCQNbz7UqRk8tuQCfRR2R
H1Dboc+GfktjC33pzhXxG0s=
=knrV
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

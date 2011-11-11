Return-Path: <cyrus@holtmann.org>
Message-ID: <4EBD7287.8080209@canonical.com>
Date: Fri, 11 Nov 2011 19:07:51 +0000
From: Gema Gomez <gema.gomez-solano@canonical.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Patch for Dinovo Edge Keyboard udev
Content-Type: multipart/mixed;
 boundary="------------020202020607080605070204"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------020202020607080605070204
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I have been advised to send this patch to you. I use a Dinovo Edge
keyboard that happens to be broken on Oneiric.

As far as my testing goes, the patch works. You can see the
conversations around the issue in this bug report:
https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/123920

Please, let me know if you need any further information to get the issue
fixed. Apologies if this is the wrong mailing list for this request.

Best Regards,
Gema
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJOvXKGAAoJEGrsYwHIaYlg1mAIAJ1HeMDXU6vCkRoOcuNKPhHB
FAjEeF0qUNrASzLvY6nVMppljNkXvAFHK9EySU5akMRRNXX/tmKKtGdorZcpOHe0
c6roikYpki8E05T1wOrt3os6Ta32jiJYMNwuzbWAq2dRx5gr9OFRCKljcomZaPZ7
AetcaMR73FtTJEx8kxB5EhAgyIg8v2ZhDZlQzJhVpnTLoikKAPOvpZxn5wTYMuuo
eXQjNvAtqcnT7ZQnOR4BI5TPtel/nt4U2XatlknBGCgPPn2NrAtf+Pvizftm/iBT
pudFHHWqXHWyu2JWkeCAgn8pnsUSGz8bLX6aMLACvO+5LYDDUhPH1UkN3qopOpM=
=kgCX
-----END PGP SIGNATURE-----

--------------020202020607080605070204
Content-Type: text/x-patch;
 name="hid2hci.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hid2hci.patch"

--- 62-bluez-hid2hci.rules.orig	2011-08-30 12:59:45.225387980 +0000
+++ 62-bluez-hid2hci.rules	2011-08-30 13:00:52.025387190 +0000
@@ -11,7 +11,7 @@
   RUN+="hid2hci --method=dell --devpath=%p", ENV{HID2HCI_SWITCH}="1"
 
 # Logitech devices
-KERNEL=="hiddev*", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c70[345abce]|c71[34bc]", \
+KERNEL=="hiddev*", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c70[345abce]|c71[bc]", \
   RUN+="hid2hci --method=logitech-hid --devpath=%p"
 
 ENV{DEVTYPE}!="usb_device", GOTO="hid2hci_end"

--------------020202020607080605070204
Content-Type: application/octet-stream;
 name="hid2hci.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="hid2hci.patch.sig"

iQEcBAABAgAGBQJOvXKGAAoJEGrsYwHIaYlgmdQIAKFYc00S3cItGqgOLbQvLItMojR/Qffa
I9URfJnVZEXaqumv/dielitYjyoUq3GrzLo1sNg/F1ODkwaZbrDpuQKgRCsGogytt42Q9TLY
9CnLyNIo9sB8GGOE+6QNqR2AVeAiQon9pVcnQ7LCGI5VK6JkWP/TpuBB8Qs7B2UcBnAEH4C/
3d6Wf4HOipyDXirk9nU6wjfy0tMlA8MMhDXbTsB93sM4vlwDE2qWEOm2Yr0I32isI+iHRJJz
xFgEO47o+B62O9hc4+TDbYFqu4kVkDWeoUVNrhXSxG1g/oEtOGt1u5QkKDKRQFtVqo4F7284
U11ToDJx5PmKHKMD2WJ2XV0=
--------------020202020607080605070204--

Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 May 2010 15:12:20 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Subject: bluez: lowercase hex digits in BDADDRs
Message-Id: <20100505151220.137a0b37.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__5_May_2010_15_12_20_+0200_VsV++YPe/IyUyJ7K"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Wed__5_May_2010_15_12_20_+0200_VsV++YPe/IyUyJ7K
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__5_May_2010_15_12_20_+0200_zvwEJVBo4MKyo04W"


--Multipart=_Wed__5_May_2010_15_12_20_+0200_zvwEJVBo4MKyo04W
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

when working on Sixaxis pairing plugin I found out a weird behavior, if
I use a BDADDR with lowercase hex digits the association can fail.

The interesting bits in bluetoothd logs are reported in the attached
diff, maybe adapter_create_device() is not robust enough?

You can reproduce this behavior using a lowercase _device_ bdaddr
into these files:
    /var/lib/bluetooth/00:03:C9:XX:XX:XX/did
    /var/lib/bluetooth/00:03:C9:XX:XX:XX/lastused
    /var/lib/bluetooth/00:03:C9:XX:XX:XX/sdp
    /var/lib/bluetooth/00:03:C9:XX:XX:XX/trusts
where 00:03:C9:XX:XX:XX is the _adapter_ bdaddr.

Can anyone else confirm that? bluez-4.64

Not a big deal, but worth reporting IMHO.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

--Multipart=_Wed__5_May_2010_15_12_20_+0200_zvwEJVBo4MKyo04W
Content-Type: text/x-diff;
 name="bluetoothd-log-lowercase-hex-bdaddr.diff"
Content-Disposition: attachment;
 filename="bluetoothd-log-lowercase-hex-bdaddr.diff"
Content-Transfer-Encoding: quoted-printable

--- bluetoothd.log.bad	2010-05-05 14:02:10.000000000 +0200
+++ bluetoothd.log.good	2010-05-05 14:12:46.000000000 +0200
@@ -134,13 +134,14 @@ bluetoothd[XXXX]: Computer is classified
 bluetoothd[XXXX]: Setting 0x000104 for major/minor device class
 bluetoothd[XXXX]: Agent registered for hci0 at :1.50:/org/bluez/agent/hci0
 bluetoothd[XXXX]: Found Sixaxis device
-bluetoothd[XXXX]: Device Bluetooth address: 00:1b:fb:xx:xx:xx
-bluetoothd[XXXX]: adapter_create_device(00:1b:fb:xx:xx:xx)
+bluetoothd[XXXX]: Device Bluetooth address: 00:1B:FB:XX:XX:XX
+bluetoothd[XXXX]: adapter_create_device(00:1B:FB:XX:XX:XX)
 bluetoothd[XXXX]: Creating device /org/bluez/XXXX/hci0/dev_00_1B_FB_XX_XX_=
XX
 bluetoothd[XXXX]: btd_device_ref(0x7fdd46a2bb10): ref=3D1
 bluetoothd[XXXX]: Probe drivers for /org/bluez/XXXX/hci0/dev_00_1B_FB_XX_X=
X_XX
 bluetoothd[XXXX]: hid_device_probe: path /org/bluez/XXXX/hci0/dev_00_1B_FB=
_XX_XX_XX
-bluetoothd[XXXX]: probe failed with driver input-hid for device /org/bluez=
/XXXX/hci0/dev_00_1B_FB_XX_XX_XX
+bluetoothd[XXXX]: btd_device_ref(0x7fdd46a2bb10): ref=3D2
+bluetoothd[XXXX]: Registered interface org.bluez.Input on path /org/bluez/=
XXXX/hci0/dev_00_1B_FB_XX_XX_XX
 bluetoothd[XXXX]: Adapter bdaddr 00:03:C9:XX:XX:XX
 bluetoothd[XXXX]: Master Bluetooth address: 00:03:C9:XX:XX:XX
 bluetoothd[XXXX]: New Master Bluetooth address: 00:03:C9:XX:XX:XX
@@ -148,9 +149,3 @@ bluetoothd[XXXX]: adapter_get_device(00:
 bluetoothd[XXXX]: Incoming connection on PSM 17
 bluetoothd[XXXX]: authorize request was sent for /org/bluez/XXXX/hci0/dev_=
00_1B_FB_XX_XX_XX
 bluetoothd[XXXX]: Incoming connection on PSM 19
-bluetoothd[XXXX]: adapter_get_device(00:1B:FB:XX:XX:XX)
-bluetoothd[XXXX]: Incoming connection on PSM 17
-bluetoothd[XXXX]: Incoming connection on PSM 19
-bluetoothd[XXXX]: adapter_get_device(00:1B:FB:XX:XX:XX)
-bluetoothd[XXXX]: Incoming connection on PSM 17
-bluetoothd[XXXX]: Incoming connection on PSM 19

--Multipart=_Wed__5_May_2010_15_12_20_+0200_zvwEJVBo4MKyo04W--

--Signature=_Wed__5_May_2010_15_12_20_+0200_VsV++YPe/IyUyJ7K
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvhbrQACgkQ5xr2akVTsAG29gCglFj4uWYAMfIerlO/bFJugZ5O
FxkAn0/nu36D/GWxfcnrlxv8/p8BfETf
=WH+S
-----END PGP SIGNATURE-----

--Signature=_Wed__5_May_2010_15_12_20_+0200_VsV++YPe/IyUyJ7K--

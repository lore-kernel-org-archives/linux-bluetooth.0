Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 23 Jan 2013 21:56:10 -0600
Message-ID: <CABQhTcOGKMwgeiySoZpCDkFQknnTKAJC06S18R0EsN4H-x6Rig@mail.gmail.com>
Subject: Patch for AR3011 device
From: Isaac Lindgren <lindenbranch@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=f46d0434bf549395a704d400ca20
List-ID: <linux-bluetooth.vger.kernel.org>

--f46d0434bf549395a704d400ca20
Content-Type: text/plain; charset=ISO-8859-1

I was experiencing the problem described on the ath3k Linux wireless page
regarding AR3011 with SFLASH.  My device is:

Bus 001 Device 004: ID 04f2:aff1 Chicony Electronics Co., Ltd


To correct this I followed the instructions on the ath3k page and added my
VID/PID to ath3k.c and blacklisted it in btusb.c:

diff -uprN a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
--- a/drivers/bluetooth/ath3k.c 2013-01-23 20:45:24.946984407 -0600
+++ b/drivers/bluetooth/ath3k.c 2013-01-23 20:45:51.443693307 -0600
@@ -68,6 +68,7 @@ static struct usb_device_id ath3k_table[
        { USB_DEVICE(0x0930, 0x0215) },
        { USB_DEVICE(0x0489, 0xE03D) },
        { USB_DEVICE(0x0489, 0xE027) },
+        { USB_DEVICE(0x04f2, 0xaff1) },

        /* Atheros AR9285 Malbec with sflash firmware */
        { USB_DEVICE(0x03F0, 0x311D) },
diff -uprN a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
--- a/drivers/bluetooth/btusb.c 2013-01-23 20:45:24.946984407 -0600
+++ b/drivers/bluetooth/btusb.c 2013-01-23 20:45:51.443693307 -0600
@@ -125,6 +125,7 @@ static struct usb_device_id blacklist_ta
        { USB_DEVICE(0x0930, 0x0215), .driver_info = BTUSB_IGNORE },
        { USB_DEVICE(0x0489, 0xe03d), .driver_info = BTUSB_IGNORE },
        { USB_DEVICE(0x0489, 0xe027), .driver_info = BTUSB_IGNORE },
+        { USB_DEVICE(0x04f2, 0xaff1), .driver_info = BTUSB_IGNORE },

        /* Atheros AR9285 Malbec with sflash firmware */
        { USB_DEVICE(0x03f0, 0x311d), .driver_info = BTUSB_IGNORE },

My apologies if this is not the correct way to submit a patch.

--f46d0434bf549395a704d400ca20
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I was experiencing the problem described on the ath3k=
 Linux wireless page regarding AR3011 with SFLASH. =A0My device is:<br><br>=
Bus 001 Device 004: ID 04f2:aff1 Chicony Electronics Co., Ltd<br><br><br>To=
 correct this I followed the instructions on the ath3k page and added my VI=
D/PID to ath3k.c and blacklisted it in btusb.c:<br>
<br>diff -uprN a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c<br>-=
-- a/drivers/bluetooth/ath3k.c 2013-01-23 20:45:24.946984407 -0600<br>+++ b=
/drivers/bluetooth/ath3k.c 2013-01-23 20:45:51.443693307 -0600<br>@@ -68,6 =
+68,7 @@ static struct usb_device_id ath3k_table[<br>
=A0 =A0 =A0 =A0 { USB_DEVICE(0x0930, 0x0215) },<br>=A0 =A0 =A0 =A0 { USB_DE=
VICE(0x0489, 0xE03D) },<br>=A0 =A0 =A0 =A0 { USB_DEVICE(0x0489, 0xE027) },<=
br>+ =A0 =A0 =A0 =A0{ USB_DEVICE(0x04f2, 0xaff1) },<br><br>=A0 =A0 =A0 =A0 =
/* Atheros AR9285 Malbec with sflash firmware */<br>
=A0 =A0 =A0 =A0 { USB_DEVICE(0x03F0, 0x311D) },<br>diff -uprN a/drivers/blu=
etooth/btusb.c b/drivers/bluetooth/btusb.c<br>--- a/drivers/bluetooth/btusb=
.c 2013-01-23 20:45:24.946984407 -0600<br>+++ b/drivers/bluetooth/btusb.c 2=
013-01-23 20:45:51.443693307 -0600<br>
@@ -125,6 +125,7 @@ static struct usb_device_id blacklist_ta<br>=A0 =A0 =A0=
 =A0 { USB_DEVICE(0x0930, 0x0215), .driver_info =3D BTUSB_IGNORE },<br>=A0 =
=A0 =A0 =A0 { USB_DEVICE(0x0489, 0xe03d), .driver_info =3D BTUSB_IGNORE },<=
br>=A0 =A0 =A0 =A0 { USB_DEVICE(0x0489, 0xe027), .driver_info =3D BTUSB_IGN=
ORE },<br>
+ =A0 =A0 =A0 =A0{ USB_DEVICE(0x04f2, 0xaff1), .driver_info =3D BTUSB_IGNOR=
E },<br><br>=A0 =A0 =A0 =A0 /* Atheros AR9285 Malbec with sflash firmware *=
/<br>=A0 =A0 =A0 =A0 { USB_DEVICE(0x03f0, 0x311d), .driver_info =3D BTUSB_I=
GNORE },<br><br></div><div>
My apologies if this is not the correct way to submit a patch.<br></div><sp=
an class=3D"sew5hdg0etmld3b"></span><span class=3D"sew5hdg0etmld3b"></span>=
<span class=3D"sew5hdg0etmld3b"></span><span class=3D"sew5hdg0etmld3b"></sp=
an></div>

--f46d0434bf549395a704d400ca20--

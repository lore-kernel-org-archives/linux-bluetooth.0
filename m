Return-Path: <cyrus@holtmann.org>
From: "Cyril Lacoux (Yack)" <clacoux@ifeelgood.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Adding support for bluetooth controller shipped with iMac i5
Date: Wed, 16 Jun 2010 20:28:59 +0400
References: <201006161443.50587.clacoux@ifeelgood.org> <1276695209.2301.73.camel@localhost.localdomain>
In-Reply-To: <1276695209.2301.73.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LvPGMO22eSAs0AL"
Message-Id: <201006162028.59280.clacoux@ifeelgood.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_LvPGMO22eSAs0AL
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 16 juin 2010 17:33:29, vous avez =C3=A9crit :

> please show the output of /proc/bus/usb/devices or usb-devices script
> for this device.
>=20
> And I want a proper kernel patch from git format-patch.

Ok,=20

Here is the output of command `git format-patch -1 --stdout` against curren=
t=20
bluetooth-next-2.6 tree - hope that's ok.

Regards,
=2D-=20
Cyril Lacoux -- BOFH excuse #170:

popper unable to process jumbo kernel

--Boundary-00=_LvPGMO22eSAs0AL
Content-Type: text/plain;
  charset="UTF-8";
  name="usb-devices.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="usb-devices.txt"

T:  Bus=01 Lev=03 Prnt=03 Port=00 Cnt=01 Dev#=  6 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=05ac ProdID=8215 Rev=01.82
S:  Manufacturer=Apple Inc.
S:  Product=Bluetooth USB Host Controller
S:  SerialNumber=7C6D62936607
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

--Boundary-00=_LvPGMO22eSAs0AL
Content-Type: text/x-patch;
  charset="UTF-8";
  name="bt-imac-i5_git.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="bt-imac-i5_git.patch"

=46rom 6275e99d05b88010d729ed1b62657b3ab477d661 Mon Sep 17 00:00:00 2001
=46rom: Cyril Lacoux <clacoux@ifeelgood.org>
Date: Wed, 16 Jun 2010 20:09:46 +0400
Subject: [PATCH] Add support for bluetooth controller shipped with iMac i5 =
(0x05ac, 0x8215)

=2D--
 drivers/bluetooth/btusb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5d9cc53..ce129de 100644
=2D-- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -75,6 +75,9 @@ static struct usb_device_id btusb_table[] =3D {
 	/* Canyon CN-BTU1 with HID interfaces */
 	{ USB_DEVICE(0x0c10, 0x0000) },
=20
+	/* Apple iMac11,1 with HID interfaces */
+	{ USB_DEVICE(0x05ac, 0x8215) },
+
 	{ }	/* Terminating entry */
 };
=20
=2D-=20
1.7.1


--Boundary-00=_LvPGMO22eSAs0AL--

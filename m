Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Elimar Riesebieter <riesebie@lxtec.de>
To: bluez-users <bluez-users@lists.sourceforge.net>
Message-ID: <20040409153508.GA2123@aragorn.home.lxtec.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Subject: [Bluez-users] hid2hci
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 9 Apr 2004 17:35:08 +0200


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I am trying to connect my Nokia6310i to my LinuxPPC Box.
Installed:

ii  bluez-pin      0.22-1         Bluetooth PIN helper with D-BUS support
ii  bluez-utils    2.6-0lxtecppc1 Utilities for controlling Bluetooth devic=
es
ii  bluez-utils2   0.1-0lxtecppc1 BlueZ utilities
ii  libbluetooth1  2.6-0lxtecppc1 Library to use the BlueZ Linux Bluetooth =
sta
ii  libbluez1      0.1-0lxtecppc1 BlueZ library


Linux version 2.6.5--mh2-aragorn (root@aragorn) \
(gcc-Version 3.3.3 (Debian 20040401)) #1 Fri Apr 9 14:53:38 CEST 2004

Running hid2hci out of bluez-utils2 produces following oops:

aragorn:/source/bluez/cvs/utils2/hid# ./hid2hci
Switching device 05ac:1000 to HCI mode was successful
usb 1-1: USB disconnect, address 2
drivers/usb/input/hid-core.c: can't resubmit intr, 0001:01:1a.0-1/input0, s=
tatus -19
drivers/usb/input/hid-core.c: can't resubmit intr, 0001:01:1a.0-1/input1, s=
tatus -19
usb 1-1: new full speed USB device using address 3
Oops: kernel access of bad area, sig: 11 [#1]
NIP: F24786B8 LR: F24786C0 SP: EF3E7D00 REGS: ef3e7c50 TRAP: 0301    Not ta=
inted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 01DAD002, DSISR: 40000000
TASK =3D ef4c9980[133] 'khubd' Last syscall: -1
GPR00: 00000022 EF3E7D00 EF4C9980 EEE8E800 EF4E42E0 00000000 00000001 00000=
000
GPR08: F2476F40 01DAD000 EEE8E800 28028224 88028222
Call trace:
 [f2478938] usb_set_interface+0x94/0x164 [usbcore]
 [f243dadc] hci_usb_probe+0x21c/0x48c [hci_usb]
 [f2472090] usb_probe_interface+0x80/0x98 [usbcore]
 [c0161dcc] bus_match+0x50/0x8c
 [c0161e60] device_attach+0x58/0xbc
 [c01620e0] bus_add_device+0x7c/0xd8
 [c0160980] device_add+0xb0/0x184
 [f2478d24] usb_set_configuration+0x20c/0x25c [usbcore]
 [f24733cc] usb_new_device+0x2bc/0x3d4 [usbcore]
 [f2474e2c] hub_port_connect_change+0x1a0/0x298 [usbcore]
 [f24751f8] hub_events+0x2d4/0x354 [usbcore]
 [f24752b4] hub_thread+0x3c/0xf4 [usbcore]
 [c000ad4c] kernel_thread+0x44/0x60

Running lsusb after that oops:

Bus 004 Device 001: ID 0000:0000 =20
Bus 003 Device 001: ID 0000:0000 =20
Bus 002 Device 001: ID 0000:0000 =20
Bus 001 Device 001: ID 0000:0000 =20

Any hint?

Ciao

Elimar


--=20
  "Talking much about oneself can also=20
   be a means to conceal oneself."
         -Friedrich Nietzsche

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAdsKs3Ig8bsVPf7ARAi1FAJsHUztauyzV0zmkx4vzj6/1pEirjACdEJxG
EWnrWIprM2TZn+s4iITv3IA=
=WSsf
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

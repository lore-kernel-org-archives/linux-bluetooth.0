Return-Path: <cyrus@holtmann.org>
Subject: hid2hci not switching to hci mode
From: Aaron Seibert <aaron@awseibert.net>
Reply-To: aaron@awseibert.net
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-AOjZRCblGpLr0DFFX0ME"
Date: Mon, 17 Aug 2009 10:17:34 -0400
Message-Id: <1250518654.2813.458.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-AOjZRCblGpLr0DFFX0ME
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Tried forcing hci mode through 2 seperate methods.

[root@scannell ~]# cat /etc/sysconfig/bluetooth=20
# Enable this to use hid2hci to switch a Bluetooth device in USB HID mode
# to HCI mode for Bluetooth operation.
HID2HCI_ENABLE=3Dtrue

# Enable this to switch capable devices back to HID mode on Bluetooth shutd=
own
#HID2HCI_UNDO=3Dtrue


And also hid2hci:

[root@scannell ~]# lsusb | grep Logitech
Bus 001 Device 028: ID 046d:c70a Logitech, Inc. MX5000 Cordless Desktop
Bus 001 Device 027: ID 046d:c70e Logitech, Inc. MX1000 Bluetooth Laser Mous=
e
Bus 001 Device 026: ID 046d:0b02 Logitech, Inc. BT Mini-Receiver (HID proxy
mode)

[root@scannell ~]# hid2hci -v 046d -p 0b02 -m logitech
Attempting to switch device 046d:0b02 to HCI mode was successful

However, the device does not actually go into HCI mode:

[root@scannell ~]# lsusb | grep Logitech
Bus 001 Device 028: ID 046d:c70a Logitech, Inc. MX5000 Cordless Desktop
Bus 001 Device 027: ID 046d:c70e Logitech, Inc. MX1000 Bluetooth Laser Mous=
e
Bus 001 Device 026: ID 046d:0b02 Logitech, Inc. BT Mini-Receiver (HID proxy
mode)

I tried running through gdb, this is the output:

(gdb) run -v 046d -p 0b02 -m logitech
Starting program: /usr/sbin/hid2hci -v 046d -p 0b02 -m logitech
Attempting to switch device 046d:0b02 to HCI mode was successful

Program exited with code 02.
(gdb) thread apply all bt
(gdb) bt
No stack.
(gdb)

--=-AOjZRCblGpLr0DFFX0ME
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqJZn4ACgkQraqtxQYlOUYeAgCfVLr6zOT+rkPiJmWxrDveITkf
BJ8Amwesmaf8a6XSVvAtFiKQ0iU8B3dQ
=vJRO
-----END PGP SIGNATURE-----

--=-AOjZRCblGpLr0DFFX0ME--


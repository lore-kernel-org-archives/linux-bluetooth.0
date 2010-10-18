Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Oct 2010 18:54:10 +0200
From: Roel Huybrechts <lists@rulus.be>
To: linux-bluetooth@vger.kernel.org
Subject: Setting Inquiry Transmit Power Level
Message-ID: <20101018165410.GA5788@titan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear list,


I'm facing the same problem that Natale Vinto mentioned nearly a
year ago [1] on this list. I'm trying to set the Inquiry Transmit
Power Level of a Belkin USB Bluetooth adapter, unfortunately
without much of success.

It is a Bluetooth 2.1 capable device as mentioned by hciconfig:
# hciconfig hci0 version
hci0:   Type: BR/EDR  Bus: USB
        BD Address: 00:19:0E:08:62:EC  ACL MTU: 1021:8  SCO MTU: 64:1
        HCI Version: 2.1 (0x4)  Revision: 0x5184
        LMP Version: 2.1 (0x4)  Subversion: 0x420e
        Manufacturer: Broadcom Corporation (15)
# hciconfig hci0 revision
hci0:   Type: BR/EDR  Bus: USB
        BD Address: 00:19:0E:08:62:EC  ACL MTU: 1021:8  SCO MTU: 64:1
        Firmware 132.66 / 14

Writing the inqtpl is supported, as shown by 'hciconfig hci0
commands'.

However:
# hciconfig hci0 inqtpl
hci0:   Type: BR/EDR  Bus: USB
        BD Address: 00:19:0E:08:62:EC  ACL MTU: 1021:8  SCO MTU: 64:1
        Inquiry transmit power level: 0
# hciconfig hci0 inqtpl 4
# hciconfig hci0 inqtpl =20
hci0:   Type: BR/EDR  Bus: USB
        BD Address: 00:19:0E:08:62:EC  ACL MTU: 1021:8  SCO
        MTU: 64:1
        Inquiry transmit power level: 0

All this happens with Bluez 4.70 (the one from Debian unstable)
on a (pretty much plain upstream) 2.6.32.22 kernel.

I'd like to hear from you if this is a hardware or firmware issue
of the adapter/chip (in which case I suspect it can't be fixed
and I need to find another adapter which isn't broken), or
whether it can be a Bluez issue.

[1] http://www.spinics.net/lists/linux-bluetooth/msg03785.html

Thanks very much for your time.


Have a nice day,

Roel Huybrechts

--=20
GPG  | 4096R/5E2DE374

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBCgAGBQJMvHuwAAoJEPQhxoNeLeN0J+EP/igalIAz5WvMPhWS2frJL9BF
W0PSGOR9ii92/zkOP9Jmx7wJqZmlMWJGIy741QHrBhNdb4Q4MNUU73MsmXMR3joC
jnb3gaJej2Bg0C2NOvomnlT0chwQtoV72a+6x3EsUr2nUh+Q2CyNkycKD6aFP+Fa
JapX+9Ovj+hzq7XjjN5fSeGlDp9r9G9vbdDbAf6FABl5+/mDwpXx5iR38tRGfIgM
QkQPk3T4T+W420Wob4/Fs2C41Wmcvysh92p7FLnE4XDlXenfdieJIxkX7TU7ZygI
R6FOBw3P6FDS0KSTqxyV67TceaBURWGfyxFCsYMQ3fvaDIlVx3X/lnknVe0LTNFk
48GaHbZ7dM922yorQktQmJmSFlno1v7NxhAODRKIJcom49dgpKySMZQNhb7D5ThS
0/ftBVJ0dfsUMbRxXCQxQVZBivvGZQizHJ4iB0mStI0d3sq6lVQrM9/dUdExo6ZZ
kLg7H1sV76oPvwX3xrEkMMndM43hl1ZfHIBsQpM0Wcscdd+/5OgGMCGaQUFlmYPQ
8r17XX+zK+ueWL3lLga7ErRbvpXu08zGadB4suj887N5Tft7jtErBqTYWBZ6tggv
INFBz3lXWo+oFs+szdKS/JoqTtRbM4oWoFKTtQqPGK3GKolnl+vunOYjJcCLAsSl
sSgg6z9mYSOGbTQ4FPGO
=3Z6E
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--

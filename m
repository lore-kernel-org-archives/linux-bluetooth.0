Return-Path: <cyrus@holtmann.org>
Message-ID: <1385843856.12122.5.camel@pc.interlinx.bc.ca>
Subject: have to re-pair mouse every few hours
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: linux-bluetooth@vger.kernel.org
Date: Sat, 30 Nov 2013 15:37:36 -0500
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-hWb1VxoENTLZWtuKAV6A"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-hWb1VxoENTLZWtuKAV6A
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm using a Microsoft Sculpt Touch Mouse on a Fedora 19 machine
(kernel-3.11.9-200.fc19.x86_64 and bluez-4.101-9.fc19.x86_64) with a:

Bus 002 Device 019: ID 0a5c:2148 Broadcom Corp. BCM92046DG-CL1ROM Bluetooth=
 2.1 Adapter

bluetooth adapter.  This exact same configuration worked for months just
fine with a Logitech bluetooth mouse.  But sadly that mouse was crap
(second one to fail within the warranty period of one of them) so
replaced it with this MS one.

The problem with this MS mouse is that it just goes AWOL and needs to be
delete and re-paired with the machine every few hours.  Typically it's
after I have gotten up from the computer and have come back to it.  But
I have also had it just happen while using it.

When this happens, the messages log reports messages such as:

Nov 30 12:42:03 pc kernel: [2500032.028982] Bluetooth: Unexpected continuat=
ion frame (len 0)
Nov 30 12:42:03 pc kernel: [2500032.115027] Bluetooth: Unexpected continuat=
ion frame (len 0)

Any ideas what the problem might be here?

Cheers,
b.



--=-hWb1VxoENTLZWtuKAV6A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQEcBAABAgAGBQJSmkyQAAoJENrB0DQWy8igbfAH/0ora1tRmonO3qxuHnrpOyno
U6m3GCOK8UPGqlMhHdrD8dMv6OK0Ne/xaEdMvlf5w973zR9MmzqDpETZ95cxQ47W
FdNMa/Vfg7JLIwwT37o1q5YzUmc6p+5VwSRRZ0wnx2VfXcgbXL2PJ/g9Q5MsFgPR
YpxUgQGWesTjQpM5ezIJhXr1fSVl+KzSh0z+NdPL/JP2NG2Ot/Hd4juvNnlAEDlk
Mc499I1e350SMaFaH4bJ8lLTE/nlFD900Or9vqxEBBAuPKJTMu2S8nOyde9Ea3xO
2RR+6r3VE7aBLsxcVegFtdncS4aZz3mRW2e6SSUn+/nKPJQ2eEwJfGUN7tngjN8=
=f7Em
-----END PGP SIGNATURE-----

--=-hWb1VxoENTLZWtuKAV6A--


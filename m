Return-Path: <cyrus@holtmann.org>
Subject: DiscoverableTimeout not working as expected
From: Ross Burton <ross@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-NqDUDffdmBOiNSISPvbF"
Date: Thu, 25 Feb 2010 12:19:14 +0000
Message-ID: <1267100354.22889.16.camel@flashheart.burtonini.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-NqDUDffdmBOiNSISPvbF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

My client calls SetProperty(DiscoverTimeout, 20) then
SetProperty(Discoverable, True) on my adaptor, but I don't get the
expected behaviour:

signal sender=3D:1.2 -> dest=3D(null destination) serial=3D847 path=3D/org/=
bluez/1564/hci0; interface=3Dorg.bluez.Adapter; member=3DPropertyChanged
   string "DiscoverableTimeout"
   variant       uint32 20
signal sender=3D:1.2 -> dest=3D(null destination) serial=3D850 path=3D/org/=
bluez/1564/hci0; interface=3Dorg.bluez.Adapter; member=3DPropertyChanged
   string "Discoverable"
   variant       boolean true
signal sender=3D:1.2 -> dest=3D(null destination) serial=3D852 path=3D/org/=
bluez/1564/hci0; interface=3Dorg.bluez.Adapter; member=3DPropertyChanged
   string "DiscoverableTimeout"
   variant       uint32 0

As the timeout is now 0, discoverable never resets itself to false.

Am I doing something stupid, or is setting the discovery timeout broken?

Ross
--=20
Intel Open Source Technology Centre
http://oss.intel.com/

--=-NqDUDffdmBOiNSISPvbF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iD8DBQBLhmrCLQnkR9C0M98RApNcAKCXTDJQ6NXg6zkBnwwgvJUuEer1qQCfdEmp
k1Cl4Zk2+rnKt3+R0/ysLXI=
=CBHo
-----END PGP SIGNATURE-----

--=-NqDUDffdmBOiNSISPvbF--

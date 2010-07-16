Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez installs alsa related stuff under /etc/alsa instead of
 /usr/share/alsa
From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Reply-To: pacho@condmat1.ciencias.uniovi.es
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann
 <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
In-Reply-To: <20100716180817.GA10326@vigoh>
References: <20100716180817.GA10326@vigoh>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-sAdUHDxwCnu05Dkv+ReB"
Date: Fri, 16 Jul 2010 20:46:44 +0200
Message-ID: <1279306004.29479.3.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-sAdUHDxwCnu05Dkv+ReB
Content-Type: multipart/mixed; boundary="=-AzRb15Frn1sxB8v/elmK"


--=-AzRb15Frn1sxB8v/elmK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 16-07-2010 a las 15:08 -0300, Gustavo F. Padovan escribi=C3=B3:
> Hi Pacho,
>=20
> * Pacho Ramos <pacho@condmat1.ciencias.uniovi.es> [2010-07-16 19:21:45 +0=
200]:
>=20
> > El vie, 16-07-2010 a las 14:01 -0300, Johan Hedberg escribi=C3=B3:
> > >=20
> > > On Fri, Jul 16, 2010, Pacho Ramos wrote:
> > > > Can this be finally committed please? Thanks a lot :-)
> > >=20
> > > It's strange the the patch has gone unnoticed ever since March. Anywa=
y,
> > > could you please provide a git format-patch version of it since that'=
s
> > > the convention for all patch submisions. That way I don't need to pla=
y
> > > manual tricks to get the git author name and email correct for the
> > > commit.
> > >=20
> > > Johan
> > >=20
> >=20
> > Sadly I have always failed to create patches in a git format-patch
> > version :'(
> >=20
> > This is what I have tried:
> > $ git clone git://git.kernel.org/pub/scm/bluetooth/bluez.git
> > Initialized empty Git repository in /home/pacho/bluez/.git/
> > remote: Counting objects: 35451, done.
> > remote: Compressing objects: 100% (8577/8577), done.
> > remote: Total 35451 (delta 27190), reused 34976 (delta 26858)
> > Receiving objects: 100% (35451/35451), 6.16 MiB | 1.39 MiB/s, done.
> > Resolving deltas: 100% (27190/27190), done.
> > $ cd bluez/
> > $ git checkout -b fix_alsa_path
> > Switched to a new branch 'fix_alsa_path'
> > $ patch -p0
> > </usr/portage/net-wireless/bluez/files/bluez-alsa_location.patch=20
> > patching file Makefile.am
> > Hunk #1 succeeded at 248 (offset 7 lines).
> > $ git format-patch master --stdout
> > $ (nothing is shown)
>=20
> If your patch is on HEAD then just do:
>=20
> git format-patch -1
>=20
> and then use 'git send-email' to send it to the mailing list.
>=20

Seems I forgot to commit ;-), I attach the patch

Thanks :-)


--=-AzRb15Frn1sxB8v/elmK
Content-Disposition: attachment; filename="0001-Install-alsa-stuff-in-correct-place.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="0001-Install-alsa-stuff-in-correct-place.patch";
	charset="UTF-8"

RnJvbSA0NDIxZDgzZDFkNWNkMDg3NWVjMTI0NTdmNjIxYTMxZmRjODg2MmExIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogUGFjaG8gUmFtb3MgPHBhY2hvQGNvbmRtYXQxLmNpZW5jaWFz
LnVuaW92aS5lcz4NCkRhdGU6IEZyaSwgMTYgSnVsIDIwMTAgMjA6Mzg6NTggKzAyMDANClN1Ympl
Y3Q6IFtQQVRDSF0gSW5zdGFsbCBhbHNhIHN0dWZmIGluIGNvcnJlY3QgcGxhY2UNCg0KLS0tDQog
TWFrZWZpbGUuYW0gfCAgICAyICstDQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9NYWtlZmlsZS5hbSBiL01ha2VmaWxlLmFt
DQppbmRleCBmNGJmODdkLi42NWQ0MzEyIDEwMDY0NA0KLS0tIGEvTWFrZWZpbGUuYW0NCisrKyBi
L01ha2VmaWxlLmFtDQpAQCAtMjQ4LDcgKzI0OCw3IEBAIGF1ZGlvX2xpYmFzb3VuZF9tb2R1bGVf
Y3RsX2JsdWV0b290aF9sYV9MSUJBREQgPSBsaWIvbGliYmx1ZXRvb3RoLmxhIEBBTFNBX0xJQlNA
DQogYXVkaW9fbGliYXNvdW5kX21vZHVsZV9jdGxfYmx1ZXRvb3RoX2xhX0NGTEFHUyA9IEBBTFNB
X0NGTEFHU0ANCiANCiBpZiBDT05GSUdGSUxFUw0KLWFsc2Fjb25mZGlyID0gJChzeXNjb25mZGly
KS9hbHNhDQorYWxzYWNvbmZkaXIgPSAkKGRhdGFkaXIpL2Fsc2ENCiANCiBhbHNhY29uZl9EQVRB
ID0gYXVkaW8vYmx1ZXRvb3RoLmNvbmYNCiBlbmRpZg0KLS0gDQoxLjcuMQ0KDQo=


--=-AzRb15Frn1sxB8v/elmK--

--=-sAdUHDxwCnu05Dkv+ReB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEABECAAYFAkxAqRQACgkQCaWpQKGI+9TQ2wCfd5qrxM2A2A1CCvS42zevL1OF
+9IAmwfpAkVj+QFKFAC26Pvardbz21vN
=HLtg
-----END PGP SIGNATURE-----

--=-sAdUHDxwCnu05Dkv+ReB--

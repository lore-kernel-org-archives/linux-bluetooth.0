Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez installs alsa related stuff under /etc/alsa instead of
 /usr/share/alsa
From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Reply-To: pacho@condmat1.ciencias.uniovi.es
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1267780295.6970.5.camel@localhost.localdomain>
References: <1267780295.6970.5.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-7mnB2xsXmyq2rQYEb3ck"
Date: Fri, 05 Mar 2010 10:24:25 +0100
Message-Id: <1267781065.6970.6.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-7mnB2xsXmyq2rQYEb3ck
Content-Type: multipart/mixed; boundary="=-eg/p70a2db9+8+TDw2Bl"


--=-eg/p70a2db9+8+TDw2Bl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 05-03-2010 a las 10:11 +0100, Pacho Ramos escribi=C3=B3:
> El jue, 04-03-2010 a las 17:42 -0800, Marcel Holtmann escribi=C3=B3:
> > Hi Pacho,
> >=20
> > > bluez installs stuff into /etc/alsa and it seems wrong since default
> > > location for alsa stuff seems to be /usr/share/alsa instead. You can
> > > also see that this is been workarounded in ubuntu, gentoo (and probab=
ly
> > > debian also).
> > >=20
> > > Any reason why using /etc/alsa instead?
> >=20
> > I thought that is the default location. If that is wrong, then please
> > quote the ALSA documentation and send a patch to fix it.
> >=20
> > Regards
> >=20
> > Marcel
>=20
> alsa-lib configure.in seems to indicate that /usr/share/alsa is the
> default one:
> dnl ALSA configuration directory
> AC_ARG_WITH(configdir,
>     AS_HELP_STRING([--with-configdir=3Ddir],
>         [path where ALSA config files are stored]),
>     confdir=3D"$withval", confdir=3D"")
> if test -z "$confdir"; then
>     eval dir=3D"$datadir"
>     case "$dir" in
>     /*) ;;
>     *) dir=3D"$prefix/share"
>     esac
>     confdir=3D"$dir/alsa"
> fi
>=20

I forgot the patch, sorry


--=-eg/p70a2db9+8+TDw2Bl
Content-Disposition: attachment; filename="bluez-4.61-alsa.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="bluez-4.61-alsa.patch"; charset="UTF-8"

LS0tIE1ha2VmaWxlLmFtfgkyMDEwLTAyLTEyIDIwOjI2OjQ4LjAwMDAwMDAwMCArMDEwMA0KKysr
IE1ha2VmaWxlLmFtCTIwMTAtMDMtMDUgMTA6MTc6MTUuMDAwMDAwMDAwICswMTAwDQpAQCAtMjQx
LDcgKzI0MSw3IEBADQogYXVkaW9fbGliYXNvdW5kX21vZHVsZV9jdGxfYmx1ZXRvb3RoX2xhX0NG
TEFHUyA9IEBBTFNBX0NGTEFHU0ANCiANCiBpZiBDT05GSUdGSUxFUw0KLWFsc2Fjb25mZGlyID0g
JChzeXNjb25mZGlyKS9hbHNhDQorYWxzYWNvbmZkaXIgPSAkKGRhdGFkaXIpL2Fsc2ENCiANCiBh
bHNhY29uZl9EQVRBID0gYXVkaW8vYmx1ZXRvb3RoLmNvbmYNCiBlbmRpZg0K


--=-eg/p70a2db9+8+TDw2Bl--

--=-7mnB2xsXmyq2rQYEb3ck
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
 digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkuQzckACgkQCaWpQKGI+9QHGwCdHUJ8QMgU3CwU5N4BCNg0Rivi
U7kAnj3KACFVCxIUn6yBIk5kRYXRE3wv
=tcMB
-----END PGP SIGNATURE-----

--=-7mnB2xsXmyq2rQYEb3ck--

Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez installs alsa related stuff under /etc/alsa instead of
 /usr/share/alsa
From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Reply-To: pacho@condmat1.ciencias.uniovi.es
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1267753367.29510.26.camel@localhost.localdomain>
References: <1267753367.29510.26.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-qip7OnSO4l0tWifi6UW0"
Date: Fri, 05 Mar 2010 10:11:35 +0100
Message-Id: <1267780295.6970.5.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-qip7OnSO4l0tWifi6UW0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El jue, 04-03-2010 a las 17:42 -0800, Marcel Holtmann escribi=C3=B3:
> Hi Pacho,
>=20
> > bluez installs stuff into /etc/alsa and it seems wrong since default
> > location for alsa stuff seems to be /usr/share/alsa instead. You can
> > also see that this is been workarounded in ubuntu, gentoo (and probably
> > debian also).
> >=20
> > Any reason why using /etc/alsa instead?
>=20
> I thought that is the default location. If that is wrong, then please
> quote the ALSA documentation and send a patch to fix it.
>=20
> Regards
>=20
> Marcel

alsa-lib configure.in seems to indicate that /usr/share/alsa is the
default one:
dnl ALSA configuration directory
AC_ARG_WITH(configdir,
    AS_HELP_STRING([--with-configdir=3Ddir],
        [path where ALSA config files are stored]),
    confdir=3D"$withval", confdir=3D"")
if test -z "$confdir"; then
    eval dir=3D"$datadir"
    case "$dir" in
    /*) ;;
    *) dir=3D"$prefix/share"
    esac
    confdir=3D"$dir/alsa"
fi


--=-qip7OnSO4l0tWifi6UW0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
 digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkuQyscACgkQCaWpQKGI+9SQZQCfSMNRj8L3+6zUn7oaHKHPgdRk
S1EAn25TQDOVxVJR6QaCEwHY26Iq75yh
=Uody
-----END PGP SIGNATURE-----

--=-qip7OnSO4l0tWifi6UW0--

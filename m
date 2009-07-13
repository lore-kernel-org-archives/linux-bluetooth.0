Return-Path: <cyrus@holtmann.org>
Message-ID: <4A5B5D89.8020205@dell.com>
Date: Mon, 13 Jul 2009 11:15:05 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
CC: marcel@holtmann.org, artem@makhutov.org, linux-bluetooth@vger.kernel.org
Subject: Re: bluetoothd not starting at boot with udev
References: <20090711161051.GM10684@titan.makhutov-it.de>	 <1247337640.9709.96.camel@localhost.localdomain>	 <6BE8CE7840AC9F459EF5A0693CA2744D6BAFB1@ausx3mpc138.aus.amer.dell.com> <1247418647.5460.3.camel@snoogens.fab.redhat.com>
In-Reply-To: <1247418647.5460.3.camel@snoogens.fab.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC7B4E6C79EA1947E6A5EBC81"
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC7B4E6C79EA1947E6A5EBC81
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Bastien:

Bastien Nocera wrote:
> On Sat, 2009-07-11 at 18:26 -0500, Mario_Limonciello@Dell.com wrote:
>  =20
>
> Your udev scripts are missing a call to "udevadm trigger --retry-failed=
"
>
> Cheers
>  =20
Currently in the Ubuntu udev init script there is a call to 'udevadm
trigger' (without any arguments).  Without any arguments it appears the
default is "--type=3Ddevices".  When I add --type=3Dfailed (--retry-faile=
d
is deprecated), the system fails to boot up to X.  If I return it back
to it's old state and add a second call right afterward of
"--type=3Dfailed", there is no difference in behavior.  bluetoothd still
fails to spawn by the udev rule.
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com


--------------enigC7B4E6C79EA1947E6A5EBC81
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkpbXZIACgkQ2CrZjkA73YsBWQCgismDFiu78TZwlW7vGx7HvPwz
AfIAn2mtd1fPGK+SKsS76xwJMPwgXdTh
=Dgvt
-----END PGP SIGNATURE-----

--------------enigC7B4E6C79EA1947E6A5EBC81--

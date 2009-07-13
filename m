Return-Path: <cyrus@holtmann.org>
Message-ID: <4A5BBE4D.1010406@dell.com>
Date: Mon, 13 Jul 2009 18:07:57 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
CC: artem@makhutov.org, linux-bluetooth@vger.kernel.org
Subject: Re: bluetoothd not starting at boot with udev
References: <20090711161051.GM10684@titan.makhutov-it.de>	 <1247337640.9709.96.camel@localhost.localdomain>	 <6BE8CE7840AC9F459EF5A0693CA2744D6BAFB1@ausx3mpc138.aus.amer.dell.com> <1247418647.5460.3.camel@snoogens.fab.redhat.com> <4A5B5D89.8020205@dell.com>
In-Reply-To: <4A5B5D89.8020205@dell.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig76C03066EADEA8F977B4CCBC"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig76C03066EADEA8F977B4CCBC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Bastien:

Mario Limonciello wrote:
> Hi Bastien:
>
> Bastien Nocera wrote:
>  =20
> Currently in the Ubuntu udev init script there is a call to 'udevadm
> trigger' (without any arguments).  Without any arguments it appears the=

> default is "--type=3Ddevices".  When I add --type=3Dfailed (--retry-fai=
led
> is deprecated), the system fails to boot up to X.  If I return it back
> to it's old state and add a second call right afterward of
> "--type=3Dfailed", there is no difference in behavior.  bluetoothd stil=
l
> fails to spawn by the udev rule.
>  =20
I'm actually suspecting that this is caused by dbus daemon not being
spawned early enough for bluetoothd to have access to.  I've come to
this conclusion by putting a shell wrapper around bluetoothd and
capturing exit code status to see that it does get spawned at startup
but immediately exits.  I put a pgrep at the same time to check for
dbus, and didn't see it running.

How are you ensuring that dbus is running by the time that udev starts
processing rules in Fedora then?

For now the only solution I can come up with is to maintain an init
script that runs "udevadm trigger --subsystem-match=3Dbluetooth".  Since
multiple invocations of bluetoothd --udev won't harm the system, it's
not that horrible of a workaround, but still ideally would like to lose
the init script altogether.
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com


--------------enig76C03066EADEA8F977B4CCBC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkpbvk0ACgkQ2CrZjkA73YuRLQCfbfGbshU9NLR7dw7ZWAh4sZeC
OlwAoJxgnNlbJ3AV5WUdq7/bX5wm+NP6
=bSoi
-----END PGP SIGNATURE-----

--------------enig76C03066EADEA8F977B4CCBC--

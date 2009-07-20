Return-Path: <cyrus@holtmann.org>
Message-ID: <4A648DDF.7060303@dell.com>
Date: Mon, 20 Jul 2009 10:31:43 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: Justin Mattock <justinmattock@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: bluetooth works with udev-145 but had some weired issues with
 it
References: <dd18b0c30907192036r477c9637x450562df605294e8@mail.gmail.com>
In-Reply-To: <dd18b0c30907192036r477c9637x450562df605294e8@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFDC8C25AA4DA127A5447BC80"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFDC8C25AA4DA127A5447BC80
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Justin:

Justin Mattock wrote:
> For some reason in rules.d
> for the permission setting:
>
> #ACTION=3D=3D"add", SUBSYSTEM=3D=3D"bluetooth", RUN+=3D"/usr/sbin/bluet=
oothd --udev"
> to
> RUN+=3D"/usr/sbin/bluetoothd --udev"
> gets this working for me.
> prior to this, udev just would not activate
> bluetoothd
> Anyways thought it would be good to let people know.
>
>  =20
I'm wondering if you are seeing something similar that was happening on
Ubuntu when getting bluez-4.45 added in where the daemon failed to start
upon bootup but works fine later (eg if you hotplug the device).

It turned out that dbus wasn't up and running at the time udev triggered
all devices early in the boot.

The easiest solution was to run:

    udevadm trigger --subsystem-match=3Dbluetooth


later on, during an init script or similar.
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com


--------------enigFDC8C25AA4DA127A5447BC80
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkpkjd8ACgkQ2CrZjkA73YukDwCcC+L72lIpP5i/QAXncVCMVJG9
zD4An15m8xHj7xbPrfKZMlolwOuzHFAw
=CvHE
-----END PGP SIGNATURE-----

--------------enigFDC8C25AA4DA127A5447BC80--

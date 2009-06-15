Return-Path: <cyrus@holtmann.org>
Message-ID: <4A365725.5070503@dell.com>
Date: Mon, 15 Jun 2009 09:13:57 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Remove hid2hci from bluez
References: <6BE8CE7840AC9F459EF5A0693CA2744D5DB52E@ausx3mpc138.aus.amer.dell.com> <1245022400.11069.6101.camel@localhost.localdomain>
In-Reply-To: <1245022400.11069.6101.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig215A9D8D50C0DFA6C18FC22C"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig215A9D8D50C0DFA6C18FC22C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Bastien:

Bastien Nocera wrote:
> I really wonder how good an idea that is, given that, ultimately, we'd
> want to remove hid2hci from everything, and handle the switching from
> within bluetoothd.
>  =20
This is a conflicting goal with the on-demand stuff I feel.  You can't
have the on-demand stuff and this working if the BT radio is only
exposed after the device switches modes.
> If we had specs for the devices (or at least rev-eng'ed specs), we'd
> need to do link keys management, and switching the devices to hci mode
> from within the same codebase.
>  =20
I agree here, but I don't see the docs showing up anytime soon.
> So I'd rather hid2hci didn't go into udev-extras, and stayed in bluez
> until a better solution comes along.
>  =20
Why?  What's it's benefit living in the bluez tree?  By moving to
udev-extras, it now lives in /lib/udev and will work even if the /usr
gets mounted on NFS late.
> (Still no luck on getting specs from Broadcom about the Dell adapters a=
t
> least?)
>  =20
I'll send another ping to ask about these again, but I wouldn't hold my
breath.

Regards

--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com


--------------enig215A9D8D50C0DFA6C18FC22C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAko2VyUACgkQ2CrZjkA73YvQwQCgmwjkrf8eQYFo3c5p2PplKuxN
MuAAn1/yh8H6/JoYTUAA8QfhQ1Xz6Fqr
=KwUp
-----END PGP SIGNATURE-----

--------------enig215A9D8D50C0DFA6C18FC22C--

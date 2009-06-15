Return-Path: <cyrus@holtmann.org>
Message-ID: <4A365E0F.6000100@dell.com>
Date: Mon, 15 Jun 2009 09:43:27 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Remove hid2hci from bluez
References: <6BE8CE7840AC9F459EF5A0693CA2744D5DB52E@ausx3mpc138.aus.amer.dell.com>	 <1245022400.11069.6101.camel@localhost.localdomain>	 <4A365725.5070503@dell.com> <1245076109.11069.7011.camel@localhost.localdomain>
In-Reply-To: <1245076109.11069.7011.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0B2452523663D9ED9D4BD4BD"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0B2452523663D9ED9D4BD4BD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Bastien:

Bastien Nocera wrote:
> On Mon, 2009-06-15 at 09:13 -0500, Mario Limonciello wrote:
>  =20
>
> Why? Instead of calling hid2hci, it would launch bluetoothd --udev, lik=
e
> the other rules. Problem solved.
>  =20
Good point, that's sensible enough.
>  =20
>
> If that's the only benefit, then, frankly, who cares.
>
> The main point is that people with an interested in Bluetooth will need=

> to go and fetch the code, and ask for patches to be committed.
>
> We're losing direct commit access to the code, and gaining something
> that could have been achieved in the distro package.
>
>  =20
Eh, direct commit access?  You submit it to this mailing list and Marcel
has to ack it, you submit it to linux-hotplug and Kay or Martin acks
it.  Seems to be 6 eggs in one hand, half a dozen in the other.  Look
over the history, and those hacking on hid2hci have been me and Marcel:
http://git.kernel.org/?p=3Dbluetooth/bluez.git;a=3Dhistory;f=3Dtools/hid2=
hci.c;h=3D11d707fd76e940b884c9078907ab1
504cd7350d4;hb=3DHEAD



--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com


--------------enig0B2452523663D9ED9D4BD4BD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAko2Xg8ACgkQ2CrZjkA73YuIbQCgmfCsSar4bBlJCjR0TT4Lw6VL
JXUAniGh3VSgSg3EfFsXfFsnC1FTxR8N
=9HGS
-----END PGP SIGNATURE-----

--------------enig0B2452523663D9ED9D4BD4BD--

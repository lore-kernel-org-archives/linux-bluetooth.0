Return-Path: <grantma@anathoth.gen.nz>
Subject: Re: [Bluez-users] Re: PROBLEM: Apple powerbook, Apple BT keyboard,
	keyboard does not reconnect on reboot
From: Matthew Grant <grantma@anathoth.gen.nz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1099943605.29330.21.camel@pegasus>
References: <1098654320.4635.16.camel@localhost>
	 <1098676528.6465.68.camel@pegasus>  <1099721547.5132.70.camel@localhost>
	 <1099744491.6919.39.camel@pegasus>  <1099771915.4563.9.camel@localhost>
	 <1099776680.6919.104.camel@pegasus>  <1099788984.4543.5.camel@localhost>
	 <1099795084.6896.3.camel@pegasus>  <1099942733.5806.7.camel@localhost>
	 <1099943605.29330.21.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-411UL6cvt5HrOlUpCnot"
Message-Id: <1100115296.6068.32.camel@localhost>
Mime-Version: 1.0
Date: Thu, 11 Nov 2004 08:34:57 +1300
List-ID: <bluez-users.lists.sourceforge.net>


--=-411UL6cvt5HrOlUpCnot
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Marcel,

Sorry about the top-posting, but I want to be quick.  Tried to get 2.6.9
compiling under powerpc with GCC 2.95, but found that a lot of the PPC
arch source will only compile under GCC 3.3.x   System compiler on
Debian Sarge (my laptop ) is GCC 3.3.4.

Will get on with getting the problems traced tonight, and find where
things are going wrong hopefully.  Should have a patch after this
weekend.

Cheers,

Matthew

On Tue, 2004-11-09 at 08:53, Marcel Holtmann wrote:
> Hi Matthew,
>=20
> > Just got debug going.  Going to put printks into hidp_get_connlist to
> > see what is happening.
> >=20
> > Your comment on the big endian bug in the L2CAP you noticed below, and
> > some of the debug I have seen with the other BT problems make it look
> > like I am having endianess issues.=20
> >=20
> > I am going to print the kernel code tonight and read it through as it i=
s
> > obvious I have to understand the stack if I am get things fixed - you
> > don't have access to an Apple machine to test things on.  In the past I
> > was a commercial router programmer, doing OSPF and IPX development.
> >=20
> > Any good places to find protocol specs?  I especially need
> > specifications on the endianess of the incoming BT data so I can audit
> > and check the debug for that sort of thing.
>=20
> everything is in the Bluetooth core and HID profile specification.
>=20
> It must not be an endian problem, because other people with Apple
> machines are using HID. May you wanna try another compiler.
>=20
> Regards
>=20
> Marcel
>=20
--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Matthew Grant        /\  ^/\^   grantma@anathoth.gen.nz      /~~~~\
A Linux Network Guy /~~\^/~~\_/~~~~~\_______/~~~~~~~~~~\____/******\
=3D=3D=3DGPG KeyID: 2EE20270  FingerPrint: 8C2535E1A11DF3EA5EA19125BA4E790E=
2EE20270=3D=3D


--=-411UL6cvt5HrOlUpCnot
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBkm1fuk55Di7iAnARAhVqAKCeszuDshz4OQNmpPyX60Nm1H/42wCfXoU9
zmU3DsAX9EDg0DK6chGHQ/0=
=FvJv
-----END PGP SIGNATURE-----

--=-411UL6cvt5HrOlUpCnot--

Return-Path: <grantma@anathoth.gen.nz>
Subject: Re: [Bluez-users] Re: PROBLEM: Apple powerbook, Apple BT keyboard,
	keyboard does not reconnect on reboot
From: Matthew Grant <grantma@anathoth.gen.nz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1099795084.6896.3.camel@pegasus>
References: <1098654320.4635.16.camel@localhost>
	 <1098676528.6465.68.camel@pegasus>  <1099721547.5132.70.camel@localhost>
	 <1099744491.6919.39.camel@pegasus>  <1099771915.4563.9.camel@localhost>
	 <1099776680.6919.104.camel@pegasus>  <1099788984.4543.5.camel@localhost>
	 <1099795084.6896.3.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/Zi6xKp7QZVIeUYVyWeI"
Message-Id: <1099942733.5806.7.camel@localhost>
Mime-Version: 1.0
Date: Tue, 09 Nov 2004 08:38:53 +1300
List-ID: <bluez-users.lists.sourceforge.net>


--=-/Zi6xKp7QZVIeUYVyWeI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Marcel,

Just got debug going.  Going to put printks into hidp_get_connlist to
see what is happening.

Your comment on the big endian bug in the L2CAP you noticed below, and
some of the debug I have seen with the other BT problems make it look
like I am having endianess issues.=20

I am going to print the kernel code tonight and read it through as it is
obvious I have to understand the stack if I am get things fixed - you
don't have access to an Apple machine to test things on.  In the past I
was a commercial router programmer, doing OSPF and IPX development.

Any good places to find protocol specs?  I especially need
specifications on the endianess of the incoming BT data so I can audit
and check the debug for that sort of thing.

Cheers,

Matthew Grant

On Sun, 2004-11-07 at 15:38, Marcel Holtmann wrote:
> Hi Matthew,
>=20
> > > and what does /proc/bluetooth/l2cap show you?
> > >=20
> >=20
> > root@sharon:/usr/src/bluetooth/bluez-utils-2.10#
> > # cat /proc/bluetooth/l2cap
> > A7:FF:10:93:0D:00 49:0B:3B:95:0A:00 1 4864 0x0041 0x0041 48 672 0x1
> > A7:FF:10:93:0D:00 49:0B:3B:95:0A:00 1 4352 0x0040 0x0040 48 672 0x1
> > A7:FF:10:93:0D:00 61:DF:16:61:07:00 1 4864 0x0041 0x004d 48 48 0x1
> > A7:FF:10:93:0D:00 61:DF:16:61:07:00 1 4352 0x0040 0x004c 48 48 0x1
> > 00:00:00:00:00:00 00:00:00:00:00:00 4 4864 0x0000 0x0000 48 48 0x1
> > 00:00:00:00:00:00 00:00:00:00:00:00 4 4352 0x0000 0x0000 48 48 0x1
> > 00:00:00:00:00:00 00:00:00:00:00:00 4 256 0x0000 0x0000 672 0 0x0
> > 00:00:00:00:00:00 00:00:00:00:00:00 4 768 0x0000 0x0000 1024 0 0x0
> >=20
> > The above bluetooth addresses are all in reverse byte order!!!
> >=20
> > Apple Keyboard is 00:0A:95:3B:0B:49
> > Logitech Mx900 Mouse is 00:07:61:16:DF:61
> > computer hci0 is 00:0D:93:10:FF:A7
>=20
> the address order is ok, but the column for the PSM has a big endian
> bug. This needs to be fixed.
>=20
> However you are connected to the mouse and the keyboard. This is
> actually working fine.
>=20
> > > You can enable the DEBUG in the hidp driver or add some printk calls =
be
> > > yourself to see where the ioctl fails.
> > >=20
> > I will give this a go latter on this afternoon.
>=20
> Try to find the reason why and where the ioctl fails.
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


--=-/Zi6xKp7QZVIeUYVyWeI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBj8tMuk55Di7iAnARAmByAJwJY178tniTKb/QjxDX3PPu12dk7ACfXK+W
zXXMAfLZw2dEPraMLriWO+A=
=x5nr
-----END PGP SIGNATURE-----

--=-/Zi6xKp7QZVIeUYVyWeI--

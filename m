Return-Path: <grantma@anathoth.gen.nz>
Subject: Re: [Bluez-users] Re: PROBLEM: Apple powerbook, Apple BT keyboard,
	keyboard does not reconnect on reboot
From: Matthew Grant <grantma@anathoth.gen.nz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1100350419.7349.43.camel@pegasus>
References: <1098654320.4635.16.camel@localhost>
	 <1098676528.6465.68.camel@pegasus>  <1099721547.5132.70.camel@localhost>
	 <1099744491.6919.39.camel@pegasus>  <1099771915.4563.9.camel@localhost>
	 <1099776680.6919.104.camel@pegasus>  <1099788984.4543.5.camel@localhost>
	 <1099795084.6896.3.camel@pegasus>  <1099942733.5806.7.camel@localhost>
	 <1099943605.29330.21.camel@pegasus>  <1100326156.6216.29.camel@localhost>
	 <1100350419.7349.43.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iegkNvUREswjP3xRre0D"
Message-Id: <1100371962.6564.4.camel@localhost>
Mime-Version: 1.0
Date: Sun, 14 Nov 2004 07:52:42 +1300
List-ID: <bluez-users.lists.sourceforge.net>


--=-iegkNvUREswjP3xRre0D
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Actually, maybe could a new release should be done for this?  It fixes a
lot of boot script problems on big-endian systems with things not being
shutdown properly for hidd.  I have observed that not having BT
connections cleanly closed off upsets my Apple keyboards.

Cheers,

Matthew Grant

On Sun, 2004-11-14 at 01:53, Marcel Holtmann wrote:
> Hi Matthew,
>=20
> > Real reason for it is this, user-space thinks cnum field is 16 bit, ker=
nel=20
> > thinks it is 32 bit.  Bug only shows up in big-endian architectures as =
result
> > count is returned in top byte of what is received from the kernel, wher=
eas on
> > i386 it is in the lowest where by fluke it works...
> >=20
> > Mismatch in the kernel and user-space  header files:
> >=20
> > in the kernel, net/bluetooth/hid/hdip.h:=20
> >=20
> > struct hidp_connlist_req {
> >         __u32  cnum;
> >         struct hidp_conninfo __user *ci;
> > };
> >=20
> > in libbluetoth, include/bluetooth/hidp.h:
> >=20
> > struct hidp_connlist_req {
> >         uint16_t cnum;
> >         struct hidp_conninfo *ci;
> > };
> >=20
> > Which way should we go here?  We need to fix kernel or user-space, and =
I need your=20
> > 'official' touch before I post a patch in the Debian bug report I am go=
ing to submit.
> > The fix I prefer affects the user-space bluetooth include files.
>=20
> thanks for finding this mismatch. We change the userspace, because the
> kernel interface should stay stable. Actually I looked also at BNEP and
> CMTP and found that we have the same problem in CMTP. So I must have
> done this wrong in the early days of CMTP and then copied over to HIDP.
> A patch for this is in the CVS now.
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


--=-iegkNvUREswjP3xRre0D
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBllf5uk55Di7iAnARAr16AJsHjhvKe8Hb7AkyEpTP7lgdFAZDFACfdbd7
0w2fZgy2KQhLKarRnsN/R3Y=
=5heK
-----END PGP SIGNATURE-----

--=-iegkNvUREswjP3xRre0D--

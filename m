Return-Path: <grantma@anathoth.gen.nz>
Subject: Re: [PATCH] - Hidp work against 2.6.9-mh4....
From: Matthew Grant <grantma@anathoth.gen.nz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1101641944.18467.43.camel@pegasus>
References: <1101604170.5907.21.camel@localhost>
	 <1101612906.18467.11.camel@pegasus>  <1101638017.5905.72.camel@localhost>
	 <1101641944.18467.43.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4YOSssh2cBWx+acp7EVJ"
Message-Id: <1101670266.5903.32.camel@localhost>
Mime-Version: 1.0
Date: Mon, 29 Nov 2004 08:31:07 +1300
List-ID: <bluez-devel.lists.sourceforge.net>


--=-4YOSssh2cBWx+acp7EVJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Marcel,

On Mon, 2004-11-29 at 00:39, Marcel Holtmann wrote:
> the report protocol mode stuff is not merged mainline, because we don't
> have a generic HID parser at the moment. What I have in my -mh patch is
> a hack, because we carry our own HID parser (in hid.[ch]). The changes
> to core.c and hidp.h to support report protocol mode are minimal. So do
> you really think nothing of your work is useful for the boot protocol
> mode? I think it is and I wanna merge that stuff mainline and keep a
> small additional patch that adds report protocol support as it is now.=20

I see where you are coming from now.  The main issue I have is that my
stuff changes the interface into hid.c, and we need to delineate this
more clearly so that what I am doing is easily integrated into what you
are doing with report mode, and to avoid issues with the untested
combination of code resulting from porting across to the tree that
development is not done on.

(I see, a lot of the projected state machine work will be useful even
with boot mode as it will fix a lot of things now  and when Linux gets
its own centralised HID parser.  This separation is also referred to in
the BT HID spec where they say that the HID layer should use the OS core
USB HID services.)

A lot of what the -mh4 adds to hidp/core.c is mostly support functions
for whats in hidp/hid.c, and about 20 lines of glue code on device
connect.  Making hid.c its own module would sort all the code
delineation issues we currently have as it would put a physical boundary
between whats in hid.c and core.c, and enforce the separation and
functionality in the new code I do.  This would also avoid weird bugs
with code not properly being back ported from the stuff I develop on top
of the HID report stuff.

A lot of the support stuff in core.c is going to be needed with a new
centralised HID parser (or current USB one ) anyhow for interfacing with
BT, so I do not see any harm in that code being in there as there is not
that much of it. =20

We would invert the module dependency of hidp.ko on bthid.ko by using
function pointers for the hid event reception functions.

Please let me know what you think of this.  I am just trying to avoid
the extra problems and work that developing against 2 different code
trees is going to create.

Best Regards,

Matthew Grant


--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Matthew Grant        /\  ^/\^   grantma@anathoth.gen.nz      /~~~~\
A Linux Network Guy /~~\^/~~\_/~~~~~\_______/~~~~~~~~~~\____/******\
=3D=3D=3DGPG KeyID: 2EE20270  FingerPrint: 8C2535E1A11DF3EA5EA19125BA4E790E=
2EE20270=3D=3D


--=-4YOSssh2cBWx+acp7EVJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBqid6uk55Di7iAnARArttAJ4qRNxHsasCJvSWdj644adVbYcdfACgpaTI
Bm6lbO11vVlSy37Jv380nj0=
=6tfd
-----END PGP SIGNATURE-----

--=-4YOSssh2cBWx+acp7EVJ--

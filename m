Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Ian Gulliver <ian@penguinhosting.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Apple keyboard problem
Message-ID: <20050109235803.GC5291@penguinhosting.net>
References: <20050109212302.GB5291@penguinhosting.net> <1105324578.8637.8.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
In-Reply-To: <1105324578.8637.8.camel@pegasus>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 9 Jan 2005 18:58:04 -0500


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > I never get a PIN entry request (as I did with the mouse) or any other
> > error.  There's a long pause between the "Connecting to device" and the
> > "Can't create".  According to lib.c in the kernel, ENOSYS is returned
> > on an unrecognized error code, but I don't know enough about the packet
> > formats to figure out what byte is the error code, or what else it might
> > mean.  Attached is an hcidump during the "hidd --search" run.
>=20
> at that pause you should type a numeric PIN on your keyboard and then
> press return.

Sorry, wasn't clear enough.  When I'm running in X, the PIN dialog pops
up as expected for the mouse, and not for the keyboard.  The blocking
call for that pause from hidd, according to strace, is:

bind(4, {sa_family=3DAF_BLUETOOTH, sa_data=3D"\0\0\212\323\4\241\16\0\0\0\0=
\0\0\0"}, 10) =3D 0
setsockopt(4, SOL_TCP, TCP_NODELAY, "0\0000\0\377\377", 6) =3D 0
connect(4, {sa_family=3DAF_BLUETOOTH, sa_data=3D"\21\0\34N:\225\n\0\0\0\0\0=
\0\0"}, 10

(pause is here)

=3D -1 ENOSYS (Function not implemented)

Typing a PIN in that space simply causes the expected:

sheba% 0000
zsh: command not found: 0000

:)

--=20
Ian Gulliver
Penguin Hosting
"Failure is not an option; it comes bundled with your Microsoft products."

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB4cULefI+qeoOjxURAk7nAJwP9/SzL35m4E3tuS9xSzUi1Nzc7ACZAZeA
wwlTWleQ+uC7tSbvYITEx8o=
=iPyN
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

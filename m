Return-Path: <crosser@average.org>
Subject: Re: [Bluez-devel] Device specific pins
From: Eugene Crosser <crosser@average.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Dave Henriksen <dhenriksen@optibrand.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075151423.25442.135.camel@pegasus>
References: <1075153448.2906.2.camel@linux.local>
	 <1075151423.25442.135.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-D024Sp+niSuJ3/GUoVZE"
Message-Id: <1075187139.9727.29.camel@pccross.average.org>
Mime-Version: 1.0
Date: Tue, 27 Jan 2004 10:05:39 +0300
List-ID: <bluez-devel.lists.sourceforge.net>


--=-D024Sp+niSuJ3/GUoVZE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-01-27 at 00:10, Marcel Holtmann wrote:

> > Just wondering if there is any way to have pins that vary depending upo=
n
> > what device you are connecting to.   Currently, I just use
> > /etb/bluetooth/givepin to supply a pin, but this pin must be the same
> > for every device that my Linux laptop connects to.
>=20
> this is a planned future for the new security manager which also
> includes one-time PIN codes.
>=20
> For the current version you must do it by yourself in a pin-helper
> script. The BD_ADDR of the remote device is one of the parameters.

Do you think it might be right to leave "low level" PIN management as it
is now, via an executable helper?  It is very much the same way as
kernel "hotplug" works.  So it can stay the same even if hcid eventually
becomes a kernel thread.

The "real" PIN management, with the database, GUI prompt boxes etc.
could be isolated from the BT stack, helper executable being the only
interface.

E.g., a Gnome or KDE applet could listen on a unix domain socket.  The
helper, when invoked, would try to talk over this socket, and if the
latter is not present or nobody listens on it, default to preexisting
database.  This way, both fancy GUI dialogues and unattended operation
could be implemented rather easily.

Sorry if I say stupid or trivial things, I did not really try to learn
how these things are currently done in Blues..

Eugene

--=-D024Sp+niSuJ3/GUoVZE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQBAFg3Cfrw/cIw6UWkRAlM3AJ4rxJx7rUObHFPaWuZaZTz8ERF7IgCglkFn
pw2Ixz9KZldMGv4GITbrC8M=
=yB62
-----END PGP SIGNATURE-----

--=-D024Sp+niSuJ3/GUoVZE--

Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] sbc: better compatibility with ARM thumb/thumb2
From: Paul Menzel <paulepanter@users.sourceforge.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Siarhei Siamashka <siarhei.siamashka@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Siarhei Siamashka <siarhei.siamashka@nokia.com>
In-Reply-To: <20110329071714.GA3915@jh-x301>
References: <1301353059-12776-1-git-send-email-siarhei.siamashka@gmail.com>
	 <20110329071714.GA3915@jh-x301>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-QbZqAoRMp/IBnzv8PVdq"
Date: Tue, 29 Mar 2011 15:51:09 +0200
Message-ID: <1301406669.15348.37.camel@mattotaupa>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-QbZqAoRMp/IBnzv8PVdq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Johan, Siarhei,


Am Dienstag, den 29.03.2011, 10:17 +0300 schrieb Johan Hedberg:

> On Tue, Mar 29, 2011, Siarhei Siamashka wrote:
> > ARM assembly optimizations fail to compile in thumb mode, but are fine
> > for thumb2. Update ifdefs in the code to make use of ARM assembly only
> > when it is safe and also make sure that no optimizations are missed
> > when compiling for thumb2.
> >=20
> > The problem was reported by Paul Menzel:
> > https://tango.0pointer.de/pipermail/pulseaudio-discuss/2011-February/00=
9022.html
> > ---
> >  sbc/sbc_math.h             |    2 +-
> >  sbc/sbc_primitives_armv6.h |    4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> Pushed upstream. Thanks.

Tested-by: Paul Menzel <paulepanter@users.sourceforge.net>


Thanks,

Paul

--=-QbZqAoRMp/IBnzv8PVdq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk2R480ACgkQPX1aK2wOHVjnhACePYCGrRyFzu4LJ6NEZR4p56i3
DDgAnis+yn6QkKVOUSa9zz6pV+0j0Mw2
=K1B2
-----END PGP SIGNATURE-----

--=-QbZqAoRMp/IBnzv8PVdq--


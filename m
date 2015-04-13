Return-Path: <cyrus@holtmann.org>
Message-ID: <1428934503.3211.7.camel@decadent.org.uk>
Subject: Re: [PATCH] ath3k: update AR3012 2.2.1 firmware with v.170
From: Ben Hutchings <ben@decadent.org.uk>
To: Kyle McMartin <kyle@infradead.org>
Cc: Kalle Valo <kvalo@qca.qualcomm.com>, linux-firmware@kernel.org,
	linux-bluetooth@vger.kernel.org, agoel@qca.qualcomm.com
Date: Mon, 13 Apr 2015 15:15:03 +0100
In-Reply-To: <20150413140617.GC27807@merlin.infradead.org>
References: <1428687294-10706-1-git-send-email-kvalo@qca.qualcomm.com>
	 <20150413140205.GB27807@merlin.infradead.org>
	 <20150413140617.GC27807@merlin.infradead.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-poPYfJE0F83gLdG+M8xU"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-poPYfJE0F83gLdG+M8xU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2015-04-13 at 10:06 -0400, Kyle McMartin wrote:
> On Mon, Apr 13, 2015 at 10:02:05AM -0400, Kyle McMartin wrote:
> > On Fri, Apr 10, 2015 at 08:34:54PM +0300, Kalle Valo wrote:
> > > This is the latest firmware version for AR3012 2.2.1.
> > > This also includes configuration file for coex support,
> > > where all Bluetooth traffic is treated as high priority.
> > >=20
> > > Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
> >=20
> > applied, thanks Kalle.
> >=20
>=20
> actually, one question before i push it out, this license is the same as
> LICENSE.QualcommAtheros_ath10k... can we rename and fix references?

I have some concern about the narrower patent license in this version.

The new patent license specifically excludes patents that are not owned
by QCA (whereas the old license also included those 'controlled' by
Atheros) and any that are obtained after the date of submission.  This
seems to allow revoking permission to distribute at a later date, if
there are any other patent applications in the pipeline.

If QCA wants the firmware to be redistributed freely (with the legal
notices intact, only for use with their hardware) then I don't see what
the point is of restricting the patent license in this way.

Ben.

--=20
Ben Hutchings
Everything should be made as simple as possible, but not simpler.
                                                           - Albert Einstei=
n

--=-poPYfJE0F83gLdG+M8xU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVSvPa+e/yOyVhhEJAQoxIA//XWbTCbPQ+sUwC3hGPLHxaCtfTCSo7fSG
QnkH6pbRM03z+VEDCEmNT1x7DO1Kj52x9DuBqM8Yry4iJ7igrHIap+tLn9ouoZZe
XTJEztugNKPMUqY3ZdEFI8IMJRTgpa4IgCaZx2+qeK05tYtjbzMvtYdxbIUySH0P
P5vtHB0ywscAKUwFG9Cvg1/jgOC3Qjko16dH+rhDs9RcgCE+/k+DSwWlW+mkwD+v
9MfnVCs+UHvXCDnd+TqzmQ9s3xwnB0HZ/hMaW/wF2pX1x+fxqgJYt/hx8/tk3JVo
OGqKuSCYEfR7knJvsIz100Y5Bi9197WAgZ0mJXKqpkIVDKphGsmnx5qsMCCEbnv1
jC26/cpdeD0eu272Vrl/5UA1tkF3SSCG8bfyziscANwBRBOTOh0LUWy6U3VUTaoI
HI9AXnPSM7EG9QP56rFJ5U2jerGkeGoMC6T4BKSdaHdcTOYYDnr7uPTIhvS520yr
d7ARnPp158q+YQDdk2Auv+nETNyuUf4TRGnnXe9w7EVpBVIfc3lqzDxR/8YgXvV8
zxvcd7xFHFdtYcnFBOeUUFubpr5ykXm+nXFEoGYwUKLmekwpjQ11z1snUVylO/z4
1jdKyeLWCzJBgF9gOgEtnGOxedPTzJcB9Y7PbjcTggQ1cC3xrf+lxHcrMglkNt2d
Jl3AJ0EaLPw=
=X+La
-----END PGP SIGNATURE-----

--=-poPYfJE0F83gLdG+M8xU--

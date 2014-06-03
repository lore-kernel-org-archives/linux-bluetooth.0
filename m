Return-Path: <cyrus@holtmann.org>
Message-ID: <1401823152.2412.1.camel@deadeye.wl.decadent.org.uk>
Subject: Re: [PATCH v3] firmware: update Intel Bluetooth device firmware
 patch files
From: Ben Hutchings <ben@decadent.org.uk>
To: Paritosh Debnath <paritosh.debnath@intel.com>
Cc: linux-bluetooth@vger.kernel.org, johannes@sipsolutions.net
Date: Tue, 03 Jun 2014 20:19:12 +0100
In-Reply-To: <1396949427-6929-1-git-send-email-paritosh.debnath@intel.com>
References: <1396949427-6929-1-git-send-email-paritosh.debnath@intel.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-3gx8XzaVzqjcWEaZ1Mqy"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-3gx8XzaVzqjcWEaZ1Mqy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2014-04-08 at 15:00 +0530, Paritosh Debnath wrote:
> This patch updates firmware patch files for following Intel Bluetooth dev=
ices:
> - Intel Wireless Bluetooth 7260
> - Intel Wireless Bluetooth 3160
>=20
> This patch fixes
> - Issue with LED blinking
> - Issue with USB
> - No SCO data over EHCI
>=20
> Signed-off-by: Paritosh Debnath <paritosh.debnath@intel.com>
> ---
> This patch contains fixes given on 0x36 submitted by Tedd
> http://www.spinics.net/lists/linux-bluetooth/msg45790.html

I already applied that patch, so I had to mess about in git a bit to
apply this on top of it.  I think I got it right, but do check after I
push later today.

Sorry for the delay.

Ben.

> ---
>  WHENCE                                  |    4 ++--
>  intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq  |  Bin 18145 -> 21198 bytes
>  intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq |  Bin 17917 -> 20989 bytes
>  3 files changed, 2 insertions(+), 2 deletions(-)
[...]

--=20
Ben Hutchings
If more than one person is responsible for a bug, no one is at fault.

--=-3gx8XzaVzqjcWEaZ1Mqy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIVAwUAU44fvee/yOyVhhEJAQpRbBAApTi7iOSLHG66NvUJ+ndQgsFOec1e5P8O
emKmfdUe0WJE3YeBMTkZoiAwXh+qG00gGSpxUZ/B9YCQrKD62OekasfFy3fD1QiD
DBxOyTQYCYUzyMRazJ9B70mCsEK1qan/K2UvNXgjWrOD8ITQ1lR+BFRrj1c78N7B
t0lOUrFxOa5vUX/UEIJlkgjbGtOGvO3yOgardyRvnzaxx6vZZeWZXNBrTR8Bm7KH
mBiPdzgT+NnHU9fNahMwUHlajq4+dFncFU2gO5cFZj6S9krEPtUebXqcL5GqYwPE
gjeA9EBiJ6merP4J4n648wdTOLa0Al3/f2MSRJ+fDbv2axdwewureoFeZBfc8BiI
L+alJkJtAAtVrOdXjRBLlnrFPwFMUiHXiJfWrhSEO0DIiFJzVX5TXqRrbnQSAj2+
q1yXfZL+v5UM/TWmBn2NV5awZk2c761ShYvjNYo+Cf1P/SDL4l8d2JCOwG+qLhuA
XtSncvlepdwSyTcIADxwNocKNitQ9MmsHthkAjBa9idatkx3k8qKW5BdN+OP0oRt
xrlykluoM+YcHMJWHyvVd51TmhxVJLKhdVo+WWvKBcQd53x8+wrS4nPYqSQvJtLy
Qhpu+JZJUhawIJYhQOmAJK232mdhBQxRxA66/qSNFpL+0IRj+O0YTmF8oFSO5H8q
rJsda4jWZ4A=
=JvT1
-----END PGP SIGNATURE-----

--=-3gx8XzaVzqjcWEaZ1Mqy--

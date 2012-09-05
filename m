Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] bluetooth.h: fix compile issue when using in C++
From: Pacho Ramos <pacho@gentoo.org>
To: Johan Hedberg <johan.hedberg@gmail.com>, iwamatsu@debian.org,
	pkg-bluetooth-maintainers@lists.alioth.debian.org
Cc: "W. Trevor King" <wking@tremily.us>,
	linux-bluetooth@vger.kernel.org,
	Patrick Ohly <patrick.ohly@intel.com>
In-Reply-To: <20120827234054.GA7793@x220.sheraton.com>
References: <1343832093.2121.0.camel@belkin4>
	 <20120727163853.GA11847@odin.tremily.us>
	 <1330953167.3457.13.camel@pohly-mobl1.fritz.box>
	 <20120817051852.GA32453@odin.tremily.us>
	 <20120827234054.GA7793@x220.sheraton.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-rnCvSL6PBYG3o7Cuc0Ui"
Date: Wed, 05 Sep 2012 19:27:13 +0200
Message-ID: <1346866033.17971.4.camel@belkin4>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-rnCvSL6PBYG3o7Cuc0Ui
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 27-08-2012 a las 16:40 -0700, Johan Hedberg escribi=C3=B3:
> Hi,
>=20
> On Fri, Aug 17, 2012, W. Trevor King wrote:
> > On Wed, Aug 01, 2012 at 04:41:33PM +0200, Pacho Ramos wrote:
> > > El dom, 29-07-2012 a las 09:52 +0200, Pacho Ramos escribi=C3=B3:
> > > > Today I got a report downstream showing that old problem:
> > > > http://permalink.gmane.org/gmane.linux.bluez.kernel/22306
> > > >=20
> > > > is still not fixed.=20
> > > >=20
> > > > Could you please commit debian patch to fix this?
> > > > http://patch-tracker.debian.org/patch/series/view/bluez/4.101-1/09_=
fix_ftbfs_with_c99.patch
> > >=20
> > > Any news about this? Thanks
> >=20
> > Bump :)
>=20
> The patch would need to be sent as a proper git patch to this mailing
> list. Particularly, we need proper author information for the patch as
> well as a commit message explaining the background to the patch and why
> it is correct (including a reference to the C++ standard and/or gcc
> documentation).
>=20
> Johan
>=20

Will forward this message to patch authors and debian maintainers to let
them reformat it with proper authoring.

--=-rnCvSL6PBYG3o7Cuc0Ui
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlBHi3EACgkQCaWpQKGI+9RcPQCcCGrPaHAoXreMYOgvOIl30l64
/wEAnja2+LgCEpvZ8tfTMmyD9bj0E93A
=5Rp1
-----END PGP SIGNATURE-----

--=-rnCvSL6PBYG3o7Cuc0Ui--


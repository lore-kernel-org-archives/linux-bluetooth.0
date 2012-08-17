Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Aug 2012 01:18:52 -0400
From: "W. Trevor King" <wking@tremily.us>
To: linux-bluetooth@vger.kernel.org
Cc: Patrick Ohly <patrick.ohly@intel.com>,
	Pacho Ramos <pacho@gentoo.org>
Subject: Re: [PATCH] bluetooth.h: fix compile issue when using in C++
Message-id: <20120817051852.GA32453@odin.tremily.us>
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=jRHKVT23PllUwdXP
In-reply-to: <1343832093.2121.0.camel@belkin4>
 <20120727163853.GA11847@odin.tremily.us>
 <1330953167.3457.13.camel@pohly-mobl1.fritz.box>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2012 at 01:12:47PM -0000, Patrick Ohly wrote:
> On Mon, 2012-03-05 at 09:31 +0100, Markus Rathgeb wrote:
> > Before you are applying the patch, could you also have a look at:
> > http://permalink.gmane.org/gmane.linux.bluez.kernel/22294
>=20
[snip]
>=20
> Updated patch attached.
>=20
> Note that Debian seems to have picked the older
> http://marc.info/?l=3Dlinux-bluetooth&m=3D132644289619172&w=3D2 patch, th=
e one
> which removes __attribute__((packed)) and replaces the (void *) cast
> with (struct __s *).
>=20
> I think that shows that it is important that upstream includes a
> solution, because otherwise distros will pick one randomly.

On Fri, Jul 27, 2012 at 12:38:53PM -0400, W. Trevor King wrote:
> This patch seems to have never made it into bluez,
[snip]
> Is there any chance of getting it accepted?

On Wed, Aug 01, 2012 at 04:41:33PM +0200, Pacho Ramos wrote:
> El dom, 29-07-2012 a las 09:52 +0200, Pacho Ramos escribi=F3:
> > Today I got a report downstream showing that old problem:
> > http://permalink.gmane.org/gmane.linux.bluez.kernel/22306
> >=20
> > is still not fixed.=20
> >=20
> > Could you please commit debian patch to fix this?
> > http://patch-tracker.debian.org/patch/series/view/bluez/4.101-1/09_fix_=
ftbfs_with_c99.patch
>=20
> Any news about this? Thanks

Bump :)

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLdQ6AAoJEEUbTsx0l5OM5YwP/iX+ifkuSVuyhf/mSDaVTyXk
wHn+gVGRYWrWU09GDvxcX9Cp1no8vDil0G4kraIkkDyU30BL7OPqwrIVxmAK5ufA
WQvyZTfHJ/wnTFz9KRjoTYCKzm2DXSQ2x11Yop6B2K4NHDQzIbGZqIOefBTTaYPn
hkk6Uxlwxv4Sm/BFsAQzjH8RyDak7v/yDzvF5a3y+P+PhCSuqngjUtJHuxaOySMI
sfCbBoTE+X+ZZAf/CDm8ab4XywXktQzZvQ2w+NDsL6k3qNCQ4FXDoMtkdomWWUBY
EoYZToH3z+WM4Li9n1Mht6DDt3hXKanBZC6i+K+qT89p+Bx8cEF62rR5URt5tASw
1ieHHaOfAo7+V+4qlcDvY3MTQcnQdDWjOAQYkawUp2NkIrcKOlaazfE7xC4TGJNS
ISUkTr9dP4C4mraz0cl5ZQh+7Kltd7S0ZZ/0Xv8pHj4DNHusYgO2a2XjXO1t2RtH
rVWyTo6K/T6TXqg0aL9FdaQBI7Fbh26yqxtl1vf/4GmltTKFUFyCHiy+wusIHRvv
Kk+Mhcq5Pt1Q3290hjHTNue/IRLsk8Xt5vUv2TIKvPAwabff59kuT/tu/W0YzTIh
IMplzlMDhfOB2C3wlFuqDhycDOeHjCEOSOh1XkpHfT6nVLmoEjZ6bVRUIEhG5lGw
PXCG8jhSj6OM34v+y4w1
=klmI
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--

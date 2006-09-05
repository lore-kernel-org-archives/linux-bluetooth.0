Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 5 Sep 2006 12:32:07 +0200
From: Filippo Giunchedi <filippo@esaurito.net>
To: Marcel Holtmann <marcel@holtmann.org>
Message-ID: <20060905103207.GC30274@esaurito.net>
References: <20060903124043.2028.48247.reportbug@forza>
	<1157367160.32195.54.camel@aeonflux.holtmann.net>
	<20060904100025.GA17058@esaurito.net>
	<1157371912.32195.69.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
In-Reply-To: <1157371912.32195.69.camel@aeonflux.holtmann.net>
Cc: Flavio Stanchina <flavio@stanchina.net>, 385857@bugs.debian.org,
        bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] Bug#385857: [Pkg-bluetooth-maintainers]
	Bug#385857: please upgrade to bluez-utils and bluez-libs 3.4
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0691496910=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0691496910==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Marcel,

On Mon, Sep 04, 2006 at 02:11:52PM +0200, Marcel Holtmann wrote:
> > > > bluez-libs compiled out of the box by just unpacking and moving the
> > > > debian directory over, but bluez-utils needs some work:
> > > >=20
> > > > * remove bluez-bcm203x package (bcm203x firmware loader removed ups=
tream)
> > >=20
> > > Not needed at all. You don't wanna support a 2.4 kernel and even if y=
ou
> > > really want to, you won't find any of these devices anymore. For all =
2.6
> > > kernels the bcm203x kernel module takes care of loading the firmware.
> >=20
> > I'm going to drop it after etch release when we'll discontinue support =
for 2.4
> > kernels.
>=20
> You can drop it now actually. A Liunx 2.4 kernel user and owner of this
> device is a really really unlikely combination. I mean it. It would take
> me at least a couple of hours to find my dongle.

good luck with finding your dongle :)
anyway, as rare as it is etch is going to support 2.4 kernels.

>=20
> > > This package has to die and from an USB and udev perspective it was a
> > > really nasty hack.
> > >=20
> > > > * remove 000_rfcomm_conf_example.patch: the example is already comm=
ented
> > > > * remove 004_rfcomm_usage.patch: applied upstream
> > >=20
> > > Sometimes it is a good idea to feed patches back to upstream so I don=
't
> > > have to extract them from the packages.
> >=20
> > yep, I'm used to do it, I must have overlooked these patches.
>=20
> Do you have any other patches that are not upstream?

I'm looking at them one by one, bluez debian packages are maintained with s=
vn.
You can browse the patches for bluez-utils at
http://svn.debian.org/wsvn/pkg-bluetooth/bluez-utils/trunk/debian/patches/?=
rev=3D0&sc=3D0

you might be interested in:

http://svn.debian.org/wsvn/pkg-bluetooth/bluez-utils/trunk/debian/patches/0=
07_hcid_typo.patch?op=3Dfile&rev=3D0&sc=3D0
which fixes a small typo in hcid

http://svn.debian.org/wsvn/pkg-bluetooth/bluez-utils/trunk/debian/patches/0=
08_pand_man.patch?op=3Dfile&rev=3D0&sc=3D0
addition for pand manpage referring /etc/bluetooth/pan/dev-up execution

http://svn.debian.org/wsvn/pkg-bluetooth/bluez-utils/trunk/debian/patches/0=
06_xsims.patch?op=3Dfile&rev=3D0&sc=3D0
more compatible usage of test in bluetooth.init and hsplay

[snip]

> And please drop your passkey agent think completely. This will be
> distribution specific and can't be a solution. It is better to put the
> passkey-agent.c example in the docs directory as an example and mention
> it in a README.Debian.
>=20
> That said. I am missing a package for bluez-gnome which contains the
> graphical passkey agent. New version is coming up also this week. It
> will fix a small glitch with the status icon.

indeed, how about this plan:

- I will add to bluez-utils a default non-interactive passkey agent (more o=
r less
  like now but less hackish) which uses /etc/bluetooth/passkeys/<bt_addr> l=
ike
  now
- bluez-gnome will provide the graphical passkey agent which takes over the
  non-interactive one

Marcel: can agents be "stackable", that is, if two agents are registered and
first one doesn't supply an answer, the second will?

comments?

filippo
--
Filippo Giunchedi - http://esaurito.net
PGP key: 0x6B79D401
random quote follows:

Age is not a particularly interesting subject. Anyone can get old. All
you have to do is live long enough.
-- Groucho Marx

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE/VInABzeamt51AERAtDsAKCiIub1MZLNGWh6iib+Uvd3au0CogCgyAS3
jzQw/lwrsCMKgnC8If+MmhI=
=uYHn
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--


--===============0691496910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0691496910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0691496910==--

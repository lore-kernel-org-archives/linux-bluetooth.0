Return-Path: <cyrus@holtmann.org>
Message-ID: <1396829760.13361.19.camel@deadeye.wl.decadent.org.uk>
Subject: Re: linux-firmware: Update Intel BT devices firmware patch files
 (7260/3160)
From: Ben Hutchings <ben@decadent.org.uk>
To: "An, Tedd" <tedd.an@intel.com>
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>,
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
	"Fry, Don" <don.fry@intel.com>
Date: Mon, 07 Apr 2014 01:16:00 +0100
In-Reply-To: <BB52B9B497F0EE4EB05C192A0408F6602F27F4AD@ORSMSX104.amr.corp.intel.com>
References: <20140314135254.2edf9d2e@han1-desk-dev>
	 <1395003913.15764.118.camel@deadeye.wl.decadent.org.uk>
	 <BB52B9B497F0EE4EB05C192A0408F6602F27F4AD@ORSMSX104.amr.corp.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-f+ld/HNCshPNp0fNK0tY"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-f+ld/HNCshPNp0fNK0tY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2014-03-20 at 17:44 +0000, An, Tedd wrote:
> Hi Ben
>=20
> Due to our internal change of build system, the version format needs
> to be updated so I can track it more easily.
[...]
> > > --- a/WHENCE
> > > +++ b/WHENCE
> > > @@ -2254,9 +2254,9 @@ Driver: btusb - Bluetooth USB driver
> > >  File: intel/ibt-hw-37.7.bseq
> > >  Version: 1316.02.00
> > >  File: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> > > -Version: 1344.01.33
> > > +Version: auto.WP_1303_02_patch_0.1.54.1 (0x36)
> > >  File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
> > > -Version: 1344.01.33
> > > +Version: auto.WP_1303_02_patch_0.1.54.1 (0x36)
> > [...]
> >=20
> > Why has the version format changed?  Are all the different parts actual=
ly
> > significant?
[...]

That doesn't answer the second question.

I really have a hard time believing that all of 'auto.WP', '1303_02',
'patch', '0.1.54.1' and '0x36' are all significant.  No-one else seems
to need more than 4 components in a version number; what's so special
about this firmware?

And another question: can an outside observer compare version strings
and get any sense of which is newer?  Are the components in the right
order (most significant first)?

Ben.

--=20
Ben Hutchings
Sturgeon's Law: Ninety percent of everything is crap.

--=-f+ld/HNCshPNp0fNK0tY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAU0HuQOe/yOyVhhEJAQrXAxAAimHkEGk00dWxzT3JqOU3meayTjO3dDgF
vi44gY/Cs4oaTJ2NBDLwP0UpSTMIa5v1u3hpTyIAHmJ1DLSl3JldJrf51P4gt4fp
V8jePMjPWoBsL0EbiNnDUM3MsZTEc7aCYWP9cwWCtQhaPVXIykxrXXvLWDUm3Sr+
XUSGQ74KcyIvH9KqVPkN1XIvFlmf3QW5WnK8Lb7h/KxKAxdy8OhKTWPt9egKGR3j
5JhKSkJnsJ8ZWL6YIPd6+i5F6rjvNQHGkxI2qxbOi+jDHhy8ruymj4mU9/sFbf3F
gQXVhN0X2hFDhcde7S8pyfvsW1WM/nP0J353jTVI2Ni8Gf9AlEY9al+zPMfYI8DH
TA+R8zruPuGnptaxkHJBILzpt18zcxNJNjexCZxJyqeh55p/9muayYNRbjK1M8mk
FZjWdMO9z9BjOwgem+TxoXs++pTUQOEweh93c3n/kpveXhH9GaKnEg/3vxK1lilC
d8CHff+jmC9/uKfZAp2mIgxt70iKyWCLhr8eJvFE8qGXFL4SyFMBqylfnyUPyFvh
/Wx9FkfU684/vLJyWS5G64HDoB4Ad75u6l6Ri15Ty7V26adBmv4SrCOYpROAAoGI
gpYJKkYM1VmJ+w/oGIXtjM48qEmcDr5KXPGjeLWn98J6Zw9kCIV94amaciTYkZDr
nGaSix9Zt8s=
=ANg3
-----END PGP SIGNATURE-----

--=-f+ld/HNCshPNp0fNK0tY--

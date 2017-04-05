Return-Path: <pavel@ucw.cz>
Date: Wed, 5 Apr 2017 22:28:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rob Herring <robh+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Sebastian Reichel <sre@kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Tony Lindgren <tony@atomide.com>, Jiri Slaby <jslaby@suse.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCHv3 00/10] Nokia H4+ support
Message-ID: <20170405202856.GA4854@amd>
References: <20170328155939.31566-1-sre@kernel.org>
 <CAL_JsqJcQ9ANtt71KRitOJ9spKD1SaeoL4RDftiCEPs8TjLJGA@mail.gmail.com>
 <C1A408F2-1DF8-4F49-B399-B936542DE6BC@holtmann.org>
 <20170331133353.GA32267@kroah.com>
 <CAL_Jsq+NU3M5yuBpK1UGgzCVvq0eABMApCqEe3_d5+tDaABsgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
In-Reply-To: <CAL_Jsq+NU3M5yuBpK1UGgzCVvq0eABMApCqEe3_d5+tDaABsgQ@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2017-04-05 13:16:58, Rob Herring wrote:
> On Fri, Mar 31, 2017 at 8:33 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Wed, Mar 29, 2017 at 11:33:26PM +0200, Marcel Holtmann wrote:
> >> Hi Rob,
> >>
> >> >> Here is PATCHv3 for the Nokia bluetooth patchset. I addressed all c=
omments from
> >> >> Rob and Pavel regarding the serdev patches and dropped the *.dts pa=
tches, since
> >> >> they were queued by Tony. I also changed the patch order, so that t=
he serdev
> >> >> patches come first. All of them have Acked-by from Rob, so I think =
it makes
> >> >> sense to merge them to serdev subsystem (now) and provide an immuta=
ble branch
> >> >> for the bluetooth subsystem.
> >> >
> >> > Greg doesn't read cover letters generally and since the serdev patch=
es
> >> > are Cc rather than To him, he's probably not planning to pick them u=
p.
> >>
> >> I wonder actually if we should merge all of these via bluetooth-next
> >> tree with proper Ack from Greg. However it would be good to also get
> >> buy in from Dave for merging this ultimately through net-next.
> >
> > I don't really care where it goes.  I can take the whole thing in my
> > tty/serial tree now if no one objects and I get an ack from the relevant
> > maintainers {hint...}
>=20
> I think it is better if it goes thru BT tree. I have another driver
> converted that is dependent on this series. There's a couple other
> serdev changes on the list too, but this shouldn't depend on them.

I believe BT tree makes sense. Still it would be nice to get Greg's
ACK ...?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljlU4gACgkQMOfwapXb+vKSlgCgwAQ1xUEux3FwJeXT4ckoyptX
dQcAn067vq0A19O5wzzsEfdsYi0a8fQE
=/bfW
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--

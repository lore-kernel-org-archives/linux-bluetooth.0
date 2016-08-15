Return-Path: <sre@kernel.org>
Date: Mon, 15 Aug 2016 03:12:10 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Ville Tervo <ville.tervo@iki.fi>,
	Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
	ivo.g.dimitrov.75@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 5/7] Bluetooth: hci_nokia: Introduce new driver
Message-ID: <20160815011210.vnqwdpapzx2q6gzg@earth>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
 <1471058078-5579-6-git-send-email-sre@kernel.org>
 <CAP=VYLo4ptVzhPjKoiiakbCgBSmpQndNzf0LHWxCZs7LiZ7PYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iwkwabbleb7dt4qo"
In-Reply-To: <CAP=VYLo4ptVzhPjKoiiakbCgBSmpQndNzf0LHWxCZs7LiZ7PYw@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>


--iwkwabbleb7dt4qo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Sun, Aug 14, 2016 at 07:54:28PM -0400, Paul Gortmaker wrote:
> On Fri, Aug 12, 2016 at 11:14 PM, Sebastian Reichel <sre@kernel.org> wrot=
e:
> > This driver adds support for Nokia H4+ procotol used
> > for example by Nokia's internet tablets (N770 - N950).
> >
> > [...]
> >
> > +config BT_HCIUART_NOKIA
> > +       bool "UART Nokia H4+ protocol support"
>=20
> If the option is a bool, then you don't need module.h or any MODULE
> macros, nor do you need any __exit or unregister related code.
>=20
> Alternatively, if there is a use case for it to be modular, then maybe you
> want to change the above to a tristate.

Actually it is bool and modular: It becomes part of the module
configured by the tristate CONFIG_BT_HCIUART option.

-- Sebastian

--iwkwabbleb7dt4qo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXsRbnAAoJENju1/PIO/qao90P/1T1PQHcpiCCBVTbEOqsV+dU
DnaWi3DoEz6h4LSvS2CST4wv2BYKdczrdTeuyoakUnQ0676mC4lzS/lwYJzz6Xy1
hQAhfkZIjp3Erlz0j1ExezZAcgfjQwvoq7Z1jaJSEI1vvVLTrS9TIF/wpX0lIWeB
U9zwB9bp6gPucP10OCYCAEHHqnKWEV8WmyKgaUd1qqJROuXOhPmLCKc0+joLwCKF
67/GqWsSkBdYz/2/l0Y+RQx1wOzyOWrBq518mJVW36MIvqGnDA74nx8uF3FqP6sV
hdoZpfEeUjmIgUbXbJSsHBw8l76WdOsSCsHkwcGV6tpdMucOmMG7Iz8NRm+B5BeR
FhSYVbiwz8gkF2MQ5F1f4sfnXTaZtRB1NKRcuC7kFPR9Kw54OPJweVYY+aW2yWlf
VLpKRrvBga1iFC6ZtOcfTcNlEEJNAQbkPf5ak9JQvsy/vnIvVnIs6kr2juskVv87
2zcBExscF/RYTNJRP7gTwEeTGXdcYxYIrU4lB9nC9LHvdP6uNWVOXaw6TkowEZLI
xIXtl2rbKy56JCBnZkjPkhGuWkV2FpYV6ZYrBR9sm0R/UI82g095WgKOiSxfY1AJ
PWsPJiWa//9UAOSVk17ViRWzZLJn9Zw7JMJzAtWVa2oRjO80hBuogYiQIzllpfR9
f2hwJYn3Fd661eeUMjN0
=U6z1
-----END PGP SIGNATURE-----

--iwkwabbleb7dt4qo--

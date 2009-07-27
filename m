Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Jul 2009 12:30:29 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: pHilipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] pcmcia: dtl1_cs: fix pcmcia_loop_config logic
Message-ID: <20090727103029.GD3671@pengutronix.de>
References: <1235753648-10045-1-git-send-email-philipp.zabel@gmail.com> <74d0deb30902271435u1d2ac128ob09896a86abbff64@mail.gmail.com> <4A6D7A47.8050001@pengutronix.de> <1248689611.28545.196.camel@violet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
In-Reply-To: <1248689611.28545.196.camel@violet>
List-ID: <linux-bluetooth.vger.kernel.org>


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > On Fri, Feb 27, 2009 at 5:54 PM, Philipp Zabel <philipp.zabel-Re5JQEe=
Qqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > >> pcmcia_loop_config returns 0 on success.
> > >>
> > >> Signed-off-by: Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@p=
ublic.gmane.org>
> > >> ---
> > >>  drivers/bluetooth/dtl1_cs.c |    2 +-
> > >>  1 files changed, 1 insertions(+), 1 deletions(-)
> > >>
> > >> diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs=
=2Ec
> > >> index 901bdd9..e0ee642 100644
> > >> --- a/drivers/bluetooth/dtl1_cs.c
> > >> +++ b/drivers/bluetooth/dtl1_cs.c
> > >> @@ -616,7 +616,7 @@ static int dtl1_config(struct pcmcia_device *lin=
k)
> > >>
> > >>        /* Look for a generic full-sized window */
> > >>        link->io.NumPorts1 =3D 8;
> > >> -       if (!pcmcia_loop_config(link, dtl1_confcheck, NULL))
> > >> +       if (pcmcia_loop_config(link, dtl1_confcheck, NULL))
> > >>                goto failed;
> > >>
> > >>        i =3D pcmcia_request_irq(link, &link->irq);
> > >> --
> > >> 1.5.6.5
> > >=20
> > > with this change my Nokia DTL-1 CF card gets detected, but the
> > > interface stays down.
> >=20
> > I am reviewing patches which came through the pcmcia-list since the las=
t=20
> > upstream commit last year.
> >=20
> > IMHO the above patch could be queued, even though there seem to be furt=
her=20
> > issues with the driver. What do you think?
> >=20
> > So, for the above patch:
> >=20
> > Acked-by: Wolfram Sang <w.sang@pengutronix.de>
>=20
> can we change it into if (pcmcia_loop_config(...) < 0) to it perfectly
> clear here.

Yup, I'd like that better, too.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkptgcUACgkQD27XaX1/VRtCRgCgugRq5VC3pXW2w02E9LGkPL+W
H+sAoJ3OL/s36PoYoKJyyLa3IX9rAiEa
=wGwe
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--

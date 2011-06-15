Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Jun 2011 16:04:48 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: Bastien Nocera <hadess@hadess.net>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/2] Add function to get default adapter ID
Message-Id: <20110615160448.418f1ade.ospite@studenti.unina.it>
In-Reply-To: <1308060161.9190.0.camel@air.hadess.net>
References: <1307627589-25786-1-git-send-email-hadess@hadess.net>
	<20110614130252.GA4215@dell.ger.corp.intel.com>
	<1308060161.9190.0.camel@air.hadess.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__15_Jun_2011_16_04_48_+0200_5Nkddo9AnrlD5bZx"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Wed__15_Jun_2011_16_04_48_+0200_5Nkddo9AnrlD5bZx
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Jun 2011 15:02:39 +0100
Bastien Nocera <hadess@hadess.net> wrote:

> On Tue, 2011-06-14 at 16:02 +0300, Johan Hedberg wrote:
> > Hi Bastien,

> > > diff --git a/src/manager.c b/src/manager.c
> > > index e805e0c..9d0de25 100644
> > > --- a/src/manager.c
> > > +++ b/src/manager.c
> > > @@ -288,6 +288,11 @@ static void manager_remove_adapter(struct btd_ad=
apter *adapter)
> > >  		btd_start_exit_timer();
> > >  }
> > > =20
> > > +int manager_get_default_adapter_id(void)
> > > +{
> > > +	return default_adapter_id;
> > > +}
> >=20
> > Would it not make more sense to have something that returns the adapter
> > object directly? I.e. are there actually any use cases where some plugin
> > would want the id but *not* want to resolve the matching adapter object?
> > And even if the plugin still needs the id (which I'd expect to be a
> > minority use-case if it exists at all) it can always call
> > adapter_get_dev_id().
>=20
> I really really don't care either way. I sent both variations of the
> patch already (Antonio has one in his patchset, and I sent the other).
> Commit either, and we'll change our patches.
>=20

Yep, same for me, either this one or the one in
http://article.gmane.org/gmane.linux.kernel.input/19751 is OK, we just
need a way to get the default adapter, please.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Wed__15_Jun_2011_16_04_48_+0200_5Nkddo9AnrlD5bZx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk34vAAACgkQ5xr2akVTsAGDKgCeLJnNyvnu6Iz9BWfIrC1z7PcR
CiIAoKJTpXVULr+f/t2oajDY2CPaw6EN
=Elhk
-----END PGP SIGNATURE-----

--Signature=_Wed__15_Jun_2011_16_04_48_+0200_5Nkddo9AnrlD5bZx--

Return-Path: <cyrus@holtmann.org>
Subject: Re: >net-wireless/bluez-4.63 unable to connect audio streams due
 commit
From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Reply-To: pacho@condmat1.ciencias.uniovi.es
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <AANLkTikFrvyeoXV0uLYcvD4GCj2s3ML2-q8f5GhXMxAK@mail.gmail.com>
References: <20100920184943.GA22968@jh-x301>
	 <1286027890.12944.1.camel@localhost.localdomain>
	 <AANLkTikFrvyeoXV0uLYcvD4GCj2s3ML2-q8f5GhXMxAK@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-5rDBKoIp5JPjL6WMzzOi"
Date: Mon, 04 Oct 2010 12:25:46 +0200
Message-ID: <1286187946.7898.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-5rDBKoIp5JPjL6WMzzOi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 04-10-2010 a las 13:00 +0300, Luiz Augusto von Dentz escribi=C3=B3:
> Hi,
>=20
> On Sat, Oct 2, 2010 at 4:58 PM, Pacho Ramos
> <pacho@condmat1.ciencias.uniovi.es> wrote:
> > El lun, 20-09-2010 a las 21:49 +0300, Johan Hedberg escribi=C3=B3:
> >> Hi,
> >>
> >> On Mon, Sep 20, 2010, Pacho Ramos wrote:
> >> > Reporter found that the problem with his dongle was introduced in co=
mmit
> >> > aee26b30bbc24cde464ba1a557c2b258ddec6432 "Make BtIO default security
> >> > level MEDIUM", he asked here, on upstream mailing list, but didn't g=
et
> >> > any reply clarifying this:
> >> > http://marc.info/?l=3Dlinux-bluetooth&m=3D127893935109510&w=3D2
> >>
> >> The important piece of info missing here is an HCI trace of the failur=
e
> >> (i.e. output of hcidump). There was a similar issue reported on IRC a
> >> few days back and the hcidump there revealed a LMP response timeout
> >> after BlueZ issues a HCI_Set_Connection_Encryption command. This would
> >> seem to indicate a bug either in the local adapter or the remote devic=
e
> >> (headset). Only an airtrace would really reveal what's going on.
> >> However, I suspect it might be possible to work around this by looking
> >> into possibilities of changing the ordering and timing of when the
> >> kernel sends the encryption request.
> >>
> >> Johan
> >>
> >
> > Sorry for the delay but downstream reporter wasn't able to provide the
> > information sooner.
> >
> > Attached is hcidump output, I hope it helps :-)
>=20
> I would say this was because of double authentication request, but it
> seems it is not the case, actually ssp doesn't seems to be used at all
> here so this must be something else, maybe you should try this:
>=20
> http://thread.gmane.org/gmane.linux.bluez.kernel/7256
>=20

Thanks but, how should I try to apply that patch? Looks like
net/bluetooth/rfcomm/core.c is not present on bluez-4.72 sources

Best regards

--=-5rDBKoIp5JPjL6WMzzOi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkypq6oACgkQCaWpQKGI+9QS5wCfUigH9ICvelsVakOPaw8kvfx2
7WIAn3HneCs90VKkos29NMVA1IWyEN5C
=ipkA
-----END PGP SIGNATURE-----

--=-5rDBKoIp5JPjL6WMzzOi--


Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Apr 2012 14:36:25 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH BlueZ v2 0/3] Current status of playstation-peripheral
 plugin
Message-Id: <20120420143625.7e8c2a9d8e73b18211bc1ca4@studenti.unina.it>
In-Reply-To: <1334748297.8818.121.camel@novo.hadess.net>
References: <1334741891-11869-1-git-send-email-ospite@studenti.unina.it>
	<1334748297.8818.121.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__20_Apr_2012_14_36_25_+0200_.Z1_Be4ABWPfv.E2"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Fri__20_Apr_2012_14_36_25_+0200_.Z1_Be4ABWPfv.E2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Apr 2012 12:24:57 +0100
Bastien Nocera <hadess@hadess.net> wrote:

> On Wed, 2012-04-18 at 11:38 +0200, Antonio Ospite wrote:
> > This is a short summary about Playstation peripherals and their pairing
> > mechanism, to recap the current status of the playstation-peripheral pl=
ugin,
> > propose a working solution and discuss possible better ones.
> >=20
> > From now on in this message I sometime call a Playstation peripheral
> > simply a "device".
>=20
> Would be good to have all that information in a README, or the source,
> and list which devices we're capable of handling (Sixaxis? Keypad?
> Headset? Move?).
>

I'll add this information as a comment in the code.

> > Bastien, please check if I am forgetting anything :)
> >=20
> > WHAT we need the plugin to do:
> >=20
> >   - When a device is connected via USB:
> >     + Fetch the (default) adapter bdaddr (from BlueZ) and store it into
> >       the device
> >     + Fetch the device bdaddr (from the device via USB/HID) and make the
> >       device _trusted_ by the adapter (is "trusted" the correct term
> >       here?
>=20
> Setting it as trusted isn't the only thing you're doing. You're making
> it known (meaning that you fill in details such as its SDP record,
> including name), then adding it as trusted so that BlueZ doesn't ask the
> user whether this device is allowed to connect.
>=20
> You need a separate function to make it "known" and insert it into
> BlueZ's database. _set_trusted() should be a function that takes a
> single device and a value (whether to trust or untrust), that's it.
>=20
> So you need to split it in 2 separate functions.

OK, so the operations we are doing are:
	- Make the device "known" (add its details to the database of
          devices known by a given adapter)
	- Make the device trusted (enable its connection)

Has the first operation a more official name? How does it relate to
the "association" operation? Is it a device operation, in the sense
that we are adding a device, or rather an adapter operation, in the
sense that we are filling the database of a given adapter?

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Fri__20_Apr_2012_14_36_25_+0200_.Z1_Be4ABWPfv.E2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+RWEkACgkQ5xr2akVTsAFskwCglY/GSsSb2znRHOIfIeUHu4DK
E4MAn2N+3UBPQUCYtZNgO3+EIA8JqfQj
=RUWD
-----END PGP SIGNATURE-----

--Signature=_Fri__20_Apr_2012_14_36_25_+0200_.Z1_Be4ABWPfv.E2--

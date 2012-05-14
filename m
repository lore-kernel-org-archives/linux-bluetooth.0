Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 May 2012 12:37:38 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>,
	linux-bluetooth@vger.kernel.org,
	Scott James Remnant <scott@netsplit.com>
Subject: Re: [PATCH BlueZ v2 0/3] Current status of playstation-peripheral
 plugin
Message-Id: <20120514123738.73a1b4f4b92ddb5e0f5f11fb@studenti.unina.it>
In-Reply-To: <20120420140825.GA19909@x220.P-661HNU-F1>
References: <1334741891-11869-1-git-send-email-ospite@studenti.unina.it>
	<1334748297.8818.121.camel@novo.hadess.net>
	<20120420143625.7e8c2a9d8e73b18211bc1ca4@studenti.unina.it>
	<20120420140825.GA19909@x220.P-661HNU-F1>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__14_May_2012_12_37_38_+0200_MiP_B6aF_Q=ixBkQ"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Mon__14_May_2012_12_37_38_+0200_MiP_B6aF_Q=ixBkQ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Apr 2012 17:08:26 +0300
Johan Hedberg <johan.hedberg@gmail.com> wrote:

> Hi Antonio,
>=20
> On Fri, Apr 20, 2012, Antonio Ospite wrote:
> > I'll add this information as a comment in the code.
> >=20
> > > > Bastien, please check if I am forgetting anything :)
> > > >=20
> > > > WHAT we need the plugin to do:
> > > >=20
> > > >   - When a device is connected via USB:
> > > >     + Fetch the (default) adapter bdaddr (from BlueZ) and store it =
into
> > > >       the device
> > > >     + Fetch the device bdaddr (from the device via USB/HID) and mak=
e the
> > > >       device _trusted_ by the adapter (is "trusted" the correct term
> > > >       here?
> > >=20
> > > Setting it as trusted isn't the only thing you're doing. You're making
> > > it known (meaning that you fill in details such as its SDP record,
> > > including name), then adding it as trusted so that BlueZ doesn't ask =
the
> > > user whether this device is allowed to connect.
> > >=20
> > > You need a separate function to make it "known" and insert it into
> > > BlueZ's database. _set_trusted() should be a function that takes a
> > > single device and a value (whether to trust or untrust), that's it.
> > >=20
> > > So you need to split it in 2 separate functions.
> >=20
> > OK, so the operations we are doing are:
> > 	- Make the device "known" (add its details to the database of
> >           devices known by a given adapter)
> > 	- Make the device trusted (enable its connection)
> >=20
> > Has the first operation a more official name? How does it relate to
> > the "association" operation? Is it a device operation, in the sense
> > that we are adding a device, or rather an adapter operation, in the
> > sense that we are filling the database of a given adapter?
>=20
> I'd make it an adapter operation and I'd also suggest to explore the
> option of using the same API that devices get added to storage during
> "normal" device discovery: btd_event_device_found(). After all you are
> discovering a device in this use case. The only speciality is that it
> happens over USB instead of traditional Bluetooth inquiry. That way you
> would only need to add the set_trusted function and nothing else.
>=20

OK, so far I've split the set_trusted() bits and moved the old big
function to adapter.c, it is now called: btd_create_stored_device()

I noticed than set_trusted() (i.e. writing to the trusts file) has to be
called before I create the device when connected via USB, otherwise
the later connection via BT does not succeed.

I am still looking how to use the adapter API in
btd_create_stored_device(), Scott if you are still willing to help I am
sending you the latest patches privately to avoid making too much noise
here for very small incremental changes.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Mon__14_May_2012_12_37_38_+0200_MiP_B6aF_Q=ixBkQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+w4HIACgkQ5xr2akVTsAGvHQCdHlK4H47i/Wb8krVM95lGkVgG
WDkAn2cD7qYgk59AjwZTrKAcCxH1HUSR
=US09
-----END PGP SIGNATURE-----

--Signature=_Mon__14_May_2012_12_37_38_+0200_MiP_B6aF_Q=ixBkQ--

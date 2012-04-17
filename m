Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Apr 2012 12:56:55 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH BlueZ 3/3] device: add a btd_device_set_trusted() call
Message-Id: <20120417125655.fc111f0cefabfee51e8af01f@studenti.unina.it>
In-Reply-To: <20120416125748.GB30242@x220.P-661HNU-F1>
References: <1329144168-19263-1-git-send-email-ospite@studenti.unina.it>
	<1329144168-19263-4-git-send-email-ospite@studenti.unina.it>
	<20120416125748.GB30242@x220.P-661HNU-F1>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__17_Apr_2012_12_56_55_+0200_Qq0La9fsB6NnLoys"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Tue__17_Apr_2012_12_56_55_+0200_Qq0La9fsB6NnLoys
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Apr 2012 15:57:48 +0300
Johan Hedberg <johan.hedberg@gmail.com> wrote:

> Hi Antonio,
>=20
> On Mon, Feb 13, 2012, Antonio Ospite wrote:
> > +int btd_device_set_trusted(const char *adapter_address,
> > +			   const char *device_address,
> > +			   char *name,
> > +			   uint16_t vendor_id_source,
> > +			   uint16_t vendor_id,
> > +			   uint16_t product_id,
> > +			   uint16_t version_id,
> > +			   const char *uuid)
> > +{
>=20
> If you have a function called set_trusted then that's *all* it should
> do. You have six other parameters there that have *nothing* to do with
> the function name.

Well that exposes my confusion/ignorance about what a "trusted device"
is, from what see, to make a device look fully trusted to BlueZ, it is
not enough to just call:

	write_trust(adapter_address, device_address, "[all]", TRUE);

a bunch of other properties are needed (uuids, sdp records), maybe the
problem is about defining what I want, maybe I want a
_statically_trusted_ device? I don't know if that even makes sense in
bluetooth terminology.

The point here is that we are setting these parameters BEFORE the
devices connects via bluetooth, in fact they are set when the device is
connected via USB for the cable pairing step.

> Also, as I mentioned in my previous email the full
> use case for all of these should be understood (which also implies the
> code that uses them being available) before anything gets added to the
> bluetoothd exported API.

You are right, of course, I'll prepare a more detailed text which
explains WHAT I need to do and WHY, and hopefully you can guide me
about HOW to do that properly.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Tue__17_Apr_2012_12_56_55_+0200_Qq0La9fsB6NnLoys
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+NTHcACgkQ5xr2akVTsAGc/wCdHdZwc8R2OffGxWhiY+k5Km+g
tggAn0ubzzlUz5V3qTT7SUWnIqxzoxWD
=S8kB
-----END PGP SIGNATURE-----

--Signature=_Tue__17_Apr_2012_12_56_55_+0200_Qq0La9fsB6NnLoys--

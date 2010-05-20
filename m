Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 May 2010 11:57:27 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Subject: Re: bluez: lowercase hex digits in BDADDRs
Message-Id: <20100520115727.32df80c3.ospite@studenti.unina.it>
In-Reply-To: <20100505151220.137a0b37.ospite@studenti.unina.it>
References: <20100505151220.137a0b37.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__20_May_2010_11_57_27_+0200_=VGuRQv1ZG_R3As="
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Thu__20_May_2010_11_57_27_+0200_=VGuRQv1ZG_R3As=
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 5 May 2010 15:12:20 +0200
Antonio Ospite <ospite@studenti.unina.it> wrote:

> Hi,
>=20
> when working on Sixaxis pairing plugin I found out a weird behavior, if
> I use a BDADDR with lowercase hex digits the association can fail.
>

Ping. Anyone ever experienced that?

> The interesting bits in bluetoothd logs are reported in the attached
> diff, maybe adapter_create_device() is not robust enough?
>=20
> You can reproduce this behavior using a lowercase _device_ bdaddr
> into these files:
>     /var/lib/bluetooth/00:03:C9:XX:XX:XX/did
>     /var/lib/bluetooth/00:03:C9:XX:XX:XX/lastused
>     /var/lib/bluetooth/00:03:C9:XX:XX:XX/sdp
>     /var/lib/bluetooth/00:03:C9:XX:XX:XX/trusts
> where 00:03:C9:XX:XX:XX is the _adapter_ bdaddr.
>=20
> Can anyone else confirm that? bluez-4.64
>=20
> Not a big deal, but worth reporting IMHO.
>=20
> Thanks,
>    Antonio
>=20

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

--Signature=_Thu__20_May_2010_11_57_27_+0200_=VGuRQv1ZG_R3As=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkv1B4cACgkQ5xr2akVTsAE9hACgr621Jq6URpvF03QV4bEQYFme
/MYAn32Ui+U1TJbxxzRp+GAIiTcrlFko
=fXlM
-----END PGP SIGNATURE-----

--Signature=_Thu__20_May_2010_11_57_27_+0200_=VGuRQv1ZG_R3As=--

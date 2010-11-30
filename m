Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Nov 2010 15:06:56 +0100
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-input@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Marcel Holtmann <marcel@holtmann.org>,
	Jiri Kosina <jkosina@suse.cz>, Alan Ott <alan@signal11.us>
Subject: Re: hidp_output_raw_report, HID_OUTPUT_REPORT and Sixaxis
Message-Id: <20101130150656.e3353e6e.ospite@studenti.unina.it>
In-Reply-To: <20101130145405.d8142bc3.ospite@studenti.unina.it>
References: <20101130145405.d8142bc3.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__30_Nov_2010_15_06_56_+0100_GGlWyX5IX9lPn3/E"
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Tue__30_Nov_2010_15_06_56_+0100_GGlWyX5IX9lPn3/E
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Nov 2010 14:54:05 +0100
Antonio Ospite <ospite@studenti.unina.it> wrote:

> Hi,
>=20
> another piece in the Sixaxis jigsaw:
> in commit d4bfa033ed84e0ae446eff445d107ffd5ee78df3 support for setting
> different report types was added to hidp, however in my Sixaxis
> experiments setting leds (sending and output report) was not working

sending _an_ output report.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Tue__30_Nov_2010_15_06_56_+0100_GGlWyX5IX9lPn3/E
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkz1BQAACgkQ5xr2akVTsAEm/wCgkL4VAn34F4x9HQnxxS6vHwCK
orIAnArtcp6RowYIazzZmYfYpQ5Fb8cu
=9RFs
-----END PGP SIGNATURE-----

--Signature=_Tue__30_Nov_2010_15_06_56_+0100_GGlWyX5IX9lPn3/E--

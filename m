Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Jul 2012 12:38:53 -0400
From: "W. Trevor King" <wking@tremily.us>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth.h: fix compile issue when using in C++
Message-id: <20120727163853.GA11847@odin.tremily.us>
References: <1330953167.3457.13.camel@pohly-mobl1.fritz.box>
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=ReaqsoxgOBHFXBhH
In-reply-to: <1330953167.3457.13.camel@pohly-mobl1.fritz.box>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2012 at 01:12:47PM -0000, Patrick Ohly wrote:
> From: Patrick Ohly <patrick.ohly@intel.com>
> Date: Mon, 16 Jan 2012 10:58:44 +0100
> Subject: [PATCH] bluetooth.h: fix typecast and typeof compile issue when =
used
>  in C++
>
> =E2=80=A6
>
> Another issue in combination with -std=3Dc++0x is the use of typeof,
> which is not a standard C++ feature and thus gets rejected in strict
> mode.
>=20
> This patch keeps the "struct __attribute__((packed))" magic and merely
> changes the typecast so that it works in C and C++. typeof gets replaced
> with __typeof__.

This patch seems to have never made it into bluez, and I just bumped
into the typeof/__typeof__ issue again today.  I could not find any
comments in the mailing list explaining if or why the patch was
rejected, so perhaps it just fell through the cracks?

Is there any chance of getting it accepted?

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQEsQbAAoJEEUbTsx0l5OM2+gQAKjHIXJXu+rn80kJAaghcClW
WJK4bO2F2AraF275UddB/HLAhaFGvTHZep17aeGIUmFDNt7VDb6ZkTRqWgF8eNON
cag8DNtgFzC+qZ7IZFgRZkY3BYM+FLVEu9xKc7kK77DCVP9sYfpomT6pWE/EtCGy
vwXtyLJaVI0kNqneTN0RPnn+WptKCafFEcu2ekLBBYv+9hTHQ+Pw+nIXmp3H6aph
OxhvviCp8FBq1WkZl/X8H8nnIdLZfBQ0PaOm6H8jsqAf7Q746kai/PWWPEhxGWii
Iwo/wE7TGP1tOohh/TETxSoTcVMwst570TsI6Iiek0GWIRCtbw2kmaC9vRcA5eGZ
Tl1ktl3KlnH5N8KNyboRRNGBKXHPRD4VTh0OLeIqCAljpH8+GnIs4DyOXswoJvHm
+XDwzYsNr1GAsQP3MsaLRS4suKAfUH2EwHlUKPt66ZDvVGTU5AFJbsUP6pXAZdIb
LpVWit96RDdXC0DVWi3MevTC5gxlDyfPnCxyTIGy5oo1NO74qq5P8EaUWdnIzZDF
3KUwHVVgEOTos4MUQfWlseWuRd2X0nGc+j/nNVbjzTxFSv2m70BSkccpqmsqu1h8
htiMms7GR1O05rxZ4EasLMXiTXHZdlFdjG4vil6eJA0ZezmemFU/253tS1q3wtk6
vOSlWDaZCR6LzmQAyDum
=Rqeb
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--

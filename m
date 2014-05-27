Return-Path: <cyrus@holtmann.org>
Message-ID: <1401223906.2586.18.camel@deadeye.wl.decadent.org.uk>
Subject: Re: linux-firmware: Add firmware patch file for Intel Bluetooth
 7260 ROM-spin
From: Ben Hutchings <ben@decadent.org.uk>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: linux-firmware@kernel.org, linux-bluetooth@vger.kernel.org,
	emmanuel.grumbach@intel.com, don.fry@intel.com
Date: Tue, 27 May 2014 21:51:46 +0100
In-Reply-To: <20140321190814.252602a0@han1-desk-dev>
References: <20140321190814.252602a0@han1-desk-dev>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Ueko2v63bh9fOMGN9ZUm"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-Ueko2v63bh9fOMGN9ZUm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2014-03-21 at 19:08 -0700, Tedd Ho-Jeong An wrote:
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>=20
> This patch adds the firmware patch file for
> - Intel Wirless 7260 BT ROM-spin SKU, also known as WP2 B5.
>=20
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
[...]

I'm finally giving up and applying your two patches, but I am tempted to
add smething like this on top:

diff --git a/WHENCE b/WHENCE
index 98519be..f4758fa 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2265,15 +2265,15 @@ Found also in alsa-firmware package.
 Driver: btusb - Bluetooth USB driver
=20
 File: intel/ibt-hw-37.7.bseq
-Version: 1316.02.00
+Version: 2013-04-22 (1316.02.00)
 File: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
-Version: auto.WP_1303_02_patch_0.1.54.1 (0x36)
+Version: 2014-03-14 (auto.WP_1303_02_patch_0.1.54.1, 0x36)
 File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
-Version: auto.WP_1303_02_patch_0.1.54.1 (0x36)
+Version: 2014-03-14 (auto.WP_1303_02_patch_0.1.54.1, 0x36)
 File: intel/ibt-hw-37.8.bseq
-Version: 1339_02.00
+Version: 2014-03-14 (1339_02.00)
 File: intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
-Version: STP2_C0_1339_02_patch_13.1 (0x0D)
+Version: 2014-03-14 (STP2_C0_1339_02_patch_13.1, 0x0D)
=20
 Licence: Redistributable. See LICENCE.ibt_firmware for details
=20
---

That way, it will be easy to recognise a new version - but I suspect
those email dates don't match your internal release dates.  I really
would prefer if you could come up with a better alternative.

Ben.

--=20
Ben Hutchings
A free society is one where it is safe to be unpopular. - Adlai Stevenson

--=-Ueko2v63bh9fOMGN9ZUm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIVAwUAU4T68ee/yOyVhhEJAQrLnw//Q0W7xPvx6Us5Q65MSaA5hBlFdIq8VGG+
gPn23bIRqaQncRzyT3D2u10CxS1g4+lFAlgbUhbQRJVpyOpHmm91E1x8PyN5qec7
iSHrHtOF627t0D2oYJAnJMvTv3uy536ub1mOg2wz+b1slxvjjzbh7ispHNjHME2W
1htKoedKt5TTVKH8Ihlb+Fq8mO5Zs+bAFDUs+IL8VQlfyUEP26pbII79zfcuGTx7
0Eos6aTJZ7w0BAthmjCALFXF0rbRnSSo8CZNC9aKn3wpRc32HlubxDw+KjOoSa5k
dXnGEu/FXD5OAj/kB27CcGoGEUs/fft7/OQnmpPq2UAmtIDXQaTuBQQqp/tOlkI5
GP+IHutMQRtJbj2/nG6liT2AocywI41KTUWS2+E4gBM05Z7twh3o7ZSsrvtuwbgA
vkqMvW8mPZsACXNCP6IASoRzGFlt4BlpRRgUyearM/Qn1yHdsh0OqMcHxoSVzrTt
dufaoiP0pZl6uBv4dz6douIq4EC8sbCILLz6V3wMiEdP0Dq1W9+U3nodZB8yJdSq
kgFkAfhotylytUfiwLqs/tL4Hw5ePd4BEXpb9Vi/PugCrOKNVnPUiQ4D/UXyXqs+
v7SjFzp1tVkDaNSYbVLtq5NHzZrkw7IbN3oXeDwJcy+gHc60HLpZiDc62q+6mina
jLL4kha1XfI=
=erhy
-----END PGP SIGNATURE-----

--=-Ueko2v63bh9fOMGN9ZUm--

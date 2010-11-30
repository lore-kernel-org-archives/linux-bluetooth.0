Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Nov 2010 14:54:05 +0100
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-input@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Marcel Holtmann <marcel@holtmann.org>,
	Jiri Kosina <jkosina@suse.cz>, Alan Ott <alan@signal11.us>
Subject: hidp_output_raw_report, HID_OUTPUT_REPORT and Sixaxis
Message-Id: <20101130145405.d8142bc3.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__30_Nov_2010_14_54_05_+0100_YiJSG2T6=FXVOzp/"
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Tue__30_Nov_2010_14_54_05_+0100_YiJSG2T6=FXVOzp/
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

another piece in the Sixaxis jigsaw:
in commit d4bfa033ed84e0ae446eff445d107ffd5ee78df3 support for setting
different report types was added to hidp, however in my Sixaxis
experiments setting leds (sending and output report) was not working
until I made this change:

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index b68a608..0c443b7 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -402,7 +402,7 @@ static int hidp_output_raw_report(struct hid_device *hi=
d, unsigned char *data, s
 		report_type =3D HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE;
 		break;
 	case HID_OUTPUT_REPORT:
-		report_type =3D HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT;
+		report_type =3D HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_OUPUT;
 		break;
 	default:
 		return -EINVAL;

Is it only the Sixaxis which needs the output report as a SET_REPORT
operation, or the change above is an actual fix?
I don't know bluetooth at all, sorry.

In case this is a sixaxis specific behavior then I guess I'll be
overriding hidp_output_raw_report() in hid-sony.c just like I did for the
usbhid counterpart.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Tue__30_Nov_2010_14_54_05_+0100_YiJSG2T6=FXVOzp/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkz1Af0ACgkQ5xr2akVTsAG19gCdHrEkPPWdB+A7kwT7t8LNIFFv
JLQAn1jxLCB7/5YN5kO+hRRf8oEdhRa7
=6XyQ
-----END PGP SIGNATURE-----

--Signature=_Tue__30_Nov_2010_14_54_05_+0100_YiJSG2T6=FXVOzp/--

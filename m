Return-Path: <cyrus@holtmann.org>
Message-ID: <4900A74C.5030200@dell.com>
Date: Thu, 23 Oct 2008 11:33:16 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Quirk for Apple Aluminum Bluetooth  keyboard FN key
References: <48F50EEB.1060802@dell.com> <1224737771.9386.180.camel@californication>
In-Reply-To: <1224737771.9386.180.camel@californication>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig182B6F5CBAFA1528037465EF"
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig182B6F5CBAFA1528037465EF
Content-Type: multipart/alternative;
 boundary="------------080406010701050503010106"

This is a multi-part message in MIME format.
--------------080406010701050503010106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Marcel:

Marcel Holtmann wrote:
> Hi Mario,
> yeah, the Ubuntu kernel team is pretty bad in getting patches back to
> upstream. However in this case please check with the upstream kernel
> since the HID bus makes all quirks general to the HID subsystem.
>
> Regards
>
> Marcel
Yeah, that's what I was thinking should be happening, and a little bit
shocked that it didn't work properly since I saw a variation of this
quirk in the hid source files already.  I was a little thrown off though
since there is already a quirk for the mighty mouse sitting in this
section that I was patching, so it seemed sensible to add the quirk for
the keyboard there too.  I'll try to investigate why those quirks aren't
carrying over properly.

Regards
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------080406010701050503010106
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html;charset=3DISO-8859-1" http-equiv=3D"Content-=
Type">
</head>
<body bgcolor=3D"#ffffff" text=3D"#000000">
<font size=3D"-1"><font face=3D"Helvetica, Arial, sans-serif">Hi Marcel:<=
br>
</font></font><br>
Marcel Holtmann wrote:
<blockquote cite=3D"mid:1224737771.9386.180.camel@californication"
 type=3D"cite">
  <pre wrap=3D"">Hi Mario,</pre>
</blockquote>
<blockquote cite=3D"mid:1224737771.9386.180.camel@californication"
 type=3D"cite">
  <pre wrap=3D"">
yeah, the Ubuntu kernel team is pretty bad in getting patches back to
upstream. However in this case please check with the upstream kernel
since the HID bus makes all quirks general to the HID subsystem.

Regards

Marcel</pre>
</blockquote>
<small><font face=3D"Helvetica, Arial, sans-serif">Yeah, that's what I
was thinking should be happening, and a little bit shocked that it
didn't work properly since I saw a variation of this quirk in the hid
source files already.&nbsp; I was a little thrown off though since there =
is
already a quirk for the mighty mouse sitting in this section that I was
patching, so it seemed sensible to add the quirk for the keyboard there
too.&nbsp; I'll try to investigate why those quirks aren't carrying over
properly.<br>
<br>
Regards</font></small><br>
<div class=3D"moz-signature">-- <br>
<title></title>
<font face=3D"Helvetica, Arial, sans-serif" size=3D"-2"><font
 color=3D"#999999">Mario Limonciello</font><br>
<b><font color=3D"#ff0000">Dell</font> | <font color=3D"#666666">Linux
Engineering</font></b><font color=3D"#666666"><br>
</font><font color=3D"#666666"><a class=3D"moz-txt-link-abbreviated" href=
=3D"mailto:mario_limonciello@dell.com">mario_limonciello@dell.com</a></fo=
nt></font>
</div>
</body>
</html>

--------------080406010701050503010106--

--------------enig182B6F5CBAFA1528037465EF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkkAp0wACgkQ2CrZjkA73YuIBACeKh5ElrsQn8F747OgUBFnsrgR
fMMAoJB7C8Sy8QqBeoSoV4RH8ef2Ct/M
=feiI
-----END PGP SIGNATURE-----

--------------enig182B6F5CBAFA1528037465EF--

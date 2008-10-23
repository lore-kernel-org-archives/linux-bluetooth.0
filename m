Return-Path: <cyrus@holtmann.org>
Message-ID: <4900E710.3090003@dell.com>
Date: Thu, 23 Oct 2008 16:05:20 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] first udev rules for running hid2hci
References: <4900DBD0.3040108@dell.com> <1224795492.9386.198.camel@californication>
In-Reply-To: <1224795492.9386.198.camel@californication>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1CC96C1B965D94CC81131784"
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1CC96C1B965D94CC81131784
Content-Type: multipart/alternative;
 boundary="------------070104020202090305040509"

This is a multi-part message in MIME format.
--------------070104020202090305040509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann wrote:
> Hi Mario,
>
>  =20
>
> I like to have this all in one and that the PCMCIA ones are in a
> different binary package is a distro problem. They don't have to be
> since we don't have the dependency of pcmcia-cs anymore. That is ancien=
t
> 2.4 stuff.
>
> If you are doing this, then also please modify hid2hci so it can take a=

> parameter to select the device you run it for. Currently it would switc=
h
> all of them. Even if you trigger it for only one.
>
> And I was actually more thinking to convert hid2hci into a bluetoothd
> plugin so the core daemon has control over it. Think about it.
>
> Regards
>
> Marcel
>
>
>  =20
Hi Marcel:

That's about the response that I was expecting/thinking.  I'll look into
modifying hid2hci to take parameters.

Regards

--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------070104020202090305040509
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html;charset=3DISO-8859-1" http-equiv=3D"Content-=
Type">
</head>
<body bgcolor=3D"#ffffff" text=3D"#000000">
Marcel Holtmann wrote:
<blockquote cite=3D"mid:1224795492.9386.198.camel@californication"
 type=3D"cite">
  <pre wrap=3D"">Hi Mario,

  </pre>
  <pre wrap=3D""><!---->
I like to have this all in one and that the PCMCIA ones are in a
different binary package is a distro problem. They don't have to be
since we don't have the dependency of pcmcia-cs anymore. That is ancient
2.4 stuff.

If you are doing this, then also please modify hid2hci so it can take a
parameter to select the device you run it for. Currently it would switch
all of them. Even if you trigger it for only one.

And I was actually more thinking to convert hid2hci into a bluetoothd
plugin so the core daemon has control over it. Think about it.

Regards

Marcel


  </pre>
</blockquote>
<font size=3D"-1"><font face=3D"Helvetica, Arial, sans-serif">Hi Marcel:<=
br>
<br>
That's about the response that I was expecting/thinking.&nbsp; I'll look
into modifying hid2hci to take parameters. <br>
<br>
Regards<br>
</font></font><br>
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

--------------070104020202090305040509--

--------------enig1CC96C1B965D94CC81131784
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkkA5xAACgkQ2CrZjkA73YuCQQCeMJoXQxfbBYx7kQ+MigP6IHDt
mPQAni07k6hmYzdKb+Kg4LHL+IIHC+6b
=Ed55
-----END PGP SIGNATURE-----

--------------enig1CC96C1B965D94CC81131784--

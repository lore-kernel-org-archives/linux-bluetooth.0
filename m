Return-Path: <cyrus@holtmann.org>
Message-ID: <4D820B1D.1080903@interlinx.bc.ca>
Date: Thu, 17 Mar 2011 09:22:37 -0400
From: "Brian J. Murrell" <brian@whamcloud.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Brad Midgley
	<public-bmidgley-Re5JQEeQqe8AvxtiuMwx3w-1dZseelyfdZg9hUCZPvPmw@public.gmane.org>
Subject: Re: how to set adapter to master with bluez 4.69?
References: <4D6EF7ED.2090905@interlinx.bc.ca>	<4D740AA7.5080209@interlinx.bc.ca>	<AANLkTin3-+9txbUyFxyrirySnkjwWVeMHrZtCqGfz-4m@mail.gmail.com>	<4D754A84.1020609@interlinx.bc.ca>	<AANLkTimzHs1=z11GJ-ye10o_6PfoQ_R1RkDeS1jCVue2@mail.gmail.com>	<AANLkTi=G2_hvZrZ=pG6naJ2fw7n4_T8=3+heV29vRPRD@mail.gmail.com>	<4D7DF55D.2010402@interlinx.bc.ca>	<4D7E0A15.5000708@interlinx.bc.ca>	<4D7E211F.1030000@interlinx.bc.ca>	<AANLkTi=N_5BaEOaaFsTHhNF82Vo83bzeNuzqmd9rMU3j@mail.gmail.com>	<4D7F5AE3.20909@interlinx.bc.ca>	<4D7F5EF2.2000709@interlinx.bc.ca> <AANLkTim2oLMjE-9C0G7VCjXafg03xnb7a0Q04zwKh2ns@mail.gmail.com> <4D820851.4040809@interlinx.bc.ca>
In-Reply-To: <4D820851.4040809@interlinx.bc.ca>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFFC4C1CAD52930725CE7E2C6"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFFC4C1CAD52930725CE7E2C6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I mean to add before I hit send that I had an opportunity to try all of
this out on my laptop yesterday (so far all of the problems I have been
reporting here have been with my PC which has a:

Bus 002 Device 003: ID 0a5c:4500 Broadcom Corp. BCM2046B1 USB 2.0 Hub
(part of BCM2046 Bluetooth)

Having my mouse and even the LG headset (which has been the most
problematic on my PC) on my laptop worked flawlessly -- without even
having to mess with any of this master/slave stuff.  I was in a
teleconference with the headset for just over an hour and was using the
mouse at the same time without a hiccup.  If only my PC would work as
reliably.

The chipset in my laptop is a:

Bus 001 Device 006: ID 0a5c:217f Broadcom Corp. Bluetooth Controller

What is interesting is that I can't seem to discover much about the
state of the adapter in that machine:

$ hcitool dev
Devices:
	hci0	70:F3:95:3E:92:34
$ hcitool hci0 lm

returns nothing.  When I do connect the mouse using the
bluetooth-applet's Connect menu for the device:

$ hcitool hci0 lm
$ hcitool con
Connections:
	> ACL 00:1F:20:0F:30:6A handle 11 state 1 lm MASTER

After turning on the headset:

$ hcitool hci0 lm
$ hcitool con
Connections:
	> ACL 00:18:6B:E5:4F:7E handle 12 state 1 lm MASTER AUTH ENCRYPT
	> ACL 00:1F:20:0F:30:6A handle 11 state 1 lm MASTER

I wonder why it worked so well on my laptop and doesn't work so well on
my PC?

Cheers,
b.


--------------enigFFC4C1CAD52930725CE7E2C6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk2CCx0ACgkQl3EQlGLyuXCqVgCfVIqgDfPO+j9jHjXgjbGqiic1
+bYAnRl5gOXcyvvMO6UgohZVO0lUaigI
=zeQp
-----END PGP SIGNATURE-----

--------------enigFFC4C1CAD52930725CE7E2C6--

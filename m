Return-Path: <cyrus@holtmann.org>
Message-ID: <4D7F5EF2.2000709@interlinx.bc.ca>
Date: Tue, 15 Mar 2011 08:43:30 -0400
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Brad Midgley
	<public-bmidgley-Re5JQEeQqe8AvxtiuMwx3w-1dZseelyfdZg9hUCZPvPmw@public.gmane.org>
Subject: Re: how to set adapter to master with bluez 4.69?
References: <4D6EF7ED.2090905@interlinx.bc.ca>	<4D740AA7.5080209@interlinx.bc.ca>	<AANLkTin3-+9txbUyFxyrirySnkjwWVeMHrZtCqGfz-4m@mail.gmail.com>	<4D754A84.1020609@interlinx.bc.ca>	<AANLkTimzHs1=z11GJ-ye10o_6PfoQ_R1RkDeS1jCVue2@mail.gmail.com>	<AANLkTi=G2_hvZrZ=pG6naJ2fw7n4_T8=3+heV29vRPRD@mail.gmail.com>	<4D7DF55D.2010402@interlinx.bc.ca>	<4D7E0A15.5000708@interlinx.bc.ca>	<4D7E211F.1030000@interlinx.bc.ca> <AANLkTi=N_5BaEOaaFsTHhNF82Vo83bzeNuzqmd9rMU3j@mail.gmail.com> <4D7F5AE3.20909@interlinx.bc.ca>
In-Reply-To: <4D7F5AE3.20909@interlinx.bc.ca>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0003A13FC62E7BEDCCEC284D"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0003A13FC62E7BEDCCEC284D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hrm.  It seems to be a real crap shoot whether this B/T stuff is going
to work or not under Linux...

Since the mouse got disconnected (not by me, but by the B/T stack) I
decided to try to disconnect the headset and connect it again.  Success,
it was connected with the adapter as MASTER:

$ hcitool con
Connections:
	< ACL 00:1A:45:1B:19:89 handle 11 state 1 lm MASTER


Then I tried to connect the mouse again.  Doing that resulted in the
headset getting disconnected and the mouse was connected:

$ hcitool con
Connections:
	< ACL 00:1F:20:0F:30:6A handle 0 state 5 lm MASTER

And then shortly after they were both connected and both as slaves.
Double yay.

$ hcitool con
Connections:
	< ACL 00:1A:45:1B:19:89 handle 12 state 1 lm MASTER
	> ACL 00:1F:20:0F:30:6A handle 11 state 1 lm MASTER

I guess the connection to the headset was still being negotiated because
the connection changed:

$ hcitool con
Connections:
	< ACL 00:1A:45:1B:19:89 handle 12 state 1 lm MASTER AUTH ENCRYPT
	> ACL 00:1F:20:0F:30:6A handle 11 state 1 lm MASTER

But then the headset reverted so that the adapter was the slave again:

$ hcitool con
Connections:
	< SCO 00:1A:45:1B:19:89 handle 1 state 1 lm SLAVE
	< ACL 00:1A:45:1B:19:89 handle 12 state 1 lm SLAVE AUTH ENCRYPT
	> ACL 00:1F:20:0F:30:6A handle 11 state 1 lm MASTER

And the mouse got disconnected shortly after that:

$ hcitool con
Connections:
	< SCO 00:1A:45:1B:19:89 handle 1 state 1 lm SLAVE
	< ACL 00:1A:45:1B:19:89 handle 12 state 1 lm SLAVE AUTH ENCRYPT

~sigh~

Am I looking for something that B/T on Linux is just not ready to
deliver yet?  Namely stable co-existence of multiple devices.

b.


--------------enig0003A13FC62E7BEDCCEC284D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk1/XvIACgkQl3EQlGLyuXC4MwCeL57AaPsqhCDQGAYvFdcrR6t1
sKoAn3fhRzbKyPG73PDH3icq6mPazODF
=jJ5b
-----END PGP SIGNATURE-----

--------------enig0003A13FC62E7BEDCCEC284D--

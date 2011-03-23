Return-Path: <cyrus@holtmann.org>
Message-ID: <4D89E589.5010909@interlinx.bc.ca>
Date: Wed, 23 Mar 2011 08:20:25 -0400
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
MIME-Version: 1.0
To: Brad Midgley <bmidgley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: how to set adapter to master with bluez 4.69?
References: <4D6EF7ED.2090905@interlinx.bc.ca>	<4D740AA7.5080209@interlinx.bc.ca>	<AANLkTin3-+9txbUyFxyrirySnkjwWVeMHrZtCqGfz-4m@mail.gmail.com>	<4D754A84.1020609@interlinx.bc.ca>	<AANLkTimzHs1=z11GJ-ye10o_6PfoQ_R1RkDeS1jCVue2@mail.gmail.com>	<AANLkTi=G2_hvZrZ=pG6naJ2fw7n4_T8=3+heV29vRPRD@mail.gmail.com>	<4D7DF55D.2010402@interlinx.bc.ca>	<4D7E0A15.5000708@interlinx.bc.ca>	<4D7E211F.1030000@interlinx.bc.ca> <AANLkTi=N_5BaEOaaFsTHhNF82Vo83bzeNuzqmd9rMU3j@mail.gmail.com> <4D89DCE6.7050106@interlinx.bc.ca>
In-Reply-To: <4D89DCE6.7050106@interlinx.bc.ca>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD4C1AF4ECC90CE630AFCAE21"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD4C1AF4ECC90CE630AFCAE21
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Experimenting again this morning with both the mouse and the headset
connected both with the B/T adapter as master and the eSCO connection as
slave (since I can't seem to influence that), it was working fairly
stably.  Every now and then all devices would just completely
disconnected and then they would all reconnect.

However this most recent disconnect of all devices resulted in the mouse
reconnecting immediately but the headset went through a dozen or two
reconnection attempts (i.e. as observed by watching the output of
hcitool con with "watch -n 0") before it finally got reconnected.

This is in contrast to where I can have a completely stable (i.e. days
on end without a single hiccup) connection with just the mouse.

This really is frustrating.  ~sigh~

With all of the time I have pissed away on this, if I knew of a B/T
adapter/chipset that would absolutely work stably with multiple devices
(mouse, headset, etc.) I would just run out and buy one, but as it is, I
am on my third B/T adapter here and still nothing works stably -- as
opposed to my laptop where multiple devices seem to cohabitate nicely.

Hrm,  Given that I have multiple B/T adapters here, I don't suppose I'd
have any better luck by using another B/T adapter and just assigning 1
device to each, would I?

Cheers,
b.


--------------enigD4C1AF4ECC90CE630AFCAE21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk2J5YkACgkQl3EQlGLyuXABsgCgjz3pLTe1/H1/Cl4UGPUyqOl5
EusAnjN74IChGY2UTh964rNVlCXLvfMB
=whfA
-----END PGP SIGNATURE-----

--------------enigD4C1AF4ECC90CE630AFCAE21--

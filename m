Return-Path: <cyrus@holtmann.org>
Message-ID: <4D7EB16F.1050609@interlinx.bc.ca>
Date: Mon, 14 Mar 2011 20:23:11 -0400
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Brad Midgley <bmidgley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: how to set adapter to master with bluez 4.69?
References: <4D6EF7ED.2090905@interlinx.bc.ca>	<4D740AA7.5080209@interlinx.bc.ca>	<AANLkTin3-+9txbUyFxyrirySnkjwWVeMHrZtCqGfz-4m@mail.gmail.com>	<4D754A84.1020609@interlinx.bc.ca>	<AANLkTimzHs1=z11GJ-ye10o_6PfoQ_R1RkDeS1jCVue2@mail.gmail.com>	<AANLkTi=G2_hvZrZ=pG6naJ2fw7n4_T8=3+heV29vRPRD@mail.gmail.com>	<4D7DF55D.2010402@interlinx.bc.ca>	<4D7E0A15.5000708@interlinx.bc.ca>	<4D7E211F.1030000@interlinx.bc.ca> <AANLkTi=N_5BaEOaaFsTHhNF82Vo83bzeNuzqmd9rMU3j@mail.gmail.com>
In-Reply-To: <AANLkTi=N_5BaEOaaFsTHhNF82Vo83bzeNuzqmd9rMU3j@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDDC74600150FB81F1CD55B79"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDDC74600150FB81F1CD55B79
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11-03-14 11:29 AM, Brad Midgley wrote:
> Brian,

Heya Brad,

> iirc, the hcitool output tells you the role of the local adapter in
> the connection.

Really?

> So when you see 'master' in that list, it's what you
> want.

Really?

$ hcitool con
Connections:
	> ACL 00:1F:20:0F:30:6A handle 11 state 1 lm MASTER
                                                     ^^^^^^

This means that in the connection to 00:1F:20:0F:30:6A which is my
mouse, my adapter is the master?  That's a strange representation.

> You should also be requesting master when you try hcitool.

Do you mean like this:

$ hcitool sr 00:02:72:1E:E0:12 master

Cheers,
b.



--------------enigDDC74600150FB81F1CD55B79
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk1+sW8ACgkQl3EQlGLyuXAOUwCeKfx9cCefHulSP+omAXOpyaUk
hPcAnAu6yTybRRrWL6937ZkAjL/6bKpB
=s1v9
-----END PGP SIGNATURE-----

--------------enigDDC74600150FB81F1CD55B79--

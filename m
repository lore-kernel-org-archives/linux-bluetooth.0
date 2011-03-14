Return-Path: <cyrus@holtmann.org>
Message-ID: <4D7E211F.1030000@interlinx.bc.ca>
Date: Mon, 14 Mar 2011 10:07:27 -0400
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Brad Midgley
	<public-bmidgley-Re5JQEeQqe8AvxtiuMwx3w-1dZseelyfdZg9hUCZPvPmw@public.gmane.org>
Subject: Re: how to set adapter to master with bluez 4.69?
References: <4D6EF7ED.2090905@interlinx.bc.ca>	<4D740AA7.5080209@interlinx.bc.ca>	<AANLkTin3-+9txbUyFxyrirySnkjwWVeMHrZtCqGfz-4m@mail.gmail.com>	<4D754A84.1020609@interlinx.bc.ca>	<AANLkTimzHs1=z11GJ-ye10o_6PfoQ_R1RkDeS1jCVue2@mail.gmail.com> <AANLkTi=G2_hvZrZ=pG6naJ2fw7n4_T8=3+heV29vRPRD@mail.gmail.com> <4D7DF55D.2010402@interlinx.bc.ca> <4D7E0A15.5000708@interlinx.bc.ca>
In-Reply-To: <4D7E0A15.5000708@interlinx.bc.ca>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC495D6885ACF0D1C36741714"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC495D6885ACF0D1C36741714
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11-03-14 08:29 AM, Brian J. Murrell wrote:
>=20
> Having been playing an audio stream to the headset for nearly an hour,
> it seems to be co-existing with the mouse today.  Currently HCI
> connections are:
>=20
> $ hcitool con
> Connections:
> 	< SCO 00:1A:45:1B:19:89 handle 1 state 1 lm SLAVE
> 	> ACL 00:1A:45:1B:19:89 handle 11 state 1 lm MASTER AUTH ENCRYPT
> 	> ACL 00:1F:20:0F:30:6A handle 12 state 1 lm MASTER
>=20
> Which I find interesting.
>=20
> I'm going to try the other headset now and see if it's just as stable
> this morning.

So, I tried the other headset, which was reported as:

$ hcitool con
Connections:
	< eSCO 00:18:6B:E5:4F:7E handle 6 state 1 lm SLAVE
	> ACL 00:18:6B:E5:4F:7E handle 12 state 1 lm MASTER AUTH ENCRYPT
	> ACL 00:1F:20:0F:30:6A handle 11 state 1 lm MASTER

and it was not as stable.  I had periodic disconnect/reconnects of all
B/T devices.

I've disconnected the (unstable) LG headset and connected the Jabra
headset again and it seems stable again.

It's just too bad I dislike the ergonomics of the Jabra headset.  It's
nowhere near as comfortable as the LG headset.  The LG headset "seals"
into the ear where Jabra basically just "hangs" there using gravity to
hold itself to the ear and does not create anywhere near as good a
fit/seal to the ear.  :-(

I'd entertain going and buying yet another headset, hoping to get the
stability of this Jabra with the fit of the LG, but given my 50/50
success rate here, it seems like it will be a real crapshoot getting a
headset that works stably.  :-(

b.




--------------enigC495D6885ACF0D1C36741714
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk1+IR8ACgkQl3EQlGLyuXDVSQCg8HGamXpFmng5tEJH8T9WpRkI
e9AAoOBcgfX7DRS/WvJLTmPz6X7jDwUo
=CtpH
-----END PGP SIGNATURE-----

--------------enigC495D6885ACF0D1C36741714--

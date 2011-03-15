Return-Path: <cyrus@holtmann.org>
Message-ID: <4D7F5AE3.20909@interlinx.bc.ca>
Date: Tue, 15 Mar 2011 08:26:11 -0400
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
MIME-Version: 1.0
To: Brad Midgley <bmidgley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: how to set adapter to master with bluez 4.69?
References: <4D6EF7ED.2090905@interlinx.bc.ca>	<4D740AA7.5080209@interlinx.bc.ca>	<AANLkTin3-+9txbUyFxyrirySnkjwWVeMHrZtCqGfz-4m@mail.gmail.com>	<4D754A84.1020609@interlinx.bc.ca>	<AANLkTimzHs1=z11GJ-ye10o_6PfoQ_R1RkDeS1jCVue2@mail.gmail.com>	<AANLkTi=G2_hvZrZ=pG6naJ2fw7n4_T8=3+heV29vRPRD@mail.gmail.com>	<4D7DF55D.2010402@interlinx.bc.ca>	<4D7E0A15.5000708@interlinx.bc.ca>	<4D7E211F.1030000@interlinx.bc.ca> <AANLkTi=N_5BaEOaaFsTHhNF82Vo83bzeNuzqmd9rMU3j@mail.gmail.com>
In-Reply-To: <AANLkTi=N_5BaEOaaFsTHhNF82Vo83bzeNuzqmd9rMU3j@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig88EE80793A6B30621A728717"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig88EE80793A6B30621A728717
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11-03-14 11:29 AM, Brad Midgley wrote:
> Brian,

Hey Brad,

> iirc, the hcitool output tells you the role of the local adapter in
> the connection. So when you see 'master' in that list, it's what you
> want. You should also be requesting master when you try hcitool.

How does this reconcile with that though:

$ hcitool con
Connections:
	> ACL 00:1F:20:0F:30:6A handle 12 state 1 lm MASTER
	< SCO 00:1A:45:1B:19:89 handle 1 state 1 lm SLAVE
	< ACL 00:1A:45:1B:19:89 handle 11 state 1 lm SLAVE AUTH ENCRYPT

If that "MASTER/SLAVE" at the end of those lines is telling me what the
disposition of the B/T adapter is, how can it be both MASTER for one
device and SLAVE for another?  Is this "MASTER/SLAVE" relationship per
device and the adapter can be master for some and slave for others?

I can't seem to change the connection for 00:1A:45:1B:19:89 to be master:=


$ sudo hcitool sr 00:1A:45:1B:19:89 master
Switch role request failed: Input/output error

so I am back at this place again.  And device co-existence is not at all
stable again.  The mouse keeps dropping out.  ~sigh~

Is the "MASTER" in this at all relevant?  Isn't it telling me that my
adapter should be trying to negotiate being master in all of the
connections it tries to create?

$ hciconfig hci0 lm
hci0:	Type: BR/EDR  Bus: USB
	BD Address: 00:02:72:1E:E0:12  ACL MTU: 1021:7  SCO MTU: 64:1
	Link mode: MASTER

b.


--------------enig88EE80793A6B30621A728717
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk1/WuMACgkQl3EQlGLyuXC7GACeLxOF0+Ikgt1If66YDYiJgtFu
GoEAoO0G79ljIabhETzyBA4/0k9Vj0pi
=Kopp
-----END PGP SIGNATURE-----

--------------enig88EE80793A6B30621A728717--

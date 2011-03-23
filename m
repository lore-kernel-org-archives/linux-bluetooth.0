Return-Path: <cyrus@holtmann.org>
Message-ID: <4D89DCE6.7050106@interlinx.bc.ca>
Date: Wed, 23 Mar 2011 07:43:34 -0400
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
MIME-Version: 1.0
To: Brad Midgley <bmidgley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: how to set adapter to master with bluez 4.69?
References: <4D6EF7ED.2090905@interlinx.bc.ca>	<4D740AA7.5080209@interlinx.bc.ca>	<AANLkTin3-+9txbUyFxyrirySnkjwWVeMHrZtCqGfz-4m@mail.gmail.com>	<4D754A84.1020609@interlinx.bc.ca>	<AANLkTimzHs1=z11GJ-ye10o_6PfoQ_R1RkDeS1jCVue2@mail.gmail.com>	<AANLkTi=G2_hvZrZ=pG6naJ2fw7n4_T8=3+heV29vRPRD@mail.gmail.com>	<4D7DF55D.2010402@interlinx.bc.ca>	<4D7E0A15.5000708@interlinx.bc.ca>	<4D7E211F.1030000@interlinx.bc.ca> <AANLkTi=N_5BaEOaaFsTHhNF82Vo83bzeNuzqmd9rMU3j@mail.gmail.com>
In-Reply-To: <AANLkTi=N_5BaEOaaFsTHhNF82Vo83bzeNuzqmd9rMU3j@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB982E9F8BD1039E47C0F5AA2"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB982E9F8BD1039E47C0F5AA2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11-03-14 11:29 AM, Brad Midgley wrote:
> Brian,

Hey Brad,

> iirc, the hcitool output tells you the role of the local adapter in
> the connection. So when you see 'master' in that list, it's what you
> want. You should also be requesting master when you try hcitool.

Does the above still jive with all of this:

$ hciconfig hci0 lm
hci0:	Type: BR/EDR  Bus: USB
	BD Address: 00:02:72:1E:E0:12  ACL MTU: 1021:7  SCO MTU: 64:1
	Link mode: SLAVE ACCEPT

Notice the B/T adapter's link mode is set to slave, yet...

$ hcitool con
Connections:
	> ACL 00:1F:20:0F:30:6A handle 11 state 1 lm MASTER

In the connection with the mouse, the B/T adapter is master.

I can change it successfully:

brian@pc:~$ sudo hciconfig hci0 lm master,accept
brian@pc:~$ hciconfig hci0 lm
hci0:	Type: BR/EDR  Bus: USB
	BD Address: 00:02:72:1E:E0:12  ACL MTU: 1021:7  SCO MTU: 64:1
	Link mode: ACCEPT MASTER

Which doesn't change the connection with the mouse:

$ hcitool con
Connections:
	> ACL 00:1F:20:0F:30:6A handle 11 state 1 lm MASTER

When I connect the headset using the bluetooth-applet:

$ hcitool con
Connections:
	< eSCO 00:18:6B:E5:4F:7E handle 6 state 1 lm SLAVE
	< ACL 00:18:6B:E5:4F:7E handle 12 state 1 lm MASTER AUTH ENCRYPT
	> ACL 00:1F:20:0F:30:6A handle 11 state 1 lm MASTER

The connection with the headset itself has the B/T adapter as master but
this eSCO connection is slave?

Oh wait.  The eSCO connection disappeared now:

$ hcitool con
Connections:
	< ACL 00:18:6B:E5:4F:7E handle 12 state 1 lm MASTER AUTH ENCRYPT
	> ACL 00:1F:20:0F:30:6A handle 11 state 1 lm MASTER

Now that I play something through the headset it comes back:

Connections:
	< eSCO 00:18:6B:E5:4F:7E handle 6 state 1 lm SLAVE
	< ACL 00:18:6B:E5:4F:7E handle 12 state 1 lm MASTER AUTH ENCRYPT
	> ACL 00:1F:20:0F:30:6A handle 11 state 1 lm MASTER

I guess that eSCO connection is only active when there is audio sent to
the headset perhaps.

I sure wish I could get all of this to work reliably.  Even if I had to
follow a recipe of manual steps -- something I have not yet been able to
figure out with any consistency.

b.


--------------enigB982E9F8BD1039E47C0F5AA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk2J3OYACgkQl3EQlGLyuXDndgCfUOJenJtECdRCjDRyYISypZWX
/t4An3wS7ZdrU6bBVRzV1Ccc+Fb+BOWh
=f3lD
-----END PGP SIGNATURE-----

--------------enigB982E9F8BD1039E47C0F5AA2--

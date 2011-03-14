Return-Path: <cyrus@holtmann.org>
Message-ID: <4D7E0A15.5000708@interlinx.bc.ca>
Date: Mon, 14 Mar 2011 08:29:09 -0400
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Brad Midgley <bmidgley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: how to set adapter to master with bluez 4.69?
References: <4D6EF7ED.2090905@interlinx.bc.ca>	<4D740AA7.5080209@interlinx.bc.ca>	<AANLkTin3-+9txbUyFxyrirySnkjwWVeMHrZtCqGfz-4m@mail.gmail.com>	<4D754A84.1020609@interlinx.bc.ca>	<AANLkTimzHs1=z11GJ-ye10o_6PfoQ_R1RkDeS1jCVue2@mail.gmail.com> <AANLkTi=G2_hvZrZ=pG6naJ2fw7n4_T8=3+heV29vRPRD@mail.gmail.com> <4D7DF55D.2010402@interlinx.bc.ca>
In-Reply-To: <4D7DF55D.2010402@interlinx.bc.ca>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEAF3A68D9C395AC530915F10"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEAF3A68D9C395AC530915F10
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi again Brad.

On 11-03-14 07:00 AM, Brian J. Murrell wrote:
>=20
> Any advise how to proceed, even just to set the adapter to master manua=
lly?

A little more playing here and I seem to have been able to set the
adapter to master:

$ hciconfig hci0 lm
hci0:	Type: BR/EDR  Bus: USB
	BD Address: 00:02:72:1E:E0:12  ACL MTU: 1021:7  SCO MTU: 64:1
	Link mode: SLAVE ACCEPT
$ hciconfig hci0 lm MASTER
Can't set default link mode on hci0: Permission denied (13)
$ sudo hciconfig hci0 lm MASTER
$ hciconfig hci0 lm
hci0:	Type: BR/EDR  Bus: USB
	BD Address: 00:02:72:1E:E0:12  ACL MTU: 1021:7  SCO MTU: 64:1
	Link mode: MASTER

Or was I?

$ sudo hcitool con
Connections:
	> ACL 00:1F:20:0F:30:6A handle 11 state 1 lm MASTER

So the mouse is still reporting it's master.

But so is the adapter:

$ hciconfig hci0 lm
hci0:	Type: BR/EDR  Bus: USB
	BD Address: 00:02:72:1E:E0:12  ACL MTU: 1021:7  SCO MTU: 64:1
	Link mode: MASTER

Maybe I am misunderstanding what I am reading.

For good measure I deleted (i.e. in the GUI) the mouse and re-added it
but it still seems to be master:

$ sudo hcitool con
Connections:
	< ACL 00:1F:20:0F:30:6A handle 11 state 1 lm MASTER

Hrm.  Now I've added my Jabra BT125 headset and the connections being
reported now are:

$ sudo hcitool con
Connections:
	< ACL 00:1A:45:1B:19:89 handle 12 state 1 lm MASTER AUTH ENCRYPT
	< ACL 00:1F:20:0F:30:6A handle 11 state 1 lm MASTER


Everybody's master now?

Having been playing an audio stream to the headset for nearly an hour,
it seems to be co-existing with the mouse today.  Currently HCI
connections are:

$ hcitool con
Connections:
	< SCO 00:1A:45:1B:19:89 handle 1 state 1 lm SLAVE
	> ACL 00:1A:45:1B:19:89 handle 11 state 1 lm MASTER AUTH ENCRYPT
	> ACL 00:1F:20:0F:30:6A handle 12 state 1 lm MASTER

Which I find interesting.

I'm going to try the other headset now and see if it's just as stable
this morning.

b.




--------------enigEAF3A68D9C395AC530915F10
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk1+ChUACgkQl3EQlGLyuXD0yACg5ChBOkgWaEVC6GQVvHq43hSh
UkUAoIc/IFiLa59FA9zkHAsVEUpouaz1
=L97b
-----END PGP SIGNATURE-----

--------------enigEAF3A68D9C395AC530915F10--

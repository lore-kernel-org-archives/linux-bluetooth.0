Return-Path: <cyrus@holtmann.org>
Message-ID: <4D7DF55D.2010402@interlinx.bc.ca>
Date: Mon, 14 Mar 2011 07:00:45 -0400
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
MIME-Version: 1.0
To: Brad Midgley <bmidgley@gmail.com>
CC: public-linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org
Subject: Re: how to set adapter to master with bluez 4.69?
References: <4D6EF7ED.2090905@interlinx.bc.ca>	<4D740AA7.5080209@interlinx.bc.ca>	<AANLkTin3-+9txbUyFxyrirySnkjwWVeMHrZtCqGfz-4m@mail.gmail.com>	<4D754A84.1020609@interlinx.bc.ca>	<AANLkTimzHs1=z11GJ-ye10o_6PfoQ_R1RkDeS1jCVue2@mail.gmail.com> <AANLkTi=G2_hvZrZ=pG6naJ2fw7n4_T8=3+heV29vRPRD@mail.gmail.com>
In-Reply-To: <AANLkTi=G2_hvZrZ=pG6naJ2fw7n4_T8=3+heV29vRPRD@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF4C0B5B5AA5DA9775E75B670"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF4C0B5B5AA5DA9775E75B670
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11-03-13 11:46 PM, Brad Midgley wrote:
> Brian,

Hi Brad,

>=20
>>> $ sudo hcitool sr 00:1F:20:0F:30:6A slave
>>> Switch role request failed: Input/output error
>=20
> Sorry I didn't look at the gui again.

No worries.  TBH, a gui knob would be nice, but I'd settle for just
being able to set it manually for the time being.

> Were you able to use hcitool to switch the role to master manually?

No, I never have been able to.  I was playing with it again this morning
and I can't even seem to get a list of remote devices any more.  I know
there is at least one -- a mouse, which I am using right at this moment.

$ sudo hcitool scan
Scanning ...
$ sudo hcitool inq
Inquiring ...
brian@pc:/etc/shorewall/gw-new$ sudo hcitool dev
Devices:
	hci0	00:02:72:1E:E0:12
$ sudo hcitool con
Connections:
	> ACL 00:1F:20:0F:30:6A handle 11 state 1 lm MASTER

I'd guess that means the mouse is at address 00:1F:20:0F:30:6A and is
master currently, yes?

$ sudo hcitool sr 00:1F:20:0F:30:6A SLAVE
Switch role request failed: Input/output error
$ hcitool sr 00:1F:20:0F:30:6A SLAVE
Switch role request failed: Operation not permitted

Any advise how to proceed, even just to set the adapter to master manuall=
y?

Cheers,
b.


--------------enigF4C0B5B5AA5DA9775E75B670
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk199V4ACgkQl3EQlGLyuXDCkwCfTCZZ0T3R5nByzKbsMMIKRCiO
21MAn15U5i+Ph/ed6HrZO80FASTz2yLi
=flmH
-----END PGP SIGNATURE-----

--------------enigF4C0B5B5AA5DA9775E75B670--


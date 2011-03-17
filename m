Return-Path: <cyrus@holtmann.org>
Message-ID: <4D820851.4040809@interlinx.bc.ca>
Date: Thu, 17 Mar 2011 09:10:41 -0400
From: "Brian J. Murrell" <brian@whamcloud.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Brad Midgley <bmidgley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: how to set adapter to master with bluez 4.69?
References: <4D6EF7ED.2090905@interlinx.bc.ca>	<4D740AA7.5080209@interlinx.bc.ca>	<AANLkTin3-+9txbUyFxyrirySnkjwWVeMHrZtCqGfz-4m@mail.gmail.com>	<4D754A84.1020609@interlinx.bc.ca>	<AANLkTimzHs1=z11GJ-ye10o_6PfoQ_R1RkDeS1jCVue2@mail.gmail.com>	<AANLkTi=G2_hvZrZ=pG6naJ2fw7n4_T8=3+heV29vRPRD@mail.gmail.com>	<4D7DF55D.2010402@interlinx.bc.ca>	<4D7E0A15.5000708@interlinx.bc.ca>	<4D7E211F.1030000@interlinx.bc.ca>	<AANLkTi=N_5BaEOaaFsTHhNF82Vo83bzeNuzqmd9rMU3j@mail.gmail.com>	<4D7F5AE3.20909@interlinx.bc.ca>	<4D7F5EF2.2000709@interlinx.bc.ca> <AANLkTim2oLMjE-9C0G7VCjXafg03xnb7a0Q04zwKh2ns@mail.gmail.com>
In-Reply-To: <AANLkTim2oLMjE-9C0G7VCjXafg03xnb7a0Q04zwKh2ns@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB33C8B45A01EA58CE9619D57"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB33C8B45A01EA58CE9619D57
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11-03-15 11:25 AM, Brad Midgley wrote:
> Brian,

Hi Brad,

> You can have both master and slave connections simultaneously, just
> like you can be slave to more than one master. In both cases it means
> your adapter is in different piconets.

Ahhh.  See.  Shows what I know about the details of B/T.  I thought one
adapter =3D=3D one piconet.

> There are rules about whether devices can refuse the master/slave
> switch. It's been some time since I read this so I can't remember, but
> maybe it's the initiating device that starts out as slave and the
> remote device has to agree to a role switch.

Hrm.  I guess I will have to play with that a bit.

> So you should be able to
> force the headset to cooperate, even if it's refusing role switches,
> by changing who initiates that connection in addition to a link policy
> that keeps your adapter as master.

OK.  So as far as the link policy that keeps the adapter as master,
after having rebooted this machine today I found the following:

$ hcitool con
Connections:
$ hciconfig hci0 lm
hci0:	Type: BR/EDR  Bus: USB
	BD Address: 00:02:72:1E:E0:12  ACL MTU: 1021:7  SCO MTU: 64:1
	Link mode: SLAVE ACCEPT

So that means that the adapter will want to be the slave in all
connections, is that right?

I should change the above slave to master as such:

$ sudo hciconfig hci0 lm master
$ hciconfig hci0 lm
hci0:	Type: BR/EDR  Bus: USB
	BD Address: 00:02:72:1E:E0:12  ACL MTU: 1021:7  SCO MTU: 64:1
	Link mode: MASTER

Is that correct?  Do I want to enable that "ACCEPT" also?

Once I do that, for my mouse at least, do I want to press the "Connect"
button on the mouse or use the Connect option for the mouse in the
bluetooth-applet?

b.


--------------enigB33C8B45A01EA58CE9619D57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk2CCFwACgkQl3EQlGLyuXAOrQCdF0HE/xgx1Uj3dHNpF4oX1CsS
c8cAn2WUaqln7jCxsenkhHYOCghhIluX
=D5+Q
-----END PGP SIGNATURE-----

--------------enigB33C8B45A01EA58CE9619D57--

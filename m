Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Oct 2011 16:55:26 +1100
From: NeilBrown <neilb@suse.de>
To: linux-bluetooth@vger.kernel.org
Subject: Help understanding Agent 'capabilities'.
Message-ID: <20111013165526.0dbbe0fc@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/o8unG_o8VTVDBS7.S51VV40"; protocol="application/pgp-signature"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Sig_/o8unG_o8VTVDBS7.S51VV40
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


Hi,
 I've been trying enhance my understanding of bluetooth and as part of that
 I have been experimenting with simple-agent to create pairing between two
 Linux hosts (a phone and a laptop as it happens).

 My understanding of Secure Simple Pairing is that there are a number of
 authentication mechanism and that the "best" would be chosen based on the
 that capabilities given to the agent.

 So if both devices tell the monitor "DisplayYesNo", it would not be able to
 do Passkey entry and would choose Numeric comparison.
 So both agents would get RequestConfirmation call backs.

 But I cannot make that happen.

 No matter what capability I give to simple-agent, one of them asks me for a
 pass key, then the other one does, and they have to match.  i.e. they both
 get RequestPinCode.
 So they seem to be assuming at least one device has a keyboard (the first
 could generate a number in the agent and display it I guess).

 Is there something else I have to change to force it to use Numeric
 comparison (or even 'just works') authentication?  Is this documented
 somewhere?

 I'm using 4.88 on one system and 4.96 on the other.

Thanks,
NeilBrown

--Sig_/o8unG_o8VTVDBS7.S51VV40
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTpZ9Tjnsnt1WYoG5AQLVSA//boae6vz8LWZS73WLjS2xm6UlIYuGJs10
egtfRuPV7UhJgyrPCQqaQ1WR/SMT5XVx5UGETHY2aU3dW5MP6W27ld1eBFdQP4gh
EN3SD+Y+O3e7zC+zCSyAbqgbs4QyeIuwL0Ipz7jrbWqe2r3bOvzZv3YNiWRDBs4l
idnDkIDtrXXAqGFmDPZaSVb8aMFYKK4c0NZuOnRkY7atwryXwwofUkTYZp4icKxb
fKJThJ2MScfnOmaClJ4hCXsPEnKvEp7RpBcXwPbNauHQsTB44nM5XN0xed7tiRds
z9tbSaK2NgxRVhyUJH5MSG7iIKYq8G/jlYgirA/Oc+s3D7MvtsvRd2NCtlnGmmZZ
Khtd0oo54gdjzmzRKoxXR/3sOvID7MUeEQdV0ap1hyqep/p14/6a66MKQIw3rjEF
GTRhYnC8M4hGFkd+cfgDhFQhnTV7pF9NPzwXoA8w+4JwGcYpROCUhk7rqQfKb3dV
VpjEq026jnx1LQAHjmnvmYPqrZMANAuw9ntIS3NhNiAQkA7HXdD0nauzcXlwGk70
+N0ZqEIq0MrxiSQ24NHC93OY+iIXmUUWcxtLbYR4/aIxaS5kAiaB9xc+Zi984qgE
PfmG1957ia9N1bx+i+y8zHj5ViaRdzgJDOvzWLjppjbvPDwBBU/APhISCkEfS4Wi
DyajVJ/54es=
=s1N7
-----END PGP SIGNATURE-----

--Sig_/o8unG_o8VTVDBS7.S51VV40--

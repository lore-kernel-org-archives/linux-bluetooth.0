Return-Path: <pierren@mac.com>
Subject: Re: [Bluez-users] Two simultanous connections
From: Pierre N <pierren@mac.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1080929429.2836.101.camel@pegasus>
References: <1080928843.9541.90.camel@localhost>
	 <1080929429.2836.101.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RyjXSTOjpzQJqZ/kJhr6"
Message-Id: <1080993011.12261.12.camel@localhost>
Mime-Version: 1.0
Date: Sat, 03 Apr 2004 13:50:11 +0200
List-ID: <bluez-users.lists.sourceforge.net>


--=-RyjXSTOjpzQJqZ/kJhr6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hcitool -a shows "invalid option -- a".
This is the bluetooth chip of an iPaq 3970. It's running Familiar
stable, so it must be a pretty old bluez version. Don't know if it
helps...

Ok, I knew I had to give more details... I create links between 3 iPaqs.
I tried using higher layer protocols to do so. Never worked. I'm just
trying to do a TCP/IP network so I can run XML-RPC on top of it, ssh
etc...

That's all I need. I tried to use pan, never worked, I tried to use dun
over pan, never worked, I tried to use rfcomm never worked. Always the
same problem:
I could connect A to B and B to C, never B to A and C to A.=20

Now I went the hcitool route. Created my own connections very very
easily. I connected B to A and C to A (A master). Ran dund _after_
hcitool connections and everything is running great.

hcitool con on A gives me two master connections. These connections have
been initialised from B and C as slave. So I can have two master
connections, but I can't create them from A. First one works, second one
doesn't, nothing happen. It's just out of curiosity.

--
Pierre



On Fri, 2004-04-02 at 20:10, Marcel Holtmann wrote:
> Hi Pierre,
>=20
> > I've been trying to setup ip net with 3 identical devices connected
> > simultanously over bluetooth. It works after a long
> > while of fiddling around. I had to go the hcitool route manually to set
> > the initial connections and then I could use dund no problem. My
> > question is: why can't I initiate a connection (hcitool cc) from a
> > device which is already connected?
>=20
> for some setups this depends on your Bluetooth chip. So what does
> "hciconfig -a" show? But I am not sure about what kind of network you
> are talking, because between two device there can be only _one_ ACL link
> and this means you can only use "hcitool cc" once. Actually there is no
> need for creating the ACL link manually with hcitool, because every
> higher layer will create it on demand.
>=20
> Regards
>=20
> Marcel
>=20
>=20

--=-RyjXSTOjpzQJqZ/kJhr6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAbqTzZkVEuKKlE7gRAl/sAKDdGOPKg13HM99hB1NECx2Lz40sjgCdF9uJ
g5rFH3aITVWzGOyqG3mt8eI=
=MnS3
-----END PGP SIGNATURE-----

--=-RyjXSTOjpzQJqZ/kJhr6--

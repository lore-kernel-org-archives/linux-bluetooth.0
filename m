Return-Path: <wouter@grep.be>
Date: Thu, 21 Oct 2004 20:03:35 +0200
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Apple PowerBook and Nokia 6310i
Message-ID: <20041021180335.GD1850@grep.be>
References: <20041020233608.GA26457@grep.be> <1098380889.4885.27.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
In-Reply-To: <1098380889.4885.27.camel@pegasus>
From: Wouter Verhelst <wouter@grep.be>
List-ID: <bluez-users.lists.sourceforge.net>


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 21, 2004 at 07:48:09PM +0200, Marcel Holtmann wrote:
> Hi Wouter,
[...]
> > While this happens, I can see the Nokia does set up the connection;
> > however, it drops the line somewhere between the "Connect: ppp0 <-->
> > /dev/rfcomm0" and te "Serial line is looped back" message. When that
> > happens, it appears as if pppd does not immediately notice.
>=20
> what kernel version is this?

2.6.8, the one distributed with Debian Sarge (package
kernel-image-2.6.8-powerpc version 2.6.8-6). Note, they have a few
Debian-specific patches; I'll try with vanilla 2.6.9 and see whether
that works.

> Maybe it is a kernel bug in the PPP code or your settings for pppd are
> simply wrong.

That's most certainly possible, since I'm not a PPP guru; however, the
following doesn't look incorrect to me:

|wouter@country:/etc/ppp/peers$ egrep -v '(^#|^$)' provider
|noauth
|connect "/usr/sbin/chat -v -f /etc/chatscripts/provider"
|defaultroute
|/dev/rfcomm0
|115200
|persist

/etc/chatscripts/provider:

|ABORT        BUSY
|ABORT        "NO CARRIER"
|ABORT        VOICE
|ABORT        "NO DIALTONE"
|""           AT&F
|OK           ATDT+3222750205
|CONNECT

which, I think, should work, no?

> Try other dialers like wvdial.

Hmm, I could try that, but I'd rather explore some other possibilities
before I go that route. If there are any, that is ;-)

Thanks,

--=20
         EARTH
     smog  |   bricks
 AIR  --  mud  -- FIRE
soda water |   tequila
         WATER
 -- with thanks to fortune

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBd/n3PfwsYq950p4RAkJnAJ9VB9fWPyFXdkdMP56tNwdkietXFgCbBwW2
cfNT99bpPYbwC3W8H3KQzb8=
=aESP
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--

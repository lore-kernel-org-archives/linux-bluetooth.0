Return-Path: <wouter@grep.be>
Date: Fri, 22 Oct 2004 13:32:32 +0200
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Apple PowerBook and Nokia 6310i
Message-ID: <20041022113232.GA4127@grep.be>
References: <20041020233608.GA26457@grep.be> <1098380889.4885.27.camel@pegasus> <20041021180335.GD1850@grep.be> <1098398997.4704.0.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
In-Reply-To: <1098398997.4704.0.camel@pegasus>
From: Wouter Verhelst <wouter@grep.be>
List-ID: <bluez-users.lists.sourceforge.net>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 22, 2004 at 12:49:57AM +0200, Marcel Holtmann wrote:
> Hi Wouter,
>=20
> > > Try other dialers like wvdial.
> >=20
> > Hmm, I could try that, but I'd rather explore some other possibilities
> > before I go that route. If there are any, that is ;-)
>=20
> you should really try the wvdial program, because it always did the
> right job for me.

I looked at it a few times in the past, and it never worked with the
particular quirks of my provider.

In the mean time, though, I found out what the problem was. I had to add
"user <username>" and "usepeerdns" directives to the peers/provider
file; now everything works smoothly.

Next, try and get GPRS working. But to do that, I shouldn't need your
help anymore. Thanks!

--=20
         EARTH
     smog  |   bricks
 AIR  --  mud  -- FIRE
soda water |   tequila
         WATER
 -- with thanks to fortune

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBeO/QPfwsYq950p4RAnB+AKCclT+mIFarmt76mVlOUOm9o5/zKgCgj6SX
ob0YG1iG1eXIw6wV6bi/mNE=
=t6Jp
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--

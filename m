Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Elimar Riesebieter <riesebie@lxtec.de>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluez-utils 2.9
Message-ID: <20040802204349.GC3303@aragorn.home.lxtec.de>
References: <20040801225614.GB22083@aragorn.home.lxtec.de> <1091411747.4279.7.camel@pegasus> <20040802184344.GA3303@aragorn.home.lxtec.de> <1091475366.4259.13.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
In-Reply-To: <1091475366.4259.13.camel@pegasus>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 2 Aug 2004 22:43:49 +0200


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 02 Aug 2004 the mental interface of
Marcel Holtmann told:

> Hi Elimar,
>=20
> > > > why does hid2hci doesn't compile in bluez-utils 2.9?
> > > >=20
> > > > Both --enable-hid2hci nor --enable-all built the binary hid2hci.
> > > >=20
> > > > Tried the same on 2.8 where it works!
> > >=20
> > > you need the USB library now to build hid2hci.
> >=20
> > Which USB library?
>=20
> take a look at libusb.sf.net. The lsusb program depends on this library
> and you should find it in any distribution, but you may have to select
> also its development package.

Fixed! Thanks

Elimar
--=20
  Alles was viel bedacht wird ist bedenklich!;-)
         Friedrich Nietzsche

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBDqeF3Ig8bsVPf7ARAiY2AJ9QjSBKzjgXmg9Iaxv5ale5/mBW0QCdEmMf
xC2YIvJppL6NiMZ/g0fu0o4=
=NQuv
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

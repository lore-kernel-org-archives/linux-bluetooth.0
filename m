Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Elimar Riesebieter <riesebie@lxtec.de>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] hid2hci
Message-ID: <20040410130853.GA4934@aragorn.home.lxtec.de>
References: <20040409153508.GA2123@aragorn.home.lxtec.de> <1081531882.21596.23.camel@pegasus> <20040409193454.GA2187@aragorn.home.lxtec.de> <1081593331.3028.10.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
In-Reply-To: <1081593331.3028.10.camel@pegasus>
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
Date: Sat, 10 Apr 2004 15:08:53 +0200


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 10 Apr 2004 the mental interface of
Marcel Holtmann told:

> Hi Elimar,
>=20
> > [...]
> > > looks like another USB problem. Maybe the USB guys already have a fix
> > > for it. Ask them.
> >=20
> > hci_usb was loaded while running hid2hci. Unloading that module
> > solves the prob. hci_usb is loaded from hotplug after changing to
> > hci by hid2hci.
>=20
> so this is really an USB race.

Maybe you're right ;-)

Ciao

Elimar

--=20
  On the keyboard of life you have always
  to keep a finger at the escape key;-)

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAd/Hl3Ig8bsVPf7ARAmt8AKCP1H9OgF9l14AF7fmsz7mJ0CB7YwCeNTIj
YIWAChvr7UW+SOyndoiF7uY=
=LsE5
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

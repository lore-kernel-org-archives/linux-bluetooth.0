Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Elimar Riesebieter <riesebie@lxtec.de>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] hid2hci
Message-ID: <20040409193454.GA2187@aragorn.home.lxtec.de>
References: <20040409153508.GA2123@aragorn.home.lxtec.de> <1081531882.21596.23.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
In-Reply-To: <1081531882.21596.23.camel@pegasus>
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
Date: Fri, 9 Apr 2004 21:34:54 +0200


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 09 Apr 2004 the mental interface of
Marcel Holtmann told:

> Hi Elimar,
[...]
> looks like another USB problem. Maybe the USB guys already have a fix
> for it. Ask them.

hci_usb was loaded while running hid2hci. Unloading that module
solves the prob. hci_usb is loaded from hotplug after changing to
hci by hid2hci.

Ciao

Elimar

--=20
  >what IMHO then?
  IMHO - Inhalation of a Multi-leafed Herbal Opiate ;)
              --posting from alex in debian-user--

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAdvre3Ig8bsVPf7ARAhu8AJ9rn1O2Hhm/1NyW2AgrkklGgumstgCfV+dq
IdC6MLpwUmpFk/C14FW2CEs=
=lNcc
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

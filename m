Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Two simultanous connections
From: Pierre N <pierren@mac.com>
To: Andreas Gaufer <Andreas.Gaufer@blue-cell-networks.com>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <20040403182354.5c3420eb.Andreas.Gaufer@blue-cell-networks.com>
References: <1080928843.9541.90.camel@localhost>
	 <1080929429.2836.101.camel@pegasus> <1080993011.12261.12.camel@localhost>
	 <1080994581.2839.26.camel@pegasus> <1080997306.12501.10.camel@localhost>
	 <20040403182354.5c3420eb.Andreas.Gaufer@blue-cell-networks.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WyPixpydUdxIBFrvKCYx"
Message-Id: <1081011200.12503.43.camel@localhost>
Mime-Version: 1.0
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
Date: Sat, 03 Apr 2004 18:53:20 +0200


--=-WyPixpydUdxIBFrvKCYx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-04-03 at 18:23, Andreas Gaufer wrote:
> On Sat, 03 Apr 2004 15:01:46 +0200
> Pierre N <pierren@mac.com> wrote:
>=20
> > Seriously, my question is why can a master hold up to 4 slaves but can'=
t
> > initiate these 4 connections itself as a master?
> >=20
> > Is it technically impossible, is it just an implementation constraint o=
r
> > is there some secret switch to do so?
> >=20
>=20
> check the role-switch procedure, its done with "hcitool" and its opention=
 "sr".=20
> Both Sides have to support this feature.

I tried this already. I can initiate a connection from A, but whatever
the type of the connection (slave or master) I can't initialise another
one. So I can't switch role on the second connection. I can switch role
of the first one, works great, but I doesn't allow me to start a second
one. It always fail silently.

I noticed that if I connected as slave, a scan shows me the 3rd iPaq.
Connected as master, a scan comes back empty. But if B and C initialise
the connections as slave, then A hold two connections as master no
problem.

Well, looks like my curiosity doesn't inspire many...

--
Pierre=20

--=-WyPixpydUdxIBFrvKCYx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAbuwAZkVEuKKlE7gRAg6+AKCLVMlGbHlf8/pJKLavSdAB+eyoCgCghyF7
2Ja6EkAwoIVGAEwR2lQgDXM=
=ylAn
-----END PGP SIGNATURE-----

--=-WyPixpydUdxIBFrvKCYx--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

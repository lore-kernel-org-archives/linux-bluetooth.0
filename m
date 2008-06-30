Return-Path: <cyrus@holtmann.org>
From: Michael Terry <michael.terry@canonical.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1214833915.6764.17.camel@bongo>
References: <1214593557.6131.26.camel@bongo>
	<1214605438.11537.0.camel@violet.holtmann.net>
	<1214833915.6764.17.camel@bongo>
Date: Mon, 30 Jun 2008 15:58:29 -0400
Message-Id: <1214855909.6764.57.camel@bongo>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Wizard patch
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0440545312=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0440545312==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-wTTU7Brfa+xtLhlYcYjf"


--=-wTTU7Brfa+xtLhlYcYjf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-06-30 at 09:51 -0400, Michael Terry wrote:
> On Sat, 2008-06-28 at 00:23 +0200, Marcel Holtmann wrote:
> > looks nice. However you have to break this up into pieces for. Sent
> > small patches and I can quickly review and commit them.
>=20
> Here's a patch to add support for connecting to devices via the client co=
de.  This patch depends on the callback patch.

Here's an updated services patch, to go along with the changes in callback2=
.diff.  I'll wait to provide an updated wizard-ui.diff until I get feedback=
.

-mt

--=-wTTU7Brfa+xtLhlYcYjf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIaTrl53i2YxNrdi0RAipRAKC3Gj/r7zzrtL+ACwfZxqymf118swCfZdg8
SSflI9UTESKUfNONCE4x3Nk=
=DVOy
-----END PGP SIGNATURE-----

--=-wTTU7Brfa+xtLhlYcYjf--



--===============0440545312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============0440545312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0440545312==--

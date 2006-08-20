Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 20 Aug 2006 12:34:20 +0200
From: Filippo Giunchedi <filippo@esaurito.net>
To: bluez-devel@lists.sf.net
Message-ID: <20060820103420.GB11669@esaurito.net>
MIME-Version: 1.0
Subject: [Bluez-devel] handling of default outgoing pin in hcid
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0536799806=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0536799806==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
I would like to hear opinions on handling of default outgoing pin/passkey in
hcid. It is my understanding that there is no way to actually set a default
outgoing pin from /var/lib/bluetooth/<sba>/pincodes. The only way to set it
is through the dbus interface, right?
Would be a patch to read default outgoing pincode from pincodes suitable?

Right now in debian I've implemented a (suboptimal) solution like pincodes =
but
with a modified passkey-agent, reading the pincode from stdin (so it doesn't
show up in ps) and using --default. See also
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D378850=20

thanks,
filippo
--
Filippo Giunchedi - http://esaurito.net
PGP key: 0x6B79D401
random quote follows:

To be learned in an art&C, the Theory is sufficient; to be a master of
it, both the Theory and practice are requisite.
-- Charles Hutton

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE6DqsABzeamt51AERAmOXAJ4oK+QjBsc+2DLVLXHT2yavGe824ACeKXmp
t1w1Rd0PslKv1Xvrsfpvj1o=
=BDyT
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--


--===============0536799806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0536799806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0536799806==--

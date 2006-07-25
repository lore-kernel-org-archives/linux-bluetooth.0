Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 25 Jul 2006 18:51:24 +0200
From: Filippo Giunchedi <filippo@esaurito.net>
To: bluez-devel@lists.sf.net
Message-ID: <20060725165124.GB14679@esaurito.net>
MIME-Version: 1.0
Cc: Kay Sievers <kay.sievers@vrfy.org>, Felix Homann <fexpop@onlinehome.de>
Subject: [Bluez-devel] bluez udev rules for pcmcia devices
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1736675436=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============1736675436==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
I think we should discuss udev rules for bluez (WRT pcmcia cards) as pointed out
by Marcel while discussing debian bug #378839.
So far there's a rules file here:
http://bugs.debian.org/cgi-bin/bugreport.cgi/bluez-pcmcia-support.rules?bug=378839;msg=72;att=1
and the bluetooth.sh script here:
http://bugs.debian.org/cgi-bin/bugreport.cgi/bluetooth.sh?bug=378839;msg=72;att=2
both borrowed in the wild (from SuSE IIRC). See the full bug log for further
discussion. I basically agree with Marcel because while the bluetooth.sh script
is invoked /usr might not be mounted yet thus it should not try to execute
/etc/init.d/bluetooth.

comments/ideas?

filippo
--
Filippo Giunchedi - http://esaurito.net
PGP key: 0x6B79D401
random quote follows:

I worked myself up from nothing to a state of extreme poverty.
-- Groucho Marx

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFExkwMABzeamt51AERAhNvAKCJzcMqw/svv0A7kE8qbRdWffD5yACglu4g
CUfd/6+Q3ML9a2pjLYMYbv0=
=Ctlo
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--


--===============1736675436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1736675436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1736675436==--

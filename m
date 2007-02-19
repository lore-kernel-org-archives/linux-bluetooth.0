Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 19 Feb 2007 10:51:45 +0100
From: Florian Ragwitz <rafl@debian.org>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070219095145.GA1828@perldition.org>
MIME-Version: 1.0
Subject: [Bluez-users] hcidump segfault
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1840413549=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============1840413549==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I'm trying to sync a Sony Ericsson W810i mobile using wammu over
bluetooth. Scanning for the device works fine, but when trying to
connect wammu hangs. I tried to debug that problem using hcidump and
saw it segfaulting after telling wammu to connect. Therefor I think the
problem is caused by something other than the wammu/gammu code or my
local bluetooth configuration.

Maybe someone can help me sort out the above problems? [1]Here you will
find the hcidump output of a wammu session which first scans for the
device and then tries to connect to it. What other information might be
useful?

1. http://files.perldition.org/wammu.hcidump


TIA,
Flo

--=20
BOFH excuse #25:
Decreasing electron flux

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFF2XMxdC8qQo5jWl4RAh+5AJ4vcjElQeKq80Ar8EPAOYARfVsaCQCeK/pl
/AqC3Lx41UZFHBkKeO2O0QQ=
=Ukwx
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--


--===============1840413549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1840413549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1840413549==--

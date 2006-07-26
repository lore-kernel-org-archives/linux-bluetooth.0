Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 26 Jul 2006 20:18:02 +0200
From: Filippo Giunchedi <filippo@esaurito.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060726181802.GC6678@esaurito.net>
References: <44C73308.3010903@gmail.com>
MIME-Version: 1.0
In-Reply-To: <44C73308.3010903@gmail.com>
Cc: JP Freeley <jpf321@gmail.com>
Subject: Re: [Bluez-devel] Unable to get on on the D-Bus
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1240693776=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============1240693776==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 26, 2006 at 05:16:56AM -0400, JP Freeley wrote:
> I have moved to the debian "sid" branch as it has 3.1 bluez included.
>=20
> When I first apt-get'd the necessary packages everything seemed to work O=
K.
> After REBOOT I am getting the following messages about HCID:
>=20
> Jul 27 03:41:37  hcid[1460]: Bluetooth HCI daemon
> Jul 27 03:41:37 sdpd[1462]: Bluetooth SDP daemon
> Jul 27 03:41:37 hcid[1460]: Service could not become the primary owner.
> Jul 27 03:41:37 hcid[1460]: Unable to get on D-Bus
> Jul 27 03:41:38 dund[1481]: Bluetooth DUN daemon version 3.1

try to restart dbus (/etc/init.d/dbus restart) and bluetooth
(/etc/init.d/bluetooth restart).
Also could you please retry with 3.1-3 (available from tomorrow I hope).

Last remark: please use the 'reportbug' utility when reporting a bug on a d=
ebian
system: it will go through the proper channels and we can easily keep track=
 of
them.

thanks,
filippo
--
Filippo Giunchedi - http://esaurito.net
PGP key: 0x6B79D401
random quote follows:

What a strange illusion it is to suppose that beauty is goodness.
-- Lev Tolstoj

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEx7HaABzeamt51AERAhjGAKDEOgPHeEl4VNLv/Ai+u39590W4/QCfXWJe
sE3A8E5ywpoYfPHdv9gJS6I=
=6IaM
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--


--===============1240693776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1240693776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1240693776==--

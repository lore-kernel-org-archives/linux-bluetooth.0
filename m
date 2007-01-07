Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 7 Jan 2007 12:06:08 -0700
From: Kevin Fenzi <kevin@scrye.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20070107120608.05a65c7f@ningauble.scrye.com>
Mime-Version: 1.0
Subject: [Bluez-devel] 2 plugz issues
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0558326705=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0558326705==
Content-Type: multipart/signed; boundary="Sig_iG2OOREt2UaTLuHOtrwI/Kc";
	protocol="application/pgp-signature"; micalg=PGP-SHA1

--Sig_iG2OOREt2UaTLuHOtrwI/Kc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Greetings.=20

I noticed not long ago that you guys had switched the btsco setup over
to a new 'plugz' setup. No kernel module is a great thing. ;)=20

I have run into 2 issues however:=20

1. Just checking out, building and running works, but I end up getting
no sound from headsetd, and it spits out:=20

Unable to set number of SCO buffers : please upgrade your Kernel !

Commenting out that check in the code results in it working ok.=20
Is that just for better performance?=20
What kernel version do you need to upgrade to here?=20
Is this related to the patches in the patches/ dir?=20

2. Once I comment out that code from 1 above, my headset works fine and
sounds ok. However, if I do anything that sends a DTMF from my sip
phone (I am using twinkle) it causes twinkle to go into a 100% cpu
spin, and once to totally lock up my machine. Any idea why DTMF would
cause that? Is there any way I can test or get more info to track down
the problem?

Otherwise great progress guys... keep up the great work.=20

kevin

--Sig_iG2OOREt2UaTLuHOtrwI/Kc
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFoUSk3imCezTjY0ERAnlvAKCOdV3cccRQjpXFuPRt8ro6crLTlACfU9H5
gUuxj5nISfpigNPG4QK/TxI=
=q2mo
-----END PGP SIGNATURE-----

--Sig_iG2OOREt2UaTLuHOtrwI/Kc--


--===============0558326705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0558326705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0558326705==--

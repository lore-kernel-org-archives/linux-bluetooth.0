Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 7 Jan 2007 16:58:12 -0700
From: Kevin Fenzi <kevin@scrye.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20070107165812.44c7789b@ningauble.scrye.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] 2 plugz issues
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1187116600=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1187116600==
Content-Type: multipart/signed; boundary="Sig_efYBsV7O2bac/pb8+spremW";
	protocol="application/pgp-signature"; micalg=PGP-SHA1

--Sig_efYBsV7O2bac/pb8+spremW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

>> 2. Once I comment out that code from 1 above, my headset works fine
>> and sounds ok. However, if I do anything that sends a DTMF from my
>> sip phone (I am using twinkle) it causes twinkle to go into a 100%
>> cpu spin, and once to totally lock up my machine. Any idea why DTMF
>> would cause that? Is there any way I can test or get more info to
>> track down the problem?

>please try it with plugz/patches/sco-flowcontrol-v3.0.diff applied.

It looks like thats against bluez-libs?=20
What version? It doesn't apply to 3.7 cleanly...=20

Or are they for something else?=20
The files seem to match bluez-libs however.=20

>Brad

kevin

--Sig_efYBsV7O2bac/pb8+spremW
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFoYkW3imCezTjY0ERAuMXAKCEyLmdoCb2vFuzxQgrJXIuCwadagCgkYvz
Ig6GWH87VschaAOh50UdSrg=
=CKlz
-----END PGP SIGNATURE-----

--Sig_efYBsV7O2bac/pb8+spremW--


--===============1187116600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1187116600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1187116600==--

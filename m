Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 22 Sep 2006 09:10:22 +0100
From: Paul LeoNerd Evans <leonerd@leonerd.org.uk>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060922091022.3a8f4ee8@nim.leo>
In-Reply-To: <eevdff$gco$1@sea.gmane.org>
References: <451334F6.2010707@gmail.com>
	<eevdff$gco$1@sea.gmane.org>
Mime-Version: 1.0
Cc: gmane.20.evilspam@spamgourmet.com
Subject: Re: [Bluez-users] Keyboard Device Pairing
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1627959595=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1627959595==
Content-Type: multipart/signed; boundary="Sig_B5=6.HoUbQ1=7DeKj_xcQYS";
	protocol="application/pgp-signature"; micalg=PGP-SHA1

--Sig_B5=6.HoUbQ1=7DeKj_xcQYS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Sep 2006 21:15:26 -0400
Chris Spencer <gmane.20.evilspam@spamgourmet.com> wrote:

> [root@localhost]# hidd --connect 00:0D:3C:40:68:7C
> <window popped up asking for a passkey>
> Can't get device information: Too many levels of symbolic links
> [root@localhost]# hidd --connect 00:0D:3C:40:68:7C
> Can't get device information: Function not implemented

Random guess, but that to me looks like "errno" is getting undefined
values and is printing whatever random number of error it happens to find.

--=20
Paul "LeoNerd" Evans

leonerd@leonerd.org.uk
ICQ# 4135350       |  Registered Linux# 179460
http://www.leonerd.org.uk/

--Sig_B5=6.HoUbQ1=7DeKj_xcQYS
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFE5pxqRXzCRLr5iQRAiTkAKCBQDlyNL5pcJGm4yx94a1e2MkwLwCeMFOv
MlExgvlEILkaCQfS5pIbo7Y=
=We1I
-----END PGP SIGNATURE-----

--Sig_B5=6.HoUbQ1=7DeKj_xcQYS--


--===============1627959595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1627959595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1627959595==--

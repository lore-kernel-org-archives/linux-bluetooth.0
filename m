Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Thomas Kear <thomas.kear@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Fri, 12 Jan 2007 09:55:21 +1300
References: <4f436aae0701110833m5aa4155bxbbc61920f5421f3c@mail.gmail.com>
In-Reply-To: <4f436aae0701110833m5aa4155bxbbc61920f5421f3c@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200701120955.24082.thomas.kear@gmail.com>
Subject: Re: [Bluez-users] Profiles on Bluez
Reply-To: thomas.kear@gmail.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0490517038=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0490517038==
Content-Type: multipart/signed; boundary="nextPart1346004.q9SNMUFIl5";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1346004.q9SNMUFIl5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

SCO (handsfree), A2DP and AVRCP are supported by the bluetooth-alsa driver
http://bluetooth-alsa.sourceforge.net

BPP, depending on which way you want to use it, is a bit of an issue at the=
=20
moment.  I haven't yet found a server that lets my PC accept print requests=
=20
from mobile devices and print them through CUPS.  However working the other=
=20
way, CUPS has a bluetooth backend that supports adding queues for bluetooth=
=20
printers (I believe using HCRP).

OPP and FTP are handled just fine by KDE's 'kdebluetooth' package, if you h=
ave=20
it installed, bluetooth:/ in a konqueror view should give you a device=20
listing, double clicking a device icon should display supported profiles, F=
TP=20
is called "OBEX File Transfer".  In OPP's case, sending a file from a devic=
e=20
to the PC should automatically open a dialogue to facilitate recieving it. =
=20
Sending files is as easy as right clicking them in a konqueror view and=20
selecting "Actions> Send with Bluetooth...".  Gnome's bluetooth utilities=20
should have similar funtionality, I cannot comment further as I've never us=
ed=20
them.

=2D-Thomas

On Friday 12 January 2007 5:33 am, Choi Sonim wrote:
> Hello ppl!
>
> What Bluetooth profile do BlueZ support ?
> I found some OBEX utilities (which both gnome and kde provides),
> and the builtin BNEP support. but that;s it. no hands-free, bpp,
> opp,a2dp,ftp, nothing ?
>
> I know it is high-level and everything can be written on top of bluez
> but i wonder what is already supported ?
>
> Thank You ppl,
> Choi.
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your opinions on IT & business topics through brief surveys - and earn ca=
sh
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

--nextPart1346004.q9SNMUFIl5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBFpqQ88/Qi7qeDfygRAgrlAKCtYbnBfZY+v/YSh2nOKmqBc3FbfwCgtPgL
ocP4RdJbGBNRyk920IDEKXU=
=h1kM
-----END PGP SIGNATURE-----

--nextPart1346004.q9SNMUFIl5--


--===============0490517038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0490517038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0490517038==--

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 07 Dec 2006 16:10:56 +0000 (GMT)
From: leconte.michel@cegetel.net
To: bluez-users@lists.sourceforge.net
Message-id: <f376804d3d0.45783d10@cegetel.net>
MIME-version: 1.0
Subject: [Bluez-users] Pairing-Authentication
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1968011898=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1968011898==
Content-type: text/html; charset=us-ascii
Content-language: fr
Content-transfer-encoding: quoted-printable
Content-disposition: inline

=3Cpre=3EHi all=2C=3Cbr=3E=3Cbr=3Eto understand the authentication proce=
dure=2C I make=3Cbr=3Ea test between 2 entities designed by =22A=22 and =
=22B=22=2E=3Cbr=3E=3Cbr=3E1=2E A connection is realized without authenti=
cation between these two entities=2C (they never paired before) =3Cbr=3E=
=3Cbr=3E2=2E Then entity =22A=22 launches an authentication request=2C=3C=
br=3E=3Cbr=3E3=2E As they never paired no link key is available for the =
link =22A=22-=22B=22=2C the pairing procedure =3Cbr=3E   works well (sam=
e pin code at each side)=3Cbr=3E   =3Cbr=3E=3Cbr=3E4=2E I disconnect the=
 link =22A=22-=22B=22=2C I reconnect =22A=22 and =22B=22 without authent=
ication=2C=3Cbr=3E=3Cbr=3E5=2E =22A=22 executes an authentication reques=
t=2C=3Cbr=3E=3Cbr=3E=3Cbr=3EAt this time=2C the authentication procedure=
 doesn=27t need a pairing as a link key is available=2E=3Cbr=3E=3Cbr=3EM=
y first question is what can I do to force the pairing before an authent=
ication request  =3F=3Cbr=3EIn other word=2C where can I delete the link=
 key for the link =22A=22-=22B=22 in bluez =3F=3Cbr=3E=3Cbr=3E=3Cbr=3EMy=
 second question=2C is how to configure security in a pan network =3F=3C=
br=3E=3Cbr=3ECan I set security at the L2CAP level with specific option =
during the setsockopt =3F=3Cbr=3E=3Cbr=3E=3Cbr=3Ethanks in advance for a=
ny help or suggestion=3Cbr=3E=3Cbr=3E=3Cbr=3EMichel=3C/pre=3E=3Cbr=3E=3C=
br=3E=3Cbr=3E=3Cbr=3E---------------------------------------------------=
-------------=3Cbr=3E


--===============1968011898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1968011898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1968011898==--

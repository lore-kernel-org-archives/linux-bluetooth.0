Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 20 Nov 2006 10:24:30 +0000 (GMT)
From: leconte.michel@cegetel.net
To: bluez-users@lists.sourceforge.net
Message-id: <f31e9d8c1e5.4561825e@cegetel.net>
MIME-version: 1.0
Subject: [Bluez-users] Problem of disconnection in a PAN network when using
	an SCO link
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0409892472=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0409892472==
Content-type: text/html; charset=us-ascii
Content-language: fr
Content-transfer-encoding: quoted-printable
Content-disposition: inline

Hi all=2C=3CBR=3E=3CBR=3EI have a problem in a PAN network when I establ=
ish an SCO link before the disconnection of two entities=2E=3CBR=3E=3CBR=
=3ETopology of the network =3A One Bluetooth kit is GN (configured in ma=
ster) the other one is PANU (configured in slave)=2C these two entities =
constitute a Bluetooth IP network (using Bnep interfaces and PAN daemons=
)=2E=3CBR=3E=3CBR=3E=3CBR=3EFirst test =3A =3CBR=3E----------=3CBR=3EThe=
 PANU wish to make a disconnection with the GN=2C it applies a bnep=5Fki=
ll=5Fconnection()=2E=3CBR=3EWith hcidump=2C one can see a disconnection =
complete event=2E =3CBR=3EThen with =22hcitool con=22 command=2C we don=27=
t see any ACL connection=2E  =3CBR=3E=3CBR=3ESecond test =3A =3CBR=3E---=
-------=3CBR=3E=3CBR=3EThe PANU and the GN establish an SCO connection o=
n the ACL link=2E=3CBR=3EThe PANU wishes to make a disconnection with th=
e GN=2C it applies a bnep=5Fkill=5Fconnection()=2E=3CBR=3EWith hcidump=2C=
 one can see two disconnection complete events=2E =3CBR=3EThe first one =
for the SCO connection the second one for the ACL link=2E=3CBR=3E=3CBR=3E=
In despite of these two deconnection events=2C the =22hcitool con=22 com=
mand=3CBR=3Eshows always an ACL connection with a state 8=2E These state=
 value corresponds to a=3CBR=3Edisconnection state=2E My goal is to have=
 a real complete disconnection of the link as=3CBR=3Ein the first test=2E=
=3CBR=3E=3CBR=3EDoes anyone has an idea to fully disconnect these link w=
ithout seeing it with the =22hcitool con=22 =3CBR=3Ecommand =3F  =3CBR=3E=
=3CBR=3EHow a link can be in a disconnection state and always visible wi=
th these later command =3F=3CBR=3E=3CBR=3E=3CBR=3Ethanks for any idea or=
 suggestion=2E=3CBR=3E=3CBR=3Eregards=2E=3CBR=3E=3CBR=3EMichel=3CBR=3E=3C=
br=3E=3Cbr=3E=3Cbr=3E=3Cbr=3E-------------------------------------------=
---------------------=3Cbr=3E


--===============0409892472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0409892472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0409892472==--

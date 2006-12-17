Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c959654e0612170809q3014cc10u51c039abee710e56@mail.gmail.com>
Date: Sun, 17 Dec 2006 14:09:06 -0200
From: "Jefferson Bosa" <jlbosa@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <c959654e0612170759r1a9e6fa6jf72be017d36ef25c@mail.gmail.com>
MIME-Version: 1.0
References: <c959654e0612170759r1a9e6fa6jf72be017d36ef25c@mail.gmail.com>
Subject: [Bluez-users] about bluetooth from Dell D600 on linux
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0987324350=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0987324350==
Content-Type: multipart/alternative;
	boundary="----=_Part_1722_13437842.1166371746645"

------=_Part_1722_13437842.1166371746645
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi, I have a Dell D600 with the internal bluetooth.
I use Kubuntu Edgy, and the system detected the bluetooth with success.

jefferson@pegasus:/home$ hciconfig -a
hci0:   Type: USB
        BD Address: 00:10:C6:52:7F:5D ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN
        RX bytes:401 acl:0 sco:0 events:18 errors:0
        TX bytes:317 acl:0 sco:0 commands:17 errors:0
        Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'Dell_D600'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object Transfer,
Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x4f2 LMP Ver: 1.2 (0x2) LMP Subver:
0x4f2
        Manufacturer: Cambridge Silicon Radio (10)

When I scan the bluetooth acessories, dont find anything.

jefferson@pegasus:/home$ hcitool scan
Scanning ...


jefferson@pegasus:/home$ lsusb
Bus 004 Device 001: ID 0000:0000
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 009: ID 413c:8000 Dell Computer Corp.
Bus 001 Device 008: ID 1267:0210 Logic3 / SpectraVideo plc
Bus 001 Device 001: ID 0000:0000

I think this bluetooth(ID 413c:8000 Dell Computer Corp.  is the
bcm2035 (http://www.modem-help.com/Dell/TrueMobile%20300%20Bluetooth%20Inte=
rnal%20card.php
), but I cant make this run.

[]'s

--=20
------------------------------------------------------
Jefferson Luiz Bosa
Bacharel em Inform=E1tica
..::| Portanto, se o Filho os libertar, voc=EAs de fato ser=E3o livres. Jo =
8:36
|::..
IM: jefferson@myjabber.net
Seja Livre, use GNU/Linux e seja feliz!

--=20
------------------------------------------------------
Jefferson Luiz Bosa
Bacharel em Inform=E1tica
..::| Portanto, se o Filho os libertar, voc=EAs de fato ser=E3o livres. Jo =
8:36
|::..
IM: jefferson@myjabber.net
Seja Livre, use GNU/Linux e seja feliz!

------=_Part_1722_13437842.1166371746645
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<span class=3D"gmail_quote"></span>Hi, I have a Dell D600 with the internal=
 bluetooth.<br>I use Kubuntu Edgy, and the system detected the bluetooth wi=
th success.<br><br>jefferson@pegasus:/home$ hciconfig -a<br>hci0:&nbsp;&nbs=
p; Type: USB
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:10:C6:52:7F:5=
D ACL MTU: 192:8 SCO MTU: 64:8
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:401 acl:0 sco:0 events:18 error=
s:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:317 acl:0 sco:0 =
commands:17 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features=
: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SN=
IFF PARK<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACC=
EPT<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'Dell_D600'<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x3e0100<br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Networking, Rendering, Capturing=
, Object Transfer, Audio
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Computer, Unca=
tegorized<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.2 (0x2) =
HCI Rev: 0x4f2 LMP Ver: 1.2 (0x2) LMP Subver: 0x4f2<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)<br><br>Wh=
en I scan the bluetooth acessories, dont find anything.
<br><br>jefferson@pegasus:/home$ hcitool scan<br>Scanning ...<br><br><br>je=
fferson@pegasus:/home$ lsusb<br>Bus 004 Device 001: ID 0000:0000<br>Bus 003=
 Device 001: ID 0000:0000<br>Bus 002 Device 001: ID 0000:0000<br>Bus 001 De=
vice 009: ID 413c:8000 Dell Computer Corp.
<br>Bus 001 Device 008: ID 1267:0210 Logic3 / SpectraVideo plc
<br>Bus 001 Device 001: ID 0000:0000<br><br>I think this bluetooth(ID 413c:=
8000 Dell Computer Corp.&nbsp; is the bcm2035 (<a href=3D"http://www.modem-=
help.com/Dell/TrueMobile%20300%20Bluetooth%20Internal%20card.php" target=3D=
"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">
http://www.modem-help.com/Dell/TrueMobile%20300%20Bluetooth%20Internal%20ca=
rd.php
</a>), but I cant make this run.<br><br>[]'s<br clear=3D"all"><span class=
=3D"sg"><br>-- <br>------------------------------------------------------<b=
r>Jefferson Luiz Bosa<br>Bacharel em Inform=E1tica<br>..::| Portanto, se o =
Filho os libertar, voc=EAs de fato ser=E3o livres. Jo 8:36 |::..
<br>IM: <a href=3D"mailto:jefferson@myjabber.net" target=3D"_blank" onclick=
=3D"return top.js.OpenExtLink(window,event,this)">jefferson@myjabber.net</a=
><br>Seja Livre, use GNU/Linux e seja feliz!

</span><br clear=3D"all"><br>-- <br>---------------------------------------=
---------------<br>Jefferson Luiz Bosa<br>Bacharel em Inform=E1tica<br>..::=
| Portanto, se o Filho os libertar, voc=EAs de fato ser=E3o livres. Jo 8:36=
 |::..
<br>IM: <a href=3D"mailto:jefferson@myjabber.net">jefferson@myjabber.net</a=
><br>Seja Livre, use GNU/Linux e seja feliz!

------=_Part_1722_13437842.1166371746645--


--===============0987324350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0987324350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0987324350==--

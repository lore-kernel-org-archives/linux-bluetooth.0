Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <fe0a97c20604040600k105581f1i96aa8334894218a@mail.gmail.com>
From: "Sowmya Gattupalli" <sowmya.gattupalli@gmail.com>
To: Bluez-devel@lists.sourceforge.net
In-Reply-To: <fe0a97c20603270203k53b20d7cx6be47e19c8d1f253@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3393_18106450.1144155656632"
References: <fe0a97c20603270203k53b20d7cx6be47e19c8d1f253@mail.gmail.com>
Subject: [Bluez-devel] Service Classes-unspecified....
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 4 Apr 2006 18:30:56 +0530

------=_Part_3393_18106450.1144155656632
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Guys I think mine is a lil peculiar problem,,,, hope to get a solution for
here,.....

Initially when I was running the knoppix live CD.... my "hcicongig -a". had
all the service classes including Networking,Rendering,Capturing and
Audio... I was delighted... but now it shows in this way!!

(and I didn't even change hcid.conf)
root@bluetooth:~# hciconfig -a
hci0:   Type: USB
        BD Address: 00:09:DD:10:00:CC ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:63 acl:0 sco:0 events:7 errors:0
        TX bytes:27 acl:0 sco:0 commands:7 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'Soumya-0'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver:
0x175
        Manufacturer: Cambridge Silicon Radio (10)


How come are my Service classes "unspecified" ??
ne ideas??

------=_Part_3393_18106450.1144155656632
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><span class=3D"gmail_quote"><br></span><div style=3D"direction: ltr;">G=
uys I think mine is a lil peculiar problem,,,, hope to get a solution for h=
ere,..... <br><br>Initially when I was running the knoppix live CD.... my &=
quot;hcicongig -a&quot;. had all the service classes including Networking,R=
endering,Capturing and Audio... I was delighted... but now it shows in this=
 way!!
<br><br>(and I didn't even change hcid.conf)<br>root@bluetooth:~# hciconfig=
 -a<br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; BD Address: 00:09:DD:10:00:CC ACL MTU: 192:8&nbsp; SCO MTU: 64:8<br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:63 acl:0 sco:0 events:7 errors=
:0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:27 acl:0 sco:0 comm=
ands:7 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xf=
f 0xff 0x0f 0x00 0x00 0x00 0x00 0x00<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; Link mode: SLAVE ACCEPT
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'Soumya-0'<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x000100<br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Service Classes: Unspecified<br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Device Class: Computer, Uncategorized<br>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1=
.1 (0x1) LMP Subver: 0x175
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Sili=
con Radio (10)<br><br><br>How come are my Service classes &quot;unspecified=
&quot; ?? <br>ne ideas??<br>

</div>

------=_Part_3393_18106450.1144155656632--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

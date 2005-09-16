Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <becc9d2c0509160020670a627b@mail.gmail.com>
From: Andrea Carlevato <andrea.carlevatoml@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Problem with l2test, rctest
In-Reply-To: <1126802829.15633.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8778_33383574.1126855235563"
References: <becc9d2c05091505534b795f7b@mail.gmail.com>
	 <becc9d2c05091506452748d6a0@mail.gmail.com>
	 <1126792737.3505.6.camel@station6.example.com>
	 <becc9d2c050915091830e5a609@mail.gmail.com>
	 <1126801476.15633.2.camel@localhost.localdomain>
	 <becc9d2c0509150944132bb8f1@mail.gmail.com>
	 <1126802829.15633.7.camel@localhost.localdomain>
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
Date: Fri, 16 Sep 2005 09:20:35 +0200

------=_Part_8778_33383574.1126855235563
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Ok,
hciconfig - of my client is:

hci0: Type: USB
BD Address: 00:10:60:A5:81:68 ACL MTU: 192:8 SCO MTU: 64:8
UP RUNNING PSCAN ISCAN
RX bytes:254 acl:0 sco:0 events:28 errors:0
TX bytes:379 acl:0 sco:0 commands:20 errors:0
Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
Link policy: RSWITCH HOLD SNIFF PARK
Link mode: ACCEPT MASTER
Name: 'EnviCartello'
Class: 0x820100
Service Classes: Networking
Device Class: Computer, Uncategorized
HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
Manufacturer: Cambridge Silicon Radio (10)

And the hciconfig of my server is :

hci0: Type: USB
BD Address: 00:10:60:29:3B:9A ACL MTU: 192:8 SCO MTU: 64:8
UP RUNNING PSCAN ISCAN
RX bytes:241 acl:0 sco:0 events:28 errors:0
TX bytes:373 acl:0 sco:0 commands:20 errors:0
Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
Link policy: RSWITCH HOLD SNIFF PARK
Link mode: ACCEPT MASTER
Name: 'PROMOPC'
Class: 0x820100
Service Classes: Networking
Device Class: Computer, Uncategorized
HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver: 0x175
Manufacturer: Cambridge Silicon Radio (10)

------=_Part_8778_33383574.1126855235563
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Ok,<br>
hciconfig - of my client is:<br>
<br>
hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:10:60:A5:81:68 AC=
L MTU: 192:8 SCO MTU: 64:8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:254 acl:0 sco:0 events:=
28 errors:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:379 acl:0 sco:0 command=
s:20 errors:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x0f 0x00 0x=
00 0x00 0x00 0x00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3=
 DH5 HV1 HV2 HV3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF =
PARK<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: ACCEPT MASTER<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'EnviCartello'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x820100<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Networking<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Computer, Uncatego=
rized<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.1 (0x1) HCI Rev: 0x20=
d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon =
Radio (10)<br>
<br>
And the hciconfig of my server is :<br>
<br>
hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:10:60:29:3B:9A AC=
L MTU: 192:8 SCO MTU: 64:8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:241 acl:0 sco:0 events:=
28 errors:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:373 acl:0 sco:0 command=
s:20 errors:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x0f 0x00 0x=
00 0x00 0x00 0x00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3=
 DH5 HV1 HV2 HV3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF =
PARK<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: ACCEPT MASTER<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'PROMOPC'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x820100<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Networking<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Computer, Uncatego=
rized<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.1 (0x1) HCI Rev: 0x17=
5 LMP Ver: 1.1 (0x1) LMP Subver: 0x175<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon =
Radio (10)<br>
<br>

------=_Part_8778_33383574.1126855235563--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

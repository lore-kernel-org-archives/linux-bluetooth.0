Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <becc9d2c05091506452748d6a0@mail.gmail.com>
From: Andrea Carlevato <andrea.carlevatoml@gmail.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <becc9d2c05091505534b795f7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8157_17014135.1126791929930"
References: <becc9d2c05091505534b795f7b@mail.gmail.com>
Subject: [Bluez-devel] Problem with l2test, rctest
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
Date: Thu, 15 Sep 2005 15:45:29 +0200

------=_Part_8157_17014135.1126791929930
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi to all,
trying these test program betweem 2 pc of mine i get
alway this error on the client side:

> ./rctest -s 00:10:60:29:XX:XX
rctest[1672]: Can't connect: Function not implemented (38)


what does it means ?


this is my hciconfig:

hci0: Type: USB
BD Address: 00:10:60:A6:XX:XX ACL MTU: 192:8 SCO MTU: 64:8
UP RUNNING PSCAN ISCAN
RX bytes:7991 acl:85 sco:0 events:551 errors:0
TX bytes:3267 acl:69 sco:0 commands:177 errors:0

and this is my lsmod output:


hci_usb 8712 2
af_packet 11464 0
ixp425_eth 15236 0
ixp400 615208 1 ixp425_eth
rfcomm 24572 3
l2cap 14724 9 bnep,rfcomm
bluetooth 30752 8 bnep,hci_usb,rfcomm,l2cap
ipv6 187296 12
ext3 96744 1
jbd 36536 1 ext3
mbcache 5060 1 ext3


Andrea

------=_Part_8157_17014135.1126791929930
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<span class=3D"gmail_quote"></span>Hi to all,<br>
trying these test program betweem 2 pc of mine i get<br>
alway this error on the client side:<br>
<br>
&gt; ./rctest -s 00:10:60:29:XX:XX<br>
rctest[1672]: Can't connect: Function not implemented (38)<br>
<br>
<br>
what does it means ?<br>
<br>
<br>
this is my hciconfig:<br>
<br>
hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:10:60:A6:XX:XX AC=
L MTU: 192:8 SCO MTU: 64:8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:7991 acl:85 sco:0 event=
s:551 errors:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:3267 acl:69 sco:0 comma=
nds:177 errors:0<br>
<br>
and this is my lsmod output:<br>
<br>
<br>
hci_usb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 8712&nbsp; 2<br>
af_packet&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 11464&nbsp; 0<br>
ixp425_eth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 15236&nbsp; 0<br>
ixp400&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 615208&nbsp; 1 ixp425_eth<br>
rfcomm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 24572&nbsp; 3<br>
l2cap&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
14724&nbsp; 9 bnep,rfcomm<br>
bluetooth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 30752&nbsp; 8 bnep,hci_usb,rfcomm,l2cap<br>
ipv6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 187296&nbsp; 12<br>
ext3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 96744&nbsp; 1<br>
jbd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
36536&nbsp; 1 ext3<br>
mbcache&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 5060&nbsp; 1 ext3<br><span class=3D"sg">
<br>
<br>
Andrea<br>
<br>
<br>

</span>

------=_Part_8157_17014135.1126791929930--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

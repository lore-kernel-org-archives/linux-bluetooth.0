Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05092009524d67443b@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_11480_16206422.1127235154148"
Subject: [Bluez-devel] firmware upgrade
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
Date: Tue, 20 Sep 2005 13:52:34 -0300

------=_Part_11480_16206422.1127235154148
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi folks,

Before start update the firmware of my dongles I would like make sure
that nothing is wrong. Sometimes, dongles upgrades can end up with
a dead dongle :) I read some documents in the Marcel's home=20
page(http://holtmann.org) but I am afraid of upgrade my dongles :)

I have the following dongles/adapters:

>>>> D-Link DBT-120 Hardware B3
$hciconfig -a hci0 version
hci0: Type: USB
BD Address: XX:XX:XX:XX:XX:XX ACL MTU: 192:8 SCO MTU: 64:8
HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1 (0x1) LMP Subver: 0x1bb
Manufacturer: Cambridge Silicon Radio (10)
$hciconfig -a hci0 revision
hci0: Type: USB
BD Address: XX:XX:XX:XX:XX:XX ACL MTU: 192:8 SCO MTU: 64:8
HCI 15.3
Chip version: BlueCore02-External
Max key size: 56 bit
SCO mapping: HCI

>>>> D-Link DBT-122 Hardware A1
$hciconfig -a hci0 version
hci0: Type: USB
BD Address: XX:XX:XX:XX:XX:XX ACL MTU: 377:10 SCO MTU: 16:0
HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x309
Manufacturer: Broadcom Corporation (15)
$hciconfig -a hci0 revision
hci0: Type: USB
BD Address: XX:XX:XX:XX:XX:XX ACL MTU: 377:10 SCO MTU: 16:0
Firmware 0.3 / 9

>>>> IBM T41
$hciconfig -a hci0 version
BD Address: XX:XX:XX:XX:XX:XX ACL MTU: 192:8 SCO MTU: 64:8
HCI Ver: 1.1 (0x1) HCI Rev: 0x222 LMP Ver: 1.1 (0x1) LMP Subver: 0x222
Manufacturer: Cambridge Silicon Radio (10)
$hciconfig -a hci0 revision
hci0: Type: USB
BD Address: XX:XX:XX:XX:XX:XX ACL MTU: 192:8 SCO MTU: 64:8
Build 546
Chip version: BlueCore02-External
Max key size: 128 bit
SCO mapping: HCI



I am not sure if upgrade will work in the DBT-122 and in my notebook
IBM T41. If someone has tips or references of how do this procedure
please send me the links.


Thanks in advance,
Claudio

------=_Part_11480_16206422.1127235154148
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi folks,<br>
<br>
Before start update the firmware of my dongles I would like make sure<br>
that nothing is wrong. Sometimes, dongles upgrades can end up with<br>
a dead dongle :) I read some documents in the Marcel's home <br>
page(<a href=3D"http://holtmann.org">http://holtmann.org</a>) but I am afra=
id of upgrade my dongles :)<br>
<br>
I have the following dongles/adapters:<br>
<br>
&gt;&gt;&gt;&gt; D-Link DBT-120 Hardware B3<br>
$hciconfig -a hci0 version<br>
hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: XX:XX:XX:XX:XX:XX AC=
L MTU: 192:8 SCO MTU: 64:8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.1 (0x1) HCI Rev: 0x1b=
b LMP Ver: 1.1 (0x1) LMP Subver: 0x1bb<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon =
Radio (10)<br>
$hciconfig -a hci0 revision<br>
hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: XX:XX:XX:XX:XX:XX AC=
L MTU: 192:8 SCO MTU: 64:8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI 15.3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Chip version: BlueCore02-Externa=
l<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Max key size: 56 bit<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SCO mapping:&nbsp; HCI<br>
<br>
&gt;&gt;&gt;&gt; D-Link DBT-122 Hardware A1<br>
$hciconfig -a hci0 version<br>
hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: XX:XX:XX:XX:XX:XX AC=
L MTU: 377:10 SCO MTU: 16:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.2 (0x2) HCI Rev: 0x0 =
LMP Ver: 1.2 (0x2) LMP Subver: 0x309<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Broadcom Corporati=
on (15)<br>
$hciconfig -a hci0 revision<br>
hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: XX:XX:XX:XX:XX:XX AC=
L MTU: 377:10 SCO MTU: 16:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Firmware 0.3 / 9<br>
<br>
&gt;&gt;&gt;&gt; IBM T41<br>
$hciconfig -a hci0 version<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: XX:XX:XX:XX:XX:XX AC=
L MTU: 192:8 SCO MTU: 64:8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.1 (0x1) HCI Rev: 0x22=
2 LMP Ver: 1.1 (0x1) LMP Subver: 0x222<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon =
Radio (10)<br>
$hciconfig -a hci0 revision<br>
hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: XX:XX:XX:XX:XX:XX AC=
L MTU: 192:8 SCO MTU: 64:8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Build 546<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Chip version: BlueCore02-Externa=
l<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Max key size: 128 bit<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SCO mapping:&nbsp; HCI<br>
<br>
<br>
<br>
I am not sure if upgrade will work in the DBT-122 and in my notebook<br>
IBM T41. If someone has tips or references of how do this procedure<br>
please send me the links.<br>
<br>
<br>
Thanks in advance,<br>
Claudio<br>
<br>

------=_Part_11480_16206422.1127235154148--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

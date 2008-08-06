Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Aug 2008 10:52:02 +0800 (CST)
From: attaboyu <attaboyu@163.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <31785730.766411217991122657.JavaMail.coremail@bj163app113.163.com>
MIME-Version: 1.0
Subject: [Bluez-devel] bcsp_recv error while do hstest in bluez-utils-3.12
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1274931521=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1274931521==
Content-Type: multipart/alternative;
	boundary="----=_Part_203674_3952877.1217991122656"

------=_Part_203674_3952877.1217991122656
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit

Hi all

I meet some errors while run hstest in bluez-utils-3.12.

toolchain: kernel-2.6.10,bluez-libs/utils-3.12, CSR BC4 UART, i-tech BlueBAND

my board can connect the headset in rfcomm and sco level,but some bcsp_recv errors issue out while run hstest, here is the result:
[root@root bin]$hstest play cq.wav 00:0D:3C:E8:1A:AC 2
Voice setting: 0x0060
RFCOMM channel connected
SCO audio channel connected (handle 45, mtu 64)
bcsp_recv: Short BCSP packet
bcsp_recv: Checksum failed: computed ab42 received 9707
bcsp_recv: Short BCSP packet
bcsp_recv: Short BCSP packet
bcsp_recv: Short BCSP packet
bcsp_recv: Short BCSP packet
bcsp_recv: Error in BCSP hdr checksum
bcsp_recv: Short BCSP packet
bcsp_recv: Short BCSP packet

bcsp_recv: Checksum failed: computed 0dbc received fff2
bcsp_recv: Short BCSP packet
bcsp_recv: Short BCSP packet
bcsp_recv: Short BCSP packet
bcsp_recv: Short BCSP packet
.....

these errors never stop, and my headset can hear noise with no music
Is this the kernel version problem or anything else? how to solve it? 

 
 Thanks

--

 Best Regards
 ------------
 Tony

------=_Part_203674_3952877.1217991122656
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: quoted-printable

<div>Hi all<br><br>I meet some errors while run hstest in bluez-utils-3.12.=
<br><br>toolchain: kernel-2.6.10,bluez-libs/utils-3.12, CSR BC4 UART, i-tec=
h BlueBAND<br><br>my board can connect the headset in rfcomm and sco level,=
but some bcsp_recv errors issue out while run hstest, here is the result:<b=
r>[root@root bin]$hstest play cq.wav 00:0D:3C:E8:1A:AC 2<br>Voice setting: =
0x0060<br>RFCOMM channel connected<br>SCO audio channel connected (handle 4=
5, mtu 64)<br>bcsp_recv: Short BCSP packet<br>bcsp_recv: Checksum failed: c=
omputed ab42 received 9707<br>bcsp_recv: Short BCSP packet<br>bcsp_recv: Sh=
ort BCSP packet<br>bcsp_recv: Short BCSP packet<br>bcsp_recv: Short BCSP pa=
cket<br>bcsp_recv: Error in BCSP hdr checksum<br>bcsp_recv: Short BCSP pack=
et<br>bcsp_recv: Short BCSP packet<br></div><div>bcsp_recv: Checksum failed=
: computed 0dbc received fff2<br>bcsp_recv: Short BCSP packet<br>bcsp_recv:=
 Short BCSP packet<br>bcsp_recv: Short BCSP packet<br>bcsp_recv: Short BCSP=
 packet<br>......<br><br>these errors never stop, and my headset can hear n=
oise with no music<br>Is this the kernel version problem or anything else? =
how to solve it? <br></div><div>&nbsp;</div><div>&nbsp;Thanks</div><div><br=
>--<br>
<div>&nbsp;Best Regards<br>&nbsp;------------<br>&nbsp;Tony<br></div>
</div>
------=_Part_203674_3952877.1217991122656--



--===============1274931521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1274931521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1274931521==--

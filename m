Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Aug 2008 17:08:54 +0800 (CST)
From: attaboyu <attaboyu@163.com>
To: bluez-users <bluez-users@lists.sourceforge.net>
Message-ID: <31384302.881251219914534417.JavaMail.coremail@bj163app113.163.com>
MIME-Version: 1.0
Subject: [Bluez-users] noisey while run hstest
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1672374089=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1672374089==
Content-Type: multipart/alternative;
	boundary="----=_Part_234232_25895898.1219914534416"

------=_Part_234232_25895898.1219914534416
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit

 hi all

hstest is not working right, please let me break it down.

My platform: ARM, kernel-2.6.18, bluez-utils/libs-3.30

#hstest play angel44k8b.wav 00:0D:3C:E8:1A:AC 2     
Voice setting: 0x0060
RFCOMM channel connected
SCO audio channel connected (handle 45, mtu 64)
AT+VGS=12

Though the rfcomm and SCO are really connected. their is no sound but noise output from headset. here are some useful information list below.

#hcitool conn
Connections:
        < SCO 00:0D:3C:E8:1A:AC handle 46 state 1 lm SLAVE 
        < ACL 00:0D:3C:E8:1A:AC handle 43 state 1 lm MASTER ENCRYPT 

#hciconfig hci0 revision
hci0:   Type: UART
        BD Address: 00:06:6E:05:05:05 ACL MTU: 310:10 SCO MTU: 64:8
        Unified 21e
        Chip version: BlueCore4-ROM
        Max key size: 128 bit
        SCO mapping:  HCI

# hcitool info 00:0D:3C:E8:1A:AC
Requesting information ...
        BD Address:  00:0D:3C:E8:1A:AC
        Device Name: i.Tech BlueBAND R
        LMP Version: 2.0 (0x3) LMP Subversion: 0xd55
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
                <3-slot packets> <5-slot packets> <encryption> <slot offset> 
                <timing accuracy> <role switch> <hold mode> <sniff mode> 
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets> 
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme> 
                <power control> <transparent SCO> <broadcast encrypt> 
                <enhanced iscan> <interlaced iscan> <interlaced pscan> 
                <inquiry with RSSI> <AFH cap. slave> <AFH class. slave> 
                <AFH cap. master> <AFH class. master> <extended features> 

 
above all, I still can see some SCO packet through hcidump, but i cant here the right sound.

 
what's the problem of this and how to solve it?
Thanks in advance!

 

--

 Best Regards
 ------------
 Tony

------=_Part_234232_25895898.1219914534416
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: quoted-printable

<div>&nbsp;hi all<br><br>hstest is not working right, please let me break i=
t down.<br><br>My platform: ARM, kernel-2.6.18, bluez-utils/libs-3.30<br><b=
r>#hstest play angel44k8b.wav 00:0D:3C:E8:1A:AC 2&nbsp;&nbsp;&nbsp;&nbsp; <=
br>Voice setting: 0x0060<br>RFCOMM channel connected<br>SCO audio channel c=
onnected (handle 45, mtu 64)<br>AT+VGS=3D12<br><br><font color=3D"#f00000">=
Though the rfcomm and SCO are really connected. their is no sound but noise=
 output from headset.</font> here are some useful information list below.<b=
r><br>#hcitool conn<br>Connections:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; &lt; SCO 00:0D:3C:E8:1A:AC handle 46 state 1 lm SLAVE <br>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; ACL 00:0D:3C:E8:1A:AC handle 43 state=
 1 lm MASTER ENCRYPT <br><br>#hciconfig hci0 revision<br>hci0:&nbsp;&nbsp; =
Type: UART<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:06:=
6E:05:05:05 ACL MTU: 310:10 SCO MTU: 64:8<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; Unified 21e<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Chip=
 version: BlueCore4-ROM<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Max k=
ey size: 128 bit<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SCO mapping:=
&nbsp; HCI<br><br># hcitool info 00:0D:3C:E8:1A:AC<br>Requesting informatio=
n ...<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:&nbsp; 00:0D=
:3C:E8:1A:AC<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Name: i.T=
ech BlueBAND R<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LMP Version: 2=
0 (0x3) LMP Subversion: 0xd55<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; Manufacturer: Cambridge Silicon Radio (10)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80<br>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &lt;3-slot packets&gt; &lt;5-slot packets&gt; &lt;encryption&gt; =
&lt;slot offset&gt; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;timing accuracy&gt; &lt;role sw=
itch&gt; &lt;hold mode&gt; &lt;sniff mode&gt; <br>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;park =
state&gt; &lt;RSSI&gt; &lt;channel quality&gt; &lt;SCO link&gt; &lt;HV2 pac=
kets&gt; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-la=
w log&gt; &lt;CVSD&gt; &lt;paging scheme&gt; <br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;power =
control&gt; &lt;transparent SCO&gt; &lt;broadcast encrypt&gt; <br>&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; &lt;enhanced iscan&gt; &lt;interlaced iscan&gt; &lt;interlaced pscan=
&gt; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; &lt;inquiry with RSSI&gt; &lt;AFH cap. slave&gt; &=
lt;AFH class. slave&gt; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;AFH cap. master&gt; &lt;AFH=
 class. master&gt; &lt;extended features&gt; <br></div><div>&nbsp;<br>above=
 all, I still can see some SCO packet through hcidump, but i cant here the =
right sound.<br></div><div>&nbsp;<br>what's the problem of this and how to =
solve it?<br>Thanks in advance!<br></div><div>&nbsp;</div><div><br>--<br>
<div>&nbsp;Best Regards<br>&nbsp;------------<br>&nbsp;Tony<br></div>
</div>
------=_Part_234232_25895898.1219914534416--



--===============1672374089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1672374089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1672374089==--

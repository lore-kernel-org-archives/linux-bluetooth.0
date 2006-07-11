Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <5d780fb40607111038g67b04b44r988a4ae48a7b9c87@mail.gmail.com>
Date: Tue, 11 Jul 2006 19:38:39 +0200
From: jeanmary <jeanmary@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] btsco and samsung WAP200 headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0131409299=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0131409299==
Content-Type: multipart/alternative;
	boundary="----=_Part_51758_15367775.1152639519970"

------=_Part_51758_15367775.1152639519970
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello

I have a SAMSUNG WAP200 headset
and a logitech MX900 dongle

the probleme is that the recording is good but the ouput is rotted

i launch a sound :

aplay -B 1000000 -D plughw:Headset audiodump.wav

i wait, i dont touch the mouse... nothing... and the sound can be better...
and can will be rotted


thanks ...

JeanMary

jm@jmdesk:~$ hciconfig -a
hci0:   Type: USB
        BD Address: 00:07:61:13:5A:3D ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:6626904 acl:33043 sco:120351 events:199 errors:0
        TX bytes:6129300 acl:88 sco:120140 commands:63 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'jmdesk'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x34e LMP Ver: 1.1 (0x1) LMP Subver:
0x34e
        Manufacturer: Cambridge Silicon Radio (10)


jm@jmdesk:~$ sudo hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:07:61:13:5A:3D ACL MTU: 192:8 SCO MTU: 64:8
        Build 846
        Chip version: BlueCore02-External
        Max key size: 56 bit
        SCO mapping:  HCI

jm@jmdesk:~$ hcitool info 00:02:78:11:35:DF
Requesting information ...
        BD Address:  00:02:78:11:35:DF
        Device Name: Samsung WEP200
        LMP Version: 2.0 (0x3) LMP Subversion: 0x977
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xfe 0x0b 0x00 0x08 0x08 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>
                <hold mode> <sniff mode> <RSSI> <channel quality> <SCO link>
                <HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>
                <paging scheme> <transparent SCO> <AFH cap. slave>
                <AFH cap. master>











-- 
JM L

------=_Part_51758_15367775.1152639519970
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello<br><br>I have a SAMSUNG WAP200 headset<br clear="all">and a logitech MX900 dongle<br><br>the probleme is that the recording is good but the ouput is rotted<br><br>i launch a sound :<br><br>aplay -B 1000000 -D plughw:Headset 
audiodump.wav<br><br>i wait, i dont touch the mouse... nothing... and the sound can be better... and can will be rotted<br><br><br>thanks ...<br><br>JeanMary<br><br>jm@jmdesk:~$ hciconfig -a<br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:07:61:13:5A:3D ACL MTU: 192:8 SCO MTU: 64:8
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:6626904 acl:33043 sco:120351 events:199 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:6129300 acl:88 sco:120140 commands:63 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'jmdesk'<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x000000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Unspecified<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Miscellaneous,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.1 (0x1) HCI Rev: 0x34e LMP Ver: 1.1 (0x1) LMP Subver: 0x34e<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)<br><br><br>jm@jmdesk:~$ sudo hciconfig hci0 revision<br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:07:61:13:5A:3D ACL MTU: 192:8 SCO MTU: 64:8
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Build 846<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Chip version: BlueCore02-External<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Max key size: 56 bit<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SCO mapping:&nbsp; HCI<br><br>jm@jmdesk:~$ hcitool info 00:02:78:11:35:DF<br>Requesting information ...<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:&nbsp; 00:02:78:11:35:DF
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Name: Samsung WEP200<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LMP Version: 2.0 (0x3) LMP Subversion: 0x977<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xfc 0xfe 0x0b 0x00 0x08 0x08 0x00 0x00<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;encryption&gt; &lt;slot offset&gt; &lt;timing accuracy&gt; &lt;role switch&gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;hold mode&gt; &lt;sniff mode&gt; &lt;RSSI&gt; &lt;channel quality&gt; &lt;SCO link&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;HV2 packets&gt; &lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law log&gt; &lt;CVSD&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;paging scheme&gt; &lt;transparent SCO&gt; &lt;AFH cap. slave&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;AFH cap. master&gt;<br><br><br><br><br><br><br><br><br><br><br><br>-- <br>JM L 

------=_Part_51758_15367775.1152639519970--


--===============0131409299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============0131409299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0131409299==--

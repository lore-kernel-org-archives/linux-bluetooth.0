Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <85cea3460606101642u36494e12oe7c3f0749b0ab354@mail.gmail.com>
Date: Sat, 10 Jun 2006 19:42:19 -0400
From: "Sweta Vasudevan" <sweta.vasudevan@gmail.com>
To: Bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] btsco and connection problems
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1764807220=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1764807220==
Content-Type: multipart/alternative;
	boundary="----=_Part_1093_33464151.1149982939552"

------=_Part_1093_33464151.1149982939552
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

I am trying to get audio-bluetooth working on my linux system-I was hoping
that you could help me out with the errors I'm getting. I am using a Fedora
Core4  2.6.16 kernel, DLink DBT 120 USB(revision B3)  and Jabra BT 250
headset.

The headset is detected(hcitool scan), but I'm not able to connect to it:

[root@lirr ~]# hciconfig -a
hci0:   Type: USB
        BD Address: 00:0D:88:AC:18:A7 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:107 acl:0 sco:0 events:14 errors:0
        TX bytes:300 acl:0 sco:0 commands:13 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'lirr.cs.columbia.edu-0'
        Class: 0x120104
        Service Classes: Networking
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
0x20d
        Manufacturer: Cambridge Silicon Radio (10)

  [root@lirr ~]# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:0D:88:AC:18:A7 ACL MTU: 192:8 SCO MTU: 64:8
        HCI 16.4
        Chip version: BlueCore02-External
        Max key size: 56 bit
        SCO mapping:  HCI

[root@lirr ~]# hcitool info 00:07:A4:26:8D:3F
Requesting information ...
Can't create connection: Connection timed out

[root@lirr ~]# hcidump -X
HCI sniffer - Bluetooth packet analyzer ver 1.18
device: hci0 snap_len: 1028 filter: 0xffffffff
(this one hangs forever)

[root@lirr ~]# btsco 00:07:A4:26:8D:3F
Error: Failed to connect to SDP server: Function not implemented
Assuming channel 2

Can't connect RFCOMM channel: Resource temporarily unavailable

[root@lirr ~]# btsco -v 00:07:A4:26:8D:3F
btsco v0.42
Device is 1:0
Error: Failed to connect to SDP server: Function not implemented
Assuming channel 2

Voice setting: 0x0060
Can't connect RFCOMM channel: Resource temporarily unavailable


I made sure that hcid and sdpd are running.
I must be missing something obvious, but can't seem figure it out.

Thanks,
sv.

------=_Part_1093_33464151.1149982939552
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi all,</div>
<div>&nbsp;</div>
<div>I am trying to get audio-bluetooth working on my linux system-I
was hoping that you could help me out with the errors I'm getting. I am
using a Fedora Core4&nbsp; 2.6.16 kernel, DLink DBT 120
USB(revision&nbsp;B3) &nbsp;and Jabra BT 250 headset.&nbsp;
<br>&nbsp;<br>The headset is detected(hcitool scan), but I'm not able to connect to it:</div>
<div>&nbsp;<br>
[root@lirr ~]# hciconfig -a<br>
hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:0D:88:AC:18:A7 ACL MTU: 192:8 SCO MTU: 64:8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:107 acl:0 sco:0 events:14 errors:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:300 acl:0 sco:0 commands:13 errors:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'lirr.cs.columbia.edu-0'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x120104<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Networking<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Computer, Desktop workstation<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)<br>
<br>
</div>
<div>&nbsp;[root@lirr ~]# hciconfig hci0 revision<br>
hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:0D:88:AC:18:A7 ACL MTU: 192:8 SCO MTU: 64:8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI 16.4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Chip version: BlueCore02-External<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Max key size: 56 bit<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SCO mapping:&nbsp; HCI<br>
<br>
[root@lirr ~]# hcitool info 00:07:A4:26:8D:3F<br>
Requesting information ...<br>
Can't create connection: Connection timed out<br>
<br>
[root@lirr ~]# hcidump -X<br>
HCI sniffer - Bluetooth packet analyzer ver 1.18<br>
device: hci0 snap_len: 1028 filter: 0xffffffff<br>
(this one hangs forever)<br>
<br>
[root@lirr ~]# btsco 00:07:A4:26:8D:3F<br>
Error: Failed to connect to SDP server: Function not implemented<br>
Assuming channel 2<br>
<br>
Can't connect RFCOMM channel: Resource temporarily unavailable<br>
<br>
[root@lirr ~]# btsco -v 00:07:A4:26:8D:3F<br>
btsco v0.42<br>
Device is 1:0<br>
Error: Failed to connect to SDP server: Function not implemented<br>
Assuming channel 2<br>
<br>
Voice setting: 0x0060<br>
Can't connect RFCOMM channel: Resource temporarily unavailable<br>
<br>
<br>
I made sure that hcid and sdpd are running. <br>
I must be missing something obvious, but can't seem figure it out.<br>
<br>
Thanks,<br>
sv.<br>
</div>

------=_Part_1093_33464151.1149982939552--


--===============1764807220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1764807220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1764807220==--

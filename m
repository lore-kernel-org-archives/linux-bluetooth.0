Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060824203220.45688.qmail@web51413.mail.yahoo.com>
Date: Thu, 24 Aug 2006 13:32:20 -0700 (PDT)
From: manojt ambe <mp_tambe@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20060823224610.63128.qmail@web51415.mail.yahoo.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Receive audio from Motorola HS850 headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0114460515=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0114460515==
Content-Type: multipart/alternative; boundary="0-2122783598-1156451540=:43706"
Content-Transfer-Encoding: 8bit

--0-2122783598-1156451540=:43706
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi All,
   
  I came across hstest program. It is able to connect to RFCOMM and SCO channels with HS850. I also see AT+VGS=15 command and few beeps. But i am not able to hear audio. Also i cannot playback recorded file. I see SCO packets in hcidump output while both playing and recording. 
  Pls help. 
   
  I am using following commands,
  ./hstest play KDE_startup_new.wav <bt_add> 1
  ./hstest record a.wav <bt_addr> 1
   
  Regards,
  Manoj

manojt ambe <mp_tambe@yahoo.com> wrote:
  Hello,

I want to receive audio from HS850 headset. I have
connected RFCOMM channel 3 and able to receive AT
command when key is pressed. But when i try to connect
SCO channel using SCO socket program on channel 1, i
get "No Route found (113)". I am using bluez 3.1.
Has anyone seen similar issue? Are there any special
tests needed to do this?

Pls let me know. I have pasted sdptool and hcidump
outputs below.

regards,
Manoj


The sdptool records gives follwing output.

Service Name: Headset
Service RecHandle: 0x10000
Service Class ID List:
"Headset" (0x1108)
"Generic Audio" (0x1203)
Protocol Descriptor List:
"L2CAP" (0x0100)
"RFCOMM" (0x0003)
Channel: 1
Profile Descriptor List:
"Headset" (0x1108)
Version: 0x0100

Service Name: Hands-Free unit
Service RecHandle: 0x10001
Service Class ID List:
"Handsfree" (0x111e)
"Generic Audio" (0x1203)
Protocol Descriptor List:
"L2CAP" (0x0100)
"RFCOMM" (0x0003)
Channel: 2
Profile Descriptor List:
"Handsfree" (0x111e)
Version: 0x0101

Service Name: Serial Command
Service RecHandle: 0x10002
Service Class ID List:
"Serial Port" (0x1101)
"Generic Audio" (0x1203)
Protocol Descriptor List:
"L2CAP" (0x0100)
"RFCOMM" (0x0003)
Channel: 3
Profile Descriptor List:
"Serial Port" (0x1101)
Version: 0x0100

[root@dhcp-10-2-201-204 root]# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.31
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
bdaddr 00:13:17:03:46:88 ptype 0xcc18 rswitch 0x01
clkoffset 0x0000
Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
bdaddr 00:13:17:03:46:88
< HCI Command: Link Key Request Reply (0x01|0x000b)
plen 22
bdaddr 00:13:17:03:46:88 key
9B5BBF681BF037F70F25654204DB5E99
> HCI Event: Command Complete (0x0e) plen 10
Link Key Request Reply (0x01|0x000b) ncmd 1
status 0x00 bdaddr 00:13:17:03:46:88
> HCI Event: Connect Complete (0x03) plen 11
status 0x00 handle 41 bdaddr 00:13:17:03:46:88
type ACL encrypt 0x01
< ACL data: handle 41 flags 0x02 dlen 12
L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings
(0x02|0x000d) plen 4
handle 41 policy 0x0f
Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 41 packets 1
> HCI Event: Command Complete (0x0e) plen 6
Write Link Policy Settings (0x02|0x000d) ncmd 1
status 0x00 handle 41
< HCI Command: Remote Name Request (0x01|0x0019) plen
10
bdaddr 00:13:17:03:46:88 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
Remote Name Request (0x01|0x0019) status 0x00 ncmd
1
> ACL data: handle 41 flags 0x02 dlen 16
L2CAP(s): Connect rsp: dcid 0x026a scid 0x0040
result 1 status 2
Connection pending - Authorization pending
> HCI Event: Remote Name Req Complete (0x07) plen 255
status 0x00 bdaddr 00:13:17:03:46:88 name
'Motorola HS850'
> ACL data: handle 41 flags 0x02 dlen 16
L2CAP(s): Connect rsp: dcid 0x026a scid 0x0040
result 0 status 0
Connection successful
< ACL data: handle 41 flags 0x02 dlen 16
L2CAP(s): Config req: dcid 0x026a flags 0x00 clen
4
MTU 1024
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 14
L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 0
Success
> ACL data: handle 41 flags 0x02 dlen 16
L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
4
MTU 1024
< ACL data: handle 41 flags 0x02 dlen 14
L2CAP(s): Config rsp: scid 0x026a flags 0x00
result 0 clen 0
Success
< ACL data: handle 41 flags 0x02 dlen 8
L2CAP(d): cid 0x026a len 4 [psm 3]
RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs
0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 8
L2CAP(d): cid 0x0040 len 4 [psm 3]
RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 41 flags 0x02 dlen 18
L2CAP(d): cid 0x026a len 14 [psm 3]
RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs
0x70 mcc_len 8
dlci 6 frame_type 0 credit_flow 15 pri 0
ack_timer 0
frame_size 1019 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 17
> ACL data: handle 41 flags 0x01 dlen 1
L2CAP(d): cid 0x0040 len 14 [psm 3]
RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs
0xaa mcc_len 8
dlci 6 frame_type 0 credit_flow 14 pri 0
ack_timer 0
frame_size 127 max_retrans 0 credits 0
< ACL data: handle 41 flags 0x02 dlen 8
L2CAP(d): cid 0x026a len 4 [psm 3]
RFCOMM(s): SABM: cr 1 dlci 6 pf 1 ilen 0 fcs
0xd3
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 8
L2CAP(d): cid 0x0040 len 4 [psm 3]
RFCOMM(s): UA: cr 1 dlci 6 pf 1 ilen 0 fcs 0x18
< ACL data: handle 41 flags 0x02 dlen 12
L2CAP(d): cid 0x026a len 8 [psm 3]
RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs
0x70 mcc_len 2
dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0
len 0
< ACL data: handle 41 flags 0x02 dlen 9
L2CAP(d): cid 0x026a len 5 [psm 3]
RFCOMM(d): UIH: cr 1 dlci 6 pf 1 ilen 0 fcs 0x93
credits 33
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
L2CAP(d): cid 0x0040 len 8 [psm 3]
RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs
0xaa mcc_len 2
dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0
len 0
< ACL data: handle 41 flags 0x02 dlen 12
L2CAP(d): cid 0x026a len 8 [psm 3]
RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs
0x70 mcc_len 2
dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0
len 0
> ACL data: handle 41 flags 0x02 dlen 12
L2CAP(d): cid 0x0040 len 8 [psm 3]
RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs
0xaa mcc_len 2
dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0
len 0
> ACL data: handle 41 flags 0x02 dlen 9
L2CAP(d): cid 0x0040 len 5 [psm 3]
RFCOMM(d): UIH: cr 0 dlci 6 pf 1 ilen 0 fcs 0x49
credits 15
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 17
> ACL data: handle 41 flags 0x01 dlen 1
L2CAP(d): cid 0x0040 len 14 [psm 3]
RFCOMM(d): UIH: cr 0 dlci 6 pf 0 ilen 10 fcs
0x55
0000: 41 54 2a 4b 45 59 3d 31 30 0d 
AT*KEY=10.
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
Read Voice Setting (0x03|0x0025) ncmd 1
status 0x00 voice setting 0x0060



__________________________________________________
Do You Yahoo!?
Tired of spam? Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


 		
---------------------------------
Talk is cheap. Use Yahoo! Messenger to make PC-to-Phone calls.  Great rates starting at 1¢/min.
--0-2122783598-1156451540=:43706
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi All,</div>  <div>&nbsp;</div>  <div>I&nbsp;came across&nbsp;hstest program. It is able to connect to RFCOMM and SCO channels with HS850. I also see AT+VGS=15 command and few beeps. But i am not able to hear audio. Also i cannot playback recorded file.&nbsp;I see SCO packets in hcidump output while both playing and recording. </div>  <div>Pls help. </div>  <div>&nbsp;</div>  <div>I am using following commands,</div>  <div>./hstest play KDE_startup_new.wav &lt;bt_add&gt; 1</div>  <div>./hstest record a.wav &lt;bt_addr&gt; 1</div>  <div>&nbsp;</div>  <div>Regards,</div>  <div>Manoj<BR><BR><B><I>manojt ambe &lt;mp_tambe@yahoo.com&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hello,<BR><BR>I want to receive audio from HS850 headset. I have<BR>connected RFCOMM channel 3 and able to receive AT<BR>command when key is pressed. But when i try to connect<BR>SCO channel using SCO socket program on
 channel 1, i<BR>get "No Route found (113)". I am using bluez 3.1.<BR>Has anyone seen similar issue? Are there any special<BR>tests needed to do this?<BR><BR>Pls let me know. I have pasted sdptool and hcidump<BR>outputs below.<BR><BR>regards,<BR>Manoj<BR><BR><BR>The sdptool records <BT ADDR>gives follwing output.<BR><BR>Service Name: Headset<BR>Service RecHandle: 0x10000<BR>Service Class ID List:<BR>"Headset" (0x1108)<BR>"Generic Audio" (0x1203)<BR>Protocol Descriptor List:<BR>"L2CAP" (0x0100)<BR>"RFCOMM" (0x0003)<BR>Channel: 1<BR>Profile Descriptor List:<BR>"Headset" (0x1108)<BR>Version: 0x0100<BR><BR>Service Name: Hands-Free unit<BR>Service RecHandle: 0x10001<BR>Service Class ID List:<BR>"Handsfree" (0x111e)<BR>"Generic Audio" (0x1203)<BR>Protocol Descriptor List:<BR>"L2CAP" (0x0100)<BR>"RFCOMM" (0x0003)<BR>Channel: 2<BR>Profile Descriptor List:<BR>"Handsfree" (0x111e)<BR>Version: 0x0101<BR><BR>Service Name: Serial Command<BR>Service RecHandle: 0x10002<BR>Service Class ID
 List:<BR>"Serial Port" (0x1101)<BR>"Generic Audio" (0x1203)<BR>Protocol Descriptor List:<BR>"L2CAP" (0x0100)<BR>"RFCOMM" (0x0003)<BR>Channel: 3<BR>Profile Descriptor List:<BR>"Serial Port" (0x1101)<BR>Version: 0x0100<BR><BR>[root@dhcp-10-2-201-204 root]# hcidump -X -V<BR>HCI sniffer - Bluetooth packet analyzer ver 1.31<BR>device: hci0 snap_len: 1028 filter: 0xffffffff<BR>&lt; HCI Command: Create Connection (0x01|0x0005) plen 13<BR>bdaddr 00:13:17:03:46:88 ptype 0xcc18 rswitch 0x01<BR>clkoffset 0x0000<BR>Packet type: DM1 DM3 DM5 DH1 DH3 DH5<BR>&gt; HCI Event: Command Status (0x0f) plen 4<BR>Create Connection (0x01|0x0005) status 0x00 ncmd 1<BR>&gt; HCI Event: Link Key Request (0x17) plen 6<BR>bdaddr 00:13:17:03:46:88<BR>&lt; HCI Command: Link Key Request Reply (0x01|0x000b)<BR>plen 22<BR>bdaddr 00:13:17:03:46:88 key<BR>9B5BBF681BF037F70F25654204DB5E99<BR>&gt; HCI Event: Command Complete (0x0e) plen 10<BR>Link Key Request Reply (0x01|0x000b) ncmd 1<BR>status 0x00 bdaddr
 00:13:17:03:46:88<BR>&gt; HCI Event: Connect Complete (0x03) plen 11<BR>status 0x00 handle 41 bdaddr 00:13:17:03:46:88<BR>type ACL encrypt 0x01<BR>&lt; ACL data: handle 41 flags 0x02 dlen 12<BR>L2CAP(s): Connect req: psm 3 scid 0x0040<BR>&lt; HCI Command: Write Link Policy Settings<BR>(0x02|0x000d) plen 4<BR>handle 41 policy 0x0f<BR>Link policy: RSWITCH HOLD SNIFF PARK<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>handle 41 packets 1<BR>&gt; HCI Event: Command Complete (0x0e) plen 6<BR>Write Link Policy Settings (0x02|0x000d) ncmd 1<BR>status 0x00 handle 41<BR>&lt; HCI Command: Remote Name Request (0x01|0x0019) plen<BR>10<BR>bdaddr 00:13:17:03:46:88 mode 2 clkoffset 0x0000<BR>&gt; HCI Event: Command Status (0x0f) plen 4<BR>Remote Name Request (0x01|0x0019) status 0x00 ncmd<BR>1<BR>&gt; ACL data: handle 41 flags 0x02 dlen 16<BR>L2CAP(s): Connect rsp: dcid 0x026a scid 0x0040<BR>result 1 status 2<BR>Connection pending - Authorization pending<BR>&gt; HCI
 Event: Remote Name Req Complete (0x07) plen 255<BR>status 0x00 bdaddr 00:13:17:03:46:88 name<BR>'Motorola HS850'<BR>&gt; ACL data: handle 41 flags 0x02 dlen 16<BR>L2CAP(s): Connect rsp: dcid 0x026a scid 0x0040<BR>result 0 status 0<BR>Connection successful<BR>&lt; ACL data: handle 41 flags 0x02 dlen 16<BR>L2CAP(s): Config req: dcid 0x026a flags 0x00 clen<BR>4<BR>MTU 1024<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>handle 41 packets 1<BR>&gt; ACL data: handle 41 flags 0x02 dlen 14<BR>L2CAP(s): Config rsp: scid 0x0040 flags 0x00<BR>result 0 clen 0<BR>Success<BR>&gt; ACL data: handle 41 flags 0x02 dlen 16<BR>L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen<BR>4<BR>MTU 1024<BR>&lt; ACL data: handle 41 flags 0x02 dlen 14<BR>L2CAP(s): Config rsp: scid 0x026a flags 0x00<BR>result 0 clen 0<BR>Success<BR>&lt; ACL data: handle 41 flags 0x02 dlen 8<BR>L2CAP(d): cid 0x026a len 4 [psm 3]<BR>RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs<BR>0x1c<BR>&gt; HCI Event:
 Number of Completed Packets (0x13) plen 5<BR>handle 41 packets 1<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>handle 41 packets 1<BR>&gt; ACL data: handle 41 flags 0x02 dlen 8<BR>L2CAP(d): cid 0x0040 len 4 [psm 3]<BR>RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7<BR>&lt; ACL data: handle 41 flags 0x02 dlen 18<BR>L2CAP(d): cid 0x026a len 14 [psm 3]<BR>RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs<BR>0x70 mcc_len 8<BR>dlci 6 frame_type 0 credit_flow 15 pri 0<BR>ack_timer 0<BR>frame_size 1019 max_retrans 0 credits 7<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>handle 41 packets 1<BR>&gt; ACL data: handle 41 flags 0x02 dlen 17<BR>&gt; ACL data: handle 41 flags 0x01 dlen 1<BR>L2CAP(d): cid 0x0040 len 14 [psm 3]<BR>RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs<BR>0xaa mcc_len 8<BR>dlci 6 frame_type 0 credit_flow 14 pri 0<BR>ack_timer 0<BR>frame_size 127 max_retrans 0 credits 0<BR>&lt; ACL data: handle 41 flags 0x02 dlen 8<BR>L2CAP(d):
 cid 0x026a len 4 [psm 3]<BR>RFCOMM(s): SABM: cr 1 dlci 6 pf 1 ilen 0 fcs<BR>0xd3<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>handle 41 packets 1<BR>&gt; ACL data: handle 41 flags 0x02 dlen 8<BR>L2CAP(d): cid 0x0040 len 4 [psm 3]<BR>RFCOMM(s): UA: cr 1 dlci 6 pf 1 ilen 0 fcs 0x18<BR>&lt; ACL data: handle 41 flags 0x02 dlen 12<BR>L2CAP(d): cid 0x026a len 8 [psm 3]<BR>RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs<BR>0x70 mcc_len 2<BR>dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0<BR>len 0<BR>&lt; ACL data: handle 41 flags 0x02 dlen 9<BR>L2CAP(d): cid 0x026a len 5 [psm 3]<BR>RFCOMM(d): UIH: cr 1 dlci 6 pf 1 ilen 0 fcs 0x93<BR>credits 33<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>handle 41 packets 1<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>handle 41 packets 1<BR>&gt; ACL data: handle 41 flags 0x02 dlen 12<BR>L2CAP(d): cid 0x0040 len 8 [psm 3]<BR>RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs<BR>0xaa mcc_len
 2<BR>dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0<BR>len 0<BR>&lt; ACL data: handle 41 flags 0x02 dlen 12<BR>L2CAP(d): cid 0x026a len 8 [psm 3]<BR>RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs<BR>0x70 mcc_len 2<BR>dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0<BR>len 0<BR>&gt; ACL data: handle 41 flags 0x02 dlen 12<BR>L2CAP(d): cid 0x0040 len 8 [psm 3]<BR>RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs<BR>0xaa mcc_len 2<BR>dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0<BR>len 0<BR>&gt; ACL data: handle 41 flags 0x02 dlen 9<BR>L2CAP(d): cid 0x0040 len 5 [psm 3]<BR>RFCOMM(d): UIH: cr 0 dlci 6 pf 1 ilen 0 fcs 0x49<BR>credits 15<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>handle 41 packets 1<BR>&gt; ACL data: handle 41 flags 0x02 dlen 17<BR>&gt; ACL data: handle 41 flags 0x01 dlen 1<BR>L2CAP(d): cid 0x0040 len 14 [psm 3]<BR>RFCOMM(d): UIH: cr 0 dlci 6 pf 0 ilen 10 fcs<BR>0x55<BR>0000: 41 54 2a 4b 45 59 3d 31 30 0d <BR>AT*KEY=10.<BR>&lt; HCI
 Command: Read Voice Setting (0x03|0x0025) plen 0<BR>&gt; HCI Event: Command Complete (0x0e) plen 6<BR>Read Voice Setting (0x03|0x0025) ncmd 1<BR>status 0x00 voice setting 0x0060<BR><BR><BR><BR>__________________________________________________<BR>Do You Yahoo!?<BR>Tired of spam? Yahoo! Mail has the best spam protection around <BR>http://mail.yahoo.com <BR><BR>-------------------------------------------------------------------------<BR>Using Tomcat but need to do more? Need to support web services, security?<BR>Get stuff done quickly with pre-integrated technology to make your job easier<BR>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo<BR>http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642<BR>_______________________________________________<BR>Bluez-users mailing list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE><BR><p>&#32;
		<hr size=1>Talk is cheap. Use Yahoo! Messenger to make PC-to-Phone calls. <a href="http://us.rd.yahoo.com/mail_us/taglines/postman7/*http://us.rd.yahoo.com/evt=39666/*http://messenger.yahoo.com"> Great rates starting at 1¢/min.
--0-2122783598-1156451540=:43706--


--===============0114460515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0114460515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0114460515==--

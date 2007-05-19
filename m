Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <917e3ae00705190555r5bc43884t3cbb517ccbb18550@mail.gmail.com>
Date: Sat, 19 May 2007 08:55:42 -0400
From: "Devin Steffler" <devinsteffler@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] interpret hcidump
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1034276049=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1034276049==
Content-Type: multipart/alternative;
	boundary="----=_Part_80444_9027261.1179579342463"

------=_Part_80444_9027261.1179579342463
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I apologize if this is not an appropriate question but I'm stumped trying to
figure out what hcidump is trying to tell me.  I posted my entire problem
here:
http://forums.gentoo.org/viewtopic-p-4064123.html#4064123

Basically my Palm is making a PPP request to my Linux machine and the Linux
machine seems to be dropping the ball.

Here's what hcidump -X -V is reporting:
tux devin # hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.30
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
bdaddr 00:06:56:xx:xx:xx class 0x020114 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
bdaddr 00:06:56:xx:xx:xx role 0x01
Role: Slave
> HCI Event: Command Status (0x0f) plen 4
Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
bdaddr 00:06:56:xx:xx:xx
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
bdaddr 00:06:56:xx:xx:xx key ED8E036AB173DCDE8448B3A9E4FB10D9
> HCI Event: Command Complete (0x0e) plen 10
Link Key Request Reply (0x01|0x000b) ncmd 1
status 0x00 bdaddr 00:06:56:xx:xx:xx
> HCI Event: Connect Complete (0x03) plen 11
status 0x00 handle 1 bdaddr 00:06:56:xx:xx:xx type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
handle 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
status 0x00 handle 1 ptype 0x0018
Packet type: DM1 DH1
> HCI Event: Command Status (0x0f) plen 4
Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
handle 1 policy 0x0f
Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
Write Link Policy Settings (0x02|0x000d) ncmd 1
status 0x00 handle 1
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
handle 1 ptype 0xcc18
Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> ACL data: handle 1 flags 0x02 dlen 12
L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 1 flags 0x02 dlen 16
L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
Connection successful
> HCI Event: Command Status (0x0f) plen 4
Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
status 0x00 handle 1 ptype 0x0018
Packet type: DM1 DH1
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 1 packets 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
status 0x00 handle 1
Features: 0x04 0xea 0x31 0x00 0x00 0x00 0x00 0x00
> ACL data: handle 1 flags 0x02 dlen 16
L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
MTU 512
< ACL data: handle 1 flags 0x02 dlen 18
L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
Success
MTU 512
< ACL data: handle 1 flags 0x02 dlen 12
L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 14
L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
Success
> ACL data: handle 1 flags 0x02 dlen 28
L2CAP(d): cid 0x0040 len 24 [psm 1]
SDP SSA Req: tid 0x1 len 0x13
pat uuid-16 0x1103 (DUN)
max 512
aid(s) 0x0000 (SrvRecHndl) 0x0004 (ProtocolDescList) 0x0100 (SrvName)
cont 00
< ACL data: handle 1 flags 0x02 dlen 64
L2CAP(d): cid 0x0040 len 60 [psm 1]
SDP SSA Rsp: tid 0x1 len 0x37
count 52
record #0
aid 0x0000 (SrvRecHndl)
uint 0x10003
aid 0x0004 (ProtocolDescList)
< < uuid-16 0x0100 (L2CAP) > <
uuid-16 0x0003 (RFCOMM) uint 0x2 > >
aid 0x0100 (SrvName)
str "Dial-Up Networking"
cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
L2CAP(s): Connect req: psm 3 scid 0x0041
< ACL data: handle 1 flags 0x02 dlen 16
L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 16
L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
MTU 251
< ACL data: handle 1 flags 0x02 dlen 18
L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
Success
MTU 251
< ACL data: handle 1 flags 0x02 dlen 16
L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
MTU 1013
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 14
L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
Success
> ACL data: handle 1 flags 0x02 dlen 8
L2CAP(d): cid 0x0041 len 4 [psm 3]
RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 1 flags 0x02 dlen 8
L2CAP(d): cid 0x0041 len 4 [psm 3]
RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 19
L2CAP(d): cid 0x0041 len 15 [psm 3]
RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
dlci 4 frame_type 0 credit_flow 0 pri 0 ack_timer 0
frame_size 246 max_retrans 0 credits 0
< ACL data: handle 1 flags 0x02 dlen 8
L2CAP(d): cid 0x0041 len 4 [psm 3]
RFCOMM(s): DM: cr 1 dlci 4 pf 1 ilen 0 fcs 0xbc
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 8
L2CAP(d): cid 0x0041 len 4 [psm 3]
RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 1 flags 0x02 dlen 8
L2CAP(d): cid 0x0041 len 4 [psm 3]
RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
< ACL data: handle 1 flags 0x02 dlen 12
L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 1 flags 0x02 dlen 12
L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
handle 1 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
status 0x00 handle 1 reason 0x13
Reason: Remote User Terminated Connection

Any ideas?

Thanks,
Devin

------=_Part_80444_9027261.1179579342463
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br>
<br>
I apologize if this is not an appropriate question but I&#39;m stumped
trying to figure out what hcidump is trying to tell me.&nbsp; I posted my
entire problem here:<br>
<a href="http://forums.gentoo.org/viewtopic-p-4064123.html#4064123">http://forums.gentoo.org/viewtopic-p-4064123.html#4064123</a><br>
<br>
Basically my Palm is making a PPP request to my Linux machine and the Linux machine seems to be dropping the ball.<br>
<br>
Here&#39;s what hcidump -X -V is reporting:<br>
tux devin # hcidump -X -V
<br>

HCI sniffer - Bluetooth packet analyzer ver 1.30
<br>

device: hci0 snap_len: 1028 filter: 0xffffffff
<br>

&gt; HCI Event: Connect Request (0x04) plen 10
<br>

    bdaddr 00:06:56:xx:xx:xx class 0x020114 type ACL
<br>

&lt; HCI Command: Accept Connection Request (0x01|0x0009) plen 7
<br>

    bdaddr 00:06:56:xx:xx:xx role 0x01
<br>

    Role: Slave
<br>

&gt; HCI Event: Command Status (0x0f) plen 4
<br>

    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
<br>

&gt; HCI Event: Link Key Request (0x17) plen 6
<br>

    bdaddr 00:06:56:xx:xx:xx
<br>

&lt; HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
<br>

    bdaddr 00:06:56:xx:xx:xx key ED8E036AB173DCDE8448B3A9E4FB10D9
<br>

&gt; HCI Event: Command Complete (0x0e) plen 10
<br>

    Link Key Request Reply (0x01|0x000b) ncmd 1
<br>

    status 0x00 bdaddr 00:06:56:xx:xx:xx
<br>

&gt; HCI Event: Connect Complete (0x03) plen 11
<br>

    status 0x00 handle 1 bdaddr 00:06:56:xx:xx:xx type ACL encrypt 0x00
<br>

&lt; HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
<br>

    handle 1
<br>

&gt; HCI Event: Connection Packet Type Changed (0x1d) plen 5
<br>

    status 0x00 handle 1 ptype 0x0018
<br>

    Packet type: DM1 DH1 
<br>

&gt; HCI Event: Command Status (0x0f) plen 4
<br>

    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
<br>

&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
<br>

    handle 1 policy 0x0f
<br>

    Link policy: RSWITCH HOLD SNIFF PARK 
<br>

&gt; HCI Event: Command Complete (0x0e) plen 6
<br>

    Write Link Policy Settings (0x02|0x000d) ncmd 1
<br>

    status 0x00 handle 1
<br>

&lt; HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
<br>

    handle 1 ptype 0xcc18
<br>

    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
<br>

&gt; ACL data: handle 1 flags 0x02 dlen 12
<br>

    L2CAP(s): Connect req: psm 1 scid 0x0040
<br>

&lt; ACL data: handle 1 flags 0x02 dlen 16
<br>

    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
<br>

      Connection successful
<br>

&gt; HCI Event: Command Status (0x0f) plen 4
<br>

    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
<br>

&gt; HCI Event: Connection Packet Type Changed (0x1d) plen 5
<br>

    status 0x00 handle 1 ptype 0x0018
<br>

    Packet type: DM1 DH1 
<br>

&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>

    handle 1 packets 1
<br>

&gt; HCI Event: Read Remote Supported Features (0x0b) plen 11
<br>

    status 0x00 handle 1
<br>

    Features: 0x04 0xea 0x31 0x00 0x00 0x00 0x00 0x00
<br>

&gt; ACL data: handle 1 flags 0x02 dlen 16
<br>

    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
<br>

      MTU 512 
<br>

&lt; ACL data: handle 1 flags 0x02 dlen 18
<br>

    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
<br>

      Success
<br>

      MTU 512 
<br>

&lt; ACL data: handle 1 flags 0x02 dlen 12
<br>

    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
<br>

&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>

    handle 1 packets 1
<br>

&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>

    handle 1 packets 1
<br>

&gt; ACL data: handle 1 flags 0x02 dlen 14
<br>

    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
<br>

      Success
<br>

&gt; ACL data: handle 1 flags 0x02 dlen 28
<br>

    L2CAP(d): cid 0x0040 len 24 [psm 1]
<br>

        SDP SSA Req: tid 0x1 len 0x13
<br>

          pat uuid-16 0x1103 (DUN)
<br>

          max 512
<br>

          aid(s) 0x0000 (SrvRecHndl) 0x0004 (ProtocolDescList) 0x0100 (SrvName)
<br>

          cont 00
<br>

&lt; ACL data: handle 1 flags 0x02 dlen 64
<br>

    L2CAP(d): cid 0x0040 len 60 [psm 1]
<br>

        SDP SSA Rsp: tid 0x1 len 0x37
<br>

          count 52
<br>

          record #0
<br>

              aid 0x0000 (SrvRecHndl)
<br>

                 uint 0x10003
<br>

              aid 0x0004 (ProtocolDescList)
<br>

                 &lt; &lt; uuid-16 0x0100 (L2CAP) &gt; &lt;
<br>

                 uuid-16 0x0003 (RFCOMM) uint 0x2 &gt; &gt;
<br>

              aid 0x0100 (SrvName)
<br>

                 str &quot;Dial-Up Networking&quot;
<br>

          cont 00
<br>

&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>

    handle 1 packets 1
<br>

&gt; ACL data: handle 1 flags 0x02 dlen 12
<br>

    L2CAP(s): Connect req: psm 3 scid 0x0041
<br>

&lt; ACL data: handle 1 flags 0x02 dlen 16
<br>

    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
<br>

      Connection successful
<br>

&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>

    handle 1 packets 1
<br>

&gt; ACL data: handle 1 flags 0x02 dlen 16
<br>

    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
<br>

      MTU 251 
<br>

&lt; ACL data: handle 1 flags 0x02 dlen 18
<br>

    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
<br>

      Success
<br>

      MTU 251 
<br>

&lt; ACL data: handle 1 flags 0x02 dlen 16
<br>

    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
<br>

      MTU 1013 
<br>

&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>

    handle 1 packets 1
<br>

&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>

    handle 1 packets 1
<br>

&gt; ACL data: handle 1 flags 0x02 dlen 14
<br>

    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
<br>

      Success
<br>

&gt; ACL data: handle 1 flags 0x02 dlen 8
<br>

    L2CAP(d): cid 0x0041 len 4 [psm 3]
<br>

      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
<br>

&lt; ACL data: handle 1 flags 0x02 dlen 8
<br>

    L2CAP(d): cid 0x0041 len 4 [psm 3]
<br>

      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
<br>

&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>

    handle 1 packets 1
<br>

&gt; ACL data: handle 1 flags 0x02 dlen 19
<br>

    L2CAP(d): cid 0x0041 len 15 [psm 3]
<br>

      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
<br>

      dlci 4 frame_type 0 credit_flow 0 pri 0 ack_timer 0
<br>

      frame_size 246 max_retrans 0 credits 0
<br>

&lt; ACL data: handle 1 flags 0x02 dlen 8
<br>

    L2CAP(d): cid 0x0041 len 4 [psm 3]
<br>

      RFCOMM(s): DM: cr 1 dlci 4 pf 1 ilen 0 fcs 0xbc 
<br>

&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>

    handle 1 packets 1
<br>

&gt; ACL data: handle 1 flags 0x02 dlen 8
<br>

    L2CAP(d): cid 0x0041 len 4 [psm 3]
<br>

      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd 
<br>

&lt; ACL data: handle 1 flags 0x02 dlen 8
<br>

    L2CAP(d): cid 0x0041 len 4 [psm 3]
<br>

      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
<br>

&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>

    handle 1 packets 1
<br>

&gt; ACL data: handle 1 flags 0x02 dlen 12
<br>

    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
<br>

&lt; ACL data: handle 1 flags 0x02 dlen 12
<br>

    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
<br>

&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>

    handle 1 packets 1
<br>

&gt; ACL data: handle 1 flags 0x02 dlen 12
<br>

    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
<br>

&lt; ACL data: handle 1 flags 0x02 dlen 12
<br>

    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
<br>

&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>

    handle 1 packets 1
<br>

&gt; HCI Event: Disconn Complete (0x05) plen 4
<br>

    status 0x00 handle 1 reason 0x13
<br>

    Reason: Remote User Terminated Connection<br>
<br>
Any ideas?<br>
<br>
Thanks,<br>
Devin<br>
<br>

------=_Part_80444_9027261.1179579342463--


--===============1034276049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1034276049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1034276049==--

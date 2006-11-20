Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: <bluez-users@lists.sourceforge.net>
Date: Mon, 20 Nov 2006 17:15:36 +0530
Message-ID: <00b501c70c99$65404970$8935c70a@dlh.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00B6_01C70CC7.7EF88570"
Subject: [Bluez-users] L2CAP disconnect problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_00B6_01C70CC7.7EF88570
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi
I am testing a HS-Gateway application. I have a listening thread which =
waits for incoming HS connection. I am using=20

        sk =3D socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
		then bind and then waiting on accept()

Now connection is successful but when I disconnect I see the RFCOMM =
channel disconnecting but then L2CAP doesn't disconnect. After a UA is =
received there is no L2CAP disc which I am expecting. Anybody faced this =
problem before?=20

Listening thread code is referenced from scotest.c but it doesn't =
work..:(

hcidump log is attached.

Thanks,
Sumeet


------=_NextPart_000_00B6_01C70CC7.7EF88570
Content-Type: text/plain;
	name="log2.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="log2.txt"

HCI sniffer - Bluetooth packet analyzer ver 1.30=0A=
device: hci1 snap_len: 1028 filter: 0xffffffff=0A=
> HCI Event: Connect Request (0x04) plen 10=0A=
    bdaddr 00:03:35:11:44:22 class 0x200404 type ACL=0A=
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7=0A=
    bdaddr 00:03:35:11:44:22 role 0x01=0A=
    Role: Slave=0A=
> HCI Event: Command Status (0x0f) plen 4=0A=
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 2=0A=
> HCI Event: Connect Complete (0x03) plen 11=0A=
    status 0x00 handle 1 bdaddr 00:03:35:11:44:22 type ACL encrypt 0x00=0A=
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4=0A=
    handle 1 policy 0x0f=0A=
    Link policy: RSWITCH HOLD SNIFF PARK =0A=
> HCI Event: Max Slots Change (0x1b) plen 3=0A=
    handle 1 slots 5=0A=
> HCI Event: Command Complete (0x0e) plen 6=0A=
    Write Link Policy Settings (0x02|0x000d) ncmd 2=0A=
    status 0x00 handle 1=0A=
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4=0A=
    handle 1 ptype 0x0018=0A=
    Packet type: DM1 DH1 =0A=
> HCI Event: Command Status (0x0f) plen 4=0A=
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1=0A=
> ACL data: handle 1 flags 0x02 dlen 12=0A=
    L2CAP(s): Connect req: psm 1 scid 0x0040=0A=
< ACL data: handle 1 flags 0x02 dlen 16=0A=
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0=0A=
      Connection successful=0A=
> HCI Event: Connection Packet Type Changed (0x1d) plen 5=0A=
    status 0x00 handle 1 ptype 0x0018=0A=
    Packet type: DM1 DH1 =0A=
> HCI Event: Command Status (0x0f) plen 4=0A=
    Unknown (0x00|0x0000) status 0x00 ncmd 2=0A=
> HCI Event: Max Slots Change (0x1b) plen 3=0A=
    handle 1 slots 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> ACL data: handle 1 flags 0x02 dlen 16=0A=
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4=0A=
      MTU 2396 =0A=
< ACL data: handle 1 flags 0x02 dlen 14=0A=
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0=0A=
      Success=0A=
< ACL data: handle 1 flags 0x02 dlen 12=0A=
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> ACL data: handle 1 flags 0x02 dlen 14=0A=
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0=0A=
      Success=0A=
> ACL data: handle 1 flags 0x02 dlen 28=0A=
    L2CAP(d): cid 0x0040 len 24 [psm 1]=0A=
        SDP SSA Req: tid 0x0 len 0x13=0A=
          pat uuid-16 0x1112 (Headset AG) uuid-16 0x0100 (L2CAP) uuid-16 =
0x0003 (RFCOMM)=0A=
          max 100=0A=
          aid(s) 0x0004 (ProtocolDescList)=0A=
          cont 00=0A=
< ACL data: handle 1 flags 0x02 dlen 120=0A=
    L2CAP(d): cid 0x0040 len 116 [psm 1]=0A=
        SDP SSA Rsp: tid 0x0 len 0x6f=0A=
          count 100=0A=
          cont 08 BA 3A 61 45 64 00 00 00=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> ACL data: handle 1 flags 0x02 dlen 12=0A=
    L2CAP(s): Connect req: psm 3 scid 0x0041=0A=
< ACL data: handle 1 flags 0x02 dlen 16=0A=
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0=0A=
      Connection successful=0A=
> ACL data: handle 1 flags 0x02 dlen 12=0A=
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040=0A=
< ACL data: handle 1 flags 0x02 dlen 12=0A=
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> ACL data: handle 1 flags 0x02 dlen 16=0A=
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4=0A=
      MTU 132 =0A=
< ACL data: handle 1 flags 0x02 dlen 14=0A=
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0=0A=
      Success=0A=
< ACL data: handle 1 flags 0x02 dlen 16=0A=
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4=0A=
      MTU 1024 =0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> ACL data: handle 1 flags 0x02 dlen 14=0A=
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0=0A=
      Success=0A=
> ACL data: handle 1 flags 0x02 dlen 8=0A=
    L2CAP(d): cid 0x0041 len 4 [psm 3]=0A=
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c =0A=
< ACL data: handle 1 flags 0x02 dlen 8=0A=
    L2CAP(d): cid 0x0041 len 4 [psm 3]=0A=
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 =0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> ACL data: handle 1 flags 0x02 dlen 18=0A=
    L2CAP(d): cid 0x0041 len 14 [psm 3]=0A=
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8=0A=
      dlci 36 frame_type 0 credit_flow 15 pri 0 ack_timer 0=0A=
      frame_size 127 max_retrans 0 credits 1=0A=
< ACL data: handle 1 flags 0x02 dlen 18=0A=
    L2CAP(d): cid 0x0041 len 14 [psm 3]=0A=
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8=0A=
      dlci 36 frame_type 0 credit_flow 14 pri 0 ack_timer 0=0A=
      frame_size 127 max_retrans 0 credits 7=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> ACL data: handle 1 flags 0x02 dlen 8=0A=
    L2CAP(d): cid 0x0041 len 4 [psm 3]=0A=
      RFCOMM(s): SABM: cr 1 dlci 36 pf 1 ilen 0 fcs 0x40 =0A=
< ACL data: handle 1 flags 0x02 dlen 8=0A=
    L2CAP(d): cid 0x0041 len 4 [psm 3]=0A=
      RFCOMM(s): UA: cr 1 dlci 36 pf 1 ilen 0 fcs 0x8b =0A=
< ACL data: handle 1 flags 0x02 dlen 12=0A=
    L2CAP(d): cid 0x0041 len 8 [psm 3]=0A=
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2=0A=
      dlci 36 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0=0A=
< ACL data: handle 1 flags 0x02 dlen 9=0A=
    L2CAP(d): cid 0x0041 len 5 [psm 3]=0A=
      RFCOMM(d): UIH: cr 0 dlci 36 pf 1 ilen 0 fcs 0xb credits 33=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> ACL data: handle 1 flags 0x02 dlen 12=0A=
    L2CAP(d): cid 0x0041 len 8 [psm 3]=0A=
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2=0A=
      dlci 36 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0=0A=
< ACL data: handle 1 flags 0x02 dlen 12=0A=
    L2CAP(d): cid 0x0041 len 8 [psm 3]=0A=
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2=0A=
      dlci 36 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> ACL data: handle 1 flags 0x02 dlen 12=0A=
    L2CAP(d): cid 0x0041 len 8 [psm 3]=0A=
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2=0A=
      dlci 36 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0=0A=
> ACL data: handle 1 flags 0x02 dlen 20=0A=
    L2CAP(d): cid 0x0041 len 16 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 36 pf 0 ilen 12 fcs 0xcd =0A=
      0000: 41 54 2b 43 4b 50 44 3d  32 30 30 0d              =
AT+CKPD=3D200.=0A=
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4=0A=
    handle 1 ptype 0x0080=0A=
    Packet type: HV3 =0A=
< ACL data: handle 1 flags 0x02 dlen 14=0A=
    L2CAP(d): cid 0x0041 len 10 [psm 3]=0A=
      RFCOMM(d): UIH: cr 0 dlci 36 pf 0 ilen 6 fcs 0x17 =0A=
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..=0A=
> HCI Event: Command Status (0x0f) plen 4=0A=
    Add SCO Connection (0x01|0x0007) status 0x00 ncmd 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> ACL data: handle 1 flags 0x02 dlen 9=0A=
    L2CAP(d): cid 0x0041 len 5 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 36 pf 1 ilen 0 fcs 0xd1 credits 1=0A=
> HCI Event: Connect Complete (0x03) plen 11=0A=
    status 0x00 handle 8 bdaddr 00:03:35:11:44:22 type SCO encrypt 0x00=0A=
< ACL data: handle 1 flags 0x02 dlen 14=0A=
    L2CAP(d): cid 0x0041 len 10 [psm 3]=0A=
      RFCOMM(d): UIH: cr 0 dlci 36 pf 0 ilen 6 fcs 0x17 =0A=
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..=0A=
> HCI Event: Command Status (0x0f) plen 4=0A=
    Unknown (0x00|0x0000) status 0x00 ncmd 2=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> ACL data: handle 1 flags 0x02 dlen 18=0A=
    L2CAP(d): cid 0x0041 len 14 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 36 pf 0 ilen 10 fcs 0xcd =0A=
      0000: 41 54 2b 56 47 53 3d 30  37 0d                    =
AT+VGS=3D07.=0A=
> ACL data: handle 1 flags 0x02 dlen 9=0A=
    L2CAP(d): cid 0x0041 len 5 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 36 pf 1 ilen 0 fcs 0xd1 credits 1=0A=
< ACL data: handle 1 flags 0x02 dlen 14=0A=
    L2CAP(d): cid 0x0041 len 10 [psm 3]=0A=
      RFCOMM(d): UIH: cr 0 dlci 36 pf 0 ilen 6 fcs 0x17 =0A=
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..=0A=
> ACL data: handle 1 flags 0x02 dlen 18=0A=
    L2CAP(d): cid 0x0041 len 14 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 36 pf 0 ilen 10 fcs 0xcd =0A=
      0000: 41 54 2b 56 47 53 3d 30  37 0d                    =
AT+VGS=3D07.=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> ACL data: handle 1 flags 0x02 dlen 9=0A=
    L2CAP(d): cid 0x0041 len 5 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 36 pf 1 ilen 0 fcs 0xd1 credits 1=0A=
< ACL data: handle 1 flags 0x02 dlen 14=0A=
    L2CAP(d): cid 0x0041 len 10 [psm 3]=0A=
      RFCOMM(d): UIH: cr 0 dlci 36 pf 0 ilen 6 fcs 0x17 =0A=
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> ACL data: handle 1 flags 0x02 dlen 9=0A=
    L2CAP(d): cid 0x0041 len 5 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 36 pf 1 ilen 0 fcs 0xd1 credits 1=0A=
> ACL data: handle 1 flags 0x02 dlen 20=0A=
    L2CAP(d): cid 0x0041 len 16 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 36 pf 0 ilen 12 fcs 0xcd =0A=
      0000: 41 54 2b 43 4b 50 44 3d  32 30 30 0d              =
AT+CKPD=3D200.=0A=
< ACL data: handle 1 flags 0x02 dlen 14=0A=
    L2CAP(d): cid 0x0041 len 10 [psm 3]=0A=
      RFCOMM(d): UIH: cr 0 dlci 36 pf 0 ilen 6 fcs 0x17 =0A=
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> ACL data: handle 1 flags 0x02 dlen 9=0A=
    L2CAP(d): cid 0x0041 len 5 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 36 pf 1 ilen 0 fcs 0xd1 credits 1=0A=
< HCI Command: Disconnect (0x01|0x0006) plen 3=0A=
    handle 8 reason 0x13=0A=
    Reason: Remote User Terminated Connection=0A=
> HCI Event: Command Status (0x0f) plen 4=0A=
    Disconnect (0x01|0x0006) status 0x00 ncmd 1=0A=
> HCI Event: Disconn Complete (0x05) plen 4=0A=
    status 0x00 handle 8 reason 0x16=0A=
    Reason: Connection Terminated by Local Host=0A=
> HCI Event: Command Status (0x0f) plen 4=0A=
    Unknown (0x00|0x0000) status 0x00 ncmd 2=0A=
< ACL data: handle 1 flags 0x02 dlen 8=0A=
    L2CAP(d): cid 0x0041 len 4 [psm 3]=0A=
      RFCOMM(s): DISC: cr 0 dlci 36 pf 1 ilen 0 fcs 0xc0 =0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> ACL data: handle 1 flags 0x02 dlen 8=0A=
    L2CAP(d): cid 0x0041 len 4 [psm 3]=0A=
      RFCOMM(s): UA: cr 0 dlci 36 pf 1 ilen 0 fcs 0xea =0A=

------=_NextPart_000_00B6_01C70CC7.7EF88570
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------=_NextPart_000_00B6_01C70CC7.7EF88570
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

------=_NextPart_000_00B6_01C70CC7.7EF88570--

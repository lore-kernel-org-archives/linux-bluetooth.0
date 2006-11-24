Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
Date: Fri, 24 Nov 2006 14:22:23 +0530
Message-ID: <019001c70fa5$dbf8e1d0$8935c70a@dlh.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0191_01C70FD3.F5B11DD0"
In-Reply-To: <1164353465.28284.8.camel@localhost>
Subject: Re: [Bluez-users] L2CAP disconnect problem
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

------=_NextPart_000_0191_01C70FD3.F5B11DD0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Marcel
I have attached the kernel messages log as well as the HCI log. There is no
ACL Disconnect after L2CAP disc response. 

Regards
Sumeet 


-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Friday, November 24, 2006 1:01 PM
To: BlueZ users
Subject: Re: [Bluez-users] L2CAP disconnect problem

Hi Summeet,

> The patch worked. But after the L2CAP disconnection, the ACL channel
doesn't disconnect. Is there some other patch also at HCI Level? Please send
it also.

are we talking about the 2.4 or 2.6 kernel here. I didn't recall any
problems with the 2.6 kernel. We had a problem some time ago where the
creator doesn't terminates his own ACL connections, but that was fixed
around 2.6.1 or so.

Make sure you have a "hcidump -X -V" to show what happens.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT Join SourceForge.net's
Techsay panel and you'll get the chance to share your opinions on IT &
business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

------=_NextPart_000_0191_01C70FD3.F5B11DD0
Content-Type: text/plain;
	name="hcilog.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="hcilog.txt"

HCI sniffer - Bluetooth packet analyzer ver 1.30=0A=
device: hci0 snap_len: 1028 filter: 0xffffffff=0A=
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0=0A=
> HCI Event: Command Complete (0x0e) plen 6=0A=
    Read Voice Setting (0x03|0x0025) ncmd 2=0A=
    status 0x00 voice setting 0x0060=0A=
> HCI Event: Disconn Complete (0x05) plen 4=0A=
    status 0x00 handle 1 reason 0x08=0A=
    Reason: Connection Timeout=0A=
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
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
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
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
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
< ACL data: handle 1 flags 0x02 dlen 33=0A=
    L2CAP(d): cid 0x0040 len 29 [psm 1]=0A=
        SDP SSA Rsp: tid 0x0 len 0x18=0A=
          count 21=0A=
          record #0=0A=
              aid 0x0004 (ProtocolDescList)=0A=
                 < < uuid-16 0x0100 (L2CAP) > <=0A=
                 uuid-16 0x0003 (RFCOMM) uint 0x12 > >=0A=
          cont 00=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> ACL data: handle 1 flags 0x02 dlen 12=0A=
    L2CAP(s): Connect req: psm 3 scid 0x0041=0A=
< ACL data: handle 1 flags 0x02 dlen 16=0A=
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0=0A=
      Connection successful=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
> ACL data: handle 1 flags 0x02 dlen 12=0A=
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040=0A=
< ACL data: handle 1 flags 0x02 dlen 12=0A=
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
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
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
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
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
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
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> ACL data: handle 1 flags 0x02 dlen 8=0A=
    L2CAP(d): cid 0x0041 len 4 [psm 3]=0A=
      RFCOMM(s): SABM: cr 1 dlci 36 pf 1 ilen 0 fcs 0x40 =0A=
< ACL data: handle 1 flags 0x02 dlen 8=0A=
    L2CAP(d): cid 0x0041 len 4 [psm 3]=0A=
      RFCOMM(s): UA: cr 1 dlci 36 pf 1 ilen 0 fcs 0x8b =0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
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
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
> ACL data: handle 1 flags 0x02 dlen 12=0A=
    L2CAP(d): cid 0x0041 len 8 [psm 3]=0A=
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2=0A=
      dlci 36 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
> ACL data: handle 1 flags 0x02 dlen 20=0A=
    L2CAP(d): cid 0x0041 len 16 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 36 pf 0 ilen 12 fcs 0xcd =0A=
      0000: 41 54 2b 43 4b 50 44 3d  32 30 30 0d              =
AT+CKPD=3D200.=0A=
< ACL data: handle 1 flags 0x02 dlen 14=0A=
    L2CAP(d): cid 0x0041 len 10 [psm 3]=0A=
      RFCOMM(d): UIH: cr 0 dlci 36 pf 0 ilen 6 fcs 0x17 =0A=
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4=0A=
    handle 1 ptype 0x0080=0A=
    Packet type: HV3 =0A=
> HCI Event: Command Status (0x0f) plen 4=0A=
    Add SCO Connection (0x01|0x0007) status 0x00 ncmd 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> ACL data: handle 1 flags 0x02 dlen 9=0A=
    L2CAP(d): cid 0x0041 len 5 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 36 pf 1 ilen 0 fcs 0xd1 credits 1=0A=
> HCI Event: Connect Complete (0x03) plen 11=0A=
    status 0x00 handle 8 bdaddr 00:03:35:11:44:22 type SCO encrypt 0x00=0A=
> HCI Event: Command Status (0x0f) plen 4=0A=
    Unknown (0x00|0x0000) status 0x00 ncmd 2=0A=
> ACL data: handle 1 flags 0x02 dlen 18=0A=
    L2CAP(d): cid 0x0041 len 14 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 36 pf 0 ilen 10 fcs 0xcd =0A=
      0000: 41 54 2b 56 47 4d 3d 30  37 0d                    =
AT+VGM=3D07.=0A=
< ACL data: handle 1 flags 0x02 dlen 14=0A=
    L2CAP(d): cid 0x0041 len 10 [psm 3]=0A=
      RFCOMM(d): UIH: cr 0 dlci 36 pf 0 ilen 6 fcs 0x17 =0A=
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> ACL data: handle 1 flags 0x02 dlen 9=0A=
    L2CAP(d): cid 0x0041 len 5 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 36 pf 1 ilen 0 fcs 0xd1 credits 1=0A=
> ACL data: handle 1 flags 0x02 dlen 18=0A=
    L2CAP(d): cid 0x0041 len 14 [psm 3]=0A=
      RFCOMM(d): UIH: cr 1 dlci 36 pf 0 ilen 10 fcs 0xcd =0A=
      0000: 41 54 2b 56 47 53 3d 30  37 0d                    =
AT+VGS=3D07.=0A=
< ACL data: handle 1 flags 0x02 dlen 14=0A=
    L2CAP(d): cid 0x0041 len 10 [psm 3]=0A=
      RFCOMM(d): UIH: cr 0 dlci 36 pf 0 ilen 6 fcs 0x17 =0A=
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
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
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
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
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> ACL data: handle 1 flags 0x02 dlen 8=0A=
    L2CAP(d): cid 0x0041 len 4 [psm 3]=0A=
      RFCOMM(s): UA: cr 0 dlci 36 pf 1 ilen 0 fcs 0xea =0A=
< ACL data: handle 1 flags 0x02 dlen 8=0A=
    L2CAP(d): cid 0x0041 len 4 [psm 3]=0A=
      RFCOMM(s): DISC: cr 0 dlci 0 pf 1 ilen 0 fcs 0x9c =0A=
< HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5=0A=
  0000: 01 01 00 01 00                                    .....=0A=
< ACL data: handle 1 flags 0x02 dlen 12=0A=
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> HCI Event: Number of Completed Packets (0x13) plen 5=0A=
    handle 1 packets 1=0A=
> ACL data: handle 1 flags 0x02 dlen 8=0A=
    L2CAP(d): cid 0x0041 len 4 [psm 3]=0A=
      RFCOMM(s): UA: cr 0 dlci 0 pf 1 ilen 0 fcs 0xb6 =0A=
> ACL data: handle 1 flags 0x02 dlen 12=0A=
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041=0A=

------=_NextPart_000_0191_01C70FD3.F5B11DD0
Content-Type: text/plain;
	name="kernellog.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="kernellog.txt"

=0A=
Nov 24 14:04:44 del32tpt kernel: Copyright (C) 2002 Marcel Holtmann =
<marcel@holtmann.org>=0A=
Nov 24 14:04:44 del32tpt kernel: rfcomm_run: =0A=
Nov 24 14:04:44 del32tpt kernel: rfcomm_l2sock_create: =0A=
Nov 24 14:04:44 del32tpt kernel: l2cap_sock_create: sock c549ae14=0A=
Nov 24 14:04:44 del32tpt kernel: l2cap_sock_init: sk d7b8da80=0A=
Nov 24 14:04:44 del32tpt kernel: l2cap_sock_bind: sk d7b8da80, =
00:00:00:00:00:00 3=0A=
Nov 24 14:04:44 del32tpt kernel: l2cap_sock_setsockopt: sk d7b8da80=0A=
Nov 24 14:04:44 del32tpt kernel: l2cap_sock_listen: sk d7b8da80 backlog =
10=0A=
Nov 24 14:04:44 del32tpt kernel: rfcomm_session_add: session c68c7a00 =
sock c549ae14=0A=
Nov 24 14:04:44 del32tpt kernel: rfcomm_worker: =0A=
Nov 24 14:05:14 del32tpt kernel: hci_sock_create: sock d3401b94=0A=
Nov 24 14:05:14 del32tpt kernel: hci_sock_ioctl: cmd 800448d3 arg =
bfffeb70=0A=
Nov 24 14:05:14 del32tpt kernel: hci_dev_get_Rc3df1d84: 0=0A=
Nov 24 14:05:14 del32tpt kernel: hci_sock_release: sock d3401b94 sk =
dd4e2580=0A=
Nov 24 14:05:14 del32tpt kernel: hci_sock_create: sock d3401b94=0A=
Nov 24 14:05:14 del32tpt kernel: hci_sock_bind: sock d3401b94 sk dd4e2580=0A=
Nov 24 14:05:14 del32tpt kernel: hci_dev_get_Rc3df1d84: 0=0A=
Nov 24 14:05:14 del32tpt kernel: hci_sock_setsockopt: sk dd4e2580, opt 2=0A=
Nov 24 14:05:14 del32tpt kernel: hci_sock_sendmsg: sock d3401b94 sk =
dd4e2580=0A=
Nov 24 14:05:14 del32tpt kernel: hci_send_raw_Rb1cc215e: hci0 type 1 len =
3=0A=
Nov 24 14:05:14 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:05:14 del32tpt kernel: hci_send_frame: hci0 type 1 len 3=0A=
Nov 24 14:05:14 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 3=0A=
Nov 24 14:05:14 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:14 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 8=0A=
Nov 24 14:05:14 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:14 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:05:14 del32tpt kernel: hci_event_packet: hci0 evt 0xe=0A=
Nov 24 14:05:14 del32tpt kernel: hci_cc_host_ctl: hci0 ocf 0x25=0A=
Nov 24 14:05:14 del32tpt kernel: hci_cc_host_ctl: hci0 Command complete: =
ogf HOST_CTL ocf 25=0A=
Nov 24 14:05:14 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:14 del32tpt kernel: hci_sock_recvmsg: sock d3401b94, sk =
dd4e2580=0A=
Nov 24 14:05:14 del32tpt kernel: hci_sock_setsockopt: sk dd4e2580, opt 2=0A=
Nov 24 14:05:14 del32tpt kernel: hci_sock_release: sock d3401b94 sk =
dd4e2580=0A=
Nov 24 14:05:14 del32tpt kernel: rfcomm_sock_create: sock d3401b94=0A=
Nov 24 14:05:14 del32tpt kernel: rfcomm_dlc_clear_state: d4053e00=0A=
Nov 24 14:05:14 del32tpt kernel: rfcomm_dlc_alloc: d4053e00=0A=
Nov 24 14:05:14 del32tpt kernel: rfcomm_sock_alloc: sk dd4e2580=0A=
Nov 24 14:05:14 del32tpt kernel: rfcomm_sock_init: sk dd4e2580=0A=
Nov 24 14:05:14 del32tpt kernel: rfcomm_sock_bind: sk dd4e2580 =
33:33:22:E1:80:00=0A=
Nov 24 14:05:14 del32tpt kernel: rfcomm_sock_listen: sk dd4e2580 backlog =
10=0A=
Nov 24 14:05:14 del32tpt kernel: rfcomm_sock_accept: sk dd4e2580 timeo =
2147483647=0A=
Nov 24 14:05:14 del32tpt kernel: bluez_accept_dequeue_R15a8bf4b: parent =
dd4e2580=0A=
Nov 24 14:05:14 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c2d7c894, sk db7ac580=0A=
Nov 24 14:05:14 del32tpt last message repeated 4 times=0A=
Nov 24 14:05:42 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 6=0A=
Nov 24 14:05:42 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:42 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 6=0A=
Nov 24 14:05:42 del32tpt kernel: hci_event_packet: hci0 evt 0x5=0A=
Nov 24 14:05:42 del32tpt kernel: hci_disconn_complete_evt: hci0 status 0=0A=
Nov 24 14:05:42 del32tpt kernel: l2cap_disconn_ind: hcon db88d800 reason =
8=0A=
Nov 24 14:05:42 del32tpt kernel: l2cap_conn_del: hcon db88d800 conn =
c68c7c80, err 110=0A=
Nov 24 14:05:42 del32tpt kernel: sco_disconn_ind: hcon db88d800 reason 8=0A=
Nov 24 14:05:42 del32tpt kernel: hci_conn_del: hci0 conn db88d800 handle =
2=0A=
Nov 24 14:05:42 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 12=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 12=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0x4=0A=
Nov 24 14:05:59 del32tpt kernel: hci_conn_request_evt: hci0 Connection =
request: 22:44:11:35:03:00 type 0x1=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_connect_ind: hdev hci0, bdaddr =
22:44:11:35:03:00=0A=
Nov 24 14:05:59 del32tpt kernel: sco_connect_ind: hdev hci0, bdaddr =
22:44:11:35:03:00=0A=
Nov 24 14:05:59 del32tpt kernel: hci_conn_add: hci0 dst 22:44:11:35:03:00=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: hci0 ogf 0x1 ocf 0x9 plen =
7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: skb len 10=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 1 len 10=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 10=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 6=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 6=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0xf=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cs_link_ctl: hci0 ocf 0x9=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cs_link_ctl: hci0 Command status: =
ogf LINK_CTL ocf 9 status 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0x3=0A=
Nov 24 14:05:59 del32tpt kernel: hci_conn_complete_evt: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: hci0 ogf 0x2 ocf 0xd plen =
4=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: skb len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: hci0 ogf 0x1 ocf 0xf plen =
4=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: skb len 7=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_connect_cfm: hcon d4053b00 bdaddr =
22:44:11:35:03:00 status 0=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_conn_add: hcon d4053b00 conn =
c68c7c80=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_conn_ready: conn c68c7c80=0A=
Nov 24 14:05:59 del32tpt kernel: sco_connect_cfm: hcon d4053b00 bdaddr =
22:44:11:35:03:00 status 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 1 len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0x1b=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0xe=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cc_link_policy: hci0 ocf 0xd=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cc_link_policy: hci0: Command =
complete: ogf LINK_POLICY ocf d=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 1 len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 6=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 6=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0xf=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cs_link_ctl: hci0 ocf 0xf=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cs_link_ctl: hci0 Command status: =
ogf LINK_CTL ocf f status 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:05:59 del32tpt kernel: hci_acldata_packet: hci0 len 12 handle =
0x1 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:05:59 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len =
12 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: Start: total len =
12, frag len 12=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_frame: len 8, cid 0x0001=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sig_channel: code 0x02 len 4 id =
0x01=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_connect_req: psm 0x01 scid 0x0040=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_init: sk dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: __l2cap_chan_add: conn c68c7c80, psm =
0x01, dcid 0x0040=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_accept_enqueue_R15946e8a: parent =
db7ac580, sk dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_set_timer: sk dd2db080 state =
2 timeout 4000=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_build_cmd: conn c68c7c80, code =
0x03, ident 0x01, len 8=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_send_rsp: code 0x03=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 conn =
d4053b00 flags 0x0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 nonfrag =
skb de366980 len 20=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn d4053b00 quote 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: skb de366980 len 20=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 2 len 20=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 20=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 1 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 1 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt last message repeated 2 times=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0x1d=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 6=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 6=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0xf=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 Command Status =
OGF 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0x1b=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0x13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 20=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 20=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:05:59 del32tpt kernel: hci_acldata_packet: hci0 len 16 handle =
0x1 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:05:59 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len =
16 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: Start: total len =
16, frag len 16=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_frame: len 12, cid 0x0001=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sig_channel: code 0x04 len 8 id =
0x02=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_config_req: dcid 0x0040 flags 0x00=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_parse_conf_req: sk dd2db080 len 4=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_get_conf_opt: type 0x01 len 2 val =
0x95c=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_build_conf_rsp: sk dd2db080 =
complete 1=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_conf_output: sk dd2db080 result 0=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_build_cmd: conn c68c7c80, code =
0x05, ident 0x02, len 6=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_send_rsp: code 0x05=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 conn =
d4053b00 flags 0x0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 nonfrag =
skb cce2de80 len 18=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_build_conf_req: sk dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_build_cmd: conn c68c7c80, code =
0x04, ident 0x01, len 4=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_send_req: code 0x04=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 conn =
d4053b00 flags 0x0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 nonfrag =
skb d68d4080 len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn d4053b00 quote 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: skb cce2de80 len 18=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 2 len 18=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 18=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: skb d68d4080 len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 2 len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 1 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt last message repeated 2 times=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0x13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 6 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0x13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 18=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 18=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:05:59 del32tpt kernel: hci_acldata_packet: hci0 len 14 handle =
0x1 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:05:59 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len =
14 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: Start: total len =
14, frag len 14=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_frame: len 10, cid 0x0001=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sig_channel: code 0x05 len 6 id =
0x01=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_config_rsp: scid 0x0040 flags =
0x00 result 0x00=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_chan_ready: sk dd2db080, parent =
db7ac580=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_clear_timer: sock dd2db080 =
state 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c2d7c894, sk db7ac580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_accept: sk db7ac580 timeo =
2147483647=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_accept_dequeue_R15a8bf4b: parent =
db7ac580=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_accept_unlink: sk dd2db080 state 1=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_accept: new socket dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_getname: sock cc239994, sk =
dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c2d7c894, sk db7ac580=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
cc239994, sk dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 32=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 32=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:05:59 del32tpt kernel: hci_acldata_packet: hci0 len 28 handle =
0x1 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:05:59 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len =
28 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: Start: total len =
28, frag len 28=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_frame: len 24, cid 0x0040=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_data_channel: sk dd2db080, len 24=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c2d7c894, sk db7ac580=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
cc239994, sk dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_sock_recvmsg_R872f3e2d: sock =
cc239994 sk dd2db080 len 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_sock_recvmsg_R872f3e2d: sock =
cc239994 sk dd2db080 len 24=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_getname: sock cc239994, sk =
dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_sendmsg: sock cc239994, sk =
dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_chan_send: sk dd2db080 len 29=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 conn =
d4053b00 flags 0x0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 nonfrag =
skb d27cb380 len 37=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn d4053b00 quote 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: skb d27cb380 len 37=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 2 len 37=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 37=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 1 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 1 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c2d7c894, sk db7ac580=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
cc239994, sk dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt last message repeated 2 times=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0x13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:05:59 del32tpt kernel: hci_acldata_packet: hci0 len 12 handle =
0x1 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:05:59 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len =
12 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: Start: total len =
12, frag len 12=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_frame: len 8, cid 0x0001=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sig_channel: code 0x02 len 4 id =
0x03=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_connect_req: psm 0x03 scid 0x0041=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_init: sk dd2dba80=0A=
Nov 24 14:05:59 del32tpt kernel: __l2cap_chan_add: conn c68c7c80, psm =
0x03, dcid 0x0041=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_accept_enqueue_R15946e8a: parent =
d7b8da80, sk dd2dba80=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_set_timer: sk dd2dba80 state =
2 timeout 4000=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_build_cmd: conn c68c7c80, code =
0x03, ident 0x03, len 8=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_send_rsp: code 0x03=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 conn =
d4053b00 flags 0x0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 nonfrag =
skb d68d4080 len 20=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn d4053b00 quote 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: skb d68d4080 len 20=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 2 len 20=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 20=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 1 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:05:59 del32tpt kernel: hci_acldata_packet: hci0 len 12 handle =
0x1 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:05:59 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len =
12 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: Start: total len =
12, frag len 12=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_frame: len 8, cid 0x0001=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sig_channel: code 0x06 len 4 id =
0x04=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_disconnect_req: scid 0x0040 dcid =
0x0040=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_build_cmd: conn c68c7c80, code =
0x07, ident 0x04, len 4=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_send_rsp: code 0x07=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 conn =
d4053b00 flags 0x0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 nonfrag =
skb d27cb380 len 16=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_clear_timer: sock dd2db080 =
state 1=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_chan_del: sk dd2db080, conn =
c68c7c80, err 104=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c2d7c894, sk db7ac580=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
cc239994, sk dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_sock_recvmsg_R872f3e2d: sock =
cc239994 sk dd2db080 len 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 6 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn d4053b00 quote 6=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: skb d27cb380 len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 2 len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 1 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_release: sock cc239994, sk =
dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_clear_timer: sock dd2db080 =
state 9=0A=
Nov 24 14:05:59 del32tpt kernel: __l2cap_sock_close: sk dd2db080 state 9 =
socket 00000000=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_kill: sk dd2db080 state 9=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_destruct: sk dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c2d7c894, sk db7ac580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0x13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 6 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0x13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 20=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 20=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:05:59 del32tpt kernel: hci_acldata_packet: hci0 len 16 handle =
0x1 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:05:59 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len =
16 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: Start: total len =
16, frag len 16=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_frame: len 12, cid 0x0001=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sig_channel: code 0x04 len 8 id =
0x05=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_config_req: dcid 0x0041 flags 0x00=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_parse_conf_req: sk dd2dba80 len 4=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_get_conf_opt: type 0x01 len 2 val =
0x84=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_build_conf_rsp: sk dd2dba80 =
complete 1=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_conf_output: sk dd2dba80 result 0=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_build_cmd: conn c68c7c80, code =
0x05, ident 0x05, len 6=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_send_rsp: code 0x05=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 conn =
d4053b00 flags 0x0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 nonfrag =
skb dd0e8780 len 18=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_build_conf_req: sk dd2dba80=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_add_conf_opt: type 0x01 len 2 val =
0x400=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_build_cmd: conn c68c7c80, code =
0x04, ident 0x02, len 8=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_send_req: code 0x04=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 conn =
d4053b00 flags 0x0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 nonfrag =
skb d68d4080 len 20=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn d4053b00 quote 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: skb dd0e8780 len 18=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 2 len 18=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 18=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: skb d68d4080 len 20=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 2 len 20=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 20=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 1 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt last message repeated 2 times=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0x13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 6 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0x13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 18=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 18=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:05:59 del32tpt kernel: hci_acldata_packet: hci0 len 14 handle =
0x1 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:05:59 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len =
14 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: Start: total len =
14, frag len 14=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_frame: len 10, cid 0x0001=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sig_channel: code 0x05 len 6 id =
0x02=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_config_rsp: scid 0x0041 flags =
0x00 result 0x00=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_chan_ready: sk dd2dba80, parent =
d7b8da80=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_clear_timer: sock dd2dba80 =
state 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_l2data_ready: d7b8da80 bytes 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_accept_connection: session =
c68c7a00=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_accept: sk d7b8da80 timeo 0=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_accept_dequeue_R15a8bf4b: parent =
d7b8da80=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_accept_unlink: sk dd2dba80 state 1=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_accept: new socket dd2dba80=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_session_add: session c68c7b80 =
sock cc239994=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 2 qlen 0=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 2=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 12=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 12=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:05:59 del32tpt kernel: hci_acldata_packet: hci0 len 8 handle =
0x1 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:05:59 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len 8 =
flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: Start: total len 8, =
frag len 8=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_frame: len 4, cid 0x0041=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_data_channel: sk dd2dba80, len 4=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_l2data_ready: dd2dba80 bytes 4=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 2 qlen 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_recv_sabm: session c68c7b80 =
state 2 dlci 0=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_send_ua: c68c7b80 dlci 0=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_send_frame: session c68c7b80 len =
4=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_sendmsg: sock cc239994, sk =
dd2dba80=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_chan_send: sk dd2dba80 len 4=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 conn =
d4053b00 flags 0x0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 nonfrag =
skb dd7d0d80 len 12=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn d4053b00 quote 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: skb dd7d0d80 len 12=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 2 len 12=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 12=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 1 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 1 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_connect: session =
c68c7b80 state 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 0=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt last message repeated 2 times=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0x13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 22=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 22=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:05:59 del32tpt kernel: hci_acldata_packet: hci0 len 18 handle =
0x1 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:05:59 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len =
18 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: Start: total len =
18, frag len 18=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_frame: len 14, cid 0x0041=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_data_channel: sk dd2dba80, len 14=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_l2data_ready: dd2dba80 bytes 14=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_recv_mcc: c68c7b80 type 0x20 cr 2=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_recv_pn: session c68c7b80 state =
1 dlci 36=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_connect_ind: session c68c7b80 =
channel 18=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_dlc_clear_state: c5a3d300=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_dlc_alloc: c5a3d300=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_sock_alloc: sk dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_sock_init: sk dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_accept_enqueue_R15946e8a: parent =
dd4e2580, sk dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_dlc_link: dlc c5a3d300 session =
c68c7b80=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_apply_pn: dlc c5a3d300 state 2 =
dlci 36 mtu 127 fc 0xf0 credits 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_send_pn: c68c7b80 cr 0 dlci 36 =
mtu 127=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_send_frame: session c68c7b80 len =
14=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_sendmsg: sock cc239994, sk =
dd2dba80=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_chan_send: sk dd2dba80 len 14=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 conn =
d4053b00 flags 0x0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 nonfrag =
skb d68d4580 len 22=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn d4053b00 quote 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: skb d68d4580 len 22=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 2 len 22=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 22=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 1 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 0=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0x13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 12=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 12=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:05:59 del32tpt kernel: hci_acldata_packet: hci0 len 8 handle =
0x1 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:05:59 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len 8 =
flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: Start: total len 8, =
frag len 8=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_frame: len 4, cid 0x0041=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_data_channel: sk dd2dba80, len 4=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_l2data_ready: dd2dba80 bytes 4=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_recv_sabm: session c68c7b80 =
state 1 dlci 36=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_send_ua: c68c7b80 dlci 36=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_send_frame: session c68c7b80 len =
4=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_sendmsg: sock cc239994, sk =
dd2dba80=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_chan_send: sk dd2dba80 len 4=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 conn =
d4053b00 flags 0x0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 nonfrag =
skb dd7b4a80 len 12=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn d4053b00 quote 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: skb dd7b4a80 len 12=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 2 len 12=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 12=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 1 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_sk_state_change: dlc c5a3d300 =
state 1 err 0=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_send_msc: c68c7b80 cr 1 v24 0x8c=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_send_frame: session c68c7b80 len =
8=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_sendmsg: sock cc239994, sk =
dd2dba80=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_chan_send: sk dd2dba80 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 conn =
d4053b00 flags 0x0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 nonfrag =
skb dd6d1c80 len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 6 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn d4053b00 quote 6=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: skb dd6d1c80 len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 2 len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 7 tx_credits 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_send_credits: c68c7b80 addr 145 =
credits 33=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_send_frame: session c68c7b80 len =
5=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_sendmsg: sock cc239994, sk =
dd2dba80=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_chan_send: sk dd2dba80 len 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 conn =
d4053b00 flags 0x0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 nonfrag =
skb dd7d0d80 len 13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 5 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn d4053b00 quote 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: skb dd7d0d80 len 13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 2 len 13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 0=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 40 tx_credits 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt last message repeated 3 times=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_accept_dequeue_R15a8bf4b: parent =
dd4e2580=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_accept_unlink: sk dd2db080 state 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_sock_accept: new socket dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_sock_getname: sock dc5db694, sk =
dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_sock_getname: sock dc5db694, sk =
dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_sock_getsockopt: sk dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_sock_recvmsg: sk dd2db080 size 11=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_sock_accept: sk dd4e2580 timeo =
2147483647=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_accept_dequeue_R15a8bf4b: parent =
dd4e2580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0x13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 5 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0x13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 6 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0x13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:05:59 del32tpt kernel: hci_acldata_packet: hci0 len 12 handle =
0x1 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:05:59 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len =
12 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: Start: total len =
12, frag len 12=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_frame: len 8, cid 0x0041=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_data_channel: sk dd2dba80, len 8=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_l2data_ready: dd2dba80 bytes 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_recv_mcc: c68c7b80 type 0x38 cr 2=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_recv_msc: dlci 36 cr 2 v24 0x8d=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_send_msc: c68c7b80 cr 0 v24 0x8d=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_send_frame: session c68c7b80 len =
8=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_sendmsg: sock cc239994, sk =
dd2dba80=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_chan_send: sk dd2dba80 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 conn =
d4053b00 flags 0x0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 nonfrag =
skb d27cb280 len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn d4053b00 quote 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: skb d27cb280 len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 2 len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 1 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 40 tx_credits 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 0=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 40 tx_credits 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:05:59 del32tpt kernel: hci_acldata_packet: hci0 len 12 handle =
0x1 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:05:59 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len =
12 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: Start: total len =
12, frag len 12=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_frame: len 8, cid 0x0041=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_data_channel: sk dd2dba80, len 8=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_l2data_ready: dd2dba80 bytes 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0x13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_recv_mcc: c68c7b80 type 0x38 cr 0=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_recv_msc: dlci 36 cr 0 v24 0x8d=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 40 tx_credits 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 0=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 40 tx_credits 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 1 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt last message repeated 2 times=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 24=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 24=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:05:59 del32tpt kernel: hci_acldata_packet: hci0 len 20 handle =
0x1 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:05:59 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len =
20 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: Start: total len =
20, frag len 20=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_frame: len 16, cid 0x0041=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_data_channel: sk dd2dba80, len 16=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_l2data_ready: dd2dba80 bytes 16=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_recv_data: session c68c7b80 =
state 1 dlci 36 pf 0=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 39 tx_credits 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 0=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 39 tx_credits 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_sock_sendmsg: sock dc5db694, sk =
dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_dlc_send: dlc c5a3d300 mtu 127 =
len 6=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 0=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 39 tx_credits 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_send_frame: session c68c7b80 len =
10=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_sock_sendmsg: sock cc239994, sk =
dd2dba80=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_chan_send: sk dd2dba80 len 10=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 conn =
d4053b00 flags 0x0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 nonfrag =
skb dd6d1480 len 18=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn d4053b00 quote 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: skb dd6d1480 len 18=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 2 len 18=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 18=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 1 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 0=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 39 tx_credits 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: sco_sock_create: sock c06c8614=0A=
Nov 24 14:05:59 del32tpt kernel: sco_sock_init: sk dd3e5580=0A=
Nov 24 14:05:59 del32tpt kernel: sco_sock_bind: sk dd3e5580 =
33:33:22:E1:80:00=0A=
Nov 24 14:05:59 del32tpt kernel: sco_sock_connect: sk dd3e5580=0A=
Nov 24 14:05:59 del32tpt kernel: sco_connect: 33:33:22:E1:80:00 -> =
22:44:11:35:03:00=0A=
Nov 24 14:05:59 del32tpt kernel: hci_get_route_Rc11ac1cc: =
33:33:22:E1:80:00 -> 22:44:11:35:03:00=0A=
Nov 24 14:05:59 del32tpt kernel: hci_connect_Rd293a8f1: hci0 dst =
22:44:11:35:03:00=0A=
Nov 24 14:05:59 del32tpt kernel: hci_conn_add: hci0 dst 22:44:11:35:03:00=0A=
Nov 24 14:05:59 del32tpt kernel: hci_add_sco: ce0bed80=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: hci0 ogf 0x1 ocf 0x7 plen =
4=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: skb len 7=0A=
Nov 24 14:05:59 del32tpt kernel: sco_conn_add: hcon ce0bed80 conn =
d0404e00=0A=
Nov 24 14:05:59 del32tpt kernel: __sco_chan_add: conn d0404e00=0A=
Nov 24 14:05:59 del32tpt kernel: sco_sock_set_timer: sock dd3e5580 state =
5 timeout 4000=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_frame: hci0 type 1 len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_sock_w4_connect_R1ea9cbab: sk =
dd3e5580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 6=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 6=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0xf=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cs_link_ctl: hci0 ocf 0x7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0x13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:05:59 del32tpt kernel: hci_acldata_packet: hci0 len 9 handle =
0x1 flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:05:59 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len 9 =
flags 0x2=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_acldata: Start: total len 9, =
frag len 9=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_recv_frame: len 5, cid 0x0041=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_data_channel: sk dd2dba80, len 5=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_l2data_ready: dd2dba80 bytes 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_recv_data: session c68c7b80 =
state 1 dlci 36 pf 16=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 39 tx_credits 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 0=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 39 tx_credits 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 6=0A=
Nov 24 14:05:59 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 13=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0x3=0A=
Nov 24 14:05:59 del32tpt kernel: hci_conn_complete_evt: hci0=0A=
Nov 24 14:05:59 del32tpt kernel: l2cap_connect_cfm: hcon ce0bed80 bdaddr =
22:44:11:35:03:00 status 0=0A=
Nov 24 14:05:59 del32tpt kernel: sco_connect_cfm: hcon ce0bed80 bdaddr =
22:44:11:35:03:00 status 0=0A=
Nov 24 14:05:59 del32tpt kernel: sco_conn_ready: conn d0404e00=0A=
Nov 24 14:05:59 del32tpt kernel: sco_sock_clear_timer: sock dd3e5580 =
state 5=0A=
Nov 24 14:05:59 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 6=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 evt 0xf=0A=
Nov 24 14:05:59 del32tpt kernel: hci_event_packet: hci0 Command Status =
OGF 0=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:05:59 del32tpt kernel: sco_sock_getsockopt: sk dd3e5580=0A=
Nov 24 14:05:59 del32tpt kernel: sco_sock_getsockopt: sk dd3e5580=0A=
Nov 24 14:05:59 del32tpt kernel: mtu 64=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:05:59 del32tpt kernel: rfcomm_sock_recvmsg: sk dd2db080 size =
2048=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:05:59 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 22=0A=
Nov 24 14:06:00 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 22=0A=
Nov 24 14:06:00 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:06:00 del32tpt kernel: hci_acldata_packet: hci0 len 18 handle =
0x1 flags 0x2=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:06:00 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:06:00 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len =
18 flags 0x2=0A=
Nov 24 14:06:00 del32tpt kernel: l2cap_recv_acldata: Start: total len =
18, frag len 18=0A=
Nov 24 14:06:00 del32tpt kernel: l2cap_recv_frame: len 14, cid 0x0041=0A=
Nov 24 14:06:00 del32tpt kernel: l2cap_data_channel: sk dd2dba80, len 14=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_l2data_ready: dd2dba80 bytes 14=0A=
Nov 24 14:06:00 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_recv_data: session c68c7b80 =
state 1 dlci 36 pf 0=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 38 tx_credits 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 0=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 38 tx_credits 1=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_sock_recvmsg: sk dd2db080 size =
2048=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_sock_sendmsg: sock dc5db694, sk =
dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_dlc_send: dlc c5a3d300 mtu 127 =
len 6=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 0=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 38 tx_credits 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_send_frame: session c68c7b80 len =
10=0A=
Nov 24 14:06:00 del32tpt kernel: l2cap_sock_sendmsg: sock cc239994, sk =
dd2dba80=0A=
Nov 24 14:06:00 del32tpt kernel: l2cap_chan_send: sk dd2dba80 len 10=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 conn =
d4053b00 flags 0x0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 nonfrag =
skb dd7d0380 len 18=0A=
Nov 24 14:06:00 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_low_sent: conn d4053b00 quote 7=0A=
Nov 24 14:06:00 del32tpt kernel: hci_sched_acl: skb dd7d0380 len 18=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_frame: hci0 type 2 len 18=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 18=0A=
Nov 24 14:06:00 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_frame: hci0 type 1 len 8=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_frame: hci0 type 1 len 8=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 0=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 38 tx_credits 0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:00 del32tpt last message repeated 2 times=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 7=0A=
Nov 24 14:06:00 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:06:00 del32tpt kernel: hci_event_packet: hci0 evt 0x13=0A=
Nov 24 14:06:00 del32tpt kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1=0A=
Nov 24 14:06:00 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:00 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 13=0A=
Nov 24 14:06:00 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 13=0A=
Nov 24 14:06:00 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:06:00 del32tpt kernel: hci_acldata_packet: hci0 len 9 handle =
0x1 flags 0x2=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:06:00 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:06:00 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len 9 =
flags 0x2=0A=
Nov 24 14:06:00 del32tpt kernel: l2cap_recv_acldata: Start: total len 9, =
frag len 9=0A=
Nov 24 14:06:00 del32tpt kernel: l2cap_recv_frame: len 5, cid 0x0041=0A=
Nov 24 14:06:00 del32tpt kernel: l2cap_data_channel: sk dd2dba80, len 5=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_l2data_ready: dd2dba80 bytes 5=0A=
Nov 24 14:06:00 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:06:00 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_recv_data: session c68c7b80 =
state 1 dlci 36 pf 16=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 38 tx_credits 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 0=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 38 tx_credits 1=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 22=0A=
Nov 24 14:06:00 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 22=0A=
Nov 24 14:06:00 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:06:00 del32tpt kernel: hci_acldata_packet: hci0 len 18 handle =
0x1 flags 0x2=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:06:00 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:06:00 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len =
18 flags 0x2=0A=
Nov 24 14:06:00 del32tpt kernel: l2cap_recv_acldata: Start: total len =
18, frag len 18=0A=
Nov 24 14:06:00 del32tpt kernel: l2cap_recv_frame: len 14, cid 0x0041=0A=
Nov 24 14:06:00 del32tpt kernel: l2cap_data_channel: sk dd2dba80, len 14=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_l2data_ready: dd2dba80 bytes 14=0A=
Nov 24 14:06:00 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_recv_data: session c68c7b80 =
state 1 dlci 36 pf 0=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 37 tx_credits 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 0=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 37 tx_credits 1=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_sock_recvmsg: sk dd2db080 size =
2048=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_sock_sendmsg: sock dc5db694, sk =
dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_dlc_send: dlc c5a3d300 mtu 127 =
len 6=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 0=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 37 tx_credits 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_send_frame: session c68c7b80 len =
10=0A=
Nov 24 14:06:00 del32tpt kernel: l2cap_sock_sendmsg: sock cc239994, sk =
dd2dba80=0A=
Nov 24 14:06:00 del32tpt kernel: l2cap_chan_send: sk dd2dba80 len 10=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 conn =
d4053b00 flags 0x0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 nonfrag =
skb dd7d0380 len 18=0A=
Nov 24 14:06:00 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_low_sent: conn d4053b00 quote 7=0A=
Nov 24 14:06:00 del32tpt kernel: hci_sched_acl: skb dd7d0380 len 18=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_frame: hci0 type 2 len 18=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 18=0A=
Nov 24 14:06:00 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_frame: hci0 type 1 len 8=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_frame: hci0 type 1 len 8=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 0=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 37 tx_credits 0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:00 del32tpt last message repeated 2 times=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 7=0A=
Nov 24 14:06:00 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:06:00 del32tpt kernel: hci_event_packet: hci0 evt 0x13=0A=
Nov 24 14:06:00 del32tpt kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1=0A=
Nov 24 14:06:00 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:00 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 13=0A=
Nov 24 14:06:00 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 13=0A=
Nov 24 14:06:00 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:06:00 del32tpt kernel: hci_acldata_packet: hci0 len 9 handle =
0x1 flags 0x2=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:06:00 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:06:00 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:06:00 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len 9 =
flags 0x2=0A=
Nov 24 14:06:00 del32tpt kernel: l2cap_recv_acldata: Start: total len 9, =
frag len 9=0A=
Nov 24 14:06:00 del32tpt kernel: l2cap_recv_frame: len 5, cid 0x0041=0A=
Nov 24 14:06:00 del32tpt kernel: l2cap_data_channel: sk dd2dba80, len 5=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_l2data_ready: dd2dba80 bytes 5=0A=
Nov 24 14:06:00 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_recv_data: session c68c7b80 =
state 1 dlci 36 pf 16=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 37 tx_credits 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 0=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:06:00 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 37 tx_credits 1=0A=
Nov 24 14:06:00 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:00 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 24=0A=
Nov 24 14:06:01 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:06:01 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 24=0A=
Nov 24 14:06:01 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:06:01 del32tpt kernel: hci_acldata_packet: hci0 len 20 handle =
0x1 flags 0x2=0A=
Nov 24 14:06:01 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:06:01 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:06:01 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:06:01 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len =
20 flags 0x2=0A=
Nov 24 14:06:01 del32tpt kernel: l2cap_recv_acldata: Start: total len =
20, frag len 20=0A=
Nov 24 14:06:01 del32tpt kernel: l2cap_recv_frame: len 16, cid 0x0041=0A=
Nov 24 14:06:01 del32tpt kernel: l2cap_data_channel: sk dd2dba80, len 16=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_l2data_ready: dd2dba80 bytes 16=0A=
Nov 24 14:06:01 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 1=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_recv_data: session c68c7b80 =
state 1 dlci 36 pf 0=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 36 tx_credits 1=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 0=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 36 tx_credits 1=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
dc5db694, sk dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: bluez_sock_poll_R7a78ae04: sock =
c06c8614, sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_sock_recvmsg: sk dd2db080 size =
2048=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_sock_sendmsg: sock dc5db694, sk =
dd2db080=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_dlc_send: dlc c5a3d300 mtu 127 =
len 6=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 0=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 36 tx_credits 1=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_send_frame: session c68c7b80 len =
10=0A=
Nov 24 14:06:01 del32tpt kernel: l2cap_sock_sendmsg: sock cc239994, sk =
dd2dba80=0A=
Nov 24 14:06:01 del32tpt kernel: l2cap_chan_send: sk dd2dba80 len 10=0A=
Nov 24 14:06:01 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 conn =
d4053b00 flags 0x0=0A=
Nov 24 14:06:01 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 nonfrag =
skb dd7b4580 len 18=0A=
Nov 24 14:06:01 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:06:01 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:06:01 del32tpt kernel: hci_low_sent: conn d4053b00 quote 7=0A=
Nov 24 14:06:01 del32tpt kernel: hci_sched_acl: skb dd7b4580 len 18=0A=
Nov 24 14:06:01 del32tpt kernel: hci_send_frame: hci0 type 2 len 18=0A=
Nov 24 14:06:01 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 18=0A=
Nov 24 14:06:01 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:06:01 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:06:01 del32tpt kernel: hci_send_frame: hci0 type 1 len 8=0A=
Nov 24 14:06:01 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:06:01 del32tpt kernel: hci_send_frame: hci0 type 1 len 8=0A=
Nov 24 14:06:01 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 0=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 36 tx_credits 0=0A=
Nov 24 14:06:01 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:01 del32tpt last message repeated 2 times=0A=
Nov 24 14:06:01 del32tpt kernel: sco_sock_release: sock c06c8614, sk =
dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: sco_sock_clear_timer: sock dd3e5580 =
state 1=0A=
Nov 24 14:06:01 del32tpt kernel: sco_sock_close: sk dd3e5580 state 1 =
conn d0404e00 socket 00000000=0A=
Nov 24 14:06:01 del32tpt kernel: sco_chan_del: sk dd3e5580, conn =
d0404e00, err 104=0A=
Nov 24 14:06:01 del32tpt kernel: sco_sock_kill: sk dd3e5580 state 9=0A=
Nov 24 14:06:01 del32tpt kernel: sco_sock_destruct: sk dd3e5580=0A=
Nov 24 14:06:01 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 7=0A=
Nov 24 14:06:01 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:06:01 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:06:01 del32tpt kernel: hci_event_packet: hci0 evt 0x13=0A=
Nov 24 14:06:01 del32tpt kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1=0A=
Nov 24 14:06:01 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:01 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:06:01 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:06:01 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:06:01 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:06:01 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 13=0A=
Nov 24 14:06:01 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:06:01 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 13=0A=
Nov 24 14:06:01 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:06:01 del32tpt kernel: hci_acldata_packet: hci0 len 9 handle =
0x1 flags 0x2=0A=
Nov 24 14:06:01 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:06:01 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:06:01 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:06:01 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len 9 =
flags 0x2=0A=
Nov 24 14:06:01 del32tpt kernel: l2cap_recv_acldata: Start: total len 9, =
frag len 9=0A=
Nov 24 14:06:01 del32tpt kernel: l2cap_recv_frame: len 5, cid 0x0041=0A=
Nov 24 14:06:01 del32tpt kernel: l2cap_data_channel: sk dd2dba80, len 5=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_l2data_ready: dd2dba80 bytes 5=0A=
Nov 24 14:06:01 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 1=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_recv_data: session c68c7b80 =
state 1 dlci 36 pf 16=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 36 tx_credits 1=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 0=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:06:01 del32tpt kernel: rfcomm_process_tx: dlc c5a3d300 state 1 =
credits 40 rx_credits 36 tx_credits 1=0A=
Nov 24 14:06:01 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:06:03 del32tpt kernel: hci_conn_timeout: conn ce0bed80 state 1=0A=
Nov 24 14:06:03 del32tpt kernel: hci_acl_disconn: ce0bed80=0A=
Nov 24 14:06:03 del32tpt kernel: hci_send_cmd: hci0 ogf 0x1 ocf 0x6 plen =
3=0A=
Nov 24 14:06:03 del32tpt kernel: hci_send_cmd: skb len 6=0A=
Nov 24 14:06:03 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:06:03 del32tpt kernel: hci_send_frame: hci0 type 1 len 6=0A=
Nov 24 14:06:03 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 6=0A=
Nov 24 14:06:03 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:03 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 6=0A=
Nov 24 14:06:03 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:06:03 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 6=0A=
Nov 24 14:06:03 del32tpt kernel: hci_event_packet: hci0 evt 0xf=0A=
Nov 24 14:06:03 del32tpt kernel: hci_cs_link_ctl: hci0 ocf 0x6=0A=
Nov 24 14:06:03 del32tpt kernel: hci_cs_link_ctl: hci0 Command status: =
ogf LINK_CTL ocf 6 status 0=0A=
Nov 24 14:06:03 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:03 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 6=0A=
Nov 24 14:06:03 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 6=0A=
Nov 24 14:06:03 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:06:03 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 6=0A=
Nov 24 14:06:03 del32tpt kernel: hci_event_packet: hci0 evt 0x5=0A=
Nov 24 14:06:03 del32tpt kernel: hci_disconn_complete_evt: hci0 status 0=0A=
Nov 24 14:06:03 del32tpt kernel: l2cap_disconn_ind: hcon ce0bed80 reason =
22=0A=
Nov 24 14:06:03 del32tpt kernel: sco_disconn_ind: hcon ce0bed80 reason 22=0A=
Nov 24 14:06:03 del32tpt kernel: sco_conn_del: hcon ce0bed80 conn =
d0404e00, err 103=0A=
Nov 24 14:06:03 del32tpt kernel: hci_conn_del: hci0 conn ce0bed80 handle =
8=0A=
Nov 24 14:06:03 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 6=0A=
Nov 24 14:06:03 del32tpt kernel: hci_event_packet: hci0 evt 0xf=0A=
Nov 24 14:06:03 del32tpt kernel: hci_event_packet: hci0 Command Status =
OGF 0=0A=
Nov 24 14:06:03 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:03 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:06 del32tpt kernel: rfcomm_sock_release: sock dc5db694, sk =
dd2db080=0A=
Nov 24 14:06:06 del32tpt kernel: rfcomm_sock_close: sk dd2db080 state 1 =
socket 00000000=0A=
Nov 24 14:06:06 del32tpt kernel: __rfcomm_dlc_close: dlc c5a3d300 state =
1 dlci 36 err 0 session c68c7b80=0A=
Nov 24 14:06:06 del32tpt kernel: rfcomm_send_disc: c68c7b80 dlci 36=0A=
Nov 24 14:06:06 del32tpt kernel: rfcomm_send_frame: session c68c7b80 len =
4=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_sock_sendmsg: sock cc239994, sk =
dd2dba80=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_chan_send: sk dd2dba80 len 4=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 conn =
d4053b00 flags 0x0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 nonfrag =
skb dd0e8e80 len 12=0A=
Nov 24 14:06:06 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_low_sent: conn d4053b00 quote 7=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sched_acl: skb dd0e8e80 len 12=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_frame: hci0 type 2 len 12=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 12=0A=
Nov 24 14:06:06 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_frame: hci0 type 1 len 8=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:06:06 del32tpt kernel: rfcomm_dlc_set_timer: dlc c5a3d300 =
state 8 timeout 2000=0A=
Nov 24 14:06:06 del32tpt kernel: rfcomm_sock_kill: sk dd2db080 state 1 =
refcnt 2=0A=
Nov 24 14:06:06 del32tpt kernel: rfcomm_sock_destruct: sk dd2db080 dlc =
c5a3d300=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:06 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 7=0A=
Nov 24 14:06:06 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:06:06 del32tpt kernel: hci_event_packet: hci0 evt 0x13=0A=
Nov 24 14:06:06 del32tpt kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:06 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 12=0A=
Nov 24 14:06:06 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 12=0A=
Nov 24 14:06:06 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:06:06 del32tpt kernel: hci_acldata_packet: hci0 len 8 handle =
0x1 flags 0x2=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:06:06 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len 8 =
flags 0x2=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_recv_acldata: Start: total len 8, =
frag len 8=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_recv_frame: len 4, cid 0x0041=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_data_channel: sk dd2dba80, len 4=0A=
Nov 24 14:06:06 del32tpt kernel: rfcomm_l2data_ready: dd2dba80 bytes 4=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:06 del32tpt kernel: rfcomm_process_rx: session c68c7b80 =
state 1 qlen 1=0A=
Nov 24 14:06:06 del32tpt kernel: rfcomm_recv_ua: session c68c7b80 state =
1 dlci 36=0A=
Nov 24 14:06:06 del32tpt kernel: __rfcomm_dlc_close: dlc c5a3d300 state =
9 dlci 36 err 0 session c68c7b80=0A=
Nov 24 14:06:06 del32tpt kernel: rfcomm_dlc_clear_timer: dlc c5a3d300 =
state 9=0A=
Nov 24 14:06:06 del32tpt kernel: rfcomm_dlc_unlink: dlc c5a3d300 refcnt =
1 session c68c7b80=0A=
Nov 24 14:06:06 del32tpt kernel: rfcomm_dlc_free: c5a3d300=0A=
Nov 24 14:06:06 del32tpt kernel: rfcomm_process_dlcs: session c68c7b80 =
state 1=0A=
Nov 24 14:06:06 del32tpt kernel: rfcomm_session_del: session c68c7b80 =
state 1=0A=
Nov 24 14:06:06 del32tpt kernel: rfcomm_send_disc: c68c7b80 dlci 0=0A=
Nov 24 14:06:06 del32tpt kernel: rfcomm_send_frame: session c68c7b80 len =
4=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_sock_sendmsg: sock cc239994, sk =
dd2dba80=0A=
Nov 24 14:06:06 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_chan_send: sk dd2dba80 len 4=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 conn =
d4053b00 flags 0x0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 nonfrag =
skb d13f9c80 len 12=0A=
Nov 24 14:06:06 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_low_sent: conn d4053b00 quote 7=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sched_acl: skb d13f9c80 len 12=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_frame: hci0 type 2 len 12=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 12=0A=
Nov 24 14:06:06 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_frame: hci0 type 1 len 8=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 8=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_sock_release: sock cc239994, sk =
dd2dba80=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_sock_clear_timer: sock dd2dba80 =
state 1=0A=
Nov 24 14:06:06 del32tpt kernel: __l2cap_sock_close: sk dd2dba80 state 1 =
socket 00000000=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_sock_set_timer: sk dd2dba80 state =
8 timeout 500=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_build_cmd: conn c68c7c80, code =
0x06, ident 0x03, len 4=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_send_req: code 0x06=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 conn =
d4053b00 flags 0x0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_acl_Rb7c3625c: hci0 nonfrag =
skb dd7d0680 len 16=0A=
Nov 24 14:06:06 del32tpt kernel: hci_tx_task: hci0 acl 6 sco 0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_low_sent: conn d4053b00 quote 6=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sched_acl: skb dd7d0680 len 16=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_frame: hci0 type 2 len 16=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 16=0A=
Nov 24 14:06:06 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:06 del32tpt last message repeated 2 times=0A=
Nov 24 14:06:06 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 7=0A=
Nov 24 14:06:06 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:06:06 del32tpt kernel: hci_event_packet: hci0 evt 0x13=0A=
Nov 24 14:06:06 del32tpt kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:06 del32tpt kernel: hci_tx_task: hci0 acl 6 sco 0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 4 =
len 7=0A=
Nov 24 14:06:06 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 7=0A=
Nov 24 14:06:06 del32tpt kernel: hci_event_packet: hci0 evt 0x13=0A=
Nov 24 14:06:06 del32tpt kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:06 del32tpt kernel: hci_tx_task: hci0 acl 7 sco 0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sched_acl: hci0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_low_sent: conn 00000000 quote 0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sched_sco: hci0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 12=0A=
Nov 24 14:06:06 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 12=0A=
Nov 24 14:06:06 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:06:06 del32tpt kernel: hci_acldata_packet: hci0 len 8 handle =
0x1 flags 0x2=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:06:06 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len 8 =
flags 0x2=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_recv_acldata: Start: total len 8, =
frag len 8=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_recv_frame: len 4, cid 0x0041=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_data_channel: sk dd2dba80, len 4=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:06 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=
Nov 24 14:06:06 del32tpt kernel: hci_recv_frame_R9a773410: hci0 type 2 =
len 16=0A=
Nov 24 14:06:06 del32tpt kernel: hci_rx_task: hci0=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_to_sock: hdev c2335e04 len 16=0A=
Nov 24 14:06:06 del32tpt kernel: hci_rx_task: hci0 ACL data packet=0A=
Nov 24 14:06:06 del32tpt kernel: hci_acldata_packet: hci0 len 12 handle =
0x1 flags 0x2=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x35 =
plen 5=0A=
Nov 24 14:06:06 del32tpt kernel: hci_send_cmd: skb len 8=0A=
Nov 24 14:06:06 del32tpt kernel: Sending Host No of Completed Packets:=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_recv_acldata: conn c68c7c80 len =
12 flags 0x2=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_recv_acldata: Start: total len =
12, frag len 12=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_recv_frame: len 8, cid 0x0001=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_sig_channel: code 0x07 len 4 id =
0x03=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_disconnect_rsp: dcid 0x0041 scid =
0x0041=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_sock_clear_timer: sock dd2dba80 =
state 8=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_chan_del: sk dd2dba80, conn =
c68c7c80, err 103=0A=
Nov 24 14:06:06 del32tpt kernel: rfcomm_l2state_change: dd2dba80 state 9=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_sock_kill: sk dd2dba80 state 9=0A=
Nov 24 14:06:06 del32tpt kernel: l2cap_sock_destruct: sk dd2dba80=0A=
Nov 24 14:06:06 del32tpt kernel: hci_sock_recvmsg: sock c1975494, sk =
d6e29580=0A=
Nov 24 14:06:06 del32tpt kernel: hci_cmd_task: hci0 cmd 1=0A=

------=_NextPart_000_0191_01C70FD3.F5B11DD0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------=_NextPart_000_0191_01C70FD3.F5B11DD0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

------=_NextPart_000_0191_01C70FD3.F5B11DD0--

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-devel] Connection with a phone stays open after closingRFCOMM channel
Message-ID: <C70061B183DE09419568AB2060C52A9518E71C@arion.intra.local>
From: "Victor Shcherbatyuk" <Victor.Shcherbatyuk@tomtom.com>
To: <bluez-devel@lists.sourceforge.net>
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
Date: Mon, 28 Feb 2005 10:00:54 +0100

Hi Marcel!

The log is below. The prog. on laptop listens on the HF channel,
receives connection, sends 3 AT's, receiving responses, closes the
channel, exits. On closing channel SE630 changes icon from HF to BT
connected.

Kind regards,
       Victor Shcherbatyuk.

------------------------------------------------------------------------
-

HCI sniffer - Bluetooth packet analyzer ver 1.18
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:0F:DE:11:E4:42 class 0x520204 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:0F:DE:11:E4:42 role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0F:DE:11:E4:42
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:0F:DE:11:E4:42
    Link key: 5d492e4c258eac395c2f74812b38cdbd
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:0F:DE:11:E4:42
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:0F:DE:11:E4:42 type ACL encrypt 0x01
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 41 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK=20
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  0000: 42 e4 11 de 0f 00 01                              B......
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 41
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 41 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
  0000: 29 00 18 cc                                       )...
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 41 ptype 0x0018
    Packet type: DM1 DH1=20
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0044
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0044 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 251=20
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0044 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0044 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 17
> ACL data: handle 41 flags 0x01 dlen 8
    L2CAP(d): cid 0x0040 len 21 [psm 1]
        SDP SSA Req: tid 0x0 len 0x10
          pat uuid-16 0x111e (Handsfree)
          max 65535
          aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 41 flags 0x02 dlen 44
    L2CAP(d): cid 0x0044 len 40 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x23
          count 32
          record #0
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x111e (Handsfree) uuid-16 0x1203 (Audio) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x3 > >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0044
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0044
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0045
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0045 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 251=20
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0045 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0045 flags 0x00 clen 4
      MTU 1024=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 17
> ACL data: handle 41 flags 0x01 dlen 1
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 251=20
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c=20
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0045 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 17
> ACL data: handle 41 flags 0x01 dlen 2
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 6 frame_type 0 credit_flow 15 pri 11 ack_timer 0
      frame_size 246 max_retrans 0 credits 7
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0045 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 6 frame_type 0 credit_flow 14 pri 11 ack_timer 0
      frame_size 246 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 6 pf 1 ilen 0 fcs 0xd3=20
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0045 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 6 pf 1 ilen 0 fcs 0x18=20
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0045 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 0 b3 1 len 10
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0045 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 1 len 10
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0045 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 6 pf 1 ilen 0 fcs 0x49 credits 33
< ACL data: handle 41 flags 0x02 dlen 20
    L2CAP(d): cid 0x0045 len 16 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 6 pf 0 ilen 12 fcs 0x55=20
      0000: 41 54 20 2b 43 49 4e 44  3d 3f 0a 0d              AT
+CIND=3D?..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 17
> ACL data: handle 41 flags 0x01 dlen 17
> ACL data: handle 41 flags 0x01 dlen 17
> ACL data: handle 41 flags 0x01 dlen 17
> ACL data: handle 41 flags 0x01 dlen 17
> ACL data: handle 41 flags 0x01 dlen 17
> ACL data: handle 41 flags 0x01 dlen 17
> ACL data: handle 41 flags 0x01 dlen 17
> ACL data: handle 41 flags 0x01 dlen 17
> ACL data: handle 41 flags 0x01 dlen 17
> ACL data: handle 41 flags 0x01 dlen 17
> ACL data: handle 41 flags 0x01 dlen 17
> ACL data: handle 41 flags 0x01 dlen 5
    L2CAP(d): cid 0x0040 len 205 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 6 pf 1 ilen 199 fcs 0x93 credits 4
      0000: 0d 0a 2b 43 49 4e 44 3a  20 28 22 62 61 74 74 63  ..+CIND:
("battc
      0010: 68 67 22 2c 28 30 2d 35  29 29 2c 28 22 73 69 67
hg",(0-5)),("sig
      0020: 6e 61 6c 22 2c 28 30 2d  35 29 29 2c 28 22 62 61
nal",(0-5)),("ba
      0030: 74 74 65 72 79 77 61 72  6e 69 6e 67 22 2c 28 30
tterywarning",(0
      0040: 2d 31 29 29 2c 28 22 63  68 61 72 67 65 72 63 6f
-1)),("chargerco
      0050: 6e 6e 65 63 74 65 64 22  2c 28 30 2d 31 29 29 2c
nnected",(0-1)),
      0060: 28 22 73 65 72 76 69 63  65 22 2c 28 30 2d 31 29
("service",(0-1)
      0070: 29 2c 28 22 73 6f 75 6e  64 65 72 22 2c 28 30 2d
),("sounder",(0-
      0080: 31 29 29 2c 28 22 6d 65  73 73 61 67 65 22 2c 28
1)),("message",(
      0090: 30 2d 31 29 29 2c 28 22  63 61 6c 6c 22 2c 28 30
0-1)),("call",(0
      00a0: 2d 31 29 29 2c 28 22 72  6f 61 6d 22 2c 28 30 2d
-1)),("roam",(0-
      00b0: 31 29 29 2c 28 22 73 6d  73 66 75 6c 6c 22 2c 28
1)),("smsfull",(
      00c0: 30 2d 31 29 29 0d 0a                              0-1))..
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(d): cid 0x0040 len 12 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 6 pf 1 ilen 6 fcs 0x93 credits 0
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
< ACL data: handle 41 flags 0x02 dlen 19
    L2CAP(d): cid 0x0045 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 6 pf 0 ilen 11 fcs 0x55=20
      0000: 41 54 20 2b 43 49 4e 44  3f 0a 0d                 AT
+CIND?..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 17
> ACL data: handle 41 flags 0x01 dlen 17
> ACL data: handle 41 flags 0x01 dlen 6
    L2CAP(d): cid 0x0040 len 36 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 6 pf 1 ilen 30 fcs 0x93 credits 1
      0000: 0d 0a 2b 43 49 4e 44 3a  20 33 2c 35 2c 30 2c 30  ..+CIND:
3,5,0,0
      0010: 2c 31 2c 30 2c 31 2c 30  2c 30 2c 30 0d 0a
,1,0,1,0,0,0..
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(d): cid 0x0040 len 12 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 6 pf 1 ilen 6 fcs 0x93 credits 0
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
< ACL data: handle 41 flags 0x02 dlen 26
    L2CAP(d): cid 0x0045 len 22 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 6 pf 0 ilen 18 fcs 0x55=20
      0000: 41 54 20 2b 43 4d 45 52  3d 33 2c 30 2c 30 2c 31  AT
+CMER=3D3,0,0,1
      0010: 0a 0d                                             ..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(d): cid 0x0040 len 12 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 6 pf 1 ilen 6 fcs 0x93 credits 1
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0045 len 4 [psm 3]
      RFCOMM(s): DISC: cr 0 dlci 6 pf 1 ilen 0 fcs 0x53=20
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 0 dlci 6 pf 1 ilen 0 fcs 0x79



-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Monday, February 28, 2005 9:08 AM
To: BlueZ Mailing List
Cc: victor@win.tue.nl
Subject: Re: [Bluez-devel] Connection with a phone stays open after
closingRFCOMM channel

Hi Victor,

> My prog. listens on a RFCOMM chan. (adv. as HF channel via SDP) of  a=20
> laptop, when I=20
> connect from my phone to the laptop the chan. is opened, I send some=20
> commands to configure the phone and when finished, close the chan. The

> problem is that L2CAP connection stays open, from the output of
hcidump I=20
> see that laptop sends DISC request on dlci 6 and receives UA, but then

> according to protocol it should also then send DISC for dlci 0, and
then=20
> terminate L2CAP -- it does not happen...
> If I do the same, but initiating connection from laptop - it works
fine...
> I'm sure there is no other RFCOMM chan. opened.

sounds like a bug in the phone. Send in the "hcidump -X -V" for it.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

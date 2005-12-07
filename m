Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Khaled" <khaled@ipbill.com>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Bluetooth Voice Setting
Message-ID: <HCEOIFALKKLBLJPENPNOKEGFCAAA.khaled@ipbill.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1133955376.3752.7.camel@blade>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 7 Dec 2005 11:38:00 -0000

Hi Marcel,

> > Would you not expect to see '> SCO' lines in the hcidump output
> given that I
> > am (trying to) use SCO for voice transfer? Like you said in one of the
> > archives, hcidump shows payload of the SCO packets over hci?
>
> The Headset and Headfree profiles specify when the SCO channel has to be
> opened. Maybe your connection is not in that state. Post the output of
> hcidump, so we can see what's going on.

This is when the bluetooth phone is initialised:

[root@mdk10-voipgsm root]# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.27
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 1
    status 0x00 voice setting 0x0060
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0E:6D:34:BD:B1 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 40 bdaddr 00:0E:6D:34:BD:B1 type ACL encrypt 0x00
< ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 40 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 40
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 40 slots 5
> ACL data: handle 40 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 40 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1024
> HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 40 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: -1
    Delay variation: -1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 16
> ACL data: handle 40 flags 0x01 dlen 16
> ACL data: handle 40 flags 0x01 dlen 8
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 28
      MTU 32772 QoS 0x01 (Best effort)
< ACL data: handle 40 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 40 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 40 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 40 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 26 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1019 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 16
> ACL data: handle 40 flags 0x01 dlen 2
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 26 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 324 max_retrans 0 credits 0
< ACL data: handle 40 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 26 pf 1 ilen 0 fcs 0xe7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0E:6D:34:BD:B1
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:0E:6D:34:BD:B1 key 802C4CACA4F2F18E1942747328FEFAE5
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:0E:6D:34:BD:B1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 40 encrypt 0x01
> ACL data: handle 40 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 26 pf 1 ilen 0 fcs 0x2c
< ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
< ACL data: handle 40 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 0 b3 0 len 7
< ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 0 b3 0 len 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 40 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 1 ilen 0 fcs 0x22 credits 4
> ACL data: handle 40 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 40 flags 0x02 dlen 17
    L2CAP(d): cid 0x0041 len 13 [psm 1]
        SDP SS Req: tid 0x178 len 0x8
          pat uuid-16 0x111e (Handsfree)
          max 255
          cont 00
< ACL data: handle 40 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 1]
        SDP SS Rsp: tid 0x178 len 0x9
          count 1
          handle 0x10001
          cont 00
> ACL data: handle 40 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): RPN CMD: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 26 br 7 db 3 sb 0 p 0 pt 0 xi 0 xo 0
      rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19 pm 0x006f
< ACL data: handle 40 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): RPN RSP: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 26 br 7 db 3 sb 0 p 0 pt 0 xi 0 xo 0
      rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19 pm 0x3f7f
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 1 len 3
< ACL data: handle 40 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 0 fcs 0xf8 credits 33
< ACL data: handle 40 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
< ACL data: handle 40 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 10 fcs 0xe4
      0000: 41 54 2b 42 52 53 46 3d  32 33                    AT+BRSF=23
< ACL data: handle 40 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 21
    L2CAP(d): cid 0x0041 len 17 [psm 1]
        SDP SA Req: tid 0x179 len 0xc
          handle 0x10001
          max 255
          aid(s) 0x0311 (unknown)
          cont 00
< ACL data: handle 40 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 1]
        SDP SA Rsp: tid 0x179 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 1 ilen 0 fcs 0x22 credits 3
> ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
< ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 9 fcs 0x3e
      0000: 0d 0a 45 52 52 4f 52 0d  0a                       ..ERROR..
< ACL data: handle 40 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
< ACL data: handle 40 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 9 fcs 0xe4
      0000: 41 54 2b 43 49 4e 44 3d  3f                       AT+CIND=?
< ACL data: handle 40 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
< ACL data: handle 40 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 1 ilen 0 fcs 0x22 credits 3
> ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 40 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 78
    L2CAP(d): cid 0x0040 len 74 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 70 fcs 0x3e
      0000: 0d 0a 2b 43 49 4e 44 3a  20 28 22 63 61 6c 6c 22  ..+CIND:
("call"
      0010: 2c 28 30 2c 31 29 29 2c  28 22 73 65 72 76 69 63
,(0,1)),("servic
      0020: 65 22 2c 28 30 2c 31 29  29 2c 28 22 63 61 6c 6c
e",(0,1)),("call
      0030: 5f 73 65 74 75 70 22 2c  28 30 2d 33 29 29 0d 0a
_setup",(0-3))..
      0040: 0d 0a 4f 4b 0d 0a                                 ..OK..
< ACL data: handle 40 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
< ACL data: handle 40 flags 0x02 dlen 16
    L2CAP(d): cid 0x0040 len 12 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 8 fcs 0xe4
      0000: 41 54 2b 43 49 4e 44 3f                           AT+CIND?
< ACL data: handle 40 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 40 flags 0x02 dlen 31
    L2CAP(d): cid 0x0041 len 27 [psm 1]
        SDP SS Req: tid 0x17a len 0x16
          pat uuid-128 00005555-0000-1000-8000-0002ee000001
          max 255
          cont 00
< ACL data: handle 40 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 1]
        SDP SS Rsp: tid 0x17a len 0x5
          count 0
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 1 ilen 0 fcs 0x22 credits 3
> ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
< ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 30
    L2CAP(d): cid 0x0040 len 26 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 22 fcs 0x3e
      0000: 0d 0a 2b 43 49 4e 44 3a  20 30 2c 31 2c 30 0d 0a  ..+CIND:
0,1,0..
      0010: 0d 0a 4f 4b 0d 0a                                 ..OK..
< ACL data: handle 40 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
< ACL data: handle 40 flags 0x02 dlen 23
    L2CAP(d): cid 0x0040 len 19 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 15 fcs 0xe4
      0000: 41 54 2b 43 4d 45 52 3d  33 2c 30 2c 30 2c 31
AT+CMER=3,0,0,1
< ACL data: handle 40 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 1 ilen 0 fcs 0x22 credits 3
> ACL data: handle 40 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
< ACL data: handle 40 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
< ACL data: handle 40 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 9 fcs 0xe4
      0000: 41 54 2b 43 4c 49 50 3d  31                       AT+CLIP=1
< ACL data: handle 40 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 1 ilen 0 fcs 0x22 credits 3
> ACL data: handle 40 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
< ACL data: handle 40 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
< ACL data: handle 40 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 9 fcs 0xe4
      0000: 41 54 2b 43 47 4d 49 3d  3f                       AT+CGMI=?
< ACL data: handle 40 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 1 ilen 0 fcs 0x22 credits 3
> ACL data: handle 40 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
< ACL data: handle 40 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
< ACL data: handle 40 flags 0x02 dlen 15
    L2CAP(d): cid 0x0040 len 11 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 7 fcs 0xe4
      0000: 41 54 2b 43 47 4d 49                              AT+CGMI
< ACL data: handle 40 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 1 ilen 0 fcs 0x22 credits 3
> ACL data: handle 40 flags 0x02 dlen 23
    L2CAP(d): cid 0x0040 len 19 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 15 fcs 0x3e
      0000: 0d 0a 4e 6f 6b 69 61 0d  0a 0d 0a 4f 4b 0d 0a
..Nokia....OK..
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 40 mode 0x02 interval 800
    Mode: Sniff


This is when a call is active (when a call is made) NOTE: when the call is
terminated, the ACL connection is terminated and then automatically
reconnected so at the end of the following output, the above may be
repeated.

[root@mdk10-voipgsm root]# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.27
device: hci0 snap_len: 1028 filter: 0xffffffff
< ACL data: handle 40 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 0]
      0000: 6b ef 05 0d 0a e4                                 k.....
< ACL data: handle 40 flags 0x02 dlen 23
    L2CAP(d): cid 0x0040 len 19 [psm 0]
      0000: 6b ef 1f 41 54 44 30 32  30 38 31 31 34 31 30 31
k..ATD0208114101
      0010: 33 3b e4                                          3;.
< ACL data: handle 40 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 0]
      0000: 6b ef 05 0d 0a e4                                 k.....
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 40 mode 0x00 interval 0
    Mode: Active
> ACL data: handle 40 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 0]
      0000: 69 ff 01 03 22                                    i..."
> ACL data: handle 40 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 0]
      0000: 69 ef 0d 0d 0a 4f 4b 0d  0a 3e                    i....OK..>
> ACL data: handle 40 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 0]
      0000: 69 ef 1d 0d 0a 2b 43 49  45 56 3a 20 33 2c 32 0d  i....+CIEV:
3,2.
      0010: 0a 3e                                             .>
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:0E:6D:34:BD:B1 class 0x000000 type SCO
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:0E:6D:34:BD:B1 role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 43 bdaddr 00:0E:6D:34:BD:B1 type SCO encrypt 0x01
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 43 ptype 0x00e0
    Packet type: HV1 HV2 HV3
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 40 slots 1
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 43 ptype 0x0080
    Packet type: HV3
> ACL data: handle 40 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 0]
      0000: 69 ef 1d 0d 0a 2b 43 49  45 56 3a 20 33 2c 33 0d  i....+CIEV:
3,3.
      0010: 0a 3e                                             .>
> ACL data: handle 40 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 0]
      0000: 69 ef 1d 0d 0a 2b 43 49  45 56 3a 20 31 2c 31 0d  i....+CIEV:
1,1.
      0010: 0a 3e                                             .>
> ACL data: handle 40 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 0]
      0000: 69 ef 1d 0d 0a 2b 43 49  45 56 3a 20 33 2c 30 0d  i....+CIEV:
3,0.
      0010: 0a 3e                                             .>
> ACL data: handle 40 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 0]
      0000: 69 ef 13 0d 0a 45 52 52  4f 52 0d 0a 3e           i....ERROR..>
> ACL data: handle 40 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 0]
      0000: 69 ef 1d 0d 0a 2b 43 49  45 56 3a 20 31 2c 30 0d  i....+CIEV:
1,0.
      0010: 0a 3e                                             .>
< ACL data: handle 40 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 0]
      0000: 6b ef 05 0d 0a e4                                 k.....
< ACL data: handle 40 flags 0x02 dlen 15
    L2CAP(d): cid 0x0040 len 11 [psm 0]
      0000: 6b ef 0f 41 54 2b 43 48  55 50 e4                 k..AT+CHUP.
< ACL data: handle 40 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 0]
      0000: 6b ef 05 0d 0a e4                                 k.....
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 0]
      0000: 69 ff 01 03 22                                    i..."
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 43 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> ACL data: handle 40 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 0]
      0000: 69 ef 0d 0d 0a 4f 4b 0d  0a 3e                    i....OK..>
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 43 reason 0x16
    Reason: Connection Terminated by Local Host
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 40 slots 5
> ACL data: handle 40 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 69 53 01 67                                       iS.g
< ACL data: handle 40 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 69 73 01 4d                                       is.M
< ACL data: handle 40 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 03 53 01 fd                                       .S..
< ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 01 53 01 9c                                       .S..
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 40 reason 0x13
    Reason: Remote User Terminated Connection
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0E:6D:34:BD:B1 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:0E:6D:34:BD:B1 type ACL encrypt 0x00
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 41 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 41
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 41 slots 5
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1024
> HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 41 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: -1
    Delay variation: -1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 16
> ACL data: handle 41 flags 0x01 dlen 16
> ACL data: handle 41 flags 0x01 dlen 8
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 28
      MTU 32772 QoS 0x01 (Best effort)
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 26 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1019 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 16
> ACL data: handle 41 flags 0x01 dlen 2
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 26 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 324 max_retrans 0 credits 0
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 26 pf 1 ilen 0 fcs 0xe7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0E:6D:34:BD:B1
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:0E:6D:34:BD:B1 key 802C4CACA4F2F18E1942747328FEFAE5
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:0E:6D:34:BD:B1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 41 encrypt 0x01
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 26 pf 1 ilen 0 fcs 0x2c
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 0 b3 0 len 7
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 0 b3 0 len 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 1 ilen 0 fcs 0x22 credits 4
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 17
    L2CAP(d): cid 0x0041 len 13 [psm 1]
        SDP SS Req: tid 0x17b len 0x8
          pat uuid-16 0x111e (Handsfree)
          max 255
          cont 00
> ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): RPN CMD: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 26 br 7 db 3 sb 0 p 0 pt 0 xi 0 xo 0
      rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19 pm 0x006f
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): RPN RSP: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 26 br 7 db 3 sb 0 p 0 pt 0 xi 0 xo 0
      rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19 pm 0x3f7f
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 1]
        SDP SS Rsp: tid 0x17b len 0x9
          count 1
          handle 0x10001
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 0 fcs 0xf8 credits 33
< ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 10 fcs 0xe4
      0000: 41 54 2b 42 52 53 46 3d  32 33                    AT+BRSF=23
< ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 21
    L2CAP(d): cid 0x0041 len 17 [psm 1]
        SDP SA Req: tid 0x17c len 0xc
          handle 0x10001
          max 255
          aid(s) 0x0311 (unknown)
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 1]
        SDP SA Rsp: tid 0x17c len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 1 ilen 0 fcs 0x22 credits 3
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 9 fcs 0x3e
      0000: 0d 0a 45 52 52 4f 52 0d  0a                       ..ERROR..
< ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
< ACL data: handle 41 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 9 fcs 0xe4
      0000: 41 54 2b 43 49 4e 44 3d  3f                       AT+CIND=?
< ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 1 ilen 0 fcs 0x22 credits 3
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 78
    L2CAP(d): cid 0x0040 len 74 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 70 fcs 0x3e
      0000: 0d 0a 2b 43 49 4e 44 3a  20 28 22 63 61 6c 6c 22  ..+CIND:
("call"
      0010: 2c 28 30 2c 31 29 29 2c  28 22 73 65 72 76 69 63
,(0,1)),("servic
      0020: 65 22 2c 28 30 2c 31 29  29 2c 28 22 63 61 6c 6c
e",(0,1)),("call
      0030: 5f 73 65 74 75 70 22 2c  28 30 2d 33 29 29 0d 0a
_setup",(0-3))..
      0040: 0d 0a 4f 4b 0d 0a                                 ..OK..
< ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(d): cid 0x0040 len 12 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 8 fcs 0xe4
      0000: 41 54 2b 43 49 4e 44 3f                           AT+CIND?
< ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 31
    L2CAP(d): cid 0x0041 len 27 [psm 1]
        SDP SS Req: tid 0x17d len 0x16
          pat uuid-128 00005555-0000-1000-8000-0002ee000001
          max 255
          cont 00
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 1]
        SDP SS Rsp: tid 0x17d len 0x5
          count 0
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 1 ilen 0 fcs 0x22 credits 3
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 30
    L2CAP(d): cid 0x0040 len 26 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 22 fcs 0x3e
      0000: 0d 0a 2b 43 49 4e 44 3a  20 30 2c 31 2c 30 0d 0a  ..+CIND:
0,1,0..
      0010: 0d 0a 4f 4b 0d 0a                                 ..OK..
< ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
< ACL data: handle 41 flags 0x02 dlen 23
    L2CAP(d): cid 0x0040 len 19 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 15 fcs 0xe4
      0000: 41 54 2b 43 4d 45 52 3d  33 2c 30 2c 30 2c 31
AT+CMER=3,0,0,1
< ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 1 ilen 0 fcs 0x22 credits 3
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
< ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
< ACL data: handle 41 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 9 fcs 0xe4
      0000: 41 54 2b 43 4c 49 50 3d  31                       AT+CLIP=1
< ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 1 ilen 0 fcs 0x22 credits 3
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
< ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
< ACL data: handle 41 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 9 fcs 0xe4
      0000: 41 54 2b 43 47 4d 49 3d  3f                       AT+CGMI=?
< ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 1 ilen 0 fcs 0x22 credits 3
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
< ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
< ACL data: handle 41 flags 0x02 dlen 15
    L2CAP(d): cid 0x0040 len 11 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 7 fcs 0xe4
      0000: 41 54 2b 43 47 4d 49                              AT+CGMI
< ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 2 fcs 0xe4
      0000: 0d 0a                                             ..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 1 ilen 0 fcs 0x22 credits 3
> ACL data: handle 41 flags 0x02 dlen 23
    L2CAP(d): cid 0x0040 len 19 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 15 fcs 0x3e
      0000: 0d 0a 4e 6f 6b 69 61 0d  0a 0d 0a 4f 4b 0d 0a
..Nokia....OK..
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 41 mode 0x02 interval 800
    Mode: Sniff



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Per Thomas Jahr <perja@extern.uio.no>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1159992339.8692.0.camel@localhost>
References: <1159992040.19347.29.camel@localhost.localdomain>
	<1159992339.8692.0.camel@localhost>
Content-Type: multipart/mixed; boundary="=-7vO7eGG6ZB85r9BMWh0g"
Date: Wed, 04 Oct 2006 22:13:41 +0200
Message-Id: <1159992821.19347.32.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Problems with security block
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


--=-7vO7eGG6ZB85r9BMWh0g
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

ons, 04,.10.2006 kl. 22.05 +0200, skrev Marcel Holtmann:
> show us the output of "hcidump -X -V" for both attempts.

That was quick :-)

Outputs for both attempts are attached.

--
Per Thomas

--=-7vO7eGG6ZB85r9BMWh0g
Content-Disposition: attachment; filename=hcidump-1
Content-Type: text/plain; name=hcidump-1; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

HCI sniffer - Bluetooth packet analyzer ver 1.18
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:16:B8:8D:EC:2B class 0x5a0204 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:16:B8:8D:EC:2B role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 6 bdaddr 00:16:B8:8D:EC:2B type ACL encrypt 0x00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 6 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 6 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
  0000: 06 00 18 cc                                       ....
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x0c ncmd 1
    Error: Command Disallowed
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:16:B8:8D:EC:2B clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:16:B8:8D:EC:2B clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x17 ncmd 1
    Error: Pairing Not Allowed
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 06 00 05                                          ...
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:16:B8:8D:EC:2B name 'perja K800i'
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1500 
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6
> ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 6 flags 0x02 dlen 50
    L2CAP(d): cid 0x0040 len 46 [psm 1]
        SDP SSA Req: tid 0x1 len 0x29
          pat uuid-128 c111b111-1111-111a-e113-1111df117112
          max 1500
          aid(s) 0x0000 (SrvRecHndl) 0x0001 (SrvClassIDList) 0x0002 (SrvRecState) 0x0003 (SrvID) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 6 flags 0x02 dlen 112
    L2CAP(d): cid 0x0040 len 108 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x67
          count 100
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10002
              aid 0x0001 (SrvClassIDList)
                 < uuid-128 c111b111-1111-111a-e113-1111df117112 >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x1 > >
          record #1
              aid 0x0000 (SrvRecHndl)
                 uint 0x10003
              aid 0x0001 (SrvClassIDList)
                 < uuid-128 c111b111-1111-111a-e113-1111df117112 >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x1 > >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 6 reason 0x13
    Reason: Remote User Teminated Connection
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:16:B8:8D:EC:2B class 0x5a0204 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:16:B8:8D:EC:2B role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 7 bdaddr 00:16:B8:8D:EC:2B type ACL encrypt 0x00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 7 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 7
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 7 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
  0000: 07 00 18 cc                                       ....
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x0c ncmd 1
    Error: Command Disallowed
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:16:B8:8D:EC:2B clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:16:B8:8D:EC:2B clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x17 ncmd 1
    Error: Pairing Not Allowed
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 07 00 05                                          ...
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:16:B8:8D:EC:2B name 'perja K800i'
> ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< ACL data: handle 7 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> ACL data: handle 7 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1012 
< ACL data: handle 7 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 7 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1024 
> ACL data: handle 7 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
< ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> ACL data: handle 7 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 0 ack_timer 0
      frame_size 1007 max_retrans 0 credits 7
< ACL data: handle 7 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 0 ack_timer 0
      frame_size 1007 max_retrans 0 credits 7
> ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59 
< ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92 
< ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> ACL data: handle 7 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 13
> ACL data: handle 7 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 1 len 10
< ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> ACL data: handle 7 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 1 len 10
< ACL data: handle 7 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 33
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:16:B8:8D:EC:2B clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): RPN CMD: cr 1 dlci 0 pf 0 ilen 3 fcs 0x70 mcc_len 1
      dlci 2 br 112 db 0 sb 0 p 0 pt 3 xi 1 xo 1
      rtri 1 rtro 1 rtci 0 rtco 1 xon 3 xoff 0 pm 0xaa07
< ACL data: handle 7 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): RPN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 br 7 db 3 sb 0 p 0 pt 0 xi 0 xo 0
      rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19 pm 0x3f7f
> ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): RPN CMD: cr 1 dlci 0 pf 0 ilen 3 fcs 0x70 mcc_len 1
      dlci 2 br 112 db 0 sb 0 p 0 pt 0 xi 1 xo 0
      rtri 0 rtro 0 rtci 1 rtco 0 xon 19 xoff 127 pm 0xaa3f
< ACL data: handle 7 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): RPN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 br 7 db 3 sb 0 p 0 pt 0 xi 0 xo 0
      rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19 pm 0x3f7f
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:16:B8:8D:EC:2B name 'perja K800i'
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> ACL data: handle 7 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 5 fcs 0x9a 
      0000: 00 03 65 6e 64                                    ..end
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:16:B8:8D:EC:2B clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 2 pf 1 ilen 0 fcs 0xb8 
< ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92 
< ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 0 dlci 0 pf 1 ilen 0 fcs 0x9c 
< ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:16:B8:8D:EC:2B name 'perja K800i'
> ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd 
> ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 0 dlci 0 pf 1 ilen 0 fcs 0xb6 
> ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 7 reason 0x13
    Reason: Remote User Teminated Connection

--=-7vO7eGG6ZB85r9BMWh0g
Content-Disposition: attachment; filename=hcidump-2
Content-Type: text/plain; name=hcidump-2; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

HCI sniffer - Bluetooth packet analyzer ver 1.18
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:16:B8:8D:EC:2B class 0x5a0204 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:16:B8:8D:EC:2B role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 6 bdaddr 00:16:B8:8D:EC:2B type ACL encrypt 0x00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 6 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 6 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
  0000: 06 00 18 cc                                       ....
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x0c ncmd 1
    Error: Command Disallowed
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:16:B8:8D:EC:2B clkoffset 0x0000
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 06 00 05                                          ...
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:16:B8:8D:EC:2B clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x17 ncmd 1
    Error: Pairing Not Allowed
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:16:B8:8D:EC:2B name 'perja K800i'
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1500 
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6
> ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 6 flags 0x02 dlen 50
    L2CAP(d): cid 0x0040 len 46 [psm 1]
        SDP SSA Req: tid 0x1 len 0x29
          pat uuid-128 c111b111-1111-111a-e113-1111df117112
          max 1500
          aid(s) 0x0000 (SrvRecHndl) 0x0001 (SrvClassIDList) 0x0002 (SrvRecState) 0x0003 (SrvID) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 6 flags 0x02 dlen 112
    L2CAP(d): cid 0x0040 len 108 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x67
          count 100
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10002
              aid 0x0001 (SrvClassIDList)
                 < uuid-128 c111b111-1111-111a-e113-1111df117112 >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x1 > >
          record #1
              aid 0x0000 (SrvRecHndl)
                 uint 0x10003
              aid 0x0001 (SrvClassIDList)
                 < uuid-128 c111b111-1111-111a-e113-1111df117112 >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x1 > >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 6 reason 0x13
    Reason: Remote User Teminated Connection
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:16:B8:8D:EC:2B class 0x5a0204 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:16:B8:8D:EC:2B role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 7 bdaddr 00:16:B8:8D:EC:2B type ACL encrypt 0x00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 7 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 7
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 7 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
  0000: 07 00 18 cc                                       ....
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x0c ncmd 1
    Error: Command Disallowed
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:16:B8:8D:EC:2B clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:16:B8:8D:EC:2B clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x17 ncmd 1
    Error: Pairing Not Allowed
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 07 00 05                                          ...
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:16:B8:8D:EC:2B name 'perja K800i'
> ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< ACL data: handle 7 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> ACL data: handle 7 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1012 
< ACL data: handle 7 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 7 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1024 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> ACL data: handle 7 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
< ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> ACL data: handle 7 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 0 ack_timer 0
      frame_size 1007 max_retrans 0 credits 7
< ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd 
< ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 7 reason 0x13
    Reason: Remote User Teminated Connection

--=-7vO7eGG6ZB85r9BMWh0g
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-7vO7eGG6ZB85r9BMWh0g
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--=-7vO7eGG6ZB85r9BMWh0g--

Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Mikko Rapeli <mikko.rapeli@iki.fi>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Message-id: <20040708205303.GD2581@nalle>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_B28YAjy6vHaQya4xf+qfFg)"
Subject: [Bluez-users] rfcomm and a freezing SE t610
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 08 Jul 2004 23:53:03 +0300


--Boundary_(ID_B28YAjy6vHaQya4xf+qfFg)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline

Hi Bluez users, 

I searched the list archives but didn't notice if anyone else had
trouble with the SonyEricsson T610 phone. With Debian unstable (kernel
2.6.6, bluez-utils 2.7-4) and a cheap USB dongle (Bus 001 Device 002: ID
0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle) other phones
like Nokia 7650 and SE t68i work pretty well, but the t610 seems not to
recognize the tier down of the rfcomm connection. The first GPRS session
works well, but when I end it the phone keeps the GPRS and Bluetooth
icons on as if the session were still open - even after I do a "rfcomm
release rfcomm5". When I try to open a new pppd session it hangs in
opening of the rfcomm5 device file and later complains "Host down" (or
something similar).

Is the phone only one to blame? Is there a way to send some more hangup
messages to the phone and hope that it catches them and stops the GPRS
and rfcomm connections? 

Attached is the hcidump of a succesfull rfcomm session followed by a
another one which fails. I can provide more information if needed.

-Mikko

--Boundary_(ID_B28YAjy6vHaQya4xf+qfFg)
Content-type: text/plain; charset=us-ascii;
 NAME=t610_bt_works_and_then_hangs.log
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=t610_bt_works_and_then_hangs.log

HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff
1089314803.422767 < HCI Command: Create Connection(0x01|0x0005) plen 13
  C . . . . . . . . . . . . 
1089314803.430082 > HCI Event: Command Status(0x0f) plen 4
  . . . . 
1089314807.175457 > HCI Event: Connect Complete(0x03) plen 11
  . ( . C . . . . . . . 
1089314807.175510 < ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
1089314807.175532 < HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
  ( . . . 
1089314807.181451 > HCI Event: Command Complete(0x0e) plen 6
  . . . . ( . 
1089314807.187448 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314807.215453 > ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
1089314807.215517 < ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1024 
1089314807.221444 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314807.249448 > ACL data: handle 0x0028 flags 0x02 dlen 17
1089314807.250451 > ACL data: handle 0x0028 flags 0x01 dlen 1
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 4
    MTU 251 
1089314807.252442 > ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 251 
1089314807.252485 < ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
1089314807.252519 < ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
1089314807.257438 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314807.259438 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314807.287436 > ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
1089314807.287483 < ACL data: handle 0x0028 flags 0x02 dlen 18
    L2CAP(d): cid 0x40 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0 frame_size 246 max_retrans 0 credits 7
1089314807.294434 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314807.324430 > ACL data: handle 0x0028 flags 0x02 dlen 17
1089314807.325451 > ACL data: handle 0x0028 flags 0x01 dlen 2
    L2CAP(d): cid 0x40 len 15 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0 frame_size 246 max_retrans 0 credits 7
1089314807.325510 < ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59 
1089314807.331426 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314807.556394 > HCI Event: Link Key Request(0x17) plen 6
  C . . . . . 
1089314807.556816 < HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
  C . . . . . * . . . T . % . . . . . . . 
  Q . 
1089314807.570388 > HCI Event: Command Complete(0x0e) plen 10
  . . . . C . . . . . 
1089314807.825349 > ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92 
1089314807.825417 < ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(d): cid 0x40 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 9
1089314807.827367 > ACL data: handle 0x0028 flags 0x02 dlen 13
    L2CAP(d): cid 0x40 len 9 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 0 b3 1 len 15
1089314807.827471 < ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(d): cid 0x40 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 9
1089314807.830363 > HCI Event: Encrypt Change(0x08) plen 4
  . ( . . 
1089314807.832362 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314807.834359 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314807.868343 > ACL data: handle 0x0028 flags 0x02 dlen 13
    L2CAP(d): cid 0x40 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 1 len 15
1089314807.868420 < ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(d): cid 0x40 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 9
1089314807.868448 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 
      ! 
1089314807.868466 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      A 
1089314807.868486 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      T 
1089314807.875335 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314807.877335 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314807.877737 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      . 
1089314807.879337 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314807.881337 > ACL data: handle 0x0028 flags 0x02 dlen 13
    L2CAP(d): cid 0x40 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 1 len 15
1089314807.881371 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314807.883339 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314807.919333 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . A 
1089314807.920342 > ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(d): cid 0x40 len 8 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 2 fcs 0x5c 
      . T . 
1089314807.927329 > ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(d): cid 0x40 len 12 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 6 fcs 0x5c 
      . . . O K . . 
1089314807.938819 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      A 
1089314807.950727 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      T 
1089314807.955322 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314807.957321 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314807.962726 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      H 
1089314807.974718 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      . 
1089314807.976319 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314807.978322 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . A 
1089314807.979332 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . T 
1089314807.981320 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.015315 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . H 
1089314808.016325 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . . 
1089314808.022333 > ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(d): cid 0x40 len 12 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 6 fcs 0x5c 
      . . . O K . . 
1089314808.033714 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      A 
1089314808.045715 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      T 
1089314808.048310 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.051306 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.057710 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      E 
1089314808.069708 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      1 
1089314808.073307 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.074306 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . A 
1089314808.076305 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . T 
1089314808.077310 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.081702 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      . 
1089314808.091304 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.092316 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . E 
1089314808.094302 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . 1 
1089314808.129297 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . . 
1089314808.131296 > ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(d): cid 0x40 len 12 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 6 fcs 0x5c 
      . . . O K . . 
1089314808.142699 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      A 
1089314808.154689 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      T 
1089314808.158291 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.160291 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.166694 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      + 
1089314808.178685 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      C 
1089314808.180290 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.181288 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . A 
1089314808.182308 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . T 
1089314808.185284 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.190689 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      G 
1089314808.198284 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.200285 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . + 
1089314808.201310 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . C 
1089314808.202688 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      D 
1089314808.208279 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.214683 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      C 
1089314808.218281 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . G 
1089314808.219290 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . D 
1089314808.221277 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.226683 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      O 
1089314808.235278 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.236279 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . C 
1089314808.238683 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      N 
1089314808.245276 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.246280 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . O 
1089314808.250697 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      T 
1089314808.261276 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.262287 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . N 
1089314808.262684 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      = 
1089314808.268269 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.271272 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . T 
1089314808.274673 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      1 
1089314808.281271 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . = 
1089314808.282291 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.286673 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      , 
1089314808.296265 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.297270 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . 1 
1089314808.298673 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      " 
1089314808.305263 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.306266 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . , 
1089314808.310773 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      I 
1089314808.316264 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . " 
1089314808.317275 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.322668 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      P 
1089314808.331263 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.333265 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . I 
1089314808.334666 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      " 
1089314808.341263 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.342276 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . P 
1089314808.342334 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 
      . 
1089314808.346667 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      , 
1089314808.348259 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.357255 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.358257 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . " 
1089314808.358658 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      " 
1089314808.364254 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.370668 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      i 
1089314808.382661 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      n 
1089314808.386253 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . , 
1089314808.386284 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.388253 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . " 
1089314808.389260 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.394800 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      t 
1089314808.406652 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      e 
1089314808.410250 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . i 
1089314808.410281 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.412250 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . n 
1089314808.413255 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.418654 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      r 
1089314808.427247 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.429247 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . t 
1089314808.430256 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . e 
1089314808.430656 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      n 
1089314808.436245 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.439244 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . r 
1089314808.442659 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      e 
1089314808.449245 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.449275 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . n 
1089314808.454649 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      t 
1089314808.463242 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.465240 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . e 
1089314808.466652 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      " 
1089314808.472248 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.478641 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      , 
1089314808.481238 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . t 
1089314808.483239 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . " 
1089314808.485233 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.490647 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      " 
1089314808.498231 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.500234 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . , 
1089314808.502638 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      " 
1089314808.508233 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.510232 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . " 
1089314808.514644 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      , 
1089314808.526226 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.526636 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      0 
1089314808.527232 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . " 
1089314808.532240 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.538635 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      , 
1089314808.550637 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      0 
1089314808.554222 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.556224 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . , 
1089314808.556256 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.557233 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . 0 
1089314808.562636 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      . 
1089314808.572234 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.574222 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . , 
1089314808.575231 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . 0 
1089314808.591219 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . . 
1089314808.649213 > ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(d): cid 0x40 len 12 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 6 fcs 0x5c 
      . . . O K . . 
1089314808.660822 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      A 
1089314808.672612 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      T 
1089314808.676201 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.678202 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.684612 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      D 
1089314808.696610 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      * 
1089314808.701197 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.703205 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . A 
1089314808.703237 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.704209 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . T 
1089314808.708605 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      9 
1089314808.720196 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.720608 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      9 
1089314808.722211 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . D 
1089314808.723211 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . * 
1089314808.726193 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.732870 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      # 
1089314808.738194 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.740203 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . 9 
1089314808.741238 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . 9 
1089314808.744621 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      . 
1089314808.751192 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314808.752211 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . # 
1089314808.790186 > ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x40 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c 
      . . 
1089314809.894005 > ACL data: handle 0x0028 flags 0x02 dlen 17
1089314809.896002 > ACL data: handle 0x0028 flags 0x01 dlen 4
    L2CAP(d): cid 0x40 len 17 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 11 fcs 0x5c 
      . . . C O N N E C T . . 
1089314809.896070 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 
      . 
1089314809.897015 > ACL data: handle 0x0028 flags 0x02 dlen 13
    L2CAP(d): cid 0x40 len 9 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 1 len 15
1089314809.897070 < ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(d): cid 0x40 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 4
1089314809.902001 > ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c 
      . 
1089314809.903007 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314809.905000 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314809.908435 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      . 
1089314809.909177 < ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(d): cid 0x40 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 4
1089314809.917021 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314809.919022 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314809.947023 > ACL data: handle 0x0028 flags 0x02 dlen 13
    L2CAP(d): cid 0x40 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 1 len 15
1089314810.977143 < ACL data: handle 0x0028 flags 0x02 dlen 46
    L2CAP(d): cid 0x40 len 42 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 38 fcs 0x9a 
      ~ . } # . ! } ! } ! }   } 0 } " } & }   
      }   }   }   } % } & > } ^ . . . F ~ 
1089314810.987820 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314811.016816 > ACL data: handle 0x0028 flags 0x02 dlen 17
1089314811.018816 > ACL data: handle 0x0028 flags 0x01 dlen 17
1089314811.019823 > ACL data: handle 0x0028 flags 0x01 dlen 17
1089314811.020823 > ACL data: handle 0x0028 flags 0x01 dlen 3
    L2CAP(d): cid 0x40 len 50 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 44 fcs 0x5c 
      . ~ . } # . ! } ! } ! }   } 2 } " } & } 
        }   }   }   } ' } " } ( } " } # } $ . 
      # . } ' ~ 
1089314811.021337 < ACL data: handle 0x0028 flags 0x02 dlen 33
    L2CAP(d): cid 0x40 len 29 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 25 fcs 0x9a 
      ~ . } # . ! } $ } ! }   } ( } ' } " } ( 
      } " . D ~ 
1089314811.022821 > ACL data: handle 0x0028 flags 0x02 dlen 17
1089314811.023822 > ACL data: handle 0x0028 flags 0x01 dlen 17
1089314811.024822 > ACL data: handle 0x0028 flags 0x01 dlen 2
    L2CAP(d): cid 0x40 len 32 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 26 fcs 0x5c 
      . ~ . } # . ! } $ } ! }   } * } % } & > 
      } ^ . . . * ~ 
1089314811.025396 < ACL data: handle 0x0028 flags 0x02 dlen 37
    L2CAP(d): cid 0x40 len 33 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 29 fcs 0x9a 
      ~ . } # . ! } ! } " }   } * } " } & }   
      }   }   }   _ . ~ 
1089314811.028815 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314811.032809 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314811.063809 > ACL data: handle 0x0028 flags 0x02 dlen 17
1089314811.064815 > ACL data: handle 0x0028 flags 0x01 dlen 17
1089314811.065815 > ACL data: handle 0x0028 flags 0x01 dlen 11
    L2CAP(d): cid 0x40 len 41 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 35 fcs 0x5c 
      . ~ . } # . ! } ! } " }   } . } " } & } 
        }   }   }   } # } $ . # S . ~ 
1089314811.066324 < ACL data: handle 0x0028 flags 0x02 dlen 43
    L2CAP(d): cid 0x40 len 39 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 35 fcs 0x9a 
      ~ . } # . ! } " } " }   } . } " } & }   
      }   }   }   } # } $ . # m ) ~ 
1089314811.067810 > ACL data: handle 0x0028 flags 0x02 dlen 17
1089314811.068826 > ACL data: handle 0x0028 flags 0x01 dlen 17
1089314811.069819 > ACL data: handle 0x0028 flags 0x01 dlen 5
    L2CAP(d): cid 0x40 len 35 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 29 fcs 0x5c 
      . ~ . } # . ! } " } " }   } * } " } & } 
        }   }   }   6 . ~ 
1089314811.070983 < ACL data: handle 0x0028 flags 0x02 dlen 34
    L2CAP(d): cid 0x40 len 30 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 26 fcs 0x9a 
      . . . # . . . . . r l n e t . i n t e r 
      n e t . . ~ 
1089314811.073805 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314811.077804 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314811.109808 > ACL data: handle 0x0028 flags 0x02 dlen 17
1089314811.110808 > ACL data: handle 0x0028 flags 0x01 dlen 6
    L2CAP(d): cid 0x40 len 19 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 13 fcs 0x5c 
      . ~ . . . # . . . . . . ; ~ 
1089314811.111446 < ACL data: handle 0x0028 flags 0x02 dlen 27
    L2CAP(d): cid 0x40 len 23 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 19 fcs 0x9a 
      . . . . . . . . . . x . . . x . . " ~ 
1089314811.111632 < ACL data: handle 0x0028 flags 0x02 dlen 37
    L2CAP(d): cid 0x40 len 33 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 29 fcs 0x9a 
      . . . ! . . . . . . . . . . . . . . . . 
      . . . . . . n . ~ 
1089314811.116798 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314811.118809 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314811.150793 > ACL data: handle 0x0028 flags 0x02 dlen 17
1089314811.151801 > ACL data: handle 0x0028 flags 0x01 dlen 17
1089314811.152801 > ACL data: handle 0x0028 flags 0x01 dlen 2
    L2CAP(d): cid 0x40 len 32 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 26 fcs 0x5c 
      . ~ . . . ! . . . . . . . . . . . . x . 
      . . x . . \ ~ 
1089314812.045651 > ACL data: handle 0x0028 flags 0x02 dlen 17
1089314812.047642 > ACL data: handle 0x0028 flags 0x01 dlen 11
    L2CAP(d): cid 0x40 len 24 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 18 fcs 0x5c 
      . ~ . . . ! . . . . . . . @ X e W . ~ 
1089314812.048249 < ACL data: handle 0x0028 flags 0x02 dlen 25
    L2CAP(d): cid 0x40 len 21 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 17 fcs 0x9a 
      . . . ! . . . . . . . . . . z . ~ 
1089314812.048664 > ACL data: handle 0x0028 flags 0x02 dlen 34
1089314812.049655 > ACL data: handle 0x0028 flags 0x01 dlen 6
    L2CAP(d): cid 0x40 len 36 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 30 fcs 0x5c 
      . ~ . . . ! . . . . . . . @ X d . . . . 
      ! . . . . . . . . r ~ 
1089314812.050175 < ACL data: handle 0x0028 flags 0x02 dlen 37
    L2CAP(d): cid 0x40 len 33 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 29 fcs 0x9a 
      . . . ! . . . . . . . @ X d . . . . ! . 
      . . . . . . . q ~ 
1089314812.053644 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314812.056637 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314812.080640 > ACL data: handle 0x0028 flags 0x02 dlen 17
1089314812.081645 > ACL data: handle 0x0028 flags 0x01 dlen 11
    L2CAP(d): cid 0x40 len 24 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 18 fcs 0x5c 
      . ~ . . . ! . . . . . . . . . . 3 3 ~ 
1089314812.082165 < ACL data: handle 0x0028 flags 0x02 dlen 25
    L2CAP(d): cid 0x40 len 21 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 17 fcs 0x9a 
      . . . ! . . . . . . . . . . Z G ~ 
1089314812.083642 > ACL data: handle 0x0028 flags 0x02 dlen 17
1089314812.084660 > ACL data: handle 0x0028 flags 0x01 dlen 17
1089314812.085650 > ACL data: handle 0x0028 flags 0x01 dlen 6
    L2CAP(d): cid 0x40 len 36 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 30 fcs 0x5c 
      . ~ . . . ! . . . . . . . @ X d . . . . 
      ! . . . . . . . . . ~ 
1089314812.087646 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314851.236906 < ACL data: handle 0x0028 flags 0x02 dlen 37
    L2CAP(d): cid 0x40 len 33 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 29 fcs 0x9a 
      ~ . } # . ! } % } # }   } 0 U s e r   r 
      e q u e s t y { ~ 
1089314851.247152 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314851.276151 > ACL data: handle 0x0028 flags 0x02 dlen 17
1089314851.277137 > ACL data: handle 0x0028 flags 0x01 dlen 5
    L2CAP(d): cid 0x40 len 18 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 12 fcs 0x5c 
      . ~ . . . ! . . . . H W ~ 
1089314851.361681 < ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(d): cid 0x40 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
1089314851.363769 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314851.363806 > ACL data: handle 0x0028 flags 0x02 dlen 13
    L2CAP(d): cid 0x40 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 1 b3 1 len 7
1089314851.388074 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      . 
1089314851.399106 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314851.400149 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      + 
1089314851.407071 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314851.412114 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      + 
1089314851.424114 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      + 
1089314851.431067 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314851.433096 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314851.436111 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      A 
1089314851.441070 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314851.448119 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      T 
1089314851.460184 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      H 
1089314851.461066 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314851.470061 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314851.472106 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      . 
1089314851.472697 < ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 2 pf 1 ilen 0 fcs 0xb8 
1089314851.479094 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314851.480068 > ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c 
      . 
1089314851.481067 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314851.487059 > ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92 
1089314851.487111 < ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd 
1089314851.487139 < ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
1089314851.493088 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314851.495056 > HCI Event: Number of Completed Packets(0x13) plen 5
  . ( . . . 
1089314893.480712 < HCI Command: Disconnect(0x01|0x0006) plen 3
  ( . . 
1089314893.486057 > HCI Event: Command Status(0x0f) plen 4
  . . . . 
1089314893.499054 > HCI Event: Disconn Complete(0x05) plen 4
  . ( . . 
1089314894.622012 < HCI Command: Create Connection(0x01|0x0005) plen 13
  C . . . . . . . . . . . . 
1089314894.628865 > HCI Event: Command Status(0x0f) plen 4
  . . . . 
1089314927.946308 > HCI Event: Connect Complete(0x03) plen 11
  " ) . C . . . . . . . 
1089314957.948470 < HCI Command: Create Connection(0x01|0x0005) plen 13
  C . . . . . . . . . . . . 
1089314957.955299 > HCI Event: Command Status(0x0f) plen 4
  . . . . 
1089314978.403891 > HCI Event: Connect Complete(0x03) plen 11
  . . . C . . . . . . . 

--Boundary_(ID_B28YAjy6vHaQya4xf+qfFg)--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

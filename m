Return-Path: <virat4lug@hotpop.com>
Message-ID: <000d01c461cb$2aad1ca0$4a000f0a@matrix>
From: "Virat Gohil" <virat4lug@hotpop.com>
To: <bluez-users@lists.sourceforge.net>
References: <1088782104.22055.7.camel@jumbo228.adsl.netsonic.fi> <1088782788.2803.32.camel@pegasus> <1088783320.22055.12.camel@jumbo228.adsl.netsonic.fi> <1088784401.2803.36.camel@pegasus> <1088844532.22814.644.camel@jumbo228.adsl.netsonic.fi>
Subject: rfcomm0: connection refused
Date: Sun, 4 Jul 2004 19:01:00 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-ID: <bluez-users.lists.sourceforge.net>

Hi All,

I tried connecting to GPRS using my nokia 6820 and CSR usbdongle. I am able
to start hcid, sdpd.

I am also able to l2ping my device.

I can bind the device to rfcomm0, after patching the kernel

I was able to connect to The Internet once, but after I restarted I got the
following error while connecting using pppd

rfcomm0: connection refused!

I thought may be I messed up a setting here or there, so I re-installed
RedHat 9.0 and tried again, I was able to conenct once, after I restart I
get the same problem. please help.

The following is the output of hcidump:
HCIDump - HCI packet analyzer ver 1.8
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection(0x01|0x0005) plen 13
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connect Complete(0x03) plen 11
< ACL data: handle 0x0029 flags 0x02 dlen 12
L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Command Complete(0x0e) plen 6
> HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
> HCI Event: Max Slots Change(0x1b) plen 3
> ACL data: handle 0x0029 flags 0x02 dlen 16
L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
MTU 1024
> ACL data: handle 0x0029 flags 0x02 dlen 16
L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
MTU 32772
< ACL data: handle 0x0029 flags 0x02 dlen 14
L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 14
L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 8
L2CAP(d): cid 0x40 len 4 [psm 3]
RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 8
L2CAP(d): cid 0x40 len 4 [psm 3]
RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 0x0029 flags 0x02 dlen 18
L2CAP(d): cid 0x40 len 14 [psm 3]
RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
dlci 2 frame_type 0 credit_flow 15 pri 0 ack_timer 0 frame_size 1019
max_retrans 0 credits 7
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 18
L2CAP(d): cid 0x40 len 14 [psm 3]
RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
dlci 2 frame_type 0 credit_flow 14 pri 0 ack_timer 0 frame_size 324
max_retrans 0 credits 0
< ACL data: handle 0x0029 flags 0x02 dlen 8
L2CAP(d): cid 0x40 len 4 [psm 3]
RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Link Key Request(0x17) plen 6
< HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
> HCI Event: Command Complete(0x0e) plen 10
> ACL data: handle 0x0029 flags 0x02 dlen 8
L2CAP(d): cid 0x40 len 4 [psm 3]
RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
< ACL data: handle 0x0029 flags 0x02 dlen 8
L2CAP(d): cid 0x40 len 4 [psm 3]
RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 0x0029 flags 0x02 dlen 12
L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 8
L2CAP(d): cid 0x40 len 4 [psm 3]
RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> ACL data: handle 0x0029 flags 0x02 dlen 12
L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
< HCI Command: Disconnect(0x01|0x0006) plen 3
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Disconn Complete(0x05) plen 4

Thank You, and all the people who have contributed in the development of
bluez!!

Virat

Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "David West" <dwest@cs.usyd.edu.au>
To: "'BlueZ Mailing List'" <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Using BlueZ for network access via ppp does notwork, nothing at all in log files
Message-ID: <000201c4259b$742f9310$0c0a4e81@chimpsky>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <017401c423ef$72767be0$0000fea9@RICHARDP>
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
Date: Mon, 19 Apr 2004 09:18:26 +1000

Hi Richard,

I had a similar problem to yours (see threads from last week).  I ended
up solving it by uninstalling and reinstalling the bluez packages.

Not the nicest way of doing things, but it often works!

Good luck,
David

-----Original Message-----
From: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net] On Behalf Of Richard
Pruen
Sent: 17 April 2004 6:15 AM
To: Marcel Holtmann
Cc: BlueZ Mailing List
Subject: Re: [Bluez-users] Using BlueZ for network access via ppp does
notwork, nothing at all in log files


From: "Marcel Holtmann" <marcel@holtmann.org>


Hello Marcel,

> Without any logfiles or hcidump or any other clues, how should we find

> your problem.

I still don't have any output from logfiles, nothing is written except
the following when dund is started: Apr 14 22:30:19 linux dund[29905]:
DUN daemon ver 1.1

hcidump follows....

Sorry for the late reply, but I have had the week from hell at work.

Richard

HCIDump - HCI packet analyzer ver 1.8
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request(0x04) plen 10
< HCI Command: Accept Connection Request(0x01|0x0009) plen 7
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Link Key Request(0x17) plen 6
< HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
> HCI Event: Command Complete(0x0e) plen 10
> HCI Event: Connect Complete(0x03) plen 11
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
> HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
> HCI Event: Command Complete(0x0e) plen 6
< HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
> HCI Event: Max Slots Change(0x1b) plen 3
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connection Packet Type Changed(0x1d) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x006c
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x006c result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x006c flags 0x0000 result 0 clen 0 < ACL
data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x006c flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 2
    L2CAP(d): cid 0x40 len 32 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1b
          pat uuid-128 0x1103 (DUN)
          max 0xff8
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 0x0029 flags 0x02 dlen 33
    L2CAP(d): cid 0x6c len 29 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x18
          cnt 0x15
          srv rec #0
            aid 0x0004 (ProtocolDescList)
               < < uuid-16 0x0100 (L2CAP) > <
               uuid-16 0x0003 (RFCOMM) uint 0x1 > >

          cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x006d
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x006d result 0 status 0
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x006c
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x006c
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x006d flags 0x0000 result 0 clen 0 < ACL
data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x006d flags 0x0000 clen 4
    MTU 1024
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x41 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x6d len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x41 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 32 ack_timer 0 frame_size
127 max_retrans 0 credits 7 < ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x6d len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 32 ack_timer 0 frame_size
127 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x41 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x6d len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x6d len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x41 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x6d len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x41 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 0 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x6d len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 0 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x41 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x6d len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 33
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x41 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x6d len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 13
    L2CAP(d): cid 0x41 len 9 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 4 fcs 0x86 credits 1
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x41 len 7 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 3 fcs 0x9a
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x41 len 8 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 4 fcs 0x9a
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x41 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 0 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x6d len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 0 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x41 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x6d len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x41 len 8 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 4 fcs 0x9a
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x6d len 4 [psm 3]
      RFCOMM(s): DISC: cr 0 dlci 2 pf 1 ilen 0 fcs 0xd9
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x006d
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x006d
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x006e
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x006e result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 4096
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x006e flags 0x0000 result 0 clen 0 < ACL
data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x006e flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 36
    L2CAP(d): cid 0x40 len 32 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1b
          pat uuid-128 0x1103 (DUN)
          max 0xff8
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 0x0029 flags 0x02 dlen 33
    L2CAP(d): cid 0x6e len 29 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x18
          cnt 0x15
          srv rec #0
            aid 0x0004 (ProtocolDescList)
               < < uuid-16 0x0100 (L2CAP) > <
               uuid-16 0x0003 (RFCOMM) uint 0x1 > >

          cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x006f
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x006f result 0 status 0
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x006e
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x006e
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x006f flags 0x0000 result 0 clen 0 < ACL
data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x006f flags 0x0000 clen 4
    MTU 1024
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x41 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x6f len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x41 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 32 ack_timer 0 frame_size
127 max_retrans 0 credits 7 < ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x6f len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 32 ack_timer 0 frame_size
127 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x41 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x6f len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x6f len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x41 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x6f len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x41 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x6f len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 33
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x41 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 0 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x6f len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 0 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x41 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x6f len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 13
    L2CAP(d): cid 0x41 len 9 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 4 fcs 0x86 credits 1
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x41 len 7 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 3 fcs 0x9a
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x41 len 8 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 4 fcs 0x9a
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x41 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 0 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x6f len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 0 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x41 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x6f len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x41 len 8 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 4 fcs 0x9a
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x6f len 4 [psm 3]
      RFCOMM(s): DISC: cr 0 dlci 2 pf 1 ilen 0 fcs 0xd9
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x006f
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x006f
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
< HCI Command: Disconnect(0x01|0x0006) plen 3
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Disconn Complete(0x05) plen 4



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Thomas Scheuchzer <thomas.scheuchzer@gmx.net>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1082328923.2567.12.camel@cellisamd.local>
Mime-Version: 1.0
Subject: [Bluez-users] PPP Timeout
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
Date: Mon, 19 Apr 2004 00:55:23 +0200

hi

I'm trying to connect my tungsten t to my gentoo linux (kernel 2.4.24).

i followed several tutorials and everything is working fine appart the
last step. the connection doesn't work. i always get a PPP Timeout on my
Palm during the sing in. The connections seems to be working. 

dund shows: 
	dund[2295]: New connection from 00:07:E0:0B:81:92
there's nothing more in /var/log/messages

it's started with 
	dund --listen --persist --msdun call dun

/etc/ppp/peers/dun contains
debug
57600
noipdefault
proxyarp
192.168.1.99:192.168.1.98
ms-dns 192.168.1.1
ktune
noauth
local
nodefaultroute
noipx

has anybody an idea? 

here's the output of hcidump. i don't know what the output means, but
for me it looks like there's some kind of communication ;-)

thanks for your help

HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request(0x04) plen 10
< HCI Command: Accept Connection Request(0x01|0x0009) plen 7
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connect Complete(0x03) plen 11
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
> HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
> HCI Event: Max Slots Change(0x1b) plen 3
> HCI Event: Command Complete(0x0e) plen 6
< HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connection Packet Type Changed(0x1d) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 1]
        SDP SS Req: tid 0x0 len 0x8
          pat uuid-16 0x1102 (LAN)
          max 0x1
          cont 00
< ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x40 len 14 [psm 1]
        SDP SS Rsp: tid 0x0 len 0x9
          cur 0x1 tot 0x1 hndl 0x804ce70
          cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 21
    L2CAP(d): cid 0x40 len 17 [psm 1]
        SDP SA Req: tid 0x1 len 0xc
          hndl 0x804ce70
          max 0xffff
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 0x0029 flags 0x02 dlen 31
    L2CAP(d): cid 0x40 len 27 [psm 1]
        SDP SA Rsp: tid 0x1 len 0x16
          cnt 0x13
          aid 0x0004 (ProtocolDescList)
             uuid-16 0x0100 (L2CAP)
             uuid-16 0x0003 (RFCOMM) uint 0x1

          cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 21
    L2CAP(d): cid 0x40 len 17 [psm 1]
        SDP SA Req: tid 0x2 len 0xc
          hndl 0x804ce70
          max 0xffff
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 0x0029 flags 0x02 dlen 31
    L2CAP(d): cid 0x40 len 27 [psm 1]
        SDP SA Rsp: tid 0x2 len 0x16
          cnt 0x13
          aid 0x0004 (ProtocolDescList)
             uuid-16 0x0100 (L2CAP)
             uuid-16 0x0003 (RFCOMM) uint 0x1

          cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 4
    MTU 1024
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x41 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x40 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 0 ack_timer 0 frame_size
328 max_retrans 0 credits 1
< ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x41 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 0 ack_timer 0 frame_size
328 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x41 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x41 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x40 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x41 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x40 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x41 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86
> ACL data: handle 0x0029 flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 37 fcs 0x9a
> ACL data: handle 0x0029 flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 37 fcs 0x9a
> ACL data: handle 0x0029 flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 37 fcs 0x9a
> ACL data: handle 0x0029 flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 37 fcs 0x9a
> ACL data: handle 0x0029 flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 37 fcs 0x9a
> ACL data: handle 0x0029 flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 37 fcs 0x9a
> ACL data: handle 0x0029 flags 0x02 dlen 45
    L2CAP(d): cid 0x40 len 41 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 37 fcs 0x9a
> ACL data: handle 0x0029 flags 0x02 dlen 46
    L2CAP(d): cid 0x40 len 42 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 38 fcs 0x9a
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 2 pf 1 ilen 0 fcs 0xb8
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x41 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0041
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0041
> HCI Event: Number of Completed Packets(0x13) plen 5
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

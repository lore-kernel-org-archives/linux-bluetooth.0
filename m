Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "J C" <jjcar1526@hotmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY14-F24b6JsnVnlBd00052861@hotmail.com>
Subject: [Bluez-users] Connection not completing?????  DT120 and T3 palm
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
Date: Thu, 18 Mar 2004 11:37:09 -0500

Hello all,

  I am having a problem.  I first set up on my linux workstation the 
software needed to get my T3 to surf the net through my linux box.  That all 
seems to work well.  I next tried to get it to work on a pc104+ embedded 
computer.  I am running the same kernel and have set things up the same way. 
  But when I try to connect the palm to the embedded computer it fails.

  I can scan the T3 using hcitool scan.  I just am not sure why there is a 
disconnect instead of the connection being passed so the dund daemon can 
pick it up and start a ppp connection.  As I mentioned earlier this all 
works on my work station.  I have spd, hcid, and dund all running.  All the 
necessary modules load up fine too.  If anyone could please advise me.

Thanks John

Here is a listing from hcidump

HCIDump - HCI packet analyzer ver 1.7
>HCI Event: Connect Request(0x04) plen 10
< HCI Command: Accept Connection Request(0x01|0x0009) plen 7
>HCI Event: Command Status(0x0f) plen 4
>HCI Event: Role Change(0x12) plen 8
>HCI Event: Connect Complete(0x03) plen 11
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
>HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
>HCI Event: Command Complete(0x0e) plen 6
< HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
>HCI Event: Command Status(0x0f) plen 4
>HCI Event: Connection Packet Type Changed(0x1d) plen 5
>HCI Event: Max Slots Change(0x1b) plen 3
>ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
>HCI Event: Number of Completed Packets(0x13) plen 5
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
>ACL data: handle 0x0029 flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 1]
        SDP SS Req: tid 0x0 len 0x8
          pat uuid-16 0x1102 (LAN)
          max 0x1
          cont 00
< ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x40 len 14 [psm 1]
        SDP SS Rsp: tid 0x0 len 0x9
          tot 0x1 cur 0x1 hndl 0x805d340
          cont 00
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0029 flags 0x02 dlen 21
    L2CAP(d): cid 0x40 len 17 [psm 1]
        SDP SA Req: tid 0x1 len 0xc
          hndl 0x805d340
          max 0xffff
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 0x0029 flags 0x02 dlen 31
    L2CAP(d): cid 0x40 len 27 [psm 1]
        SDP SA Rsp: tid 0x1 len 0x16
          cnt 0x13
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0x2 > >

          cont 00
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0029 flags 0x02 dlen 21
    L2CAP(d): cid 0x40 len 17 [psm 1]
        SDP SA Req: tid 0x2 len 0xc
          hndl 0x805d340
          max 0xffff
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 0x0029 flags 0x02 dlen 31
    L2CAP(d): cid 0x40 len 27 [psm 1]
        SDP SA Rsp: tid 0x2 len 0x16
          cnt 0x13
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0x2 > >

          cont 00
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
>ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
>HCI Event: Number of Completed Packets(0x13) plen 5
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 4
    MTU 1024
>HCI Event: Number of Completed Packets(0x13) plen 5
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
>ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x41 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x40 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 4 frame_type 0 credit_flow 15 pri 0 ack_timer 0 frame_size 328 
max_retrans 0 credits 1
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x41 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 4 pf 1 ilen 0 fcs 0xbc
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0041
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0041
>HCI Event: Number of Completed Packets(0x13) plen 5
>HCI Event: Disconn Complete(0x05) plen 4

_________________________________________________________________
Get reliable access on MSN 9 Dial-up. 3 months for the price of 1! 
(Limited-time offer) http://click.atdmt.com/AVE/go/onm00200361ave/direct/01/



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

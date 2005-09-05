Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <2554.193.48.73.126.1125927739.squirrel@webmail.essi.fr>
From: "Steve MOREAU" <moreau@essi.fr>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: [Bluez-users] (no subject)
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
Date: Mon, 5 Sep 2005 15:42:19 +0200 (CEST)

Hello,

I've met a problem using a bluetooth device and I don't now what to do...
I'm trying to connect a master device (at least I suppose... because the
PC is waiting for the data and l2ping doesn't work) that sends data to my
PC (Linux Fedora Core 4) when I ask it. Until now, I use hcidump to see
data from the device :

Linux : hcidump
Device : Transmit button

It gives me that :

HCI sniffer - Bluetooth packet analyzer ver 1.25
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Disconn Complete (0x05) plen 4
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SS Req: tid 0x1 len 0xa
          pat uuid-32 0x1103 (DUN)
          max 40
          cont 00
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x9
          count 1
          handle 0x10001
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 21
    L2CAP(d): cid 0x0040 len 17 [psm 1]
        SDP SA Req: tid 0x2 len 0xc
          handle 0x10001
          max 38
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 41 flags 0x02 dlen 31
    L2CAP(d): cid 0x0040 len 27 [psm 1]
        SDP SA Rsp: tid 0x2 len 0x16
          count 19
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0x1 > >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 325
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 1024
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      Success
      MTU 325
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 0 ack_timer 0
      frame_size 319 max_retrans 0 credits 0
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
> HCI Event: Number of Completed Packets (0x13) plen 5

hcidump then stays in blocking way, probably waiting for the device to
send something to it. I wonder if it usual to have "DM" packet in respons=
e
to an "PN CMD". I read bluez archives this afternoon and read Marcel pdf
to understand bluetooth protocol. I also found a quoatation saying a "PN
CMD" request can be a "PN CMD" or a "DM" answer. I wonder if my Linux
configuration is good. I had already had a problem with the DUN connectio=
n
that was blocking hcidump here :

> ACL data: handle 41 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SS Req: tid 0x1 len 0xa
          pat uuid-32 0x1103 (DUN)
          max 40
          cont 00

I solved it with :

1. service dund start
2. sdptool add DUN
3. sdpd

And now the trace is longer but I can't still get my data... Did I miss
something else ? I can't find PN CMD in bluetooth specifiaction (what
Parameter Negotiation means ?), I'm not sure it is due to that...

Have you already meet this problem ?

Thanks in advance

Steve



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

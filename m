Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <40329CA6.7080302@mdolabs.com>
From: Andy Ross <andy@mdolabs.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------060400030404050409090905"
Subject: [Bluez-devel] RFCOMM bug?
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 17 Feb 2004 14:58:46 -0800

This is a multi-part message in MIME format.
--------------060400030404050409090905
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I'm having some trouble with the bluez implementation as distributed
with fedora.  I thought for a long time that this was a bug on the
device (Ericsson P900 / Symbian 7.0) side of the connection, but it's
now looking like a kernel issue on the linux box.

The app on the other side is a simple RFCOMM echoer.  It reads a byte
at a time and writes it back out to the socket.  I'm connecting to it
with a "cat /dev/rfcomm1", while I do a "echo a > /dev/rfcomm1" from
another shell.  What comes back is an unending spew of bytes, mostly
(but oddly not entirely) derived from the "a\r\n" that went out the
terminal initially.

FWIW, I see almost identical behavior when connecting to the "modem"
device on the phone.  The AT command work (in the sense that I can see
the desired output appear on the socket), but come back as part of an
infinite garbage stream.

Attached is the result of an hcidump -tx of such a session.  Note that
the local machine never stops sending data, despite the fact that I
can verify with strace that only 3 bytes of data are ever written to
the rfcomm device.

Can anyone shed some light on this?

Andy

--------------060400030404050409090905
Content-Type: text/plain;
 name="hci-log.tty"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hci-log.tty"

HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff
1077057403.092894 < HCI Command: Create Connection(0x01|0x0005) plen 13
  E3 58 E8 D9 0A 00 18 CC 01 00 00 00 01 
1077057403.099367 > HCI Event: Command Status(0x0f) plen 4
  00 01 05 04 
1077057405.062120 > HCI Event: Connect Complete(0x03) plen 11
  00 28 00 E3 58 E8 D9 0A 00 01 00 
1077057405.062400 < ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
1077057405.062413 < HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
  28 00 0E 00 
1077057405.070114 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 28 00 01 00 
1077057405.073116 > HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 28 00 
1077057405.117115 > HCI Event: Max Slots Change(0x1b) plen 3
  28 00 05 
1077057406.027997 > ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0048 scid 0x0040 result 1 status 2
1077057406.143983 > ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0048 scid 0x0040 result 0 status 0
1077057406.144234 < ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0048 flags 0x0000 clen 4
    MTU 1024 
1077057406.151987 > ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
1077057406.152978 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 28 00 01 00 
1077057406.152999 < ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0048 flags 0x0000 result 0 clen 0
1077057406.159001 > ACL data: handle 0x0028 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 4
    MTU 672 
1077057406.159977 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 28 00 01 00 
1077057406.166292 < ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x48 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
1077057406.174974 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 28 00 01 00 
1077057406.196974 > ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
1077057406.197056 < ACL data: handle 0x0028 flags 0x02 dlen 18
    L2CAP(d): cid 0x48 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 10 frame_type 0 credit_flow 15 pri 7 ack_timer 0 frame_size 667 max_retrans 0 credits 7
1077057406.206978 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 28 00 01 00 
1077057406.234970 > ACL data: handle 0x0028 flags 0x02 dlen 17
1077057406.242968 > ACL data: handle 0x0028 flags 0x01 dlen 1
    L2CAP(d): cid 0x40 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 10 frame_type 0 credit_flow 14 pri 7 ack_timer 0 frame_size 667 max_retrans 0 credits 3
1077057406.243029 < ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x48 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 10 pf 1 ilen 0 fcs 0x8c 
1077057406.247967 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 28 00 01 00 
1077057406.288964 > ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 10 pf 1 ilen 0 fcs 0x47 
1077057406.289036 < ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(d): cid 0x48 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 10 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 0
1077057406.304962 > ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(d): cid 0x40 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 10 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 0
1077057406.305006 < ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(d): cid 0x48 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 10 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 0
1077057406.305958 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 28 00 01 00 
1077057406.310970 > ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(d): cid 0x40 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 10 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 0
1077057406.311016 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x48 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 10 pf 1 ilen 0 fcs 0xac 
      21 
1077057406.311957 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 28 00 01 00 
1077057406.316958 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 28 00 01 00 


       ==========================================
       = Connection is established, I now do a: =
       =  echo a > /dev/rfcomm1                 =
       ==========================================


1077057417.282291 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x48 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 10 pf 0 ilen 1 fcs 0xb0 
      61 
1077057417.282310 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x48 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 10 pf 0 ilen 1 fcs 0xb0 
      0D 
1077057417.282315 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x48 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 10 pf 0 ilen 1 fcs 0xb0 
      0A 
1077057417.291570 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 28 00 01 00 
1077057417.293572 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 28 00 01 00 
1077057417.295569 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 28 00 01 00 
1077057417.313579 > ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 10 pf 1 ilen 0 fcs 0x76 
      05 
1077057417.320571 > ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 10 pf 0 ilen 1 fcs 0x6a 
      61 
1077057417.320610 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x48 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 10 pf 0 ilen 1 fcs 0xb0 
      61 
1077057417.324567 > ACL data: handle 0x0028 flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 10 pf 1 ilen 1 fcs 0x76 
      01 0D 
1077057417.324590 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x48 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 10 pf 0 ilen 1 fcs 0xb0 
      0D 
1077057417.324595 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x48 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 10 pf 0 ilen 1 fcs 0xb0 
      0A 
1077057417.327575 > ACL data: handle 0x0028 flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 10 pf 1 ilen 1 fcs 0x76 
      01 0A 
1077057417.328567 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 28 00 01 00 
1077057417.329579 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 28 00 01 00 
1077057417.331231 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x48 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 10 pf 0 ilen 1 fcs 0xb0 
      0D 
1077057417.331245 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x48 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 10 pf 0 ilen 1 fcs 0xb0 
      0A 
1077057417.331568 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 28 00 01 00 
1077057417.341570 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 28 00 01 00 
1077057417.341576 > ACL data: handle 0x0028 flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 10 pf 1 ilen 1 fcs 0x76 
      02 61 
1077057417.341623 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x48 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 10 pf 0 ilen 1 fcs 0xb0 
      61 
1077057417.342566 > ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 10 pf 0 ilen 1 fcs 0x6a 
      0D 
1077057417.342601 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x48 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 10 pf 0 ilen 1 fcs 0xb0 
      0D 
1077057417.342607 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x48 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 10 pf 0 ilen 1 fcs 0xb0 
      0A 
1077057417.346563 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 28 00 01 00 
1077057417.347567 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 28 00 01 00 
1077057417.349563 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 28 00 01 00 
1077057417.349583 > ACL data: handle 0x0028 flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 10 pf 1 ilen 1 fcs 0x76 
      01 0A 
1077057417.349616 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x48 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 10 pf 0 ilen 1 fcs 0xb0 
      0D 
1077057417.349623 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x48 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 10 pf 0 ilen 1 fcs 0xb0 
      0A 
1077057417.354561 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 28 00 01 00 
1077057417.354564 > ACL data: handle 0x0028 flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 10 pf 1 ilen 1 fcs 0x76 
      01 0D 
1077057417.354588 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x48 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 10 pf 0 ilen 1 fcs 0xb0 
      0D 
1077057417.356562 > ACL data: handle 0x0028 flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 10 pf 1 ilen 1 fcs 0x76 
      01 0A 
1077057417.356585 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x48 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 10 pf 0 ilen 1 fcs 0xb0 
      0A 
1077057417.357563 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 28 00 01 00 
1077057417.359562 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 28 00 01 00 
1077057417.359565 > ACL data: handle 0x0028 flags 0x02 dlen 10
    L2CAP(d): cid 0x40 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 10 pf 1 ilen 1 fcs 0x76 
      01 61 
1077057417.359592 < ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x48 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 10 pf 0 ilen 1 fcs 0xb0 
      0D 


       ===========================
       = And so on, ad infinitum =
       ===========================

--------------060400030404050409090905--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

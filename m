Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Sascha Ziemann <ziemann@secunet.de>
To: bluez-users@lists.sourceforge.net
References: <20050823050058.8940.qmail@web35314.mail.mud.yahoo.com>
In-Reply-To: <20050823050058.8940.qmail@web35314.mail.mud.yahoo.com> (Swathi
	Mathur's message of "Mon, 22 Aug 2005 22:00:57 -0700 (PDT)")
Message-ID: <87fyt15a5b.fsf@secunet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] O2 XDA mini and DUND
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
Date: Tue, 23 Aug 2005 10:29:20 +0200

Hi,

I have some problems to configure DUN access for the XDA mini.  I use
the description for the XDA II:

http://wiki.xda-developers.com/wiki/bluetoothnetworking

but it does not work at all.  If I understand it right the DUND should
start the PPPD to enable the PPP handshake, but DUND reports only a
timeout error (110) and a protocol error (71).  I could not find any
DUND option to enable any debuging output.

The basic communication works.  I can search on each side each other
and I can l2ping from my Debian system the XDA mini.

After this I tried HCIDUMP, but I dont understand the output.  How can
I analyse this problem further?  Is anybody here able to read the
HCIDUMP output?

----------------------------------------------------------------------
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:09:2D:1C:A3:72 class 0x100114 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:09:2D:1C:A3:72 type ACL encrypt 0x00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0067
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0067 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 4096 
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0067 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0067 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 17
> ACL data: handle 41 flags 0x01 dlen 19
    L2CAP(d): cid 0x0040 len 32 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1b
          pat uuid-128 00001103-0000-1000-8000-00805f9b34fb
          max 4088
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 41 flags 0x02 dlen 33
    L2CAP(d): cid 0x0067 len 29 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x18
          count 21
          record #0
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x1 > >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0068
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0068 result 0 status 0
      Connection successful
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0067
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0067
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0068 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0068 flags 0x00 clen 4
      MTU 1024 
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0068 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 32 ack_timer 0
      frame_size 1024 max_retrans 0 credits 7
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0068 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73 
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0068
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0068
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0069
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0069 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 4096 
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0069 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0069 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 36
    L2CAP(d): cid 0x0040 len 32 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1b
          pat uuid-128 00001103-0000-1000-8000-00805f9b34fb
          max 4088
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 41 flags 0x02 dlen 33
    L2CAP(d): cid 0x0069 len 29 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x18
          count 21
          record #0
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x1 > >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x006a
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x006a result 0 status 0
      Connection successful
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0069
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0069
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x006a flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x006a flags 0x00 clen 4
      MTU 1024 
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x006a len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 32 ack_timer 0
      frame_size 1024 max_retrans 0 credits 7
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x006a len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73 
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x006a
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x006a
> HCI Event: Number of Completed Packets (0x13) plen 5
< HCI Command: Disconnect (0x01|0x0006) plen 3
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x16
    Reason: Connection Terminated by Local Host
----------------------------------------------------------------------

Regards
Ziemann




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

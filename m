Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Jouni.Lohikoski@iki.fi" <jlohikos@cc.hut.fi>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] HID mouse doesnt reconnect after sleep if bemused-bemusedlinuxserver connection is open
Message-ID: <20041017201517.GA323918@kosh.hut.fi>
Reply-To: bluez-users@lists.sourceforge.net
References: <20041017125132.GA274769@kosh.hut.fi> <1098018136.4911.87.camel@pegasus> <20041017133034.GC274769@kosh.hut.fi> <1098026676.4911.96.camel@pegasus> <20041017165348.GA292044@kosh.hut.fi> <1098032261.4911.102.camel@pegasus> <20041017184054.GA306443@kosh.hut.fi> <1098042076.21553.0.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1098042076.21553.0.camel@pegasus>
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
Date: Sun, 17 Oct 2004 23:15:17 +0300

On Sun, Oct 17, 2004 at 09:41:16PM +0200, Marcel Holtmann wrote:
> it is enough to do "hciconfig hci0 noauth noencrypt" for testing this,
> but if this not helps then you should buy yourself a Bluetooth dongle
> with at least HCI 16.4 firmware on it.

Ok. It is not huge problem, as I can always disconnect the bemused
connection for a moment to reconnect the HID mouse.

But still I don't quite understand why it works otherway around,
so if HID mouse connection is open and working, I can connect with
Bemused client to bemusedlinuxserver whether hcid was in security mode 3
or not, and both works until HID mouse is idle long enough to go in the
sleep mode.

One thing I didn't try. Although HID mouse now made a connection without
authentication and encryption, maybe it remembered it has to
authenticate and tried it just like before when hcid was in security
mode 3. The following hcidump may tell if this was the case for someone
who is used to read those dumps?

// jouni

p.s.
hcidump where bemused connection is closed down after I try to
reconnect the HID mouse and waited about 10 secs when hcidump didn't
show anything incoming or outgoing.  Either packets were hanging and
buffered somewhere, or the mouse then still tried reconnecting .,..and
also succeeded now after bemused connection was shut down.


HCIDump - HCI packet analyzer ver 1.9
device: hci0 snap_len: 1028 filter: 0xffffffff
> ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x41 len 4 [psm 0]
      53 53 01 1C 
< ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x52 len 4 [psm 0]
      53 73 01 36 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00 
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0052
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0052
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00 
< HCI Command: Disconnect (0x01|0x0006) plen 3
  28 00 13 
> HCI Event: Command Status (0x0f) plen 4
  00 01 06 04 
> HCI Event: Disconn Complete (0x05) plen 4
  00 28 00 16 
> HCI Event: Connect Request (0x04) plen 10
  88 00 82 61 04 00 80 25 00 01 
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  88 00 82 61 04 00 00 
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04 
> HCI Event: Role Change (0x12) plen 8
  00 88 00 82 61 04 00 00 
> HCI Event: Link Key Request (0x17) plen 6
  88 00 82 61 04 00 
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  88 00 82 61 04 00 38 D3 3A 63 75 CA A6 FC 0A 56 AB 1B CB 9F 
  75 A0 
> HCI Event: Command Complete (0x0e) plen 10
  01 0B 04 00 88 00 82 61 04 00 
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  88 00 82 61 04 00 38 D3 3A 63 75 CA A6 FC 0A 56 AB 1B CB 9F 
  75 A0 
> HCI Event: Command Complete (0x0e) plen 10
  01 0B 04 00 88 00 82 61 04 00 
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  88 00 82 61 04 00 38 D3 3A 63 75 CA A6 FC 0A 56 AB 1B CB 9F 
  75 A0 
> HCI Event: Command Complete (0x0e) plen 10
  01 0B 04 00 88 00 82 61 04 00 
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  88 00 82 61 04 00 38 D3 3A 63 75 CA A6 FC 0A 56 AB 1B CB 9F 
  75 A0 
> HCI Event: Command Complete (0x0e) plen 10
  01 0B 04 00 88 00 82 61 04 00 
> HCI Event: Connect Complete (0x03) plen 11
  00 29 00 88 00 82 61 04 00 01 00 
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  29 00 0F 00 
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  88 00 82 61 04 00 01 
> HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 29 00 
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
  29 00 18 CC 
> HCI Event: Max Slots Change (0x1b) plen 3
  29 00 05 
> HCI Event: Command Status (0x0f) plen 4
  00 01 0F 04 
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  00 29 00 18 CC 
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0059
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0059 result 0 status 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 6
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 28
    MTU 48 Unknown (type 03, len 22) 
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0059 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0059 flags 0x0000 clen 4
    MTU 48 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: QoS Setup Complete (0x0d) plen 21
  00 29 00 00 01 00 00 00 00 00 00 00 00 FF FF FF FF FF FF FF 
  FF 
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x005a
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x005a result 0 status 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 40
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 28
    MTU 48 Unknown (type 03, len 22) 
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x005a flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x005a flags 0x0000 clen 4
    MTU 48 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0042
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 01 00 00 00 
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x005b scid 0x0042 result 1 status 2
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 00 00 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 00 FF 00 
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x005b scid 0x0042 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x005b flags 0x0000 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 03 FB 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 04 F9 00 
> HCI Event: Mode Change (0x14) plen 6
  00 29 00 02 14 00 
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0042 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0042 flags 0x0000 clen 4
    MTU 48 
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x005b flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 24
    L2CAP(d): cid 0x5b len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1200 (PNPInfo)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 04 F8 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 04 F9 00 
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x42 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
          cont 00 
< ACL data: handle 0x0029 flags 0x02 dlen 24
    L2CAP(d): cid 0x5b len 20 [psm 1]
        SDP SSA Req: tid 0x1 len 0xf
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 04 F9 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 03 FC 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 02 FD 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 01 FD 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 01 00 00 
> ACL data: handle 0x0029 flags 0x02 dlen 52
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x2b
          cnt 0x26
          srv rec #0
            aid 0x0000 (SrvRecHndl)
               uint 0x10000
            aid 0x0001 (SrvClassIDList)
               < uuid-16 0x1124 (HID) >
            aid 0x0004 (ProtocolDescList)
               < < uuid-16 0x0100 (L2CAP) uint 0x11 > <
               uuid-16 0x0200 > >

ERROR: Unexpected syntax

          cont 
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x5b len 22 [psm 1]
        SDP SSA Req: tid 0x2 len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 FB 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 FB F7 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 FF FF 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 FE FF 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 FF 00 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 FE 00 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 FE 00 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 FE 00 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 FD FF 00 
> ACL data: handle 0x0029 flags 0x02 dlen 52
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0x2 len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          11 09 00 06 35 09 09 65 6E 09 00 6A 09 01 00 09 00 09 35 08 
          35 06 19 11 24 09 01 00 09 00 0D 35 0F 35 0D 35 06 02 00 D5 
          cont 11 09 00 06 35 09 09 65 6E 09 00 6A 09 01 00 09 00 09 35 08 35 06 19 11 24 09 01 00 09 00 0D 35 0F 35 0D 35 06 02 00 D5 
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x5b len 22 [psm 1]
        SDP SSA Req: tid 0x3 len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 D5 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 FC FF 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 FC FF 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 FE FF 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 FE 00 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 FF 00 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 FF 00 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 00 FF 00 
> ACL data: handle 0x0029 flags 0x02 dlen 52
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0x3 len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          01 00 09 00 13 35 03 19 00 11 09 01 00 25 09 43 53 52 20 4D 
          6F 75 73 65 09 01 01 25 12 54 68 72 65 65 20 42 75 02 00 AF 
          cont 01 00 09 00 13 35 03 19 00 11 09 01 00 25 09 43 53 52 20 4D 6F 75 73 65 09 01 01 25 12 54 68 72 65 65 20 42 75 02 00 AF 
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x5b len 22 [psm 1]
        SDP SSA Req: tid 0x4 len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 AF 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 52
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0x4 len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          74 6F 6E 20 4D 6F 75 73 65 09 01 02 25 0D 43 53 52 20 48 49 
          44 45 6E 67 69 6E 65 09 02 00 09 01 00 09 02 01 09 02 00 89 
          cont 74 6F 6E 20 4D 6F 75 73 65 09 01 02 25 0D 43 53 52 20 48 49 44 45 6E 67 69 6E 65 09 02 00 09 01 00 09 02 01 09 02 00 89 
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x5b len 22 [psm 1]
        SDP SSA Req: tid 0x5 len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 89 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 52
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0x5 len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          00 09 02 02 08 80 09 02 03 08 33 09 02 04 28 01 09 02 05 28 
          01 09 02 06 35 3C 35 3A 08 22 25 36 05 01 09 02 A1 02 00 63 
          cont 00 09 02 02 08 80 09 02 03 08 33 09 02 04 28 01 09 02 05 28 01 09 02 06 35 3C 35 3A 08 22 25 36 05 01 09 02 A1 02 00 63 
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x5b len 22 [psm 1]
        SDP SSA Req: tid 0x6 len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 63 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 52
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0x6 len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          09 01 A1 00 85 02 05 09 19 01 29 03 15 00 25 01 95 03 75 01 
          81 02 95 01 75 05 81 03 05 01 09 30 09 31 09 38 15 02 00 3D 
          cont 09 01 A1 00 85 02 05 09 19 01 29 03 15 00 25 01 95 03 75 01 81 02 95 01 75 05 81 03 05 01 09 30 09 31 09 38 15 02 00 3D 
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x5b len 22 [psm 1]
        SDP SSA Req: tid 0x7 len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 3D 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 52
    L2CAP(d): cid 0x42 len 48 [psm 1]
        SDP SSA Rsp: tid 0x7 len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          25 7F 75 08 95 03 81 06 C0 C0 09 02 07 35 08 35 06 09 04 09 
          09 01 00 09 02 08 28 00 09 02 09 28 01 09 02 0A 28 02 00 17 
          cont 25 7F 75 08 95 03 81 06 C0 C0 09 02 07 35 08 35 06 09 04 09 09 01 00 09 02 08 28 00 09 02 09 28 01 09 02 0A 28 02 00 17 
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x5b len 22 [psm 1]
        SDP SSA Req: tid 0x8 len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 17 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 35
    L2CAP(d): cid 0x42 len 31 [psm 1]
        SDP SSA Rsp: tid 0x8 len 0x1a
          cnt 0x17

ERROR: Unexpected syntax
          09 02 0B 09 01 00 09 02 0C 09 1F 40 09 02 0D 28 00 09 02 0E 
          28 01 00 
          cont 09 02 0B 09 01 00 09 02 0C 09 1F 40 09 02 0D 28 00 09 02 0E 28 01 00 
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x005b scid 0x0042
< ACL data: handle 0x0029 flags 0x02 dlen 5
    L2CAP(d): cid 0x59 len 1 [psm 17]
      HIDP: Set protocol: Boot protocol
< ACL data: handle 0x0029 flags 0x02 dlen 7
    L2CAP(d): cid 0x5a len 3 [psm 19]
      HIDP: Data: Output report
      01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x005b scid 0x0042
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 5
    L2CAP(d): cid 0x40 len 1 [psm 17]
      HIDP: Handshake: Successful
> HCI Event: Mode Change (0x14) plen 6
  00 29 00 00 00 00 
> HCI Event: Mode Change (0x14) plen 6
  00 29 00 02 28 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 01 00 00 
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 05 FE 00 
> HCI Event: Mode Change (0x14) plen 6
  00 29 00 00 00 00 

  .... mouse works normally.



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

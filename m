Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Paul Hedderly <bulkpaul@mjr.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Message-ID: <20040915114002.GM26469@wacka.mjr.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Subject: [Bluez-users] Cheap BT Mouse - reconnect problem
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
Date: Wed, 15 Sep 2004 12:40:02 +0100


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I also just got a Bluetooth mouse.

I'm using the hidp module (2.4.27-mh1) and Debian bluez-XXX 2.9-3.

The mouse pairs and works great. Until... the time out or a need to
re-connect from distance separation/reboot etc.

It originally paired as:
New HID device 00:04:61:81:77:80 (CSR HIDEngine Three Button Mouse)

Pressing a button on the mouse gives me another pin prompt.. but no
mouse. The only way to reconnect is to repair (there is
a button on the bottom side of the mouse.) Sometimes I've had to rm
/etc/bluetooth/link_key. (Is there a way to remove individual keys from
that file?)

So on an attempted re-connect (press a button on the mouse) I get
(hcidump and logs combined):

> HCI Event: Connect Request (0x04) plen 10
  80 77 81 61 04 00 80 25 00 01
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  80 77 81 61 04 00 01
> HCI Event: Command Status (0x0f) plen 4
  00 04 09 04
> HCI Event: Link Key Request (0x17) plen 6
  80 77 81 61 04 00
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
  80 77 81 61 04 00
> HCI Event: Command Complete (0x0e) plen 10
  04 0C 04 00 80 77 81 61 04 00
> HCI Event: PIN Code Request (0x16) plen 6
  80 77 81 61 04 00
> HCI Event: Link Key Request (0x17) plen 6
  80 77 81 61 04 00
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
  80 77 81 61 04 00
> HCI Event: Command Complete (0x0e) plen 10
  04 0C 04 00 80 77 81 61 04 00
> HCI Event: Connect Complete (0x03) plen 11
  06 01 00 80 77 81 61 04 00 01 01
Sep 15 12:26:19 weeblu hcid[2929]: link_key_request (sba=00:E0:03:25:68:98, dba=00:04:61:81:77:80)
Sep 15 12:26:19 weeblu hcid[2929]: pin_code_request (sba=00:E0:03:25:68:98, dba=00:04:61:81:77:80)
Sep 15 12:26:19 weeblu hcid[2929]: link_key_request (sba=00:E0:03:25:68:98, dba=00:04:61:81:77:80)
Sep 15 12:26:19 weeblu hcid[2929]: link_key_request (sba=00:E0:03:25:68:98, dba=00:04:61:81:77:80)
Sep 15 12:26:19 weeblu hcid[2929]: pin_code_request (sba=00:E0:03:25:68:98, dba=00:04:61:81:77:80)
Sep 15 12:26:19 weeblu hcid[2929]: link_key_request (sba=00:E0:03:25:68:98, dba=00:04:61:81:77:80)
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
  80 77 81 61 04 00 04 31 32 33 34 00 00 00 00 00 00 00 00 00
  00 00 00
> HCI Event: Command Complete (0x0e) plen 10
  04 0D 04 02 80 77 81 61 04 00

Trying a to force a reconnect from the computer gives:

weeblu:/tmp/bluez-utils-2.10/hidd# hidd -c 00:04:61:81:77:80
Can't create HID control channel: Host is down
weeblu:/tmp/bluez-utils-2.10/hidd# hidd -c 00:04:61:81:77:80
Can't create HID control channel: Host is down

(Even making sure the mouse is on by pressing a button regularly)
hcidump -x showed:

< HCI Command: Create Connection (0x01|0x0005) plen 13
  80 77 81 61 04 00 18 CC 02 00 00 00 00
> HCI Event: Command Status (0x0f) plen 4
  00 04 05 04
> HCI Event: Connect Complete (0x03) plen 11
  04 01 00 80 77 81 61 04 00 01 01
< HCI Command: Create Connection (0x01|0x0005) plen 13
  80 77 81 61 04 00 18 CC 02 00 00 00 00
> HCI Event: Command Status (0x0f) plen 4
  00 04 05 04
> HCI Event: Connect Complete (0x03) plen 11
  04 01 00 80 77 81 61 04 00 01 01

I've attached a combined hcidump/sylog of a pair process.

I'm using a pin of 1234 - which is what worked when initially repairing.
But I've tried 0000 and "".

I've had a butchers at hidd/main.c - mostly to see if I can turn on more
debugging, but also to see what changed from 2.9 to 2.10 - and I can see
nothing that should change anything here, I think.

I have no idea what the -t (timeout) option does. Can anyone shed light
on that?

Any help much appreciated!

--
Paul



--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="MouseRePair.txt"

< HCI Command: Create Connection (0x01|0x0005) plen 13
  80 77 81 61 04 00 18 CC 02 00 00 00 00
> HCI Event: Command Status (0x0f) plen 4
  00 04 05 04
> HCI Event: Link Key Request (0x17) plen 6
  80 77 81 61 04 00
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
  80 77 81 61 04 00
> HCI Event: Command Complete (0x0e) plen 10
  04 0C 04 00 80 77 81 61 04 00
> HCI Event: PIN Code Request (0x16) plen 6
  80 77 81 61 04 00
Sep 15 12:35:51 weeblu hcid[2929]: link_key_request (sba=00:E0:03:25:68:98, dba=00:04:61:81:77:80)
Sep 15 12:35:51 weeblu hcid[2929]: pin_code_request (sba=00:E0:03:25:68:98, dba=00:04:61:81:77:80)
Sep 15 12:35:51 weeblu hcid[2929]: link_key_request (sba=00:E0:03:25:68:98, dba=00:04:61:81:77:80)
Sep 15 12:35:51 weeblu hcid[2929]: pin_code_request (sba=00:E0:03:25:68:98, dba=00:04:61:81:77:80)
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
  80 77 81 61 04 00 04 31 32 33 34 00 00 00 00 00 00 00 00 00
  00 00 00
> HCI Event: Command Complete (0x0e) plen 10
  04 0D 04 00 80 77 81 61 04 00
> HCI Event: Link Key Notification (0x18) plen 23
  80 77 81 61 04 00 D1 83 3F 87 ED BC D7 91 82 92 67 E4 37 A1
  71 C7 00
Sep 15 12:35:55 weeblu hcid[2929]: link_key_notify (sba=00:E0:03:25:68:98)
Sep 15 12:35:55 weeblu hcid[2929]: Saving link key 00:E0:03:25:68:98 00:04:61:81:77:80
Sep 15 12:35:55 weeblu hcid[2929]: link_key_notify (sba=00:E0:03:25:68:98)
Sep 15 12:35:55 weeblu hcid[2929]: Saving link key 00:E0:03:25:68:98 00:04:61:81:77:80
> HCI Event: Connect Complete (0x03) plen 11
  00 01 00 80 77 81 61 04 00 01 01
< ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  01 00 0F 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> HCI Event: Max Slots Change (0x1b) plen 3
  01 00 05
> HCI Event: Max Slots Change (0x1b) plen 3
  01 00 05
> HCI Event: Command Complete (0x0e) plen 6
  04 0D 08 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0106 scid 0x0040 result 1 status 2
> ACL data: handle 0x0001 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0106 scid 0x0040 result 0 status 0
< ACL data: handle 0x0001 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0106 flags 0x0000 clen 4
    MTU 48
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0001 flags 0x02 dlen 17
> ACL data: handle 0x0001 flags 0x01 dlen 17
> HCI Event: QoS Setup Complete (0x0d) plen 21
  00 01 00 00 01 B5 75 00 00 00 00 00 00 F2 2B 00 00 00 00 00
  00
> ACL data: handle 0x0001 flags 0x01 dlen 6
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 28
    MTU 48 Unknown (type 03, len 22)
< ACL data: handle 0x0001 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0106 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0107 scid 0x0041 result 1 status 2
> ACL data: handle 0x0001 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0107 scid 0x0041 result 0 status 0
< ACL data: handle 0x0001 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0107 flags 0x0000 clen 4
    MTU 48
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0001 flags 0x02 dlen 40
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 28
    MTU 48 Unknown (type 03, len 22)
< ACL data: handle 0x0001 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0107 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0042
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0108 scid 0x0042 result 1 status 2
> ACL data: handle 0x0001 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0108 scid 0x0042 result 0 status 0
< ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0108 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0042 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0001 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0042 flags 0x0000 clen 4
    MTU 48
< ACL data: handle 0x0001 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0108 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0001 flags 0x02 dlen 24
    L2CAP(d): cid 0x0108 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1200 (PNPInfo)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 14
    L2CAP(d): cid 0x0042 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
          cont 00
< ACL data: handle 0x0001 flags 0x02 dlen 24
    L2CAP(d): cid 0x0108 len 20 [psm 1]
        SDP SSA Req: tid 0x1 len 0xf
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 52
    L2CAP(d): cid 0x0042 len 48 [psm 1]
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
< ACL data: handle 0x0001 flags 0x02 dlen 26
    L2CAP(d): cid 0x0108 len 22 [psm 1]
        SDP SSA Req: tid 0x2 len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 FB
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 52
    L2CAP(d): cid 0x0042 len 48 [psm 1]
        SDP SSA Rsp: tid 0x2 len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          11 09 00 06 35 09 09 65 6E 09 00 6A 09 01 00 09 00 09 35 08
          35 06 19 11 24 09 01 00 09 00 0D 35 0F 35 0D 35 06 02 00 D5
          cont 11 09 00 06 35 09 09 65 6E 09 00 6A 09 01 00 09 00 09 35 08 35 06 19 11 24 09 01 00 09 00 0D 35 0F 35 0D 35 06 02 00 D5
< ACL data: handle 0x0001 flags 0x02 dlen 26
    L2CAP(d): cid 0x0108 len 22 [psm 1]
        SDP SSA Req: tid 0x3 len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 D5
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 52
    L2CAP(d): cid 0x0042 len 48 [psm 1]
        SDP SSA Rsp: tid 0x3 len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          01 00 09 00 13 35 03 19 00 11 09 01 00 25 09 43 53 52 20 4D
          6F 75 73 65 09 01 01 25 12 54 68 72 65 65 20 42 75 02 00 AF
          cont 01 00 09 00 13 35 03 19 00 11 09 01 00 25 09 43 53 52 20 4D 6F 75 73 65 09 01 01 25 12 54 68 72 65 65 20 42 75 02 00 AF
< ACL data: handle 0x0001 flags 0x02 dlen 26
    L2CAP(d): cid 0x0108 len 22 [psm 1]
        SDP SSA Req: tid 0x4 len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 AF
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 52
    L2CAP(d): cid 0x0042 len 48 [psm 1]
        SDP SSA Rsp: tid 0x4 len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          74 6F 6E 20 4D 6F 75 73 65 09 01 02 25 0D 43 53 52 20 48 49
          44 45 6E 67 69 6E 65 09 02 00 09 01 00 09 02 01 09 02 00 89
          cont 74 6F 6E 20 4D 6F 75 73 65 09 01 02 25 0D 43 53 52 20 48 49 44 45 6E 67 69 6E 65 09 02 00 09 01 00 09 02 01 09 02 00 89
< ACL data: handle 0x0001 flags 0x02 dlen 26
    L2CAP(d): cid 0x0108 len 22 [psm 1]
        SDP SSA Req: tid 0x5 len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 89
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 52
    L2CAP(d): cid 0x0042 len 48 [psm 1]
        SDP SSA Rsp: tid 0x5 len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          00 09 02 02 08 80 09 02 03 08 33 09 02 04 28 01 09 02 05 28
          01 09 02 06 35 3C 35 3A 08 22 25 36 05 01 09 02 A1 02 00 63
          cont 00 09 02 02 08 80 09 02 03 08 33 09 02 04 28 01 09 02 05 28 01 09 02 06 35 3C 35 3A 08 22 25 36 05 01 09 02 A1 02 00 63
< ACL data: handle 0x0001 flags 0x02 dlen 26
    L2CAP(d): cid 0x0108 len 22 [psm 1]
        SDP SSA Req: tid 0x6 len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 63
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 52
    L2CAP(d): cid 0x0042 len 48 [psm 1]
        SDP SSA Rsp: tid 0x6 len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          09 01 A1 00 85 02 05 09 19 01 29 03 15 00 25 01 95 03 75 01
          81 02 95 01 75 05 81 03 05 01 09 30 09 31 09 38 15 02 00 3D
          cont 09 01 A1 00 85 02 05 09 19 01 29 03 15 00 25 01 95 03 75 01 81 02 95 01 75 05 81 03 05 01 09 30 09 31 09 38 15 02 00 3D
< ACL data: handle 0x0001 flags 0x02 dlen 26
    L2CAP(d): cid 0x0108 len 22 [psm 1]
        SDP SSA Req: tid 0x7 len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 3D
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 52
    L2CAP(d): cid 0x0042 len 48 [psm 1]
        SDP SSA Rsp: tid 0x7 len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          25 7F 75 08 95 03 81 06 C0 C0 09 02 07 35 08 35 06 09 04 09
          09 01 00 09 02 08 28 00 09 02 09 28 01 09 02 0A 28 02 00 17
          cont 25 7F 75 08 95 03 81 06 C0 C0 09 02 07 35 08 35 06 09 04 09 09 01 00 09 02 08 28 00 09 02 09 28 01 09 02 0A 28 02 00 17
< ACL data: handle 0x0001 flags 0x02 dlen 26
    L2CAP(d): cid 0x0108 len 22 [psm 1]
        SDP SSA Req: tid 0x8 len 0x11
          pat uuid-16 0x1124 (HID)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 17
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 35
    L2CAP(d): cid 0x0042 len 31 [psm 1]
        SDP SSA Rsp: tid 0x8 len 0x1a
          cnt 0x17

ERROR: Unexpected syntax
          09 02 0B 09 01 00 09 02 0C 09 1F 40 09 02 0D 28 00 09 02 0E
          28 01 00
          cont 09 02 0B 09 01 00 09 02 0C 09 1F 40 09 02 0D 28 00 09 02 0E 28 01 00
< ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0108 scid 0x0042
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
< ACL data: handle 0x0001 flags 0x02 dlen 5
    L2CAP(d): cid 0x0106 len 1 [psm 17]
      HIDP: Set protocol: Boot protocol
< ACL data: handle 0x0001 flags 0x02 dlen 7
    L2CAP(d): cid 0x0107 len 3 [psm 19]
      HIDP: Data: Output report
      01 00
> ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0108 scid 0x0042
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00
> ACL data: handle 0x0001 flags 0x02 dlen 5
    L2CAP(d): cid 0x0040 len 1 [psm 17]
      HIDP: Handshake: Successful
Sep 15 12:35:56 weeblu hidd: New HID device 00:04:61:81:77:80 (CSR HIDEngine Three Button Mouse)
Sep 15 12:35:56 weeblu hidd: New HID device 00:04:61:81:77:80 (CSR HIDEngine Three Button Mouse)

--a8Wt8u1KmwUX3Y2C--


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

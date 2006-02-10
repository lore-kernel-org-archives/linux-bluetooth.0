Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43EBF81F.5000600@gmail.com>
From: nix4me@gmail.com
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Re: bluez and dbus
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
Date: Thu, 09 Feb 2006 19:19:11 -0700

Marcel,
I have sdpd, hcid, and hidd --server, in my rc.local for startup.

$hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.29
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 0
 > HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
 > HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:50:F2:E6:FF:46 mode 2 clkoffset 0x36ce class 0x002540
 > HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:50:F2:E6:FF:46 mode 2 clkoffset 0x36cd class 0x002540
 > HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:50:F2:E6:FF:46 mode 2 clkoffset 0x36cd class 0x002540
 > HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:50:F2:E6:FF:46 mode 2 clkoffset 0x36cd class 0x002540
 > HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:50:F2:E6:FF:46 mode 2 clkoffset 0x36cd class 0x002540
 > HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:50:F2:E6:FF:46 mode 2 clkoffset 0x36cd class 0x002540
 > HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:50:F2:E6:FF:46 mode 2 clkoffset 0x36cd class 0x002540
 > HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:50:F2:E6:FF:46 mode 2 clkoffset 0x36cd class 0x002540
 > HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:50:F2:E6:FF:46 mode 2 clkoffset 0x36cd class 0x002540
 > HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:50:F2:E6:FF:46 ptype 0xcc18 rswitch 0x01 clkoffset 0x36cd 
(valid)
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 6 bdaddr 00:50:F2:E6:FF:46 type ACL encrypt 0x00
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
 > ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 6 flags 0
    Service type: 0
    Token rate: 1511
    Peak bandwith: 0
    Latency: 0
    Delay variation: 0
 > ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
 > ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 6 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1200 (PNPInfo)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 2
 > ACL data: handle 6 flags 0x02 dlen 27
 > ACL data: handle 6 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x2b
          count 38
          cont 02 00 32
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0040 len 22 [psm 1]
        SDP SSA Req: tid 0x1 len 0x11
          pat uuid-16 0x1200 (PNPInfo)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 32
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 27
 > ACL data: handle 6 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x2b
          count 38
          cont 02 00 0C
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0040 len 22 [psm 1]
        SDP SSA Req: tid 0x2 len 0x11
          pat uuid-16 0x1200 (PNPInfo)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 0C
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 4
 > ACL data: handle 6 flags 0x01 dlen 20
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Rsp: tid 0x2 len 0xf
          count 12
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10001
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1200 (PNPInfo) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x1 > <
                 uuid-16 0x0001 (SDP) > >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1200 (PNPInfo) uint 0x100 > >
              aid 0x0200 (VersionNumList)
                 uint 0x100
              aid 0x0201 (SrvDBState)
                 uint 0x45e
              aid 0x0202 (unknown)
                 uint 0x7b
              aid 0x0203 (unknown)
                 uint 0x39
              aid 0x0204 (unknown)
                 bool 0x1
              aid 0x0205 (unknown)
                 uint 0x1
          cont 00
< ACL data: handle 6 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x3 len 0xf
          pat uuid-16 0x1124 (HID)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 27
 > ACL data: handle 6 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x3 len 0x2b
          count 38
          cont 02 02 23
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0040 len 22 [psm 1]
        SDP SSA Req: tid 0x4 len 0x11
          pat uuid-16 0x1124 (HID)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 02 23
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 27
 > ACL data: handle 6 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x4 len 0x2b
          count 38
          cont 02 01 FD
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0040 len 22 [psm 1]
        SDP SSA Req: tid 0x5 len 0x11
          pat uuid-16 0x1124 (HID)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 01 FD
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 27
 > ACL data: handle 6 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x5 len 0x2b
          count 38
          cont 02 01 D7
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0040 len 22 [psm 1]
        SDP SSA Req: tid 0x6 len 0x11
          pat uuid-16 0x1124 (HID)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 01 D7
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 27
 > ACL data: handle 6 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x6 len 0x2b
          count 38
          cont 02 01 B1
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0040 len 22 [psm 1]
        SDP SSA Req: tid 0x7 len 0x11
          pat uuid-16 0x1124 (HID)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 01 B1
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 27
 > ACL data: handle 6 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x7 len 0x2b
          count 38
          cont 02 01 8B
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0040 len 22 [psm 1]
        SDP SSA Req: tid 0x8 len 0x11
          pat uuid-16 0x1124 (HID)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 01 8B
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 27
 > ACL data: handle 6 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x8 len 0x2b
          count 38
          cont 02 01 65
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0040 len 22 [psm 1]
        SDP SSA Req: tid 0x9 len 0x11
          pat uuid-16 0x1124 (HID)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 01 65
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 27
 > ACL data: handle 6 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x9 len 0x2b
          count 38
          cont 02 01 3F
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0040 len 22 [psm 1]
        SDP SSA Req: tid 0xa len 0x11
          pat uuid-16 0x1124 (HID)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 01 3F
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 27
 > ACL data: handle 6 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0xa len 0x2b
          count 38
          cont 02 01 19
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0040 len 22 [psm 1]
        SDP SSA Req: tid 0xb len 0x11
          pat uuid-16 0x1124 (HID)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 01 19
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 27
 > ACL data: handle 6 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0xb len 0x2b
          count 38
          cont 02 00 F3
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0040 len 22 [psm 1]
        SDP SSA Req: tid 0xc len 0x11
          pat uuid-16 0x1124 (HID)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 F3
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 27
 > ACL data: handle 6 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0xc len 0x2b
          count 38
          cont 02 00 CD
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0040 len 22 [psm 1]
        SDP SSA Req: tid 0xd len 0x11
          pat uuid-16 0x1124 (HID)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 CD
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 27
 > ACL data: handle 6 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0xd len 0x2b
          count 38
          cont 02 00 A7
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0040 len 22 [psm 1]
        SDP SSA Req: tid 0xe len 0x11
          pat uuid-16 0x1124 (HID)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 A7
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 27
 > ACL data: handle 6 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0xe len 0x2b
          count 38
          cont 02 00 81
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0040 len 22 [psm 1]
        SDP SSA Req: tid 0xf len 0x11
          pat uuid-16 0x1124 (HID)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 81
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 27
 > ACL data: handle 6 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0xf len 0x2b
          count 38
          cont 02 00 5B
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0040 len 22 [psm 1]
        SDP SSA Req: tid 0x10 len 0x11
          pat uuid-16 0x1124 (HID)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 5B
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 27
 > ACL data: handle 6 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x10 len 0x2b
          count 38
          cont 02 00 35
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0040 len 22 [psm 1]
        SDP SSA Req: tid 0x11 len 0x11
          pat uuid-16 0x1124 (HID)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 35
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 27
 > ACL data: handle 6 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x11 len 0x2b
          count 38
          cont 02 00 0F
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0040 len 22 [psm 1]
        SDP SSA Req: tid 0x12 len 0x11
          pat uuid-16 0x1124 (HID)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 0F
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 27
    L2CAP(d): cid 0x0040 len 23 [psm 1]
        SDP SSA Rsp: tid 0x12 len 0x12
          count 15
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10000
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1124 (HID) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x11 > <
                 uuid-16 0x0011 (HIDP) > >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1124 (HID) uint 0x100 > >
              aid 0x000d (IconURL)
                 < < < uuid-16 0x0100 (L2CAP) uint 0x13 > < uuid-16 
0x0011 (HIDP) > > >
              aid 0x0100 (SrvName)
                 str "Microsoft Wireless Optical Desktop for Bluetooth 
Keyboard"
              aid 0x0101 (SrvDesc)
                 str "Bluetooth keyboard"
              aid 0x0102 (ProviderName)
                 str "Microsoft"
              aid 0x0200 (VersionNumList)
                 uint 0x100
              aid 0x0201 (SrvDBState)
                 uint 0x111
              aid 0x0202 (unknown)
                 uint 0x40
              aid 0x0203 (unknown)
                 uint 0x33
              aid 0x0204 (unknown)
                 bool 0x1
              aid 0x0205 (unknown)
                 bool 0x1
              aid 0x0206 (unknown)
                 < < uint 0x22 str 05 01 09 06 a1 01 85 01 05 08 19 01 
29 03 15 00 25 01 75 01 95 03 91 02 09 4b 95 01 91 02 95 04 91 01 05 07 
19 e0 29 e7 95 08 81 02 75 08 95 01 81 01 19 00 29 91 26 ff 00 95 06 81 
00 c0 05 0c 09 01 a1 01 85 02 05 0c 15 00 25 01 75 01 95 1c 09 e2 09 b7 
09 cd 09 ea 09 e9 09 b6 09 b5 0a 83 01 0a 1a 02 0a 79 02 0a ab 01 0a 08 
02 0a 02 02 0a 03 02 0a 07 02 0a 01 02 0a 92 01 0a 9c 01 09 95 0a 23 02 
0a 89 02 0a 8b 02 0a 8c 02 0a 8a 01 0a 99 01 0a a7 01 0a b6 01 0a b7 01 
81 02 75 01 95 04 81 01 06 00 ff 0a 02 ff 26 ff 00 95 01 75 08 81 02 c0 
05 01 09 80 a1 01 85 03 19 81 29 83 25 01 95 03 75 01 81 02 95 05 81 01 
c0 05 0c 09 01 a1 01 85 04 05 01 09 06 a1 02 06 00 ff 15 00 25 03 95 01 
75 02 0a 01 fe 81 02 75 06 81 01 c0 c0 05 0c 09 01 a1 01 85 05 05 01 09 
06 a1 02 06 00 ff 25 01 75 01 95 02 0a 03 fe 0a 04 fe 81 02 95 06 81 01 
c0 c0 05 0c 09 01 a1 01 85 ff 05 06 95 01 75 02 19 24 29 26 81 02 75 06 
81 01 c0 > >
              aid 0x0207 (unknown)
                 < < uint 0x309 uint 0x100 > >
              aid 0x0208 (unknown)
                 bool 0x0
              aid 0x0209 (unknown)
                 bool 0x1
              aid 0x020a (unknown)
                 bool 0x1
              aid 0x020b (unknown)
                 uint 0x100
              aid 0x020c (unknown)
                 uint 0x1f40
              aid 0x020d (unknown)
                 bool 0x0
              aid 0x020e (unknown)
                 bool 0x1
          cont 00
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0040
 > ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 48
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
 > ACL data: handle 6 flags 0x02 dlen 27
 > ACL data: handle 6 flags 0x01 dlen 13
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 28
      MTU 48 QoS 0x01 (Best effort)
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x0041
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 2
 > ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
 > ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 4
      MTU 48
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
 > ACL data: handle 6 flags 0x02 dlen 27
 > ACL data: handle 6 flags 0x01 dlen 13
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 28
      MTU 48 QoS 0x01 (Best effort)
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 0
      Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
< ACL data: handle 6 flags 0x02 dlen 5
    L2CAP(d): cid 0x0041 len 1 [psm 17]
      HIDP: Set protocol: Boot protocol
< ACL data: handle 6 flags 0x02 dlen 7
    L2CAP(d): cid 0x0042 len 3 [psm 19]
      HIDP: Data: Output report
      0000: 01 00                                             ..
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 2
 > ACL data: handle 6 flags 0x02 dlen 7
    L2CAP(d): cid 0x0041 len 3 [psm 19]
      HIDP: Data: Input report
      0000: 04 01                                             ..
 > ACL data: handle 6 flags 0x02 dlen 7
    L2CAP(d): cid 0x0041 len 3 [psm 19]
      HIDP: Data: Input report
      0000: 05 00                                             ..
 > ACL data: handle 6 flags 0x02 dlen 5
    L2CAP(d): cid 0x0040 len 1 [psm 17]
      HIDP: Handshake: Successful
                                                      
the same thing happen's whether I have anything in /etc/bluetooth/pin or 
not.
this successful connection you see above, is after having to remove the 
battery, and hitting the connect button before it could be found.

I don't know if you need it or not, but here is my dongle info:

$hciconfig -a
hci0:   Type: USB
        BD Address: 00:13:46:AD:A1:8C ACL MTU: 377:10 SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN INQUIRY
        RX bytes:89450 acl:4774 sco:0 events:497 errors:0
        TX bytes:5848 acl:148 sco:0 commands:173 errors:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'Broadcom BCM2035'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x309
        Manufacturer: Broadcom Corporation (15)

Regard's
Doug


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

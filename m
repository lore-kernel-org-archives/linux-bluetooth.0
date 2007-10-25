Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <a8e1da0710250033v58a85375v7120bd59bf90431a@mail.gmail.com>
Date: Thu, 25 Oct 2007 15:33:43 +0800
From: "Dave Young" <hidave.darkstar@gmail.com>
To: "Scott Bambrough" <sbambrough@storm.ca>
In-Reply-To: <47202594.9060606@storm.ca>
MIME-Version: 1.0
References: <47202594.9060606@storm.ca>
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Problems using bluetooth keyboard with Nokia
	N800...
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On 10/25/07, Scott Bambrough <sbambrough@storm.ca> wrote:
> I'm attempting to use a Freedom Universal bluetooth keyboard with my
> Nokia N800.   I've managed to pair successfully but cannot get the
> keyboard to connect.
>
> I've tried via the N800's Bluetooth control panel and all I get is
> connection failed.  I've attached a file kbd.txt which is the output of
> 'hcidump -X -V' when using the control panel to try to connect to the
> keyboard.
>
> I've also tried using hidd.  With hidd I get:
>
> Nokia-N800-26:/etc/bluetooth# hidd --connect 00:08:0d:6f:4c:ab
> Can't create HID control channel: Connection reset by peer
>
> I've also attached a file kbd1.txt which is the output of 'hcidump -X
> -V' when using the control panel to try to connect using hidd.
>
> AFAIK, I have the latest OS installed with all the latest available
> updates.  I've gathered the following information from the tablet:
>
> Nokia-N800-26:/etc/bluetooth# dpkg -l | grep bluez
> ii  bluez-hcidump
> 1.36-0osso1                 Analyses Bluetooth HCI packets
> ii  bluez-utils
> 3.9-osso5.1                  Bluetooth tools and daemons
> ii  bluez-utils-test
> 3.9-osso5.1                  testing tools for bluez
> ii  osso-bluez-compat
> 0.5                                OSSO compatibility tools for BlueZ
> ii  python2.5-bluez
> 0.9.1-1osso3               Python wrappers around BlueZ
>
> Nokia-N800-26:/etc/bluetooth# uname -a
> Linux Nokia-N800-26 2.6.18-omap1 #2 Wed Jun 13 11:37:40 EEST 2007 armv6l
> unknown
>
> Nokia-N800-26:/etc/bluetooth# hcitool info 00:08:0d:6f:4c:ab
> Requesting information ...
>         BD Address:  00:08:0d:6f:4c:ab
>         Device Name: KEYBOARD
>         LMP Version: 2.0 (0x3) LMP Subversion: 0xbb8
>         Manufacturer: Silicon Wave (11)
>         Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset>
>                 <timing accuracy> <role switch> <hold mode> <sniff mode>
>                 <park state> <RSSI> <channel quality> <SCO link> <HV2
> packets>
>                 <HV3 packets> <u-law log> <A-law log> <CVSD> <power control>
>                 <enhanced iscan> <interlaced iscan> <interlaced pscan>
>                 <AFH cap. slave> <AFH class. slave> <AFH cap. master>
>                 <AFH class. master>
>
> Nokia-N800-26:/etc/bluetooth# hciconfig -a
> hci0:   Type: UART
>         BD Address: 00:19:4F:DB:0B:D1 ACL MTU: 384:4 SCO MTU: 64:8
>         UP RUNNING PSCAN
>         RX bytes:9011 acl:98 sco:0 events:251 errors:0
>         TX bytes:4338 acl:96 sco:0 commands:73 errors:0
>         Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'Nokia N800'
>         Class: 0x100114
>         Service Classes: Object Transfer
>         Device Class: Computer, Palm
>         HCI Ver: 2.0 (0x3) HCI Rev: 0x6cc LMP Ver: 2.0 (0x3) LMP Subver:
> 0x6cc
>         Manufacturer: Cambridge Silicon Radio (10)
>
> Any chance someone could look at the dumps and suggest a way to get the
> two devices to connect.  I haven't attempted to modify
> /etc/bluetooth/hcid.conf by hand yet; I figured it shouldn't need to be
> or the control panel would do it.
>
> BTW, I have verified the keyboard actually works as a HID device.  I was
> able to successfully pair and connect with a laptop running Windows XP
> and the Microsoft stack.
>
> Thanks,
>
> Scott
>
>
> HCI sniffer - Bluetooth packet analyzer ver 1.36
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 00:0B:0D:6F:4C:AB ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x00 handle 44 bdaddr 00:0B:0D:6F:4C:AB type ACL encrypt 0x00
> < ACL data: handle 44 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0040
> < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
>     handle 44
> > HCI Event: Max Slots Change (0x1b) plen 3
>     handle 44 slots 5
> > HCI Event: Command Status (0x0f) plen 4
>     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>     handle 44 policy 0x0f
>     Link policy: RSWITCH HOLD SNIFF PARK
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
>       Connection successful
> < ACL data: handle 44 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> > ACL data: handle 44 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>       MTU 48
> < ACL data: handle 44 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
>       Success
>       MTU 48
> > HCI Event: Command Complete (0x0e) plen 6
>     Write Link Policy Settings (0x02|0x000d) ncmd 1
>     status 0x00 handle 44
> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>     bdaddr 00:0B:0D:6F:4C:AB mode 2 clkoffset 0x0000
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>       Success
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > HCI Event: Read Remote Supported Features (0x0b) plen 11
>     status 0x00 handle 44
>     Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
> > HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> > HCI Event: Remote Name Req Complete (0x07) plen 255
>     status 0x00 bdaddr 00:0B:0D:6F:4C:AB name 'KEYBOARD'
> < ACL data: handle 44 flags 0x02 dlen 24
>     L2CAP(d): cid 0x0040 len 20 [psm 1]
>         SDP SSA Req: tid 0x0 len 0xf
>           pat uuid-16 0x1200 (PNPInfo)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0x0 len 0x2b
>           count 39
>           cont 01 19
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0x1 len 0x10
>           pat uuid-16 0x1200 (PNPInfo)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 19
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0x1 len 0x2b
>           count 39
>           cont 01 1A
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0x2 len 0x10
>           pat uuid-16 0x1200 (PNPInfo)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 1A
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 30
>     L2CAP(d): cid 0x0040 len 26 [psm 1]
>         SDP SSA Rsp: tid 0x2 len 0x15
>           count 18
>           record #0
>               aid 0x0000 (SrvRecHndl)
>                  uint 0x10001
>               aid 0x0001 (SrvClassIDList)
>                  < uuid-16 0x1200 (PNPInfo) >
>               aid 0x0002 (SrvRecState)
>                  uint 0x0
>               aid 0x0004 (ProtocolDescList)
>                  < < uuid-16 0x0100 (L2CAP) uint 0x1 > <
>                  uuid-16 0x0001 (SDP) > >
>               aid 0x0009 (BTProfileDescList)
>                  < < uuid-16 0x1200 (PNPInfo) uint 0x118 > >
>               aid 0x0200 (VersionNumList)
>                  uint 0x100
>               aid 0x0201 (SrvDBState)
>                  uint 0x45e
>               aid 0x0202 (unknown)
>                  uint 0x403
>               aid 0x0203 (unknown)
>                  uint 0x112
>               aid 0x0204 (unknown)
>                  bool 0x1
>               aid 0x0205 (unknown)
>                  uint 0x2
>           cont 00
> < ACL data: handle 44 flags 0x02 dlen 24
>     L2CAP(d): cid 0x0040 len 20 [psm 1]
>         SDP SSA Req: tid 0x3 len 0xf
>           pat uuid-16 0x1124 (HID)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0x3 len 0x2b
>           count 39
>           cont 01 1B
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0x4 len 0x10
>           pat uuid-16 0x1124 (HID)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 1B
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0x4 len 0x2b
>           count 39
>           cont 01 1C
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0x5 len 0x10
>           pat uuid-16 0x1124 (HID)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 1C
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0x5 len 0x2b
>           count 39
>           cont 01 1D
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0x6 len 0x10
>           pat uuid-16 0x1124 (HID)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 1D
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0x6 len 0x2b
>           count 39
>           cont 01 1E
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0x7 len 0x10
>           pat uuid-16 0x1124 (HID)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 1E
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0x7 len 0x2b
>           count 39
>           cont 01 1F
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0x8 len 0x10
>           pat uuid-16 0x1124 (HID)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 1F
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0x8 len 0x2b
>           count 39
>           cont 01 20
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0x9 len 0x10
>           pat uuid-16 0x1124 (HID)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 20
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0x9 len 0x2b
>           count 39
>           cont 01 21
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0xa len 0x10
>           pat uuid-16 0x1124 (HID)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 21
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0xa len 0x2b
>           count 39
>           cont 01 22
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0xb len 0x10
>           pat uuid-16 0x1124 (HID)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 22
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0xb len 0x2b
>           count 39
>           cont 01 23
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0xc len 0x10
>           pat uuid-16 0x1124 (HID)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 23
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0xc len 0x2b
>           count 39
>           cont 01 24
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0xd len 0x10
>           pat uuid-16 0x1124 (HID)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 24
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 29
>     L2CAP(d): cid 0x0040 len 25 [psm 1]
>         SDP SSA Rsp: tid 0xd len 0x14
>           count 17
>           record #0
>               aid 0x0000 (SrvRecHndl)
>                  uint 0x10000
>               aid 0x0001 (SrvClassIDList)
>                  < uuid-16 0x1124 (HID) >
>               aid 0x0002 (SrvRecState)
>                  uint 0x0
>               aid 0x0004 (ProtocolDescList)
>                  < < uuid-16 0x0100 (L2CAP) uint 0x11 > <
>                  uuid-16 0x0011 (HIDP) > >
>               aid 0x0005 (BrwGrpList)
>                  < uuid-16 0x1002 (PubBrwsGrp) >
>               aid 0x0006 (LangBaseAttrIDList)
>                  < uint 0x656e uint 0x6a uint 0x100 >
>               aid 0x0009 (BTProfileDescList)
>                  < < uuid-16 0x1124 (HID) uint 0x130 > >
>               aid 0x000d (IconURL)
>                  < < < uuid-16 0x0100 (L2CAP) uint 0x13 > < uuid-16 0x0011 (HIDP) > > >
>               aid 0x0100 (SrvName)
>                  str "keyboard"
>               aid 0x0101 (SrvDesc)
>                  str "Bluetooth Kbd"
>               aid 0x0102 (ProviderName)
>                  str "     "
>               aid 0x0200 (VersionNumList)
>                  uint 0x100
>               aid 0x0201 (SrvDBState)
>                  uint 0x100
>               aid 0x0202 (unknown)
>                  uint 0x40
>               aid 0x0203 (unknown)
>                  uint 0x33
>               aid 0x0204 (unknown)
>                  bool 0x1
>               aid 0x0205 (unknown)
>                  bool 0x1
>               aid 0x0206 (unknown)
>                  < < uint 0x22 str 05 01 09 06 a1 01 85 01 05 07 19 e0 29 e7 15 00 25 01 75 01 95 08 81 02 95 01 75 08 81 03 95 05 75 01 05 08 19 01 29 05 91 02 95 01 75 03 91 03 95 06 75 08 15 00 26 ff 00 05 07 19 00 29 ff 81 00 c0 05 0c 09 01 a1 01 85 02 15 00 25 01 75 01 95 07 0a 25 02 0a 24 02 0a 26 02 0a 21 02 0a 2a 02 0a 23 02 0a 8a 01 81 02 95 01 81 01 95 08 09 e2 09 ea 09 e9 09 cd 09 b7 09 b6 09 b5 0a 94 01 81 02 19 4a 29 51 81 02 19 52 29 5f 81 02 c0 05 0c 09 01 a1 01 85 ff 05 06 95 01 75 02 19 24 29 26 81 02 95 01 75 06 81 01 c0 > >
>               aid 0x0207 (unknown)
>                  < < uint 0x409 uint 0x100 > >
>               aid 0x0208 (unknown)
>                  bool 0x0
>               aid 0x0209 (unknown)
>                  bool 0x1
>               aid 0x020a (unknown)
>                  bool 0x0
>               aid 0x020b (unknown)
>                  uint 0x100
>               aid 0x020c (unknown)
>                  uint 0xfa0
>               aid 0x020d (unknown)
>                  bool 0x1
>               aid 0x020e (unknown)
>                  bool 0x1
>           cont 00
> < ACL data: handle 44 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> < ACL data: handle 44 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 17 scid 0x0040
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
>       Connection successful
> < ACL data: handle 44 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>       MTU 48
> > ACL data: handle 44 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>       MTU 48
> < ACL data: handle 44 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
>       Success
>       MTU 48
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 1 clen 4
>       MTU 128
> < ACL data: handle 44 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>       MTU 48
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 1 clen 4
>       MTU 128
> < ACL data: handle 44 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>     handle 44 reason 0x13
>     Reason: Remote User Terminated Connection
> > HCI Event: Command Status (0x0f) plen 4
>     Disconnect (0x01|0x0006) status 0x00 ncmd 1
> > HCI Event: Disconn Complete (0x05) plen 4
>     status 0x00 handle 44 reason 0x16
>     Reason: Connection Terminated by Local Host
>
>
> HCI sniffer - Bluetooth packet analyzer ver 1.36
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Connect Request (0x04) plen 10
>     bdaddr 00:0B:0D:6F:4C:AB class 0x002540 type ACL
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>     bdaddr 00:0B:0D:6F:4C:AB role 0x00
>     Role: Master
> > HCI Event: Command Status (0x0f) plen 4
>     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> > HCI Event: Role Change (0x12) plen 8
>     status 0x00 bdaddr 00:0B:0D:6F:4C:AB role 0x00
>     Role: Master
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x00 handle 44 bdaddr 00:0B:0D:6F:4C:AB type ACL encrypt 0x00
> < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
>     handle 44
> > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
>     bdaddr 00:0B:0D:6F:4C:AB mode 1
> > HCI Event: Command Status (0x0f) plen 4
>     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> > HCI Event: Max Slots Change (0x1b) plen 3
>     handle 44 slots 5
> > ACL data: handle 44 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 17 scid 0x0040
> < ACL data: handle 44 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
>       Connection successful
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > HCI Event: Command Status (0x0f) plen 4
>     Unknown (0x00|0x0000) status 0x00 ncmd 1
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>     handle 44 policy 0x0f
>     Link policy: RSWITCH HOLD SNIFF PARK
> > ACL data: handle 44 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>       MTU 48
> < ACL data: handle 44 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
>       Success
>       MTU 48
> < ACL data: handle 44 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>       MTU 48
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > HCI Event: Command Complete (0x0e) plen 6
>     Write Link Policy Settings (0x02|0x000d) ncmd 1
>     status 0x00 handle 44
> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
>     handle 44 ptype 0xcc18
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 1 clen 4
>       MTU 128
> < ACL data: handle 44 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>       MTU 48
> > HCI Event: Read Remote Supported Features (0x0b) plen 11
>     status 0x00 handle 44
>     Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
> > HCI Event: Command Status (0x0f) plen 4
>     Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>     bdaddr 00:0B:0D:6F:4C:AB mode 2 clkoffset 0x0000
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > HCI Event: Connection Packet Type Changed (0x1d) plen 5
>     status 0x00 handle 44 ptype 0xff1e
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5 2-DH1 2-DH3 2-DH5 3-DH1 3-DH3 3-DH5
> > ACL data: handle 44 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 1 clen 4
>       MTU 128
> < ACL data: handle 44 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> > HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> > HCI Event: Remote Name Req Complete (0x07) plen 255
>     status 0x00 bdaddr 00:0B:0D:6F:4C:AB name 'KEYBOARD'
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>     handle 44 reason 0x13
>     Reason: Remote User Terminated Connection
> > HCI Event: Command Status (0x0f) plen 4
>     Disconnect (0x01|0x0006) status 0x00 ncmd 1
> > HCI Event: Disconn Complete (0x05) plen 4
>     status 0x00 handle 44 reason 0x16
>     Reason: Connection Terminated by Local Host
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 00:08:0D:6F:4C:AB ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x00 handle 44 bdaddr 00:08:0D:6F:4C:AB type ACL encrypt 0x00
> < ACL data: handle 44 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0040
> < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
>     handle 44
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > HCI Event: Command Status (0x0f) plen 4
>     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> > HCI Event: Max Slots Change (0x1b) plen 3
>     handle 44 slots 5
> > ACL data: handle 44 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
>       Connection successful
> < ACL data: handle 44 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> > ACL data: handle 44 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>       MTU 48
> < ACL data: handle 44 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
>       Success
>       MTU 48
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>       Success
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > HCI Event: Command Status (0x0f) plen 4
>     Unknown (0x00|0x0000) status 0x00 ncmd 1
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>     handle 44 policy 0x0f
>     Link policy: RSWITCH HOLD SNIFF PARK
> > HCI Event: Command Complete (0x0e) plen 6
>     Write Link Policy Settings (0x02|0x000d) ncmd 1
>     status 0x00 handle 44
> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>     bdaddr 00:08:0D:6F:4C:AB mode 2 clkoffset 0x0000
> > HCI Event: Read Remote Supported Features (0x0b) plen 11
>     status 0x00 handle 44
>     Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
> > HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> > HCI Event: Remote Name Req Complete (0x07) plen 255
>     status 0x00 bdaddr 00:08:0D:6F:4C:AB name 'KEYBOARD'
> < ACL data: handle 44 flags 0x02 dlen 24
>     L2CAP(d): cid 0x0040 len 20 [psm 1]
>         SDP SSA Req: tid 0x0 len 0xf
>           pat uuid-16 0x1200 (PNPInfo)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0x0 len 0x2b
>           count 39
>           cont 01 01
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0x1 len 0x10
>           pat uuid-16 0x1200 (PNPInfo)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 01
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0x1 len 0x2b
>           count 39
>           cont 01 02
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0x2 len 0x10
>           pat uuid-16 0x1200 (PNPInfo)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 02
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 30
>     L2CAP(d): cid 0x0040 len 26 [psm 1]
>         SDP SSA Rsp: tid 0x2 len 0x15
>           count 18
>           record #0
>               aid 0x0000 (SrvRecHndl)
>                  uint 0x10001
>               aid 0x0001 (SrvClassIDList)
>                  < uuid-16 0x1200 (PNPInfo) >
>               aid 0x0002 (SrvRecState)
>                  uint 0x0
>               aid 0x0004 (ProtocolDescList)
>                  < < uuid-16 0x0100 (L2CAP) uint 0x1 > <
>                  uuid-16 0x0001 (SDP) > >
>               aid 0x0009 (BTProfileDescList)
>                  < < uuid-16 0x1200 (PNPInfo) uint 0x118 > >
>               aid 0x0200 (VersionNumList)
>                  uint 0x100
>               aid 0x0201 (SrvDBState)
>                  uint 0x45e
>               aid 0x0202 (unknown)
>                  uint 0x403
>               aid 0x0203 (unknown)
>                  uint 0x112
>               aid 0x0204 (unknown)
>                  bool 0x1
>               aid 0x0205 (unknown)
>                  uint 0x2
>           cont 00
> < ACL data: handle 44 flags 0x02 dlen 24
>     L2CAP(d): cid 0x0040 len 20 [psm 1]
>         SDP SSA Req: tid 0x3 len 0xf
>           pat uuid-16 0x1124 (HID)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0x3 len 0x2b
>           count 39
>           cont 01 03
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0x4 len 0x10
>           pat uuid-16 0x1124 (HID)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 03
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0x4 len 0x2b
>           count 39
>           cont 01 04
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0x5 len 0x10
>           pat uuid-16 0x1124 (HID)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 04
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0x5 len 0x2b
>           count 39
>           cont 01 05
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0x6 len 0x10
>           pat uuid-16 0x1124 (HID)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 05
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0x6 len 0x2b
>           count 39
>           cont 01 06
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0x7 len 0x10
>           pat uuid-16 0x1124 (HID)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 06
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0x7 len 0x2b
>           count 39
>           cont 01 07
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0x8 len 0x10
>           pat uuid-16 0x1124 (HID)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 07
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0x8 len 0x2b
>           count 39
>           cont 01 08
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0x9 len 0x10
>           pat uuid-16 0x1124 (HID)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 08
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0x9 len 0x2b
>           count 39
>           cont 01 09
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0xa len 0x10
>           pat uuid-16 0x1124 (HID)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 09
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0xa len 0x2b
>           count 39
>           cont 01 0A
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0xb len 0x10
>           pat uuid-16 0x1124 (HID)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 0A
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0xb len 0x2b
>           count 39
>           cont 01 0B
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0xc len 0x10
>           pat uuid-16 0x1124 (HID)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 0B
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 52
>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>         SDP SSA Rsp: tid 0xc len 0x2b
>           count 39
>           cont 01 0C
> < ACL data: handle 44 flags 0x02 dlen 25
>     L2CAP(d): cid 0x0040 len 21 [psm 1]
>         SDP SSA Req: tid 0xd len 0x10
>           pat uuid-16 0x1124 (HID)
>           max 65535
>           aid(s) 0x0000 - 0xffff
>           cont 01 0C
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 29
>     L2CAP(d): cid 0x0040 len 25 [psm 1]
>         SDP SSA Rsp: tid 0xd len 0x14
>           count 17
>           record #0
>               aid 0x0000 (SrvRecHndl)
>                  uint 0x10000
>               aid 0x0001 (SrvClassIDList)
>                  < uuid-16 0x1124 (HID) >
>               aid 0x0002 (SrvRecState)
>                  uint 0x0
>               aid 0x0004 (ProtocolDescList)
>                  < < uuid-16 0x0100 (L2CAP) uint 0x11 > <
>                  uuid-16 0x0011 (HIDP) > >
>               aid 0x0005 (BrwGrpList)
>                  < uuid-16 0x1002 (PubBrwsGrp) >
>               aid 0x0006 (LangBaseAttrIDList)
>                  < uint 0x656e uint 0x6a uint 0x100 >
>               aid 0x0009 (BTProfileDescList)
>                  < < uuid-16 0x1124 (HID) uint 0x130 > >
>               aid 0x000d (IconURL)
>                  < < < uuid-16 0x0100 (L2CAP) uint 0x13 > < uuid-16 0x0011 (HIDP) > > >
>               aid 0x0100 (SrvName)
>                  str "keyboard"
>               aid 0x0101 (SrvDesc)
>                  str "Bluetooth Kbd"
>               aid 0x0102 (ProviderName)
>                  str "     "
>               aid 0x0200 (VersionNumList)
>                  uint 0x100
>               aid 0x0201 (SrvDBState)
>                  uint 0x100
>               aid 0x0202 (unknown)
>                  uint 0x40
>               aid 0x0203 (unknown)
>                  uint 0x33
>               aid 0x0204 (unknown)
>                  bool 0x1
>               aid 0x0205 (unknown)
>                  bool 0x1
>               aid 0x0206 (unknown)
>                  < < uint 0x22 str 05 01 09 06 a1 01 85 01 05 07 19 e0 29 e7 15 00 25 01 75 01 95 08 81 02 95 01 75 08 81 03 95 05 75 01 05 08 19 01 29 05 91 02 95 01 75 03 91 03 95 06 75 08 15 00 26 ff 00 05 07 19 00 29 ff 81 00 c0 05 0c 09 01 a1 01 85 02 15 00 25 01 75 01 95 07 0a 25 02 0a 24 02 0a 26 02 0a 21 02 0a 2a 02 0a 23 02 0a 8a 01 81 02 95 01 81 01 95 08 09 e2 09 ea 09 e9 09 cd 09 b7 09 b6 09 b5 0a 94 01 81 02 19 4a 29 51 81 02 19 52 29 5f 81 02 c0 05 0c 09 01 a1 01 85 ff 05 06 95 01 75 02 19 24 29 26 81 02 95 01 75 06 81 01 c0 > >
>               aid 0x0207 (unknown)
>                  < < uint 0x409 uint 0x100 > >
>               aid 0x0208 (unknown)
>                  bool 0x0
>               aid 0x0209 (unknown)
>                  bool 0x1
>               aid 0x020a (unknown)
>                  bool 0x0
>               aid 0x020b (unknown)
>                  uint 0x100
>               aid 0x020c (unknown)
>                  uint 0xfa0
>               aid 0x020d (unknown)
>                  bool 0x1
>               aid 0x020e (unknown)
>                  bool 0x1
>           cont 00
> < ACL data: handle 44 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> < ACL data: handle 44 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 17 scid 0x0040
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
>       Connection successful
> < ACL data: handle 44 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>       MTU 48
> > ACL data: handle 44 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>       MTU 48
> < ACL data: handle 44 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
>       Success
>       MTU 48
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 1 clen 4
>       MTU 128
> < ACL data: handle 44 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>       MTU 48
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 1 clen 4
>       MTU 128

Problem might be here, configuration request MTU 48 , response with
error (it seems need to be 128).

> < ACL data: handle 44 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 44 packets 1
> > ACL data: handle 44 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>     handle 44 reason 0x13
>     Reason: Remote User Terminated Connection
> > HCI Event: Command Status (0x0f) plen 4
>     Disconnect (0x01|0x0006) status 0x00 ncmd 1
> > HCI Event: Disconn Complete (0x05) plen 4
>     status 0x00 handle 44 reason 0x16
>     Reason: Connection Terminated by Local Host
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

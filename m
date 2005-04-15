Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Lars Steinke <sf@lsweb.de>
To: bluez-users@lists.sourceforge.net
Cc: bluez-devel@lists.sourceforge.net
Message-ID: <20050415111207.GA4885@lsweb.de>
References: <20050404194542.GA7640@lsweb.de> <20050404195007.GA8373@lsweb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050404195007.GA8373@lsweb.de>
Subject: [Bluez-users] Re: btsco - headset profile activated but no sco packets transmitted ???
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 15 Apr 2005 13:12:07 +0200
List-ID: <bluez-devel.lists.sourceforge.net>

Was away for a few days, thanks for the replies which unfortunately seem
to suggest this is not a mere configuration issue I can fix from my side.

I've tried Linux 2.6.11.7 next and refetched btsco from cvs today: One
thing that seems to have changed is that I now get the confirmation
tone from the headset whenever aplay or arecord are started - 
unfortunately I can still neither hear or record any audio with it 
(even though that works fine using the Widcomm stack)...

hciconfig -a
hci0:   Type: USB
        BD Address: 00:02:72:80:A5:D3 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:13064 acl:364 sco:0 events:722 errors:0
        TX bytes:8126 acl:339 sco:0 commands:182 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'localhost-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver:
0x33c
        Manufacturer: Cambridge Silicon Radio (10)

Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized

root@sigma:~# btsco -v 00:07:A4:95:41:76
btsco v0.4
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
recieved AT+CKPD=200
speaker volume: 3 mic volume: 15
driver is in use
connected SCO channel
Done setting sco fd
recieved AT+VGS=15
Sending up speaker change 15
recieved AT+VGS=03
Sending up speaker change 3
recieved AT+VGS=07
Sending up speaker change 7
recieved AT+VGS=11
Sending up speaker change 11
speaker volume: 11 mic volume: 15
driver is not in use
disconnected SCO channel
speaker volume: 11 mic volume: 15
driver is in use
connected SCO channel
Done setting sco fd
recieved AT+VGS=11
Sending up speaker change 11
speaker volume: 11 mic volume: 15
driver is not in use
disconnected SCO channel
RFCOMM channel lost

snd-bt-sco revision 1.6 $
snd-bt-sco: snd-bt-scod thread starting
snd-bt-sco: playback_open
Bluetooth: SCO (Voice Link) ver 0.4
Bluetooth: SCO socket layer initialized
snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 2000
snd-bt-sco: playback_trigger 1
snd-bt-sco: setting playback to bspcm
snd-bt-sco: playback_trigger 0
snd-bt-sco: setting playback to NULL
snd-bt-sco: Disposing of previous socket count 2
snd-bt-sco: capture_open
snd-bt-sco: capture_prepare
snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 2000
snd-bt-sco: capture_trigger 1
snd-bt-sco: setting capture to bspcm
snd-bt-sco: capture_trigger 0
snd-bt-sco: setting capture to NULL
snd-bt-sco: Disposing of previous socket count 2

--
HCI sniffer - Bluetooth packet analyzer ver 1.19
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:07:A4:95:41:76 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: Link Key Request (0x17) plen 6
  0000: 76 41 95 a4 07 00                                 vA....
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:07:A4:95:41:76
    Link key: 39b150b8640b812d72b82f572be54b85
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 76 41 95 a4  07 00                    ....vA....
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 2b 00 76 41 95 a4 07  00 01 01                 .+.vA......
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 43 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 2b 00                                 ....+.
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  0000: 76 41 95 a4 07 00 01                              vA.....
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x006a scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x006a scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x006a flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48 
< ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x006a flags 0x00 result 0 clen 0
      Success
< ACL data: handle 43 flags 0x02 dlen 24
    L2CAP(d): cid 0x006a len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> ACL data: handle 43 flags 0x02 dlen 27
> ACL data: handle 43 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x2b
          count 38
          cont 02 00 22
< ACL data: handle 43 flags 0x02 dlen 26
    L2CAP(d): cid 0x006a len 22 [psm 1]
        SDP SSA Req: tid 0x1 len 0x11
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 22
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> ACL data: handle 43 flags 0x02 dlen 27
> ACL data: handle 43 flags 0x01 dlen 19
    L2CAP(d): cid 0x0040 len 42 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x25
          count 34
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10000
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1108 (Headset) uuid-16 0x1203 (Audio) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x1 > >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1108 (Headset) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "Headset"
              aid 0x0302 (unknown)
                 bool 0x1
          cont 00
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x006a scid 0x0040
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 25 0c 00 60 00                                 .%..`.
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x006a scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x006b scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x006b scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x006b flags 0x00 clen 4
      MTU 1024 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 1024 
< ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x006b flags 0x00 result 0 clen 0
      Success
< ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x006b len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
< ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(d): cid 0x006b len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1019 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 127 max_retrans 0 credits 0
< ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x006b len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92 
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(d): cid 0x006b len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(d): cid 0x006b len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x006b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
> ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 15
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> ACL data: handle 43 flags 0x02 dlen 20
    L2CAP(d): cid 0x0041 len 16 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 12 fcs 0x40 
      0000: 41 54 2b 43 4b 50 44 3d  32 30 30 0d              AT+CKPD=200.
< ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(d): cid 0x006b len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a 
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
< ACL data: handle 43 flags 0x02 dlen 17
    L2CAP(d): cid 0x006b len 13 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 9 fcs 0x9a 
      0000: 41 54 2b 56 47 53 3d 33  0d                       AT+VGS=3.
< ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(d): cid 0x006b len 14 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 10 fcs 0x9a 
      0000: 41 54 2b 56 47 4d 3d 31  35 0d                    AT+VGM=15.
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
    handle 43 ptype 0x00e0
    Packet type: HV1 HV2 HV3 
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 07 04                                       ....
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 2e 00 76 41 95 a4 07  00 00 01                 ...vA......
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> ACL data: handle 43 flags 0x02 dlen 19
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 10 fcs 0x5c credits 3
      0000: 41 54 2b 56 47 53 3d 31  35 0d                    AT+VGS=15.
< ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(d): cid 0x006b len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a 
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> ACL data: handle 43 flags 0x02 dlen 19
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 10 fcs 0x5c credits 1
      0000: 41 54 2b 56 47 53 3d 30  33 0d                    AT+VGS=03.
< ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(d): cid 0x006b len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a 
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> ACL data: handle 43 flags 0x02 dlen 19
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 10 fcs 0x5c credits 1
      0000: 41 54 2b 56 47 53 3d 30  37 0d                    AT+VGS=07.
< ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(d): cid 0x006b len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a 
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> ACL data: handle 43 flags 0x02 dlen 19
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 10 fcs 0x5c credits 1
      0000: 41 54 2b 56 47 53 3d 31  31 0d                    AT+VGS=11.
< ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(d): cid 0x006b len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a 
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> HCI Event: Mode Change (0x14) plen 6
  0000: 00 2b 00 02 00 08                                 .+....
< ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(d): cid 0x006b len 14 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 10 fcs 0x9a 
      0000: 41 54 2b 56 47 53 3d 31  31 0d                    AT+VGS=11.
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 46 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 06 04                                       ....
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 2e 00 16                                       ....
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
    handle 43 ptype 0x00e0
    Packet type: HV1 HV2 HV3 
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 07 04                                       ....
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 29 00 76 41 95 a4 07  00 00 01                 .).vA......
> ACL data: handle 43 flags 0x02 dlen 17
> ACL data: handle 43 flags 0x01 dlen 2
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 10 fcs 0x5c credits 2
      0000: 41 54 2b 56 47 53 3d 31  31 0d                    AT+VGS=11.
< ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(d): cid 0x006b len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a 
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 41 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 06 04                                       ....
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 29 00 16                                       .)..
> HCI Event: Mode Change (0x14) plen 6
  0000: 00 2b 00 00 00 00                                 .+....
> ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): DISC: cr 0 dlci 2 pf 1 ilen 0 fcs 0xd9 
< ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x006b len 4 [psm 3]
      RFCOMM(s): UA: cr 0 dlci 2 pf 1 ilen 0 fcs 0xf3 
< ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x006b len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd 
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x006b scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> ACL data: handle 43 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x006b scid 0x0041
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 43 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 06 04                                       ....
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 2b 00 16                                       .+..

--

Original mail to bluez-users follows:

> Oops, forgot that info here:
> 
> root@sigma:~# hcitool info 00:07:A4:95:41:76
> Requesting information ...
>         BD Address:  00:07:A4:95:41:76
>         Device Name: Jabra BT110
>         LMP Version: 1.2 (0x2) LMP Subversion: 0x613
>         Manufacturer: Cambridge Silicon Radio (10)
>         Features: 0xfc 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
>                 <encryption> <slot offset> <timing accuracy> <role
> switch>
>                 <hold mode> <sniff mode> <park state> <RSSI> <channel
> quality>
>                 <SCO link> <HV2 packets> <HV3 packets> <u-law log>
> <A-law log>
>                 <CVSD> <paging scheme> <transparent SCO>
> 
> On Mon, Apr 04, 2005 at 09:45:42PM +0200, Lars Steinke wrote:
> > Hi there,
> > 
> > while running btsco I can successfully change my mixersettings via 
> > the headset, so I assume the connection has been established just fine:
> > 
> > root@sigma:~/src/btsco# ./btsco -v 00:07:A4:95:41:76 2
> > btsco v0.4
> > Device is 1:0
> > Voice setting: 0x0060
> > RFCOMM channel 2 connected
> > recieved AT+BRSF=24
> > recieved AT+VGS=03
> > Sending up speaker change 3
> > recieved AT+VGS=07
> > Sending up speaker change 7
> > recieved AT+VGS=11
> > Sending up speaker change 11
> > recieved AT+VGS=15
> > Sending up speaker change 15
> > speaker volume: 15 mic volume: 1
> > driver is in use
> > connected SCO channel
> > Done setting sco fd
> > 
> > But I can neither hear sound nor record anything via the Jabra BT110
> > headset using BlueZ 20050328 with kernel 2.6.11:
> > 
> > aplay -D plughw:Headset test.wav
> > Playing Sparc Audio 'test.wav' : Mu-Law, Rate 8000 Hz, Mono
> > 
> > I just hear a raise in static when playback commences (even though mixer
> > levels are maxed in alsamixer!)...
> > 
> > snd-bt-sco revision 1.6 $
> > snd-bt-sco: snd-bt-scod thread starting
> > snd-bt-sco: playback_open
> > snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 2000
> > snd-bt-sco: playback_trigger 1
> > snd-bt-sco: setting playback to bspcm
> > 
> > root@sigma:~# hcitool con
> > Connections:
> >         < SCO 00:07:A4:95:41:76 handle 44 state 1 lm SLAVE
> >         < ACL 00:07:A4:95:41:76 handle 41 state 1 lm MASTER
> > root@sigma:~# hciconfig hci0
> > hci0:   Type: USB
> >         BD Address: 00:02:72:80:A5:D3 ACL MTU: 192:8 SCO MTU: 64:8
> >         UP RUNNING PSCAN ISCAN
> >         RX bytes:9966 acl:207 sco:0 events:535 errors:0
> >         TX bytes:6279 acl:191 sco:0 commands:195 errors:0
> > 
> > root@sigma:~# hciconfig hci0 revision
> > hci0:   Type: USB
> >         BD Address: 00:02:72:80:A5:D3 ACL MTU: 192:8 SCO MTU: 64:8
> >         HCI 16.14
> >         Chip version: BlueCore02-External
> >         Max key size: 56 bit
> >         SCO mapping:  HCI
> > 
> > Audio works fine with that headset and dongle using the Widcomm stack
> > 1.4 under Windoze ;(...
> > 
> > Regards,
> > Lars


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

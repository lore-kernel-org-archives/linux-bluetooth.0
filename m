Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
From: Stefan Bellon <sbellon@sbellon.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <4d3382eb6csbellon@sbellon.de>
Content-Type: text/plain
Subject: [Bluez-users] bluetooth-alsa and Jabra BT800
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
Date: Wed, 26 Jan 2005 23:23:17 +0100

Hi!

Today I got my Jabra BT800 and wanted to try it with bluetooth-alsa.
The page lists the BT200 and BT250 as working, so I suspect it should
be able to get the BT800 going as well.

However, I'm having trouble, and frankly, this is my first Bluetooth
headset, so my experience is not that big.

I followed the instruction on the bluetooth-alsa page and include the
output here. Hopefully somebody of you can shed some light on what I'm
missing.

The Bluetooth adapter I'm using at the PC is a AVM BlueFritz USB 2.0

root@roma# hciconfig -a
hci0:   Type: USB
        BD Address: 00:04:0E:87:88:E9 ACL MTU: 120:20  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN 
        RX bytes:2502 acl:1 sco:0 events:120 errors:0
        TX bytes:1029 acl:12 sco:0 commands:66 errors:0
        Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: ACCEPT MASTER 
        Name: 'roma-0'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x2005 LMP Ver: 1.1 (0x1) LMP Subver: 0x1805
        Manufacturer: AVM Berlin (31)

root@roma# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:04:0E:87:88:E9 ACL MTU: 120:20  SCO MTU: 64:0
        Unknown type

root@roma# hcitool info 00:07:A4:21:1D:86
Requesting information ...
        BD Address:  00:07:A4:21:1D:86
        Device Name: Jabra BT800
        LMP Version: 1.2 (0x2) LMP Subversion: 0x68d
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xff 0x8b 0x78 0x08 0x08 0x00 0x80
                <encryption> <slot offset> <timing accuracy> <role switch> 
                <hold mode> <sniff mode> <park state> <RSSI> <channel quality> 
                <SCO link> <HV2 packets> <HV3 packets> <u-law log> <A-law log> 
                <CVSD> <paging scheme> <transparent SCO> <broadcast encrypt> 
                <enhanced iscan> <interlaced iscan> <interlaced pscan> 
                <inquiry with RSSI> <AFH cap. slave> <AFH cap. master> 
                <extended features> 


sbellon@roma$ btsco 00:07:A4:21:1D:86
Device is 1:0
Failed to connect to SDP server: Connection timed out
Assuming channel 2
Voice setting: 0x0060
Can't connect RFCOMM channel: Resource temporarily unavailable

The following is the hcidump for the btsco execution above:

root@roma# hcidump -X
HCIDump - HCI packet analyzer ver 1.12
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 86 1d 21 a4 07 00 18 cc  02 00 00 00 00           ..!..........
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: Link Key Request (0x17) plen 6
  0000: 86 1d 21 a4 07 00                                 ..!...
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: 86 1d 21 a4 07 00 91 19  02 dc fc bc 09 ee 46 a3  ..!...........F.
  0010: 33 f2 01 d5 fc 1a                                 3.....
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 86 1d 21 a4  07 00                    ......!...
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 05 00 86 1d 21 a4 07  00 01 01                 .....!.....
< ACL data: handle 0x0005 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 05 00 0f 00                                       ....
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  0000: 00 05 00 18 cc                                    .....
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 05 00                                 ......
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 05 00 01 00                                    .....
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 25 0c 00 60 00                                 .%..`.
< ACL data: handle 0x0005 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 05 00 01 00                                    .....
< HCI Command: Disconnect (0x01|0x0006) plen 3
  0000: 05 00 13                                          ...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 06 04                                       ....
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 05 00 16                                       ....


sbellon@roma$ aplay -D plughw:Headset some.wav
Playing WAVE 'some.wav' : Unsigned 8 bit, Rate 11025 Hz, Mono
Aborted by signal Interrupt...

The following is the hcidump for the aplay execution above:

root@roma# hcidump -X
HCIDump - HCI packet analyzer ver 1.12
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
  0000: 86 1d 21 a4 07 00 0c 04  20 01                    ..!..... .
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  0000: 86 1d 21 a4 07 00 00                              ..!....
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 09 04                                       ....
> HCI Event: Role Change (0x12) plen 8
  0000: 00 86 1d 21 a4 07 00 00                           ...!....
> HCI Event: Link Key Request (0x17) plen 6
  0000: 86 1d 21 a4 07 00                                 ..!...
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: 86 1d 21 a4 07 00 91 19  02 dc fc bc 09 ee 46 a3  ..!...........F.
  0010: 33 f2 01 d5 fc 1a                                 3.....
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 86 1d 21 a4  07 00                    ......!...
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 06 00 86 1d 21 a4 07  00 01 01                 .....!.....
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 06 00 0f 00                                       ....
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  0000: 00 06 00 18 cc                                    .....
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 06 00                                 ......
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
  0000: 06 00 18 cc                                       ....
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 0f 04                                       ....
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  0000: 00 06 00 18 cc                                    .....

As you can see from the dmesg output, the snd-bt-sco module itself is
loaded:

snd-bt-sco revision 1.4 $
snd-bt-sco: snd-bt-scod thread starting
snd-bt-sco: playback_open
snd-bt-sco: prepare ok bps: 16000 size: 32768 count: 8192
snd-bt-sco: playback_open
snd-bt-sco: capture_open
snd-bt-sco: prepare ok bps: 16000 size: 32768 count: 512
snd-bt-sco: capture_prepare
snd-bt-sco: prepare ok bps: 16000 size: 32768 count: 512
snd-bt-sco: playback_open
snd-bt-sco: capture_open
snd-bt-sco: prepare ok bps: 16000 size: 32768 count: 512
snd-bt-sco: capture_prepare
snd-bt-sco: prepare ok bps: 16000 size: 32768 count: 512
snd-bt-sco: playback_open
snd-bt-sco: capture_open
snd-bt-sco: prepare ok bps: 16000 size: 23808 count: 11904
snd-bt-sco: playback_trigger 1
snd-bt-sco: setting playback to bspcm
snd-bt-sco: playback_trigger 0
snd-bt-sco: setting playback to NULL
snd-bt-sco: playback_open
snd-bt-sco: prepare ok bps: 16000 size: 8002 count: 2000
snd-bt-sco: playback_trigger 1
snd-bt-sco: setting playback to bspcm
snd-bt-sco: playback_trigger 0
snd-bt-sco: setting playback to NULL
snd-bt-sco: playback_open
snd-bt-sco: prepare ok bps: 16000 size: 8002 count: 2000
snd-bt-sco: playback_trigger 1
snd-bt-sco: setting playback to bspcm
snd-bt-sco: playback_trigger 0
snd-bt-sco: setting playback to NULL
snd-bt-sco: playback_open
snd-bt-sco: prepare ok bps: 16000 size: 8002 count: 2000
snd-bt-sco: playback_trigger 1
snd-bt-sco: setting playback to bspcm
snd-bt-sco: playback_trigger 0
snd-bt-sco: setting playback to NULL

Thanks in advance for any help.

Greetings,
Stefan.

-- 
Stefan Bellon


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

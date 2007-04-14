Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <BAY103-F224E09EECA0E11C403D8A5DA5C0@phx.gbl>
From: "X Cite" <getxcite@hotmail.com>
To: bluez-devel@lists.sourceforge.net
Date: Sat, 14 Apr 2007 19:23:27 +0000
Mime-Version: 1.0
Subject: [Bluez-devel] handy as bluetooth headset
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

hi bluez developers!
i wanna know if it's possible to use my sony ericsson w810i handy as a 
bt-headset!

hcitool info <device> :
---------------------------------------------------------------------------------------------------------
Requesting information ...
        BD Address:  nix!
        Device Name:
        LMP Version: 1.2 (0x2) LMP Subversion: 0x41c
        Manufacturer: Philips Semiconductors (37)
        Features: 0xff 0xed 0x8d 0xf8 0x1a 0x08 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <channel quality> <SCO link> <HV3 packets>
                <u-law log> <A-law log> <CVSD> <power control>
                <transparent SCO> <broadcast encrypt> <enhanced iscan>
                <interlaced iscan> <interlaced pscan> <inquiry with RSSI>
                <extended SCO> <EV5 packets> <AFH cap. slave>
                <AFH class. slave> <AFH cap. master>
---------------------------------------------------------------------------------------------------------

sdptool browse <device>:
---------------------------------------------------------------------------------------------------------
Service Description: Sony Ericsson W810
Service RecHandle: 0x10000
Service Class ID List:
  "PnP Information" (0x1200)

Service Name: OBEX SyncML Client
Service RecHandle: 0x10001
Service Class ID List:
  UUID 128: 00000002-0000-1000-8000-0002ee000002
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
  "OBEX" (0x0008)

Service Name: Dial-up Networking
Service RecHandle: 0x10002
Service Class ID List:
  "Dialup Networking" (0x1103)
  "Generic Networking" (0x1201)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 2
Profile Descriptor List:
  "Dialup Networking" (0x1103)
    Version: 0x0100

Service Name: Serial Port
Service RecHandle: 0x10003
Service Class ID List:
  "Serial Port" (0x1101)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 3

Service Name: HF Voice Gateway  <-- this sounds good
Service RecHandle: 0x10004
Service Class ID List:
  "Handfree Audio Gateway" (0x111f)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 4
Profile Descriptor List:
  "Handsfree" (0x111e)
    Version: 0x0101

Service Name: HS Voice Gateway  <--- this too
Service RecHandle: 0x10005
Service Class ID List:
  "Headset Audio Gateway" (0x1112)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 5
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100

Service Name: OBEX Object Push
Service RecHandle: 0x10006
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 6
  "OBEX" (0x0008)
Profile Descriptor List:
  "OBEX Object Push" (0x1105)
    Version: 0x0100

Service Name: OBEX File Transfer
Service RecHandle: 0x10007
Service Class ID List:
  "OBEX File Transfer" (0x1106)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 7
  "OBEX" (0x0008)
Profile Descriptor List:
  "OBEX File Transfer" (0x1106)
    Version: 0x0100

Service Name: OBEX IrMC Sync Server
Service RecHandle: 0x10008
Service Class ID List:
  "IrMC Sync" (0x1104)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 8
  "OBEX" (0x0008)
Profile Descriptor List:
  "IrMC Sync" (0x1104)
    Version: 0x0100

Service Name: NAP service
Service Description: NAP description
Service RecHandle: 0x10009
Service Class ID List:
  "Network Access Point" (0x1116)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 15
  "BNEP" (0x000f)
    Version: 0x0100
    SEQ8: 0 6
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Network Access Point" (0x1116)
    Version: 0x0100

Service Name: Mouse & Keyboard
Service Description: Remote Control
Service Provider: Sony Ericsson
Service RecHandle: 0x1000a
Service Class ID List:
  "Human Interface Device" (0x1124)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 17
  "HIDP" (0x0011)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Human Interface Device" (0x1124)
    Version: 0x0100
---------------------------------------------------------------------------------------------------------

hciconfig hci0 revision :
---------------------------------------------------------------------------------------------------------
hci0:   Type: USB
        BD Address: nix! ACL MTU: 192:8 SCO MTU: 64:8
        HCI 16.4
        Chip version: BlueCore02-External
        Max key size: 56 bit
        SCO mapping:  HCI
---------------------------------------------------------------------------------------------------------

$ uname -r
2.6.19.1
(with patch v3.0 from plugz)

- plugz and sbc successfully build

- pairing with my computer for filetransfer works ( security is auto, 
because my pin_helper does not run correctly, so I added a default passkey 
in hcid.conf)

- I create .asoundrc in my home directory like described

testrun :
$ headsetd -n
headsetd[7473]: Bluetooth headset daemon version 0.5

$ aplay -D headset$ <file.wav>
my handy reacts and want the pin, but than:
headsetd:
headsetd[7473]: Configuration phase ended: target bdaddr is <addr>, timeout 
is 6000 ms
headsetd[7473]: Changing state: Idle-->Paging
headsetd[7473]: Changing state: Paging-->Connecting
headsetd[7473]: unable to connect to headset: Connection refused
headsetd[7473]: Changing state: Connecting-->Idle

aplay says:
aplay: main:550: audio open error: Verbindungsaufbau abgelehnt (Connection 
refused)

the same with mplayer:
alsa-init: playback open error: Connection refused
Could not open/initialize audio device -> no sound.
Audio: no sound

- my Bluez Lib:
  bluez-libs 3.7-4

_________________________________________________________________
Sie suchen E-Mails, Dokumente oder Fotos? Die neue MSN Suche Toolbar mit 
Windows-Desktopsuche liefert in sekundenschnelle Ergebnisse. Jetzt neu! 
http://desktop.msn.de/ Jetzt gratis downloaden!


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

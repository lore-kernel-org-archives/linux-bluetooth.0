Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <437514D5.7040300@gmx.de>
From: Maik Zumstrull <Maik.Zumstrull@gmx.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=UTF-8
Subject: [Bluez-devel] btsco: Not working...but almost
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 11 Nov 2005 23:01:57 +0100

Okay, I'm in the situation I've seen reportet a few times on the List:

Everything seems as if it were working, but I can't actually hear any
sound sent to the Headset. I suspect it's the unsupported Bluetooth
adapter in my laptop, which ist, unfortunately, Broadcom-based.

Any chance to get these supported? Using an additional USB Bluetooth
stick when I have a built-in adapter seems stupid.

Anyway, here's my configuration (I'm going by the bulletpoints on the
bluetooth-alsa page):

Hub: Don't know. It's internal, as I said. They might have wired it up
in a weird way. I see the Bluetooth dongle as "Bus 4 Device 2".

Headset: Jabra BT500
Adapter: The one that comes with an IBM T43p, Broadcom-based
http://www.thinkwiki.org/wiki/IBM_Integrated_Bluetooth_IV_with_56K_Modem_%28BMDC-3%29


sp8472@Maik-2013:~$ sudo hciconfig -a
hci0:   Type: USB
        BD Address: 00:0E:9B:DE:0C:60 ACL MTU: 377:10 SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT
        RX bytes:67613 acl:26 sco:1280 events:68 errors:0
        TX bytes:925 acl:21 sco:0 commands:40 errors:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'Maik-2013-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x9 LMP Ver: 1.2 (0x2) LMP Subver:
0x6963
        Manufacturer: Broadcom Corporation (15)

sp8472@Maik-2013:~$ sudo hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:0E:9B:DE:0C:60 ACL MTU: 377:10 SCO MTU: 16:0
        Firmware 9.105 / 99
sp8472@Maik-2013:~$ sudo hcitool info 00:07:A4:C0:25:A5
Requesting information ...
        BD Address:  00:07:A4:C0:25:A5
        Device Name: Jabra BT500
        LMP Version: 1.2 (0x2) LMP Subversion: 0x613
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>
                <hold mode> <sniff mode> <park state> <RSSI> <channel
quality>
                <SCO link> <HV2 packets> <HV3 packets> <u-law log>
<A-law log>
                <CVSD> <paging scheme> <transparent SCO>
sp8472@Maik-2013:~$



This is output from btsco (while trying to play a file to the device):
btsco v0.4c
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
speaker volume: 15 mic volume: 1
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
recieved AT+VGS=15
Sending up speaker change 15
speaker volume: 15 mic volume: 1
driver is not in use
disconnected SCO channel


Kernel 2.6.14, bluez-utils 2.19


I hope I can somehow get this configuration to work. Otherwise, I'd have
to either send back the headset or get a CSR adapter. Both would annoy
me, obviously. Thanks for any help you can offer.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

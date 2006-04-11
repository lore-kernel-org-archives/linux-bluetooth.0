Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Wayne Stallwood <wayne@digimatic.plus.com>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1144793265.6691.14.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] hardware report for bluetooth-alsa
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
Date: Tue, 11 Apr 2006 23:07:45 +0100

Just built btsco from CVS and I can confirm that it works with the
following hardware.

Hawking Technology HBTC1 USB adapter
Bluetrek G2 headset (volume controls and call button are also detected)

The only problem I have is that the sound from the Bluetrek's mic is
muffled and quiet even if I set Mic volume to 15. It seems to be some
sort of soft clipping issue because from volume 8 to 15 yelds little
change and it is still as quiet (but distorted) if I shout at it.

Performance of the G2's Mic is fine when it is paired with my mobile.

Is there anything I can do to tweak the sound quality or are the quality
issues work in progress ?

Many Thanks for getting me this far
Wayne

hciconfig -a
hci0:   Type: USB
        BD Address: 00:E0:98:FD:C5:CB ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:3379314 acl:6837 sco:62823 events:6924 errors:0
        TX bytes:3307038 acl:6766 sco:62497 commands:44 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'digimatic-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object
Transfer, Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
0x20d
        Manufacturer: Cambridge Silicon Radio (10)

sudo hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:E0:98:FD:C5:CB ACL MTU: 192:8 SCO MTU: 64:8
        HCI 16.4
        Chip version: BlueCore02-External
        Max key size: 56 bit
        SCO mapping:  HCI

hcitool info 00:06:C5:0F:85:90
Requesting information ...
        BD Address:  00:06:C5:0F:85:90
        Device Name: BlueTrek G2
        LMP Version: 1.1 (0x1) LMP Subversion: 0x42c
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role
switch>
                <hold mode> <sniff mode> <park state> <RSSI> <channel
quality>
                <SCO link> <HV2 packets> <HV3 packets> <u-law log>
<A-law log>
                <CVSD> <paging scheme> <power control> <transparent SCO>





-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

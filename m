Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Fri, 28 Jul 2006 14:37:44 -0400
Message-ID: <E65CD2CAB74C80498703D6EF7624BB4C023974AE@zmaex.zma.zoran.com>
From: "Lan Zhang" <Lan.Zhang@Zoran.com>
To: <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Hci Reset Problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi, Marcel:

I forgot the system we had is using vmware system, and that may cause
the HCI to reset. Anyway, I tested all the BT dongle I had here with a
stang along Linux, I attached result below. I htink you may interested. 

Regards,
Lan


EPSON --- WORK
hci0:   Type: USB
        BD Address: 00:03:7A:2A:CD:D8 ACL MTU: 384:8 SCO MTU: 64:8
        HCI 19.2
        Chip version: BlueCore4-External
        Max key size: 56 bit
        SCO mapping:  HCI
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
                <3-slot packets> <5-slot packets> <encryption> <slot
offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2
packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging
scheme>
                <power control> <transparent SCO> <broadcast encrypt>
                <EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan>
                <interlaced iscan> <interlaced pscan> <inquiry with
RSSI>
                <extended SCO> <EV4 packets> <EV5 packets> <AFH cap.
slave>
                <AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL>
                <AFH cap. master> <AFH class. master> <EDR eSCO 2 Mbps>
                <EDR eSCO 3 Mbps> <3-slot EDR eSCO> <extended features>

Belkin, linksys, D-link --- WORK
hci0:   Type: USB
        BD Address: 00:0A:3A:55:C3:4C ACL MTU: 192:8 SCO MTU: 64:8
        HCI 16.4
        Chip version: BlueCore02-External
        Max key size: 56 bit
        SCO mapping:  HCI
        Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot
offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2
packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging
scheme>
                <transparent SCO>


CNet --- WORK
hci0:   Type: USB
        BD Address: 00:11:F6:02:85:C8 ACL MTU: 120:20 SCO MTU: 64:0
        Unsupported manufacturer
        Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot
offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2
packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <power
control>
                <enhanced iscan> <interlaced iscan> <interlaced pscan>
                <AFH cap. slave> <AFH class. slave> <AFH cap. master>
                <AFH class. master>



AmbiCom --- DIDN'T WORK at all, cannot send out inquire. 
hci0:   Type: USB
        BD Address: 00:0E:A1:32:CA:E1 ACL MTU: 377:10 SCO MTU: 16:0
        Firmware 0.105 / 97
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot
offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <power
control>
                <transparent SCO> <enhanced iscan> <interlaced iscan>
                <interlaced pscan> <AFH cap. slave> <AFH cap. master>

Kensington --- DIDN'T WORK at all. 
hci0:   Type: USB
        BD Address: 00:0C:55:F6:6A:01 ACL MTU: 377:10 SCO MTU: 16:0
        Firmware 0.105 / 101
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot
offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <power
control>
                <transparent SCO> <enhanced iscan> <interlaced iscan>
                <interlaced pscan> <AFH cap. slave> <AFH cap. master>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

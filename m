Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Miles Sabin <miles@milessabin.com>
To: bluez-devel@lists.sourceforge.net
Date: Sat, 6 Jan 2007 19:03:42 +0000
MIME-Version: 1.0
Message-Id: <200701061903.42746.miles@milessabin.com>
Subject: [Bluez-devel] btsco and Sony Ericsson HBH-PV705 headset
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

I'm having problems getting this working with Skype or aplay on an FC6
Sony Vaio laptop. btsco is fresh from CVS today.

The bluetooth connection looks good, SCO channel connections/disconnections
produce an audible click on the headset speaker, and kill -USR1 <btsco>
gives me a ringtone on the headset as expected. However, I'm getting no
other audio, either input or output. Any help would be much appreciated.

The details, as requested on the bluetooth-alsa Contacts page,

miles@kant:~$ hciconfig -a
hci0:   Type: USB
        BD Address: 08:00:46:CC:4F:D5 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN
        RX bytes:17936 acl:216 sco:0 events:570 errors:0
        TX bytes:6725 acl:235 sco:0 commands:194 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'Kant'
        Class: 0x120104
        Service Classes: Networking, Object Transfer
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.1 (0x1) HCI Rev: 0x30d LMP Ver: 1.1 (0x1) LMP Subver: 0x30d
        Manufacturer: Cambridge Silicon Radio (10)

root@kant:miles# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 08:00:46:CC:4F:D5 ACL MTU: 192:8 SCO MTU: 64:8
        HCI 16.7.5
        Chip version: BlueCore02-External
        Max key size: 56 bit
        SCO mapping:  HCI

miles@kant:~$ hcitool info 00:16:B8:D1:96:C7
Requesting information ...
        BD Address:  00:16:B8:D1:96:C7
        Device Name: HBH-PV705
        LMP Version: 1.2 (0x2) LMP Subversion: 0x73b
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xfe 0x0f 0x00 0x08 0x08 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>
                <hold mode> <sniff mode> <RSSI> <channel quality> <SCO link>
                <HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>
                <paging scheme> <power control> <transparent SCO>
                <AFH cap. slave> <AFH cap. master>

root@kant:miles# hcidump -X -V    # While making a Skype test call
HCI sniffer - Bluetooth packet analyzer ver 1.32
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
    handle 42 ptype 0x00e0
    Packet type: HV1 HV2 HV3
> HCI Event: Command Status (0x0f) plen 4
    Add SCO Connection (0x01|0x0007) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:16:B8:D1:96:C7 type SCO encrypt 0x01
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:16:B8:D1:96:C7 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> ACL data: handle 42 flags 0x02 dlen 19
    L2CAP(d): cid 0x0041 len 15 [psm 0]
      0000: 09 ff 15 01 41 54 2b 56  47 53 3d 30 39 0d 5c     ....AT+VGS=09.\
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x004f len 10 [psm 0]
      0000: 0b ef 0d 0d 0a 4f 4b 0d  0a 9a                    .....OK...
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:16:B8:D1:96:C7 name 'HBH-PV705'
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 41 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x16
    Reason: Connection Terminated by Local Host

miles@kant:~$ uname -a
Linux kant.milessabin.com 2.6.18-1.2869.fc6 #1 SMP Wed Dec 20 14:51:19 EST 2006 i686 i686 i386 GNU/Linux

miles@kant:~$ rpm -qa | grep bluez
bluez-libs-3.7-1
bluez-gnome-0.6-1.fc6
bluez-hcidump-1.32-1
bluez-utils-3.7-2
bluez-libs-devel-3.7-1
bluez-utils-cups-3.7-2

Cheers,


Miles

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

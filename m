Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Daniel Andor <da209@cam.ac.uk>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200501181145.11573.da209@cam.ac.uk>
Subject: [Bluez-devel] bluetooth headset
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
Date: Tue, 18 Jan 2005 11:45:11 +0000

Hi,

Had success with connecting to my laptop's headset profile, but not before 
figuring out that it doesn't work with the default channel 7, but needs to be 
made to use channel 8:

Does't work:
$ ./btsco 00:0B:6B:58:92:E9
Device is 3:0
Voice setting: 0x0060
RFCOMM channel 7 connected

Does work:
$ ./btsco 00:0B:6B:58:92:E9 8
Device is 3:0
Voice setting: 0x0060
RFCOMM channel 8 connected
recieved AT+BRSF=22
recieved AT+CIND=?
opened hwdep
connected SCO channel
Setting sco fd
Done setting sco fd
recieved AT+CIND?
AT+CMER=3,0,0,1=15
Sending up speaker change 15
recieved AT+CHLD=?
recieved AT+CCWA=1
recieved AT+CLIP=1

Details:
$ uname -a
Linux pooh 2.6.9-2-k7 #1 Sat Jan 8 15:38:24 EST 2005 i686 GNU/Linux

$ sudo hciconfig -a
hci0:   Type: USB
        BD Address: 00:02:72:40:AD:56 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:9550635 acl:181 sco:187095 events:359 errors:0
        TX bytes:9545657 acl:188 sco:187095 commands:98 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: ACCEPT MASTER
        Name: 'pooh'
        Class: 0x100100
        Service Classes: Object Transfer
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)

$ sudo hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:02:72:40:AD:56 ACL MTU: 192:8  SCO MTU: 64:8
        HCI 16.4
        Chip version: BlueCore02
        Max key size: 56 bit
        SCO mapping:  HCI

$ sudo hcitool info 00:0B:6B:58:92:E9
Requesting information ...
        BD Address:  00:0B:6B:58:92:E9
        Device Name: HANNAH
        LMP Version: 1.2 (0x2) LMP Subversion: 0x694a
        Manufacturer: Broadcom Corporation (15)
        Features: 0xff 0xff 0x0d 0x38 0x08 0x08 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <power control>
                <transparent SCO> <enhanced iscan> <interlaced iscan>
                <interlaced pscan> <AFH cap. slave> <AFH cap. master>



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

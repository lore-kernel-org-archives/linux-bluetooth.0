Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <b92d97be0704232057m648388a9w1748fe6312d25164@mail.gmail.com>
Date: Tue, 24 Apr 2007 13:27:12 +0930
From: "Adam Dixon" <adamtdixon@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] headset and input noise
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

Hello All.

I have bluetooth going on my laptop, and have got btsco working with
my X3 micro bt headset. However I get mass static / noise from the
input randomly.
I have reproduced on skype, twinkle and now on arecord. So currently I
dont want to use it for the phone (its intended use).

I have searched the list, and found some people having reference the
'noise', but found no clear fix.

I followed a guide to get everything installed and this is how I bring
up my headset;
hcitool cc 00:0F:79:04:7A:11
modprobe snd_bt_sco  (not done if already loaded)
hciconfig hci0 voice 0x0060
btsco 00:0F:79:04:7A:11

Has anyone had this problem and know how to get around it? As I am
very happy with it other wise. If anyone could lend a hand that would
be great.

Adam



Some information;

btsco v0.5c

uname -a
Linux dixon 2.6.20-1.2933.fc6 #1 SMP Mon Mar 19 11:00:19 EDT 2007
x86_64 x86_64 x86_64 GNU/Linux

hciconfig -a
hci0:   Type: USB
        BD Address: 00:1A:6B:1E:E9:A6 ACL MTU: 384:8 SCO MTU: 64:8
        UP RUNNING PSCAN
        RX bytes:6909425 acl:20 sco:135398 events:111 errors:0
        TX bytes:6889503 acl:18 sco:135074 commands:57 errors:5
        Features: 0xff 0xff 0x9f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'dixon-0'
        Class: 0x120104
        Service Classes: Networking, Object Transfer
        Device Class: Computer, Desktop workstation
        HCI Ver: 2.0 (0x3) HCI Rev: 0xdd2 LMP Ver: 2.0 (0x3) LMP Subver: 0xdd2
        Manufacturer: Cambridge Silicon Radio (10)

hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:1A:6B:1E:E9:A6 ACL MTU: 384:8 SCO MTU: 64:8
        Build 3538
        Chip version: BlueCore4-External
        Max key size: 56 bit
        SCO mapping:  HCI

hcitool scan
Scanning ...
        00:0F:79:04:7A:11       X3 micro

 hcitool info 00:0F:79:04:7A:11
Requesting information ...
        BD Address:  00:0F:79:04:7A:11
        Device Name: X3 micro
        LMP Version: 1.2 (0x2) LMP Subversion: 0x610
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xff 0x0f 0x00 0x08 0x08 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>
                <hold mode> <sniff mode> <park state> <RSSI> <channel quality>
                <SCO link> <HV2 packets> <HV3 packets> <u-law log> <A-law log>
                <CVSD> <paging scheme> <power control> <transparent SCO>
                <AFH cap. slave> <AFH cap. master>

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

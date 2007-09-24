Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Michele Puccio <michele.puccio@eng.it>
To: bluez-users@lists.sourceforge.net
Date: Mon, 24 Sep 2007 16:00:01 +0200
Message-Id: <1190642401.6465.20.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-users] problem pairing device
Reply-To: michele.puccio@eng.it,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

hi all
I cannot pair any device using hcitool scan or hcitool inq: both exit
without any result or error. this is the output of hcidump during a
scan:
HCI sniffer - Bluetooth packet analyzer ver 1.33
device: hci0 snap_len: 1028 filter: 0xffffffff
HCI Command: Inquiry (0x01|0x0001) plen 5
        lap 0x9e8b33 len 8 num 0
HCI Event: Command Status (0x0f) plen 4
        Inquiry (0x01|0x0001) status 0x00 ncmd 1
HCI Event: Vendor (0xff) plen 7
        0000: cd 03 00 04 00 0000                              .......
HCI Event: Vendor (0xff) plen 7
        0000: cd 03 00 04 00 0000                              .......
HCI Event: Vendor (0xff) plen 7
        0000: cd 03 00 04 00 0000                              .......
HCI Event: Vendor (0xff) plen 7
        0000: cd 03 00 04 00 0000                              .......
HCI Event: Vendor (0xff) plen 7
        0000: cd 03 00 04 00 0000                              .......
HCI Event: Vendor (0xff) plen 7
        0000: cd 03 00 04 00 0000                              .......
HCI Event: Vendor (0xff) plen 7
        0000: cd 03 00 04 00 0000                              .......
HCI Event: Vendor (0xff) plen 7
        0000: cd 03 00 04 00 0000                              .......
HCI Event: Vendor (0xff) plen 7
        0000: cd 03 00 04 00 0000                              .......
HCI Event: Vendor (0xff) plen 7
        0000: cd 03 00 04 00 0000                              .......
HCI Event: Inquiry Complete (0x01) plen 1
        
status 0x00 and this is the output of hciconfig -a
hci0:   Type: USB
        BD Address: 00:16:41:1B:97:A3 ACL MTU: 384:8 SCO MTU: 64:8
        UP RUNNING PSCAN 
        RX bytes:807 acl:0 sco:0 events:63 errors:0
        TX bytes:331 acl:0 sco:0 commands:20 errors:0
        Features: 0xff 0xff 0x9f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'D610'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x679 LMP Ver: 1.2 (0x2) LMP Subver:
0x679
        Manufacturer: Cambridge Silicon Radio (10)

I'm using ubuntu feisty. any suggestions?
thanks
michele


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

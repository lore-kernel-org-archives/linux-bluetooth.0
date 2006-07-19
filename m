Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44BE5DB3.7090406@gmail.com>
Date: Wed, 19 Jul 2006 12:28:35 -0400
From: JP Freeley <jpf321@gmail.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Error: sdptool browse --> Connection reset by peer
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

I am getting an error ("Connection reset by peer") when I run an 
"sdptool browse" and it discovers my Sprint Pocket PC handset.

I'm sure this is probably a common situation. I have attached my 
"hcidump -V -R". Any help in deciphering this problem would be great. My 
goal is to send a .vcf file to the device.

Could this device be looking at my "device class" and refusing the 
connection?

Of course, I'd be happy to provide any other info as necessary to assit.

TIA,

jpf

*** HCICONFIG ***

% hciconfig -a

hci0:   Type: USB

        BD Address: 00:03:C9:87:37:13 ACL MTU: 1017:8 SCO MTU: 64:0

        UP RUNNING PSCAN ISCAN 

        RX bytes:18007 acl:307 sco:0 events:523 errors:0

        TX bytes:90101 acl:325 sco:0 commands:129 errors:0

        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80

        Packet type: DM1 DH1 HV1 

        Link policy: RSWITCH HOLD SNIFF PARK 

        Link mode: SLAVE ACCEPT 

        Name: 'bbm-0'

        Class: 0x100100

        Service Classes: 

        Device Class: Computer, Uncategorized

        HCI Ver: 2.0 (0x3) HCI Rev: 0x2000 LMP Ver: 2.0 (0x3) LMP Subver: 0x4127

        Manufacturer: Broadcom Corporation (15)

*** HCIDUMP ***

% hcidump -V -R

HCI sniffer - Bluetooth packet analyzer ver 1.30

device: hci0 snap_len: 1028 filter: 0xffffffff

< 01 01 04 05 33 8B 9E 0A 14 

< HCI Command: Inquiry (0x01|0x0001) plen 5

    lap 0x9e8b33 len 10 num 20

> 04 0F 04 00 01 01 04 

> HCI Event: Command Status (0x0f) plen 4

    Inquiry (0x01|0x0001) status 0x00 ncmd 1

> 04 02 0F 01 99 CD B9 37 12 00 01 00 00 14 01 10 CB 1E 

> HCI Event: Inquiry Result (0x02) plen 15

    bdaddr 00:12:37:B9:CD:99 mode 1 clkoffset 0x1ecb class 0x100114

> 04 02 0F 01 99 CD B9 37 12 00 01 00 00 14 01 10 CB 1E 

> HCI Event: Inquiry Result (0x02) plen 15

    bdaddr 00:12:37:B9:CD:99 mode 1 clkoffset 0x1ecb class 0x100114

> 04 02 0F 01 99 CD B9 37 12 00 01 00 00 14 01 10 CA 1E 

> HCI Event: Inquiry Result (0x02) plen 15

    bdaddr 00:12:37:B9:CD:99 mode 1 clkoffset 0x1eca class 0x100114

> 04 02 0F 01 99 CD B9 37 12 00 01 00 00 14 01 10 CB 1E 

> HCI Event: Inquiry Result (0x02) plen 15

    bdaddr 00:12:37:B9:CD:99 mode 1 clkoffset 0x1ecb class 0x100114

> 04 02 0F 01 99 CD B9 37 12 00 01 00 00 14 01 10 CB 1E 

> HCI Event: Inquiry Result (0x02) plen 15

    bdaddr 00:12:37:B9:CD:99 mode 1 clkoffset 0x1ecb class 0x100114

> 04 02 0F 01 99 CD B9 37 12 00 01 00 00 14 01 10 CB 1E 

> HCI Event: Inquiry Result (0x02) plen 15

    bdaddr 00:12:37:B9:CD:99 mode 1 clkoffset 0x1ecb class 0x100114

> 04 02 0F 01 99 CD B9 37 12 00 01 00 00 14 01 10 CB 1E 

> HCI Event: Inquiry Result (0x02) plen 15

    bdaddr 00:12:37:B9:CD:99 mode 1 clkoffset 0x1ecb class 0x100114

> 04 02 0F 01 99 CD B9 37 12 00 01 00 00 14 01 10 CA 1E 

> HCI Event: Inquiry Result (0x02) plen 15

    bdaddr 00:12:37:B9:CD:99 mode 1 clkoffset 0x1eca class 0x100114

> 04 02 0F 01 99 CD B9 37 12 00 01 00 00 14 01 10 CB 1E 

> HCI Event: Inquiry Result (0x02) plen 15

    bdaddr 00:12:37:B9:CD:99 mode 1 clkoffset 0x1ecb class 0x100114

> 04 02 0F 01 99 CD B9 37 12 00 01 00 00 14 01 10 CB 1E 

> HCI Event: Inquiry Result (0x02) plen 15

    bdaddr 00:12:37:B9:CD:99 mode 1 clkoffset 0x1ecb class 0x100114

> 04 02 0F 01 99 CD B9 37 12 00 01 00 00 14 01 10 CA 1E 

> HCI Event: Inquiry Result (0x02) plen 15

    bdaddr 00:12:37:B9:CD:99 mode 1 clkoffset 0x1eca class 0x100114

> 04 01 01 00 

> HCI Event: Inquiry Complete (0x01) plen 1

    status 0x00

< 01 05 04 0D 99 CD B9 37 12 00 18 00 01 00 CA 9E 01 

< HCI Command: Create Connection (0x01|0x0005) plen 13

    bdaddr 00:12:37:B9:CD:99 ptype 0x0018 rswitch 0x01 clkoffset 0x1eca (valid)

    Packet type: DM1 DH1 

> 04 0F 04 00 01 05 04 

> HCI Event: Command Status (0x0f) plen 4

    Create Connection (0x01|0x0005) status 0x00 ncmd 1

> 04 03 0B 00 0C 00 99 CD B9 37 12 00 01 00 

> HCI Event: Connect Complete (0x03) plen 11

    status 0x00 handle 12 bdaddr 00:12:37:B9:CD:99 type ACL encrypt 0x00

< 02 0C 20 0C 00 08 00 01 00 02 01 04 00 01 00 40 00 

< 01 0D 08 04 0C 00 0F 00 

< ACL data: handle 12 flags 0x02 dlen 12

    L2CAP(s): Connect req: psm 1 scid 0x0040

< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4

    handle 12 policy 0x0f

    Link policy: RSWITCH HOLD SNIFF PARK 

> 04 0E 06 01 0D 08 00 0C 00 

> HCI Event: Command Complete (0x0e) plen 6

    Write Link Policy Settings (0x02|0x000d) ncmd 1

    status 0x00 handle 12

> 04 05 04 00 0C 00 13 

> HCI Event: Disconn Complete (0x05) plen 4

    status 0x00 handle 12 reason 0x13

    Reason: Remote User Terminated Connection


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

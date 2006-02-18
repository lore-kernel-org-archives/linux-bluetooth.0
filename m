Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Florian Schmid <annaeus@gmx.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200602182140.29119.annaeus@gmx.de>
Subject: [Bluez-users] Pairing BTH-100 with Bluwalker BT-Dongle
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
Date: Sat, 18 Feb 2006 21:40:28 +0100

Hello,
I`m trying to pair my Hama BTH-100 Headset to my Bluewalker BT-Dongle.
But I only get this Errormessage:

btsco -v 00:14:41:00:10:54
btsco v0.41
Device is 1:0
Error: Failed to connect to SDP server: Invalid exchange
Assuming channel 2

Voice setting: 0x0060
Can't connect RFCOMM channel: Invalid exchange

Maybe that ist usefull also:
--------------------------------------
hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.23
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:14:41:00:10:54 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:14:41:00:10:54
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
    bdaddr 00:14:41:00:10:54
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
    status 0x00 bdaddr 00:14:41:00:10:54
> HCI Event: Connect Complete (0x03) plen 11
    status 0x06 handle 11 bdaddr 00:14:41:00:10:54 type ACL encrypt 0x00
    Error: PIN or Key Missing
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 1
    status 0x00 voice setting 0x0060
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:14:41:00:10:54 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:14:41:00:10:54
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
    bdaddr 00:14:41:00:10:54
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
    status 0x00 bdaddr 00:14:41:00:10:54
> HCI Event: Connect Complete (0x03) plen 11
    status 0x06 handle 11 bdaddr 00:14:41:00:10:54 type ACL encrypt 0x00
    Error: PIN or Key Missing
-------------------------

lsusb
Bus 005 Device 001: ID 0000:0000
Bus 004 Device 002: ID 0a5c:2101 Broadcom Corp.
Bus 004 Device 001: ID 0000:0000
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 003: ID 093a:2500 Pixart Imaging, Inc.
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000
---------------------------------------------------------------------------
hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:0B:0D:4A:53:0F ACL MTU: 1017:8 SCO MTU: 64:0
        Firmware 8285.65 / 33
---------------------------------------------------------

hciconfig -a
hci0:   Type: USB
        BD Address: 00:0B:0D:4A:53:0F ACL MTU: 1017:8 SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:2397 acl:0 sco:0 events:182 errors:0
        TX bytes:1318 acl:0 sco:0 commands:92 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'rechenknecht-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x205d LMP Ver: 2.0 (0x3) LMP Subver: 
0x4121
        Manufacturer: Broadcom Corporation (15)
-------------------------------------------------

Thank you for your help.

Florian Schmid


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

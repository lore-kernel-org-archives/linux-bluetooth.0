Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: David Mackie <D.Mackie@ru.ac.za>
To: bluez-users@lists.sourceforge.net
Message-ID: <20060118123739.GA39259@rucus.ru.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] rfcomm connect error Too many links(31)
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
Date: Wed, 18 Jan 2006 14:37:39 +0200

Hi,

I am trying to write a program that forwards one rfcomm connection to
another connection, but each time I try make a 2nd connection out I get a
"Too many links(31)" error. Attached is my code but here is some simple
"psedo code" of it:

rcsocklisten = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)
bind(rcsocklisten, (struct sockaddr *) &loc_addr, sizeof(loc_addr)
listen(rcsocklisten, 4)
rcsockin = accept(rcsocklisten, (struct sockaddr *)&rem_addr, &opt)
rcsockout = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)
bind(rcsockout, (struct sockaddr *) &addr, sizeof(addr)
connect(rcsockout, (struct sockaddr *)&addr, sizeof(addr)
--ERROR here--

hcidump -V -x shows the following:

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:80:C8:26:FD:6D ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x09 handle 0 bdaddr 00:80:C8:26:FD:6D type ACL encrypt 0x00
    Error: Connection Limit Exceeded

The "Connection Limit Exceeded" is worry and confusing me as I have run
mutiple rfcomm connections through this chip before.

below are hciconfig -a on the 3 devices

[device rcloopback is run on]
hci0:   Type: USB
        BD Address: 00:0D:88:AC:DE:07 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING
        RX bytes:244095 acl:1979 sco:0 events:11528 errors:0
        TX bytes:1472737 acl:11072 sco:0 commands:184 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'bent'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1 (0x1) LMP Subver: 0x1bb
        Manufacturer: Cambridge Silicon Radio (10)

[device connecting to rcloopback]
hci0:   Type: USB
        BD Address: 00:20:ED:09:59:57 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:181657222 acl:868257 sco:0 events:533586 errors:0
        TX bytes:106682353 acl:645874 sco:0 commands:615 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'crooked'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x110 LMP Ver: 1.1 (0x1) LMP Subver: 0x110
        Manufacturer: Cambridge Silicon Radio (10)

[device rcloopback connects too]
hci0:   Type: USB
        BD Address: 00:80:C8:26:FD:6D ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING
        RX bytes:394 acl:0 sco:0 events:18 errors:0
        TX bytes:319 acl:0 sco:0 commands:17 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'ubuntu-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1 (0x1) LMP Subver: 0x1bb
        Manufacturer: Cambridge Silicon Radio (10)

Any help would be very much appreciated as I am hitting a brick wall...

-- 
 David Mackie


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

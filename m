Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4316B5BE.4090901@avantwave.com>
From: mike lee <mikelee@avantwave.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Could not connect with pand profile
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
Date: Thu, 01 Sep 2005 16:03:10 +0800

Dear all
   I am developing a embedded device with pand profile. But the device
can not connect to a bluetooth access point with error code 0x22 which
is LMP timeout. Below is the hcidump result.
   It seems to not give out the pincode. Although the bluepin script is
refined to one line "echo PIN:0000" , i don't know whether it is the
problem. And all other things are the default setting.

< HCI Command: Create Connection(0x01|0x0005) plen 13
  5A 06 00 E0 08 00 18 CC 02 00 00 00 01
> HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
> HCI Event: Role Change(0x12) plen 8
  00 5A 06 00 E0 08 00 01
> HCI Event: PIN Code Request(0x16) plen 6
  5A 06 00 E0 08 00
> HCI Event: Connect Complete(0x03) plen 11
  22 29 00 5A 06 00 E0 08 00 01 00

hciconfig -a
hci0:   Type: UART
        BD Address: 00:08:E0:04:A4:BF ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:5933 acl:153 sco:0 events:337 errors:0
        TX bytes:3632 acl:141 sco:0 commands:71 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: '00:08:E0:04:A4:BF'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
0x20d
        Manufacturer: Cambridge Silicon Radio (10)

Thx for helping
Mike,Lee


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

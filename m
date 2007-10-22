Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Oliver Neukum <oliver@neukum.org>
To: marcel@holtmann.org, maxk@qualcomm.com, bluez-devel@lists.sf.net
Date: Mon, 22 Oct 2007 17:01:23 +0200
MIME-Version: 1.0
Message-Id: <200710221701.24120.oliver@neukum.org>
Subject: [Bluez-devel] connection to keypad dropped after several minutes of
	inactivity with 2.6.23
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

I have a Logitech Mediapad which drops the connection if I don't use it for several minutes.
It just stops working.

oenone:/home/oliver # hciconfig -a
hci0:   Type: USB
        BD Address: 00:50:F2:E9:DF:8D ACL MTU: 377:10 SCO MTU: 16:0
        UP RUNNING PSCAN
        RX bytes:0 acl:177 sco:0 events:286 errors:0
        TX bytes:1747 acl:43 sco:0 commands:66 errors:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ oenone (0)'
        Class: 0x100100
        Service Classes: Object Transfer
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x3 LMP Ver: 1.2 (0x2) LMP Subver: 0x800
        Manufacturer: Broadcom Corporation (15)

oenone:/home/oliver # hcitool inq
Inquiring ...
oenone:/home/oliver # hcitool info 00:07:61:36:C1:09
Requesting information ...
        BD Address:  00:07:61:36:C1:09
        Device Name: Logitech Mediapad
        LMP Version: 1.2 (0x2) LMP Subversion: 0x545
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xff 0x0f 0x00 0x08 0x08 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>
                <hold mode> <sniff mode> <park state> <RSSI> <channel quality>
                <SCO link> <HV2 packets> <HV3 packets> <u-law log> <A-law log>
                <CVSD> <paging scheme> <power control> <transparent SCO>
                <AFH cap. slave> <AFH cap. master>

	Regards
		Oliver

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4729D526.8050308@vsnl.com>
Date: Thu, 01 Nov 2007 19:01:18 +0530
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
From: Mohan Sundaram <mohan.tux@gmail.com>
Subject: [Bluez-users] Headset problem
Reply-To: smohan@vsnl.com, BlueZ users <bluez-users@lists.sourceforge.net>
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

OS: Ubuntu Gutsy with standard Bluez utils
Headset utility command: gksudo -D 
/usr/share/applications/gbtsco.desktop /usr/bin/gbtsco
Paired devices management: kcmshell kcm_btpaired

Removed pairing and discovered Motorola HS805. Connects when choose make 
active headset in gbtsco. Bluetooth Manager shows popup where 0000 is 
given and connection gets established. Used hcitool to check.

	root@smohan-laptop:/home/smohan# hcitool con
	Connections:
         	< ACL 00:0B:2E:39:31:3F handle 12 state 1 lm MASTER
	root@smohan-laptop:/home/smohan#

Powered off headset. Powered it on and it was discovered in gbtsco. 
However, make active handset failed. hcidump shown below.

root@smohan-laptop:/home/smohan# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.39
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:0B:2E:39:31:3F ptype 0xcc18 rswitch 0x01 clkoffset 0x5c16 
(valid)
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: Link Key Request (0x17) plen 6
     bdaddr 00:0B:2E:39:31:3F
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
     bdaddr 00:0B:2E:39:31:3F key 265F25F5209707194F1651FF8A49B049
 > HCI Event: Command Complete (0x0e) plen 10
     Link Key Request Reply (0x01|0x000b) ncmd 1
     status 0x00 bdaddr 00:0B:2E:39:31:3F
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x05 handle 12 bdaddr 00:0B:2E:39:31:3F type ACL encrypt 0x00
     Error: Authentication Failure
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
 > HCI Event: Command Complete (0x0e) plen 6
     Read Voice Setting (0x03|0x0025) ncmd 1
     status 0x00 voice setting 0x0060
< HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:0B:2E:39:31:3F ptype 0xcc18 rswitch 0x01 clkoffset 0x5c16 
(valid)
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: Link Key Request (0x17) plen 6
     bdaddr 00:0B:2E:39:31:3F
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
     bdaddr 00:0B:2E:39:31:3F key 265F25F5209707194F1651FF8A49B049
 > HCI Event: Command Complete (0x0e) plen 10
     Link Key Request Reply (0x01|0x000b) ncmd 1
     status 0x00 bdaddr 00:0B:2E:39:31:3F
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x05 handle 12 bdaddr 00:0B:2E:39:31:3F type ACL encrypt 0x00
     Error: Authentication Failure

How do I get this to work if it is paired once? In Bluetooth 
preferences, the device is seen as a bonded and trusted device too.

Mohan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <47293E85.1050708@vsnl.com>
Date: Thu, 01 Nov 2007 08:18:37 +0530
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

I have a Motorola headset and am trying to use it with my system. When I 
invoke the Bluetooth headset applet, the headset is discovered by does 
not register as the active handset. It looks like the connection is made 
but it still does not show up.

root@smohan-laptop:/home/smohan# hcidump
HCI sniffer - Bluetooth packet analyzer ver 1.39
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
 > HCI Event: Command Status (0x0f) plen 4
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
 > HCI Event: Inquiry Complete (0x01) plen 1
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
 > HCI Event: Command Status (0x0f) plen 4
 > HCI Event: Remote Name Req Complete (0x07) plen 255
< HCI Command: Create Connection (0x01|0x0005) plen 13
 > HCI Event: Command Status (0x0f) plen 4
 > HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
 > HCI Event: Command Complete (0x0e) plen 10
 > HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
 > HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Create Connection (0x01|0x0005) plen 13
 > HCI Event: Command Status (0x0f) plen 4
 > HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
 > HCI Event: Command Complete (0x0e) plen 10
 > HCI Event: Connect Complete (0x03) plen 11

after this, hcitool con does not show any connections.
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

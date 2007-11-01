Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <47297FC1.4030602@gmail.com>
Date: Thu, 01 Nov 2007 12:56:57 +0530
From: Mohan Sundaram <mohan.tux@gmail.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <47293E85.1050708@vsnl.com>
	<1193893377.32459.111.camel@violet>	<472971D8.60704@gmail.com>
	<1193898729.32459.144.camel@violet>
In-Reply-To: <1193898729.32459.144.camel@violet>
Subject: Re: [Bluez-users] Headset problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
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

Marcel Holtmann wrote:
> that is a strange issue. What does 'hciconfig hci0 version' tells you
> about your dongle?
> 
> Are you sure you are using standard code, because this double name
> resolving is not meant to happen.
> 
> Regards
> 
> Marcel
Another thing I noticed is that whenever this happens, if I switch off 
and switch on the radio (fn+F2) for both wifi and BT, the discovery goes 
thro' ok. hcidump given.

root@smohan-laptop:/home/smohan# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.39
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
     lap 0x9e8b33 len 8 num 250
 > HCI Event: Command Status (0x0f) plen 4
     Inquiry (0x01|0x0001) status 0x00 ncmd 1
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e2 class 0x200404 
rssi -51
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e3 class 0x200404 
rssi -48
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e2 class 0x200404 
rssi -48
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e2 class 0x200404 
rssi -49
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e3 class 0x200404 
rssi -46
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e2 class 0x200404 
rssi -48
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e2 class 0x200404 
rssi -45
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e3 class 0x200404 
rssi -45
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e2 class 0x200404 
rssi -45
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e2 class 0x200404 
rssi -45
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e3 class 0x200404 
rssi -45
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e3 class 0x200404 
rssi -45
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e2 class 0x200404 
rssi -45
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e3 class 0x200404 
rssi -44
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e2 class 0x200404 
rssi -45
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e2 class 0x200404 
rssi -45
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e3 class 0x200404 
rssi -44
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e2 class 0x200404 
rssi -46
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e3 class 0x200404 
rssi -45
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e3 class 0x200404 
rssi -45
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e2 class 0x200404 
rssi -47
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e3 class 0x200404 
rssi -45
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e2 class 0x200404 
rssi -46
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x62e2 class 0x200404 
rssi -46
 > HCI Event: Inquiry Complete (0x01) plen 1
     status 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
     bdaddr 00:0B:2E:39:31:3F mode 2 clkoffset 0x0000
 > HCI Event: Command Status (0x0f) plen 4
     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x0000
 > HCI Event: Command Status (0x0f) plen 4
     Remote Name Request (0x01|0x0019) status 0x17 ncmd 1
     Error: Repeated Attempts
 > HCI Event: Remote Name Req Complete (0x07) plen 255
     status 0x00 bdaddr 00:0B:2E:39:31:3F name 'Motorola HS805'
< HCI Command: Reset (0x03|0x0003) plen 0
device: disconnected

*****BT switched off and turned on******

root@smohan-laptop:/home/smohan# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.39
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
     lap 0x9e8b33 len 8 num 250
 > HCI Event: Command Status (0x0f) plen 4
     Inquiry (0x01|0x0001) status 0x00 ncmd 1
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x17c9 class 0x200404 
rssi -46
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x17c8 class 0x200404 
rssi -47
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x17c9 class 0x200404 
rssi -48
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x17c9 class 0x200404 
rssi -48
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x17c8 class 0x200404 
rssi -47
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x17c9 class 0x200404 
rssi -48
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x17c8 class 0x200404 
rssi -47
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x17c9 class 0x200404 
rssi -48
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x17c8 class 0x200404 
rssi -47
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x17c8 class 0x200404 
rssi -47
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15

     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x17c9 class 0x200404 
rssi -47
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
     bdaddr 00:0B:2E:39:31:3F mode 1 clkoffset 0x17c8 class 0x200404 
rssi -47
 > HCI Event: Inquiry Complete (0x01) plen 1
     status 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
     bdaddr 00:0B:2E:39:31:3F mode 2 clkoffset 0x0000
 > HCI Event: Command Status (0x0f) plen 4
     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
 > HCI Event: Remote Name Req Complete (0x07) plen 255
     status 0x00 bdaddr 00:0B:2E:39:31:3F name 'Motorola HS805'

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

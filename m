Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 15 Oct 2006 15:09:13 +0200
From: Romain Quidet <romain.quidet@neuf.fr>
To: bluez-users@lists.sourceforge.net
Message-id: <453232F9.1070003@neuf.fr>
MIME-version: 1.0
Subject: [Bluez-users] not seen
Reply-To: romain.quidet@neuf.fr,
        BlueZ users <bluez-users@lists.sourceforge.net>
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

hello,

I'm using a debian (testing) with 2.6.18 kernel, bluez 3.7
I've got a sagem phone, and a belkin BT dongle.

I don't know anything about bluetooth, and it does not work for me !!

 From my phone I can't see my pc, can you help me ?

here some info :

dmesg :

Oct 15 14:50:07 localhost kernel: Bluetooth: Core ver 2.10
Oct 15 14:50:07 localhost kernel: NET: Registered protocol family 31
Oct 15 14:50:07 localhost kernel: Bluetooth: HCI device and connection 
manager initialized
Oct 15 14:50:07 localhost kernel: Bluetooth: HCI socket layer initialized
Oct 15 14:50:17 localhost kernel: Bluetooth: L2CAP ver 2.8
Oct 15 14:50:17 localhost kernel: Bluetooth: L2CAP socket layer initialized
Oct 15 14:50:17 localhost kernel: Bluetooth: RFCOMM socket layer initialized
Oct 15 14:50:17 localhost kernel: Bluetooth: RFCOMM TTY layer initialized
Oct 15 14:50:17 localhost kernel: Bluetooth: RFCOMM ver 1.8

everything seems to be loaded...

I run hcidump :

CI sniffer - Bluetooth packet analyzer ver 1.31
device: hci0 snap_len: 1028 filter: 0xffffffff
 > HCI Event: Command Complete (0x0e) plen 4
    Write Local Name (0x03|0x0013) ncmd 1
    status 0x00
< HCI Command: Write Class of Device (0x03|0x0024) plen 3
    class 0x3e0100
 > HCI Event: Command Complete (0x0e) plen 4
    Write Class of Device (0x03|0x0024) ncmd 1
    status 0x00
< HCI Command: Read Local Name (0x03|0x0014) plen 0
 > HCI Event: Command Complete (0x0e) plen 252
    Read Local Name (0x03|0x0014) ncmd 1
    status 0x00 name 'BlueZ (0)'
< HCI Command: Read Class of Device (0x03|0x0023) plen 0
 > HCI Event: Command Complete (0x0e) plen 7
    Read Class of Device (0x03|0x0023) ncmd 1
    status 0x00 class 0x3e0100
< HCI Command: Read Class of Device (0x03|0x0023) plen 0
 > HCI Event: Command Complete (0x0e) plen 7
    Read Class of Device (0x03|0x0023) ncmd 1
    status 0x00 class 0x3e0100
< HCI Command: Read Class of Device (0x03|0x0023) plen 0
 > HCI Event: Command Complete (0x0e) plen 7
    Read Class of Device (0x03|0x0023) ncmd 1
    status 0x00 class 0x3e0100
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 6 num 0
 > HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e40 class 0x7a0204 rssi -54
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e40 class 0x7a0204 rssi -56
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e40 class 0x7a0204 rssi -56
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e40 class 0x7a0204 rssi -56
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e3f class 0x7a0204 rssi -55
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e3f class 0x7a0204 rssi -54
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e40 class 0x7a0204 rssi -60
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e40 class 0x7a0204 rssi -60
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e40 class 0x7a0204 rssi -61
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e40 class 0x7a0204 rssi -62
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e40 class 0x7a0204 rssi -52
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e3f class 0x7a0204 rssi -52
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e3f class 0x7a0204 rssi -52
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e3f class 0x7a0204 rssi -53
 > HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 6 num 0
 > HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e3f class 0x7a0204 rssi -67
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e3f class 0x7a0204 rssi -63
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e3e class 0x7a0204 rssi -60
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e3e class 0x7a0204 rssi -60
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e3e class 0x7a0204 rssi -60
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e3f class 0x7a0204 rssi -60
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e3f class 0x7a0204 rssi -59
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e3f class 0x7a0204 rssi -60
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e3f class 0x7a0204 rssi -59
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e3e class 0x7a0204 rssi -61
 > HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 6 num 0
 > HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e3b class 0x7a0204 rssi -59
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e3b class 0x7a0204 rssi -58
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e3b class 0x7a0204 rssi -59
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e3b class 0x7a0204 rssi -58
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e3b class 0x7a0204 rssi -58
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e3b class 0x7a0204 rssi -58
 > HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 6 num 0
 > HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e36 class 0x7a0204 rssi -76
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e36 class 0x7a0204 rssi -73
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e36 class 0x7a0204 rssi -73
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e36 class 0x7a0204 rssi -78
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e37 class 0x7a0204 rssi -68
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e36 class 0x7a0204 rssi -67
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e36 class 0x7a0204 rssi -67
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e37 class 0x7a0204 rssi -69
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e37 class 0x7a0204 rssi -68
 > HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00

I can get pair or see my device. The address 08:00:28:F9:9A:96 seems to 
be correct...

Thank for your help !

Romain

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

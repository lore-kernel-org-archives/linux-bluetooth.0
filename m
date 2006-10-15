Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 15 Oct 2006 15:17:18 +0200
From: Romain Quidet <looping78@neuf.fr>
To: bluez-users@lists.sourceforge.net
Message-id: <453234DE.2060209@neuf.fr>
MIME-version: 1.0
Subject: [Bluez-users] error connecting
Reply-To: looping78@neuf.fr, BlueZ users <bluez-users@lists.sourceforge.net>
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

I'm a french user of a debian and a sagem phone.
I use a belkin BT dongle.

I load everything : see dmesg
Oct 15 14:50:07 localhost kernel: Bluetooth: HCI device and connection 
manager initialized
Oct 15 14:50:07 localhost kernel: Bluetooth: HCI socket layer initialized
Oct 15 14:50:17 localhost kernel: Bluetooth: L2CAP ver 2.8
Oct 15 14:50:17 localhost kernel: Bluetooth: L2CAP socket layer initialized
Oct 15 14:50:17 localhost kernel: Bluetooth: RFCOMM socket layer initialized
Oct 15 14:50:17 localhost kernel: Bluetooth: RFCOMM TTY layer initialized
Oct 15 14:50:17 localhost kernel: Bluetooth: RFCOMM ver 1.8

I've got error while searching for device (can't see my pc via my phone 
and vice versa)

run hcidump :

< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 0
 > HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e33 class 0x7a0204 rssi -69
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e33 class 0x7a0204 rssi -70
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e33 class 0x7a0204 rssi -71
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e32 class 0x7a0204 rssi -70
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e32 class 0x7a0204 rssi -70
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e32 class 0x7a0204 rssi -69
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e32 class 0x7a0204 rssi -68
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e32 class 0x7a0204 rssi -65
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e32 class 0x7a0204 rssi -68
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e33 class 0x7a0204 rssi -66
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e32 class 0x7a0204 rssi -71
 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 08:00:28:F9:9A:96 mode 1 clkoffset 0x6e32 class 0x7a0204 rssi -69
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 6 num 0
 > HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x12 ncmd 1
    Error: Invalid HCI Command Parameters
 > HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00

any suggestion ?!

thank you !!

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

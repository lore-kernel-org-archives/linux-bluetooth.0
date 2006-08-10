Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: menace82 <menace82@gmail.com>
To: bluez-users@lists.sourceforge.net
Date: Thu, 10 Aug 2006 18:05:15 +0300
MIME-Version: 1.0
Message-Id: <200608101805.15810.menace82@gmail.com>
Subject: [Bluez-users] Bluez + Planet BT-320 + SE P910i + SuSE Linux 10.1
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
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

Hello... I just bought a bluetooth dongle... My system recognise it as 
bluetooth but i cannot find any devices. I've tried "hcitool scan" but i got 
a "Inquiry failed: Connection timed out" message... My mobile phone can 
detect my pc, but while i try to pair it i get an error message....

hcidump -X -V
linux:/home/user # hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.29
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 6 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 6 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 6 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 6 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

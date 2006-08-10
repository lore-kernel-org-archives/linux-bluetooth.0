Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c49421c50608101218v4838ca3at9e84e463041459a1@mail.gmail.com>
Date: Thu, 10 Aug 2006 16:18:46 -0300
From: "Loreno Oliveira" <lorenooliveira@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] Inquiry failed: Connection timed out
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1212808032=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1212808032==
Content-Type: multipart/alternative;
	boundary="----=_Part_85703_19023542.1155237526994"

------=_Part_85703_19023542.1155237526994
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi there!

I'm on troubles with a BT USB dongle I've just bougth. When I try "hcitool
scan" the inquiry is not completed and a message "Inquiry failed: Connection
timed out" is displayed instead.

Does my dongle is not supported by bluez?? Bellow are the output of some
commands.

loreno@teckiller:~$ hciconfig
hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:1 errors:1

loreno@teckiller:~$ hcitool scan
Scanning ...
Inquiry failed: Connection timed out

loreno@teckiller:~$ lsusb
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 004: ID 1131:1001 Integrated System Solution Corp.
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 003: ID 09da:0006 A4 Tech Co., Ltd
Bus 001 Device 001: ID 0000:0000

loreno@teckiller:~$ hciconfig version
hci0:   Type: USB
        BD Address: 00:11:67:4F:EC:8F ACL MTU: 678:8  SCO MTU: 48:10
        UP RUNNING PSCAN ISCAN
        RX bytes:83 acl:0 sco:0 events:10 errors:0
        TX bytes:52 acl:0 sco:0 commands:13 errors:0

loreno@teckiller:~$ dpkg --list | grep bluez
ii  bluez-bcm203x  2.10-5ubuntu3  Firmware loader for Broadcom 203x based
Blue
ii  bluez-cups     2.10-5ubuntu3  Bluetooth printer driver for CUPS
ii  bluez-hcidump  1.12-1ubuntu0. Analyses Bluetooth HCI packets
ii  bluez-pcmcia-s 2.10-5ubuntu3  PCMCIA support files for BlueZ 2.0Bluetooth
ii  bluez-pin      0.24-1         Bluetooth PIN helper with D-BUS support
ii  bluez-utils    2.10-5ubuntu3  Bluetooth tools and daemons

loreno@teckiller:~$ hciconfig -a
hci0:   Type: USB
        BD Address: 00:11:67:4F:EC:8F ACL MTU: 678:8  SCO MTU: 48:10
        UP RUNNING PSCAN ISCAN
        RX bytes:83 acl:0 sco:0 events:10 errors:0
        TX bytes:52 acl:0 sco:0 commands:13 errors:0
        Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: ACCEPT MASTER
        Name: 'teckiller-0'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.2 (0x2) LMP Subver:
0x1fe
        Manufacturer: Integrated System Solution Corp. (57)

------=_Part_85703_19023542.1155237526994
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi there!<br><br>I'm on troubles with a BT USB dongle I've just bougth. When I try &quot;hcitool scan&quot; the inquiry is not completed and a message &quot;Inquiry failed: Connection timed out&quot; is displayed instead.<br>
<br>Does my dongle is not supported by bluez?? Bellow are the output of some commands.<br><br>loreno@teckiller:~$ hciconfig<br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:00:00:00:00:00 ACL MTU: 0:0&nbsp; SCO MTU: 0:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DOWN
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:0 acl:0 sco:0 events:0 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:0 acl:0 sco:0 commands:1 errors:1<br><br>loreno@teckiller:~$ hcitool scan<br>Scanning ...<br>Inquiry failed: Connection timed out<br><br>loreno@teckiller
:~$ lsusb<br>Bus 003 Device 001: ID 0000:0000<br>Bus 002 Device 004: ID 1131:1001 Integrated System Solution Corp.<br>Bus 002 Device 001: ID 0000:0000<br>Bus 001 Device 003: ID 09da:0006 A4 Tech Co., Ltd<br>Bus 001 Device 001: ID 0000:0000
<br><br>loreno@teckiller:~$ hciconfig version<br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:11:67:4F:EC:8F ACL MTU: 678:8&nbsp; SCO MTU: 48:10<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:83 acl:0 sco:0 events:10 errors:0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:52 acl:0 sco:0 commands:13 errors:0<br><br>loreno@teckiller:~$ dpkg --list | grep bluez<br>ii&nbsp; bluez-bcm203x&nbsp; 2.10-5ubuntu3&nbsp; Firmware loader for Broadcom 203x based Blue<br>ii&nbsp; bluez-cups&nbsp;&nbsp;&nbsp;&nbsp; 2.10-5ubuntu3
&nbsp; Bluetooth printer driver for CUPS<br>ii&nbsp; bluez-hcidump&nbsp; 1.12-1ubuntu0. Analyses Bluetooth HCI packets<br>ii&nbsp; bluez-pcmcia-s 2.10-5ubuntu3&nbsp; PCMCIA support files for BlueZ 2.0 Bluetooth<br>ii&nbsp; bluez-pin&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.24-1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bluetooth PIN helper with D-BUS support
<br>ii&nbsp; bluez-utils&nbsp;&nbsp;&nbsp; 2.10-5ubuntu3&nbsp; Bluetooth tools and daemons<br><br>loreno@teckiller:~$ hciconfig -a<br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:11:67:4F:EC:8F ACL MTU: 678:8&nbsp; SCO MTU: 48:10<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:83 acl:0 sco:0 events:10 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:52 acl:0 sco:0 commands:13 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: ACCEPT MASTER<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'teckiller-0'<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x000000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Unspecified<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Miscellaneous,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.2 (0x2) LMP Subver: 0x1fe<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Integrated System Solution Corp. (57)<br>

------=_Part_85703_19023542.1155237526994--


--===============1212808032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1212808032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1212808032==--

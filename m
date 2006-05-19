Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41458.156.116.2.246.1148041722.squirrel@webmail.uio.no>
From: markusv@student.matnat.uio.no
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: [Bluez-users] Internal bluetooth on d610
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
Date: Fri, 19 May 2006 14:28:42 +0200 (CEST)


hi all
I have a dell latitude d610 with internal bluetooth. I have recently
installed ubuntu linux. I am using the bluez version distributed wiht
ubuntu. But I have some problems with my internal bluetooth device. The
hcitool dev gives me the output:
 hciconfig
hci0:   Type: USB
        BD Address: 00:16:41:0B:19:64 ACL MTU: 384:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:226 acl:0 sco:0 events:20 errors:0
        TX bytes:413 acl:0 sco:0 commands:19 errors:0

so the bluetooth device is recognized by the system. But when i try
hcitool inq no devices are found, using a Belkin usb bluetooth adapter mye
cellular phone is recognized. Why does my internal bluetooth device not
recognize my phone? What is wrong here?

regards
Markus







-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

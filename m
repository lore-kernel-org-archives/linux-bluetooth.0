Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44F2A960.7040002@tootai.net>
Date: Mon, 28 Aug 2006 10:29:20 +0200
From: Administrator TOOTAI <admin@tootai.net>
MIME-Version: 1.0
To: Bluetooth <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Bluetooth with Windows CE5 problem
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

Mornibg,

I use bluetooth stack on my Debian SID since ages, specially for headset 
(BT100 and B-Speach) and it work well. Now I bought a smartphone -O2 XDA 
Atom- which is running Windows CE5.

The problem I face is that I can't use the device as a Headset. I can 
beam files from device to notebook. On the device, I only have the 
serial port service from my USB dongle (Linksys Class1 BT100)

Here is the output of sdptool browse --l2cap 00:02:C7:EF:8C:CB

Service Name: Voice Gateway
Service RecHandle: 0x10002
Service Class ID List:
   "Headset Audio Gateway" (0x1112)
   "Generic Audio" (0x1203)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 1
Profile Descriptor List:
   "Headset" (0x1108)
     Version: 0x0100

Service Name: Voice Gateway
Service RecHandle: 0x10003
Service Class ID List:
   "Handfree Audio Gateway" (0x111f)
   "Generic Audio" (0x1203)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 2
Profile Descriptor List:
   "Handsfree" (0x111e)
     Version: 0x0101

What is strange is that browsing the device without --l2cap shows nothing:

nomade:/etc/bluetooth# sdptool browse 00:02:C7:EF:8C:CB
Browsing 00:02:C7:EF:8C:CB ...
nomade:/etc/bluetooth#

If someone has a way to get it work, would be great to share.

Thanks

-- 
Daniel

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44E6C978.7040504@newkirk.us>
Date: Sat, 19 Aug 2006 04:19:04 -0400
From: Joel Newkirk <bluez@newkirk.us>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Error:  This is uuid32
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

I just got a Samsung T509 handset.  Paired a BT headset with it fine. 
But my primary use for it is a data connection from a Zaurus, running
pdaXrom.  sdptool is version 1.5, BT is a compactflash Billionton card,
all works fine talking to a Nokia 6600.

"sdptool search OPUSH" works fine, gives me OBEX Object Push with L2DAP
and RFComm, channel 5.

"sdptool search DUN" gives me:
Inquiring ...
Searching for DUN on 00:16:DB:D8:xx:xx ...
Service Name: Dial-up networking
Service RecHandle: 0x10002
Service Class ID List:
    "Error: This is uuid32" (0x00001103)
Protocol Descriptor List:
    "Error: " (0x00000100)
    "Error: " (0x00000003)
    uint8: 0x1
Profile Descriptor List:
    "Dialup Networking" (0x1103)
    Version: 0x0100


Is this a lame bluetooth implementation by samsung, a defective phone,
or a problem relating to bluez?  I can't tell if the errors are coming
from the phone, or from bluez, and I'm down to a few days remaining to
return the phone if its bluetooth is buggy.

Thanks for any help.

j


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40D6E1B6.90700@identisys.de>
From: Thomas Eller <te@identisys.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] Rfcomm connection with multiple usb dongles
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 21 Jun 2004 15:25:10 +0200

Hello !

I have two USB dongles connected to my system:

hciconfig <ENTER>

hci0:   Type: USB
         BD Address: 00:02:72:B1:6E:28 ACL MTU: 192:8  SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:6901 acl:92 sco:0 events:655 errors:0
         TX bytes:6146 acl:147 sco:0 commands:302 errors:0

hci1:   Type: USB
         BD Address: 00:02:72:B1:6E:29 ACL MTU: 192:8  SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:147 acl:0 sco:0 events:21 errors:0
         TX bytes:328 acl:0 sco:0 commands:20 errors:0

--------------

I try the rfcomm-command: rfcomm connect 0 xx:xx:xx:xx:xx:xx 1

This connection is made over hci0 on channel 1, activating the device 
rfcomm0.

How can i tell rfcomm to make a connection over hci1 ??


Thanks,

Thomas


-- 
---------------------------

Thomas Eller

Identisys GmbH
Moselstr.8

35260 Stadtallendorf

Phone: +49 (0)6428-442180
FAX: +49 (0)6428-442348


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

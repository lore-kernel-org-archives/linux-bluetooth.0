Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Forever Again" <erics_trip@hotmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law12-F76bdkSmLAztx0004f857@hotmail.com>
Subject: [Bluez-users] HCI not working after using usb_storage
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
Date: Fri, 13 Feb 2004 23:29:04 +0000

I have a logitech mx900 mouse, which was working fine before. I'm running 
the 2.6.2 kernel on Fedora. Using the bthid daemon it was working. Then I 
tried to use a usb memory stick, and after using the usb_storage driver, my 
mouse stopped working. I check to see what was up and I noticed that my hci 
device was gone. When I try running hciconfig hci0 up, I get this:

Can't open HCI socket.: Address family not supported by protocol.

What do I need to do to get the mouse working again, and is it possible to 
use the usb_storage as well. I'm more concerned about using the mouse, but 
both would be nice.

Evan

_________________________________________________________________
Choose now from 4 levels of MSN Hotmail Extra Storage - no more account 
overload! http://click.atdmt.com/AVE/go/onm00200362ave/direct/01/



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

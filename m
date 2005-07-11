Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <BAY7-F48C458C0DEB2EC0E6E098D4DC0@phx.gbl>
From: "Fahad Khowaja" <fahadkhowaja@hotmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Subject: [Bluez-users] unable to open /dev/rfcomm0: No such device.
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
Date: Mon, 11 Jul 2005 13:06:01 +0000

Hi! The issue is resolved. For anyone who may be interested in the details, 
it's as follows:

The problem was that the kernel did not recognize character device major 
version 216. It had no drivers for this type of device. I had to configure 
RFCOMM protocol support and RFCOMM TTY support under Bluetooth support in 
the kernel and recompile it. This step added a driver to the kernel and a 
cat of /proc/devices listed "216 rfcomm" as a recognized device.

Not being able to recognize this type of device was also causing ioctl() 
function calls which referred to it to fail. After the drivers were loaded, 
the ioctl() calls worked properly (which were previously giving errors).

Fahad.

_________________________________________________________________
Take advantage of powerful junk e-mail filters built on patented Microsoft® 
SmartScreen Technology. 
http://join.msn.com/?pgmarket=en-ca&page=byoa/prem&xAPID=1994&DI=1034&SU=http://hotmail.com/enca&HL=Market_MSNIS_Taglines 
  Start enjoying all the benefits of MSN® Premium right now and get the 
first two months FREE*.



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

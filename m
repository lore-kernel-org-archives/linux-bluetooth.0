Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <BAY7-F138540399B59B859EA98DDD4DC0@phx.gbl>
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
Date: Mon, 11 Jul 2005 10:37:12 +0000

Hello list members!

I am using Bluez on an Axis Developer Board 82+ running kernel 2.4. I have 
everything running fine except when I try to issue "rfcomm bind" or cat 
/dev/rfcomm0 or echo "foo" > /dev/rfcomm0 I get a "No such device" error. A 
cat of my /proc/devices produces:

Character devices:
  1 mem
  2 pty
  3 ttyp
  4 ttyS
  5 cua
10 misc
90 mtd
108 ppp
120 etrax gpio
121 ds1302
128 ptm
136 pts
162 raw
180 usb

Block devices:
  1 ramdisk
31 mtdblock

It seems that the character device with major version 216 is not recognized 
by the kernel. Which driver is used for these devices? Which options should 
I enable in the kernel for it to be included in the kernel (I don't have 
module support on the axis board)? It will be an immense help if someone can 
give me some pointers!

Gratefully yours,
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

Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Douglas Russell <puggy@gentoo.org>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200408191339.21138.puggy@gentoo.org>
Subject: [Bluez-users] OSX reprogrammed my mouse!
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
Date: Thu, 19 Aug 2004 13:39:20 +0100

MX900 Mouse.
Built in powerbook bluetooth.

Well, I think this is what has happened. I used my mouse in OSX for a couple 
of days and when I returned to linux my mouse appears as /dev/input/event4 as 
opposed to a mouse device. Also, kdebluetooth now seems able to determine 
that it is a MX900 wheras before it just listed the hardware address.

I've tried unpairing the device in OSX and taking out the batteries and 
reconnecting it a million times in linux. I even tried pairing it with the 
MX900 base station (in non-bluetooth mode) then reconnecting to the 
powerbooks build in bluetooth.

Any ideas?

Cheers.

Puggy


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

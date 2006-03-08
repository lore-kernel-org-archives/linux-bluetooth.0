Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Radek <fotopiper@o2.pl>
To: bluez-devel@lists.sourceforge.net
Message-Id: <20060308221925.17d20407.fotopiper@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-devel] PIN helper
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 8 Mar 2006 22:19:25 +0100

Hello,
from whot I had read in the net there had been some controversies about
the pinhelpers. The d-bus one need d-bus, and the python one need some
extra libs as well as X..
Maybe it was thougt before.. but I would suggest using a different
method. A list of devices with coresponding pins. This gives the
possibilities to have a different pin for different devices (important
especially if you have some that have a fixed pin:0000, not a very
secure idea for a default pin) and possibly a default pin as an option.
A very simple script that does that:

#!/bin/sh
echo "PIN:"$(grep $2 /etc/bluetooth/pins|sed s/.*PIN\://)

Not a very clean solusion (sorry I'm no programer, and my knowledge of
bash/sh is limited) but portable (bysybox suports all that is needed).
The obviously in format:

anything countaining the HWaddress of the device PIN: and the pin

this gives the possibility to have something like this:

00:0E:05:05:04:02; My cat; PIN:0000
00:0E:05:05:04:01; The dog; PIN:1111432334

It would be better if the script checked the files permisions, gave an
option to use a default pin and maybe some logging... But for that my
current sh knowledge is not enough.. sorry :-(

Still I think this is a beeter solusion, a more universal one, then the
ones shiped with bluez now.. which doesn't meen that the current
helpers are not helpful :)

My regards.

-- 
Radoslaw Rurarz
Warsaw Poland


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

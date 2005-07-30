Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: bc90021 <bc90021@bc90021.net>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <loom.20050728T195337-380@post.gmane.org>
References: <428EDFCA.5070702@gmail.com>
	 <1116842776.30044.33.camel@pegasus>	 <4292938B.2090000@gmail.com>
	 <1116924491.30044.131.camel@pegasus>	 <429553F1.7020604@gmail.com>
	 <1117095364.12036.14.camel@pegasus>	 <429682D6.2020800@gmail.com>
	 <1117177537.12036.90.camel@pegasus>	 <42980599.9040801@gmail.com>
	 <1117287707.12036.138.camel@pegasus> <429E8F28.3010008@gmail.com>
	 <loom.20050728T195337-380@post.gmane.org>
Content-Type: text/plain
Message-Id: <1122682209.11983.113.camel@viskulan.tigerhost.net>
Mime-Version: 1.0
Subject: [Bluez-users] Treo 650 Oddities
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
Date: Fri, 29 Jul 2005 20:10:08 -0400

Hi All,

I have three devices:


Dell Desktop, with USB Dongle
Dell Laptop, with USB Dongle
Treo 650 (Verizon)


>>From the desktop, I can see the phone and the laptop.
>>From the laptop, I can see the desktop and the phone.
>>From the phone, I can see the desktop, but not the laptop.

No matter what I do, the phone will not discover the laptop.  It sees
the desktop with no problem.

I've tried switching the dongles, to no effect.  I've tried updating my
BlueZ software, to no effect.  I've tried updating the kernel, to no
effect.

I can't use hcidump to find out what's going on, because it doesn't
register the connection attempt from the phone.  (I tried that with the
desktop, too, with the same effect.)  However, the desktop can
successfully connect to the phone nonetheless, as the laptop should.
(I've backed up the Treo with pilot-xfer, so I know it works.)

The dongle (either one), when in the laptop, will turn to a more solid
blue (as opposed to intermittently flashing), making it look like it is
getting a signal.  I'm never more than three feet from the laptop with
the phone, so range is not an issue.

The kernel versions are the same on the desktop and the laptop.  The
BlueZ software versions are identical (I'm using Gentoo on both).  The
configuration files are the same (literally, I scp'ed them) on the
laptop as they are on the desktop.

Can anyone suggest what to try next?  I'm at a loss here... I want to be
able to use the Treo as a modem for the laptop while I'm on vacation,
but since I can't pair them, I can't do that right now.

Thanks in advance for any and all help.



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

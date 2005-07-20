Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: <fyp@dreamx.org>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <E1Dv9Kx-0007c4-NM@server.broadrick.moe.edu.sg>
Subject: [Bluez-users] Bluetooth as ttyS0
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
Date: Wed, 20 Jul 2005 15:49:51 +0800

Hi!

I've having reading many sites and found that to bind a port for 
bluetooth i need rfcomm. I've also tried the steps in doing it but it 
doesn't seem like what I really wanted.

My objective is to make a USB Bluetooth dongle work as a Serial port
(i.e ttyS0). I've a USB Bluetooth dongle and a RS232 Bluetooth device.
This is to emulate a serial cable replacement. 
A simple diagram of what I really want to achieve is osmething like 
this:

|LinuxPC| USB<-->Bluetooth ~~~~~~ Bluetooth<-->RS232 |LinuxPC|

The problem I'm having now is to make the bluetooth into an emulated 
rs232 port. I hope someone can help me with this. 
-- 



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

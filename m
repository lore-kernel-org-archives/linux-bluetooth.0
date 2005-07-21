Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michael Mauch <michael.mauch@gmx.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20050721180417.GB18197@elmicha.333200002251-0001.dialin.t-online.de>
References: <E1DvTw1-00021X-U4@server.broadrick.moe.edu.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1DvTw1-00021X-U4@server.broadrick.moe.edu.sg>
Subject: [Bluez-users] Re: Bluetooth as ttyS0
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
Date: Thu, 21 Jul 2005 20:04:17 +0200

fyp@dreamx.org wrote:

> Yes I'm using a rs232 dongle. I've got it setup using AT commands to
> make it auto accept connections. So now the problem I'm facing is
> setting up the USB dongle on the linux pc. I'm not really sure how to go
> about doing it. Why use rfcomm instead of hciattach to attach the
> bluetooth to ttys0 ?

I don't know when you would use hciattach, but with rfcomm you can
create a connection to a serial device (e.g. /dev/rfcomm0, not /dev/ttyS0).

E.g.

  rfcomm bind 0 11:22:33:44:55:66 7

This will create a /dev/rfcomm0 which you can use just like your real
serial port /dev/ttyS0 (e.g. with minicom). See "man rfcomm" for details.

Use "sdptool browse 11:22:33:44:55:66" (of course with the BT address of
your device) to find the channel number of the Serial Port service of
your device (that's the "7" in the rfcomm bind example above).

Also have a look at /etc/bluetooth/rfcomm.conf.

Regards...
		Michael


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

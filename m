Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] USB/Bluetooth dongle doesn't work in hub
References: <qszekj3j47n.fsf@timepilot.gpcc.itd.umich.edu>
	<1099959115.29330.40.camel@pegasus>
	<qszzn1rhnmh.fsf@timepilot.gpcc.itd.umich.edu>
	<qszr7n3lgkp.fsf@timepilot.gpcc.itd.umich.edu>
	<1099985025.29330.52.camel@pegasus>
From: Scott W Gifford <gifford@umich.edu>
In-Reply-To: <1099985025.29330.52.camel@pegasus> (Marcel Holtmann's message
 of "Tue, 09 Nov 2004 08:23:45 +0100")
Message-ID: <qszvfblv8rv.fsf@mspacman.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Wed, 01 Dec 2004 19:33:24 -0500

Marcel Holtmann <marcel@holtmann.org> writes:

[...]

>> As before, they work fine when plugged directly into the laptop.
>
> go ahead and report this problem to the USB mailing list, because it is
> not a Bluetooth problem and I don't know why this fails.

I didn't get an answer on the USB mailing list, but I saw another
related answer that seemed to help.  Apparently using certain types of
transfers on a high-speed hub with a low-speed device is still
unsupported:

  http://www.linux-usb.org/usb2.html

    In terms of functionality, the latest driver:

    [...]

    * Has partial support for split transactions (full and low speed
      transfers) through USB 2.0 hubs:

    [...]

      o You can't (yet) use full speed isochronous transfers through
        USB 2.0 hubs. (At least without an experimental patch.)  That
        means: don't hook up USB 1.1 webcams, speakers, etc. to high
        speed buses, they'll enumerate but you won't be able to use
        them otherwise. Eventually of course a dozen USB 1.1 webcams
        will easily coexist at full data rate on a single USB 2.0 bus,
        using USB 2.0 hubs.

The "ehci-hcd" module provides support for high-speed USB 2.0.
Removing it with rmmod makes everything run as low-speed USB 1.x, and
that seems to solve the problem.

I tested with the dongles I have: D-link DBT-120, Belkin F8T001,
AmbiCom BT2000, and IOGear GBU211.  I tested plugged directly in,
plugged into a hub connected directly, and plugged into a hub
connected to a hub connected to a hub connected directly.

-----ScottG.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

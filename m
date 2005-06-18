Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Kernel panic on stopping pand
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <42B447F2.9080801@eridani.co.uk>
References: <42B447F2.9080801@eridani.co.uk>
Content-Type: text/plain
Message-Id: <1119137187.9217.5.camel@pegasus>
Mime-Version: 1.0
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
Date: Sun, 19 Jun 2005 01:26:27 +0200

Hi Michael,

> Trying kernel 2.6.11.12, I got this (attached) kernel panic message 
> after trying to stop pand after the first set of messages logged appeared.
> 
> Before that are the messages, when the entire USB layer seems to stall.  
> It's possibly worth noting this only happens going through a hub - when 
> connected directly to the machine the problem doesn't occur.
> 
> There was a second panic, where the machine froze up, and the message 
> was way too long to fit on the screen... this wasn't logged in syslog.
> 
> It's possible the fault could be the USB hub driver, but it doesn't play 
> up like this when I run my USB hard disc through it. I haven't tried my 
> DVD burner through the hub - they make expensive beermats :-/

please re-test it with the 2.6.12 kernel. The hci_usb driver is not
perfect, but we had problems with dongles attached to an USB hub before
and so this might be also a problem inside the USB subsystem.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

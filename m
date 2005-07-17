Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] can't open hcid socket
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050714155156.16265.qmail@web33507.mail.mud.yahoo.com>
References: <20050714155156.16265.qmail@web33507.mail.mud.yahoo.com>
Content-Type: text/plain
Message-Id: <1121607080.22662.6.camel@pegasus>
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
Date: Sun, 17 Jul 2005 15:31:20 +0200

Hi Vinod,

> I am trying to send create a bluetooth connection
> between my ipaq 3870 running familiar v0.8.2,GPE,
> (2.4.19 .. hh37) and a desktop with usb dongle.
> 
> I was following a link
> http://opie.handhelds.org/cgi-bin/moin.cgi/BluetoothGprs
> 
> But i ran into trouble,
> 
> #/etc/init.d/bluetooth start
> 
> i got
> 
> Starting Bluetooth subsystem: hcid sdpdCan't open HIDP
> control socket: Invalid argument
>  hidd rfcomm.

this means that the hidp kernel module is missing.

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

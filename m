Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Beginner with PAND
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <d49842$5o6$1@sea.gmane.org>
References: <d49842$5o6$1@sea.gmane.org>
Content-Type: text/plain
Message-Id: <1114165056.32265.56.camel@pegasus>
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
Date: Fri, 22 Apr 2005 12:17:36 +0200

Hi William,

> I am trying to set up one of my computers to work as an Internet router
> for other bluetooth devices.  I'm trying to use pand, and I notice that
> it has this -e flag.  I use it to designate the ethernet device name
> that I want to give to my bluetooth stack/dongle (someone correct me if
> I am not understanding this correctly).  Well, ifconfig doesn't reveal
> another device when pand is running.  I can't network to a device that
> doesn't exist.  So what do I do?

the bnep0 device is only created when you actually created the BNEP
connection. To set the IP before the connection you must use a Bridge on
top the bnepX interfaces. Check the PAN howto for details.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

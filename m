Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Beginner with PAND
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <d4c6it$hjp$1@sea.gmane.org>
References: <d49842$5o6$1@sea.gmane.org>
	 <1114165056.32265.56.camel@pegasus>  <d4c6it$hjp$1@sea.gmane.org>
Content-Type: text/plain
Message-Id: <1114252765.10706.16.camel@pegasus>
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
Date: Sat, 23 Apr 2005 12:39:25 +0200

Hi William,

> >>I am trying to set up one of my computers to work as an Internet router
> >>for other bluetooth devices.  I'm trying to use pand, and I notice that
> >>it has this -e flag.  I use it to designate the ethernet device name
> >>that I want to give to my bluetooth stack/dongle (someone correct me if
> >>I am not understanding this correctly).  Well, ifconfig doesn't reveal
> >>another device when pand is running.  I can't network to a device that
> >>doesn't exist.  So what do I do?
> > 
> > the bnep0 device is only created when you actually created the BNEP
> > connection. To set the IP before the connection you must use a Bridge on
> > top the bnepX interfaces. Check the PAN howto for details.
> 
> Why do I need a bridge?  I don't have to create a bridge in MS Windows 
> XP to set this up.  I don't really want a bridge either.  Are you sure 
> that there isn't another way?

this is not Windows, period.

However you can do it without a bridge, but then you have to deal with
the IP assignment over the hotplug or your distribution specific
methods. The bnep0 is only available when the connection is established
and it will go away when the connection terminates.

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

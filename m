Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] killing a persisted pand session
From: Marcel Holtmann <marcel@holtmann.org>
To: wim delvaux <wim.delvaux@adaptiveplanet.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403070310.27377.wim.delvaux@adaptiveplanet.com>
References: <200403070058.50508.wim.delvaux@adaptiveplanet.com>
	 <200403070245.59604.wim.delvaux@adaptiveplanet.com>
	 <1078624633.2807.20.camel@pegasus>
	 <200403070310.27377.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1078627054.2807.27.camel@pegasus>
Mime-Version: 1.0
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
Date: Sun, 07 Mar 2004 03:37:34 +0100

Hi Wim,

> > when do you start your "pand --listen"? Don't start it from
> > bluetooth.agent script.
> 
> 	Ah that might be the problem. Indeed it is started from there.
> 
> 	Why ? As said I have a dongle that gets inserted and removed frequently.
> 	Therefore I wanted the hcid/sdpd/pand thing to start when the dongle
> 	is inserted. so I added the start / stop of these apps to the bluetooth.agent	
> 	script.  

all these daemons can run all the time, even when no dongle is inserted.
Start them from /etc/init.d/... and not from bluetooth.agent, because
the hotplug stuff is not for starting daemons. It is for device
configuration.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

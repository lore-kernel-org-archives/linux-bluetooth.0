Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] link_key_request problems
From: Marcel Holtmann <marcel@holtmann.org>
To: wim delvaux <wim.delvaux@adaptiveplanet.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402250154.18963.wim.delvaux@adaptiveplanet.com>
References: <200402250154.18963.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1077672429.2919.67.camel@pegasus>
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
Date: Wed, 25 Feb 2004 02:27:10 +0100

Hi Wim,

> I am setting up a pan connection between my Ipaq/Linux and my Linux/2.6 
> server.
> 
> When I try to connect I see in the logfile that hcid tries to authenticate by 
> using a stored link key.  This does not seem to work since the connection is 
> not established.
> 
> When I remove the link_key file and use the pin it works.
> 
> What might be the problem here ? 

what are your hcid.conf settings? Set the pairing mode to "multi".

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

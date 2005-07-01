Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] SDPD problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050630150432.88B0C1DD1C5@mrelay2.st2.lyceu.net>
References: <20050630150432.88B0C1DD1C5@mrelay2.st2.lyceu.net>
Content-Type: text/plain
Message-Id: <1120213468.15397.191.camel@pegasus>
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
Date: Fri, 01 Jul 2005 12:24:28 +0200

Hi Esther,

> I'm trying to get Bluez work. I'm making some progress, but I haven't been
> able to add services to the Linux box, and discover them through another
> devices.
> 
> When I type sdpd, to start the sdp daemon, the following error arise:
> 
> init_server: binding L2CAP socket: Address already in use
> main: Server initialization failed

this means that a SDP server is already running.

> (If I type sdptool add XX, nothing really happens)
> 
> How can I manage to get it into work?

Add them and then check with "sdptool browse local".

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

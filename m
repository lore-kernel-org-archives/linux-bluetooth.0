Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Major slowdown when service discovery+opening a
	service happens on two systems trying to talk to each other
From: Marcel Holtmann <marcel@holtmann.org>
To: Marc-Andre Laverdiere-Papineau <m_laverd@alcor.concordia.ca>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.OSF.4.44.0402161503210.336210-100000@alcor.concordia.ca>
References: <Pine.OSF.4.44.0402161503210.336210-100000@alcor.concordia.ca>
Content-Type: text/plain
Message-Id: <1077022337.2841.15.camel@pegasus>
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
Date: Tue, 17 Feb 2004 13:52:17 +0100

Hi Marc-Andre,

> I'm not following all the terminology, since
> I'm working with Java. I was wondering what you would suggest that would
> be better for performance.

even if you work with Java you should follow the Bluetooth terminology,
because otherwise it can be possible that we speak of different things.

> Hciconfig shows a few options for page scan (device discovery?) and
> inquiry scan (service discovery?). Should I consider tweaking those?

No, you should read the Bluetooth specification and understand what
these two means, because you got them wrong.

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

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Major slowdown when service discovery+opening a
	service happens on two systems trying to talk to each other
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Marc-Andr=E9_Laverdi=E8re?= <m_laverd@alcor.concordia.ca>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1076900027.403030bbba48f@alcor.concordia.ca>
References: <Pine.OSF.4.44.0402141959300.358746-100000@alcor.concordia.ca>
	 <1076855495.14758.49.camel@pegasus>
	 <1076900027.403030bbba48f@alcor.concordia.ca>
Content-Type: text/plain
Message-Id: <1076921935.2840.43.camel@pegasus>
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
Date: Mon, 16 Feb 2004 09:58:55 +0100

Hi Marc-Andre,

> Each system is perpetually running the following:
> 1- Device discovery (on a constant basis)
> 2- Service discovery on detected devices (for one particular service)
> (I made a quick hack not to scan already scanned devices. So this is not
> 'perpetually running' per se)
> 3- A L2CAP service
> 
> and they might try to open a connection to send data to the other one, etc.
> I'm using default BlueZ settings, so I do not know if there are options for
> each
> of those that might change anything.

so it is possible that you run an inquiry while you page another device.
Actually I don't know if this is supported by any Bluetooth chips on the
market. And you run an inquiry while you have an ACL link opened. This
works with most devices that supports scatternet, but is not one of the
best ideas and can decrease your performance. What does "hciconfig -a"
say about your devices?

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

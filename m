Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Major slowdown when service discovery+opening a
	service happens on two systems trying to talk to each other
From: Marcel Holtmann <marcel@holtmann.org>
To: Marc-Andre Laverdiere-Papineau <m_laverd@alcor.concordia.ca>
Cc: jawbt@yahoogroups.com,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.OSF.4.44.0402141959300.358746-100000@alcor.concordia.ca>
References: <Pine.OSF.4.44.0402141959300.358746-100000@alcor.concordia.ca>
Content-Type: text/plain
Message-Id: <1076855495.14758.49.camel@pegasus>
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
Date: Sun, 15 Feb 2004 15:31:35 +0100

Hi Marc-Andre,

> I'm working on an application where every Bluetooth device is trying to
> scan for every other one around, and check if it runs my custom service.
> At the same time, said service is running in another thread, waiting to be
> connected to.
> 
> I am using Rococo with Bluez. Kernel RH2.4.28, latest version of BlueZ.
> Belkin FT003 dongles.
> 
> When I have one computer having the service opened+performing the scan,
> while the other just performs the scan, things go fine. The scans are
> timely and I can send a message.
> 
> However, then I have both computers running the service+the service scan,
> things slow down to a crawl. Actually, it depends on its mood.
>  It can take a full minute to have a device scan and a service scan
> completing, or less than 20 seconds! Sometimes, computer a  will be able
> to detect computer b, while B still shows no sign of life.
> 
> On top of things, if I manage to get it to send a message to its peer, the
> peer will get an Exception :( I was able to fix this by preventing the
> application from doing a service scan at the moment it would send, but
> that didn't fix the weird behaviour on service discovery. This hackaround
> is not sturdy and I don't like it as a general thing.
> 
> Has such thing ever happened to any of you? What can I do to fix it?
> 
> It looks like Bluetooth won't let me open a connection while doing a
> service scan. Is there limitations on what can be running simultaneously?
> It looks like service scan + opening connections is no good. Should I
> know other ones like that?

please speak in terms of the Bluetooth specification. What are you
doing? Inquiry, page, service discovery or what?

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

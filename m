Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth Service
From: Marcel Holtmann <marcel@holtmann.org>
To: zs@comp.rgu.ac.uk
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1077220929.9892.13.camel@zs>
References: <1077215650.9218.31.camel@zs> <1077217187.2767.17.camel@pegasus>
	 <1077220929.9892.13.camel@zs>
Content-Type: text/plain
Message-Id: <1077222592.2767.35.camel@pegasus>
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
Date: Thu, 19 Feb 2004 21:29:52 +0100

Hi Zia,

> At first, I would want to make a simple chat application lookalike. The
> aim would be for client to discover services and establish connection to
> the server socket. Once having that, I was thinking about streaming
> other web-contents/xml using the connection. While reading the Bluetooth
> specification, I read about HTTP service, but again I don't know whether
> if its implemented in Bluez, or how can it can be implemented. 
> 
> Also, for me the mystery is what happens when the service is being
> discovered? How does the client makes the connection to the service
> itself? Is there any relevant documentation around over it?

you can use L2CAP or RFCOMM based sockets for it. The BlueZ utils/test
directory contains example programs for it. You should look at it and
start writing your own code. Look at my latest slides for a more general
overview (http://www.holtmann.org/papers/bluetooth/wtc2003_slides.pdf).

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

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Windows Port
From: Marcel Holtmann <marcel@holtmann.org>
To: acr@acroberts.com
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <48760.80.63.28.114.1075219113.squirrel@acroberts.com>
References: <31555.80.63.28.114.1075193693.squirrel@acroberts.com>
	 <1075211962.12766.3.camel@pegasus>
	 <46161.80.63.28.114.1075214415.squirrel@acroberts.com>
	 <1075213551.12766.22.camel@pegasus>
	 <46892.80.63.28.114.1075215434.squirrel@acroberts.com>
	 <48760.80.63.28.114.1075219113.squirrel@acroberts.com>
Content-Type: text/plain
Message-Id: <1075221520.12766.31.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 27 Jan 2004 17:38:40 +0100

Hi Antony,

> I've just been looking at the code (from 2.4 - I'm running RH9). As far as
> I can see L2CAP and RFCOMM are connected by a socket interface, and L2CAP
> and the HCI layer are connected by a callback interface, yes?
> 
> After a very cursory investigation, I don't think it's a lot of work to
> create an abstraction layer so that Windows can provide the same APIs that
> BlueZ is using. In fact Microsofts BT implementation also uses a
> socket-based approach (unfortunately, because MS don't want us innovating
> in Bluetooth, everything other than RFCOMM is locked down).
> 
> Of course, the hci_ API would have to be re-written to accomodate the new
> driver (probably need to use sockets there as well), but I don't see why
> L2CAP and RFCOMM couldn't communicate in the same way on Windows. I'd
> probably move them up into user space as services - this of course means
> you have a messy route back into kernel mode for Virtual Serial port
> functions, but still, I'd say it's doable.
> 
> I would draw the line at Virtual Serial Port and BNEP, and let Windows
> have it's own user services (not the same as the gnome stuff for BlueZ).
> 
> What do you think? Am I right in that we are basically talking about
> sockets for L2CAP and RFCOMM?

I don't believe that it is possible to port BlueZ to the Windows
platform, but I also don't wanna keep you from trying it. Personally I
think it is easier to start from scratch and then offer the same
interfaces as BlueZ does for Linux.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

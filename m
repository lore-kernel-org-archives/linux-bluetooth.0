Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Handling a Hardware Error event on iPAQ h5550
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0503171141200.22782-100000@redbean.intranet.gw-instruments.de>
References: 
	 <Pine.LNX.4.33.0503171141200.22782-100000@redbean.intranet.gw-instruments.de>
Content-Type: text/plain
Message-Id: <1111057586.11792.58.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 17 Mar 2005 12:06:26 +0100

Hi Peter,

> I'm not that familiar with the architecture of BlueZ but with the
> experiences for our own stack I can tell you this is not trivial. The main
> problem here is that the Bluetooth Stack is not stateless. One possible
> solution is to feed the reset done event to the higher layers (l2cap). But
> than L2cap must be modified to correctly shut down all connections. It
> would be easier if the HCI layer tracks the state of all ACL and SCO
> connections (Marcel ??). Than a reset done event can be handled like a
> unexpected link loss on all active connections and the higher layers do
> not need any modifications (hopefully).

we can do this and actually calling "hcitool cc" does this already, but
it waits indeed for a timeout of the HCI_Disconnect.

> It may be much simpler trying to find the cause of the data corruption.

This is really the best thing to do, because H:4 is a stupid protocol if
you run it over hardware. For stack internal use it is perfect.

Hopefully 3-Wire UART will come at some time and make the H:4 obsolete.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

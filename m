Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] l2cap connection problems
From: Marcel Holtmann <marcel@holtmann.org>
To: becicka@uiuc.edu
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <70a9c48b.5f72b479.8225b00@expms2.cites.uiuc.edu>
References: <70a9c48b.5f72b479.8225b00@expms2.cites.uiuc.edu>
Content-Type: text/plain
Message-Id: <1089889116.3569.27.camel@notepaq>
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
Date: Thu, 15 Jul 2004 12:58:37 +0200

Hi Troy,

> I have written a client and server that need to be able to
> communicate over Bluetooth.  I am attempting to use L2CAP, but
> am not able to consistently connect to the server.  My
> application requires the server socket that accepts L2CAP
> connections to be non-blocking.  On the client side, I am
> using a non-blocking connect (connect with 2 second timeout).
>  However, in trying to debug the connection problem, I have
> tried using non-blocking sockets at both ends.  Even in this
> situation, my results were the same.  Sometimes the connection
> is accepted immediately (roughly half the time), the server
> begins streaming data to the client, and everything works
> great.  Just as frequently, the connection attempt times out
> at the client (when the client uses a blocking connect), or
> the connection succeeds after some number (potentially very
> many) of non-blocking connect attempts.  Occasionally the
> connection attempt appears as if it will never succeed.  I
> have attached a file containing hcidump output for 3 cases
> which are annotated in the file.  In all 3 cases a blocking
> accept is used at the server.  It seems as if the HCI layer
> events are identical regardless of whether or not the L2CAP
> layer accept (server) and connect (client) succeed.  Any
> thoughts as to what the problem might be?  For whatever it's
> worth, I am using D-Link DBT120 USB adapters.  Thanks in advance.

I can't really follow you what you are trying to achieve. May you better
show us the source code.

>>From the dump I saw you use PSM 100. This PSM is not valid according to
the specification, because PSM values must be odd.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

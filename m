Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] How to initiate a Pin-Exchange?
Message-ID: <20040417140311.GA2532@gmx.net>
References: <200404142203.21126.panizzon@woody.ch> <200404142211.55534.cijoml@volny.cz> <200404151149.35989.panizzon@woody.ch> <200404151729.32798.cijoml@volny.cz> <20040415202106.GA17934@gmx.net> <1082160503.4489.25.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1082160503.4489.25.camel@pegasus>
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
Date: Sat, 17 Apr 2004 16:03:11 +0200

On  0, Marcel Holtmann <marcel@holtmann.org> wrote:
> > If you try to connect from a bluez-computer to any other device, it
> > should etablish a connection. The stack should notice that there is need
> > for a link key and if none exists it requests a pin. 
> > 
> > < HCI Command: Create Connection(0x01|0x0005) plen 13
> > > HCI Event: Command Status(0x0f) plen 4
> > > HCI Event: Link Key Request(0x17) plen 6
> > < HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
> > > HCI Event: Command Complete(0x0e) plen 10
> > > HCI Event: PIN Code Request(0x16) plen 6
> > < HCI Command: PIN Code Request Reply(0x01|0x000d) plen 23
> > > HCI Event: Command Complete(0x0e) plen 10
> > > HCI Event: Link Key Notification(0x18) plen 23
> > > HCI Event: Connect Complete(0x03) plen 11
> > < HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
> > > HCI Event: Command Complete(0x0e) plen 6
> 
> this is security mode 3 ;)

What is security mode 3? AUTH and ENCRYPT ?
What is wrong about it?

> > I etablished the connection with hcitool. Which prints an timeout but
> > completes the connection as requested.
> 
> And the create connection command of hcitool is for low level testing
> only. You should better use l2ping or sdptool/rfcomm for testing.

I don't care about the output as long as it works. ;) 

> > P.S.: I noticed that bluez-pin only get the correct xauth credentials
> > when the bluetooth userland daemons are restarted after X is up.
> > Unfortunately I understand nothing from the X Authentication system, so
> > i have no clue why or how to fix it.
> 
> You can use the D-Bus enabled hcid and bluez-pin package.

Anyone written some doc about this combination? I dont get it running..

nicholas


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

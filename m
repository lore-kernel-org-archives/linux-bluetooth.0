Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] How to initiate a Pin-Exchange?
Message-ID: <20040415202106.GA17934@gmx.net>
References: <200404142203.21126.panizzon@woody.ch> <200404142211.55534.cijoml@volny.cz> <200404151149.35989.panizzon@woody.ch> <200404151729.32798.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200404151729.32798.cijoml@volny.cz>
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
Date: Thu, 15 Apr 2004 22:21:06 +0200

On  0, "Michal Semler (volny.cz)" <cijoml@volny.cz> wrote:
> Dne ?t 15. dubna 2004 11:49 Benoit Panizzon napsal(a):
 > > > How can I start the pin exchange with bluez?
> > > > bluez-pin does nothing at all as I see with hcidump.
> > >
> > > It's used when second site request pin when connecting
> >
> > Ok, but how do I request a pin from another device with bluez? Like when I
> > got a bluez-bluez setup?
> 
> I never needed that. I allways tried connect to remote side and second device 
> allways requested for pin :)

The archive is down at the moment, so i can't look the history of this
thread but I hope my asumptions aren't that wrong.
If you try to connect from a bluez-computer to any other device, it
should etablish a connection. The stack should notice that there is need
for a link key and if none exists it requests a pin. 

< HCI Command: Create Connection(0x01|0x0005) plen 13
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Link Key Request(0x17) plen 6
< HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
> HCI Event: Command Complete(0x0e) plen 10
> HCI Event: PIN Code Request(0x16) plen 6
< HCI Command: PIN Code Request Reply(0x01|0x000d) plen 23
> HCI Event: Command Complete(0x0e) plen 10
> HCI Event: Link Key Notification(0x18) plen 23
> HCI Event: Connect Complete(0x03) plen 11
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
> HCI Event: Command Complete(0x0e) plen 6

I etablished the connection with hcitool. Which prints an timeout but
completes the connection as requested.

nicholas

P.S.: I noticed that bluez-pin only get the correct xauth credentials
when the bluetooth userland daemons are restarted after X is up.
Unfortunately I understand nothing from the X Authentication system, so
i have no clue why or how to fix it.

Kernel 2.6.5-mh3
bluez-libs 2.6
bluez-utils 2.6
bluez-pin 0.23
AUTH ENCRYPT
and hcid.conf: "security user;"


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

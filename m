Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Catalin Drula <catalin@cs.toronto.edu>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.58.0502110245280.20071@qew.cs>
References: <Pine.GSO.4.58.0502110245280.20071@qew.cs>
Content-Type: text/plain
Message-Id: <1108109727.18099.7.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: Re: Re: Lower granularity for INQUIRY interval
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
Date: Fri, 11 Feb 2005 09:15:27 +0100

Hi Catalin,

> > > Not necessarily a bad idea. In my case, I need to do symmetric
> > > Bluetooth discovery. There are no predefined roles (master-slave,
> > > server-client) for the devices which must continually scan their
> > > surroundings in order to discover other devices. Hence, each device
> > > must continously switch between the INQUIRY and INQUIRY SCAN states
> >
> > I still don"t get why switching inquiry scan on and off should help in
> > any case. Since inquiry scan defines the discoverable mode and so you
> > switch devices to unvisible when they inquiry and back to visible when
> > they don"t.
> 
> I never switch inquiry scan off (the scan mode always stays PSCAN and
> ISCAN). But when an inquiry is initiated, the device switches into INQUIRY
> mode (or substate) from stops scanning (moves out of the INQUIRY SCAN
> substate for the duration of the inquiry). That is to say, during an
> inquiry a device is not discoverable (or visible). That is what I meant by
> switching between the two states.

in the code you sent me, you did exactly this. So what are we talking
about?

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

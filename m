Return-Path: <catalin@cs.toronto.edu>
Date: Fri, 11 Feb 2005 02:54:23 -0500 (EST)
From: Catalin Drula <catalin@cs.toronto.edu>
To: marcel@holtmann.org
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: Re: Re: Lower granularity for INQUIRY interval   
Message-ID: <Pine.GSO.4.58.0502110245280.20071@qew.cs>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

> > Not necessarily a bad idea. In my case, I need to do symmetric
> > Bluetooth discovery. There are no predefined roles (master-slave,
> > server-client) for the devices which must continually scan their
> > surroundings in order to discover other devices. Hence, each device
> > must continously switch between the INQUIRY and INQUIRY SCAN states
>
> I still don"t get why switching inquiry scan on and off should help in
> any case. Since inquiry scan defines the discoverable mode and so you
> switch devices to unvisible when they inquiry and back to visible when
> they don"t.

I never switch inquiry scan off (the scan mode always stays PSCAN and
ISCAN). But when an inquiry is initiated, the device switches into INQUIRY
mode (or substate) from stops scanning (moves out of the INQUIRY SCAN
substate for the duration of the inquiry). That is to say, during an
inquiry a device is not discoverable (or visible). That is what I meant by
switching between the two states.

Catalin

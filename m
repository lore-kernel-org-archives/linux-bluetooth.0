Return-Path: <catalin@cs.toronto.edu>
Date: Fri, 11 Feb 2005 04:00:37 -0500 (EST)
From: Catalin Drula <catalin@cs.toronto.edu>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: Re: Re: Lower granularity for INQUIRY interval
In-Reply-To: <1108109727.18099.7.camel@pegasus>
Message-ID: <Pine.GSO.4.58.0502110351380.28007@qew.cs>
References: <Pine.GSO.4.58.0502110245280.20071@qew.cs> <1108109727.18099.7.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

On Fri, 11 Feb 2005, Marcel Holtmann wrote:

> > > I still don"t get why switching inquiry scan on and off should help in
> > > any case. Since inquiry scan defines the discoverable mode and so you
> > > switch devices to unvisible when they inquiry and back to visible when
> > > they don"t.
> >
> > I never switch inquiry scan off (the scan mode always stays PSCAN and
> > ISCAN). But when an inquiry is initiated, the device switches into INQUIRY
> > mode (or substate) from stops scanning (moves out of the INQUIRY SCAN
> > substate for the duration of the inquiry). That is to say, during an
> > inquiry a device is not discoverable (or visible). That is what I meant by
> > switching between the two states.
>
> in the code you sent me, you did exactly this. So what are we talking
> about?

You're right, I did do that, but then I realized it was unnecessary (as
you yourself pointed out). However, the first issue I raised (that of
being able to inquire with a finer granularity) remains, but as you said
the solution is to go to the HCI level and stop the ongoing inquiry with
INQUIRY CANCEL.

One behaviour that I noticed (just empirically) and that is worth
mentioning is that sometimes it appears that a few shorter inquiries (1-2
seconds long) separated by pauses (of the same length) yield up more
discovered devices than one long inquiry (of say 10.28 seconds). I do not
know enough about the baseband layer to explain this and please notice I
said "sometimes" and "empirically". So this is definitely not always the
case, and it might not be the case at all since it's just based on my
empirical observations (no data, statistics to support this).

Catalin

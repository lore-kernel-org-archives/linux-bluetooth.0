Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Missing data in ACL packets from CSR chip
Date: Fri, 13 Feb 2004 09:35:25 -0800
Message-ID: <000501c3f257$c4649af0$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1076688033.2671.113.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

It looks like a UART problem to me too, but it's probably not on my side
because both the sniffer and the host saw the same error.

I would like to try BCSP. Are there tools available to put the module in
BCSP mode?

I'm trying to get a firmware upgrade... But no luck yet.

-Daryl.

> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@holtmann.org] 
> Sent: February 13, 2004 8:01 AM
> To: Daryl Van Vorst
> Cc: BlueZ Mailing List
> Subject: Re: [Bluez-devel] Missing data in ACL packets from CSR chip
> 
> 
> Hi Daryl,
> 
> > Here's my decode:
> > 
> > Starting at index 536645:
> > 
> > 0536645: 04 13 05 01 2d 00 03 00
> > HCI event: Number of completed packets
> > 
> > 0536655: 02 2d 20 09 00 05 00 40 00 21 ff 01 03 9c
> > Valid ACL data packet.
> > 
> > 0536673 - 0537012
> > More Number of completed packets events
> > 
> > 0537013: 02 2d 20 09 00 05 00 40 00 21 ff 01 01 9c
> > Valid ACL data packet
> > 
> > 0537031: 02 2d 20 09 00 05 00 40 00 21 ff 01 9c 02
> > Corrupt packet.
> 
> this looks like an UART problem to me, but I don't know if it 
> is on the chip, on the module or one your side.
> 
> Is it possible for you to use BCSP? Do you have a firmware 
> update to the latest HCI 16.x or HCI 17.x?
> 
> Regards
> 
> Marcel
> 
> 
> 

Return-Path: <mab@comnets.uni-bremen.de>
Date: Thu, 24 Aug 2006 15:51:02 +0200 (MEST)
From: Markus Becker <mab@comnets.uni-bremen.de>
To: Marcel Holtmann <marcel@holtmann.org>
cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] bluez-libs UUID-128 support for Protocol
 Descriptor List
In-Reply-To: <1156430602.4133.108.camel@aeonflux.holtmann.net>
Message-ID: <Pine.LNX.4.21.0608241550360.27134-100000@bugs.comnets.uni-bremen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>


On Thu, 24 Aug 2006, Marcel Holtmann wrote:

> Hi Markus,
> 
> > > > I've created a patch for bluez-libs/src/sdp.c to support the finding of
> > > > UUID128 encoded protocols. So that also kdebluetooth and others can
> > > > recognize those protocols. It changes the display of the Protocol
> > > > Descriptor List for example from:
> > > > 
> > > > Service Name: ATEmulator
> > > > Service RecHandle: 0x10010
> > > > Service Class ID List:
> > > >   "Error: This is UUID-128" (0x7dd6b763-99a9-4a92-87b5-bc8efe565c37)
> > > >   "Error: This is UUID-128" (0x00001101-0000-1000-8000-00805f9b34fb)
> > > > Protocol Descriptor List:
> > > >   "Error: " (0x00000100-0000-1000-8000-00805f9b34fb)
> > > >   "Error: " (0x00000003-0000-1000-8000-00805f9b34fb)
> > > >     Channel: 25
> > > > 
> > > > to:
> > > > 
> > > > Service Name: ATEmulator
> > > > Service RecHandle: 0x10010
> > > > Service Class ID List:
> > > >   UUID 128: 7dd6b763-99a9-4a92-87b5-bc8efe565c37
> > > >   UUID 128: 00001101-0000-1000-8000-00805f9b34fb
> > > > Protocol Descriptor List:
> > > >   "L2CAP" (0x00000100-0000-1000-8000-00805f9b34fb)
> > > >   "RFCOMM" (0x00000003-0000-1000-8000-00805f9b34fb)
> > > >     Channel: 25
> > > > 
> > > > Please consider it for integration into mainline bluez-libs.
> > > 
> > > the patch is wrong. Before you are doing a lookup against the short
> > > UUIDs of Bluetooth you should check if the base UUID is the Bluetooth
> > > base UUID. Otherwise you can't do the lookup.
> > > 
> > OK. I attached a patch that does the whole String_lookup differently and
> > using sdp_uuid128_to_uuid for 128 bit UUIDs. Unfortunately I had to change
> > the interface in sdp_lib.h because of "const" not being fulfilled by
> > sdp_uuid128_to_uuid.
> > 
> > I hope this patch is more to your liking. If not, contact me.
> 
> your patch is a little bit too complex and the coding style is wrong and
> changing the prototypes is not a good idea.
> 
> Please test the attached patch. This is how I would do it.

Tested and works for me. Thanks.

> 
> Regards
> 
> Marcel
> 
> 

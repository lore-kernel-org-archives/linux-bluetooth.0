Return-Path: <cyrus@holtmann.org>
Message-ID: <1349962908.27233.164.camel@aeonflux>
Subject: Re: [PATCH v3 01/10] doc: Add settings storage documentation
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>, linux-bluetooth@vger.kernel.org
Date: Thu, 11 Oct 2012 15:41:48 +0200
In-Reply-To: <20121010184103.GA23441@x220.ger.corp.intel.com>
References: <1349878219-14359-1-git-send-email-frederic.danis@linux.intel.com>
	 <1349878219-14359-2-git-send-email-frederic.danis@linux.intel.com>
	 <1349890310.27233.140.camel@aeonflux>
	 <20121010184103.GA23441@x220.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > > +            ./attribute_db
> > > +        ./<remote device address>/
> > > +            ./settings
> > > +            ./keys
> > > +            ./attribute_db
> > > +        ...
> > 
> > Why did we want directories for remote devices again? Can we not just
> > put all in one big file with the name of the remote address?
> 
> For profile-specific storage this could be convenient (when removing the
> device we just remove the entire directory and the core daemon doesn't
> need to care about profiles details). OTOH the core needs to either way
> provide some API so the plugins know to write to the right location
> (be it a single file for the entire device or a single directory for the
> device).

fair enough. And a generic function to return the path for the device
specific storage location is a good idea anyway. So the profile does
need to care.

However we could also force the profile implementation to use a specific
file with such a function. And we could derive the name from the driver
name entry.

So we could return <device-bdaddr>-magic-profile for storage.

> > > +Adapter directory files
> > > +=======================
> > > +
> > > +Settings file contains 1 [General] group with adapter info:
> > > +  [General]
> > > +  Name=
> > > +  Class=0x000000
> > > +  Pairable=<true|false>
> > > +  PairableTimeout=0
> > > +  DiscoverableTimeout=0
> > > +  Mode=<off|connectable|discoverable>
> > > +  OnMode=<connectable|discoverable>
> > 
> > Actually with management interface now being used, we can be a bit
> > smarter here. The mode can be programmed even if the controller is not
> > powered.
> > 
> > So this might be better as Discoverable, Connectable, Pairable and
> > Powered boolean options.
> > 
> > Also Pairable has no timeout in the kernel API anymore. Do we still need
> > this?
> 
> We do have it currently as a documented adapter D-Bus property so that'd
> need to be removed too. I don't personally have a great need for this
> but I could imagine some device manufacturers deciding to have something
> like this (especially those with very simple UI's with a single button
> or so).

Fair enough. I was just asking if we still want the pairable timeout. I
have no problem with it.

> > > +The attribute_db file is a list of handles (group name) with UUID and Value as
> > > +keys, for example:
> > > +  [0x0001]
> > > +  UUID=00002800-0000-1000-8000-00805f9b34fb
> > > +  Value=0018
> > > +
> > > +  [0x0004]
> > > +  UUID=00002803-0000-1000-8000-00805f9b34fb
> > > +  Value=020600002A
> > > +
> > > +  [0x0006]
> > > +  UUID=00002a00-0000-1000-8000-00805f9b34fb
> > > +  Value=4578616D706C6520446576696365
> > 
> > Is this our primary key, the handle?
> 
> Yep, the reasoning was that you can easily have multiple
> profiles/services with the same UUID with GATT, so the UUID is no good
> as a unique identifier (not that GLib even supports multiple groups with
> the same name - it merges their content together to a single logical
> group).
> 
> > > +Names file contains 1 [Names] group with device address as key:
> > > +  [Names]
> > > +  <nn:nn:nn:nn:nn:nn>=device name a
> > > +  <mm:mm:mm:mm:mm:mm>=device name b
> > 
> > I am not sure this is the best idea this way. Maybe just creating files
> > for each address we ever see is a better idea. Details like LastSeen
> > could be useful for unpaired devices.
> 
> So instead of a cache file we'd have a cache directory? I'd be fine with
> that.

Something like that. Details need to be figured out, but I like to make
it bluntly clear that this data could be purged.

> 
> > > +  Features=0000000000000000
> > > +  AddressType=<BR/EDR|LE>
> > > +  LEAddressType=<public|random>
> > 
> > That is not needed. It is encoded in the address itself.
> 
> Not quite true. You cannot distinguish between public and random. But
> once you do know that it's random you *can* figure out what kind of
> random it is from the two most significant bits of the address.
> 
> What we discussed on #bluez was that this could simply be a reference to
> what address is indicated by the directory (or filename, if that's what
> we go with) for the device storage, e.g. AddressType=<static|public> and
> for private resolvable addresses (for which we'd have the public address
> in storage) we'd need to check if we have any IRK's to know if we need
> to look for a private address to connect to them. Additionally we could
> have a SupportedTechnologies list like "BR/EDR,LE", "LE", etc (feel free
> to suggest a better name if you want).

Since we will not store private random addresses, and we turn static
random addresses into a cache. So why do we still need this?

Regards

Marcel



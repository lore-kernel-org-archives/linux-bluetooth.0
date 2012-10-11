Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Oct 2012 16:24:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 01/10] doc: Add settings storage documentation
Message-ID: <20121011142430.GA29271@x220.example.org>
References: <1349878219-14359-1-git-send-email-frederic.danis@linux.intel.com>
 <1349878219-14359-2-git-send-email-frederic.danis@linux.intel.com>
 <1349890310.27233.140.camel@aeonflux>
 <20121010184103.GA23441@x220.ger.corp.intel.com>
 <1349962908.27233.164.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349962908.27233.164.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 11, 2012, Marcel Holtmann wrote:
> > > > +  Features=0000000000000000
> > > > +  AddressType=<BR/EDR|LE>
> > > > +  LEAddressType=<public|random>
> > > 
> > > That is not needed. It is encoded in the address itself.
> > 
> > Not quite true. You cannot distinguish between public and random. But
> > once you do know that it's random you *can* figure out what kind of
> > random it is from the two most significant bits of the address.
> > 
> > What we discussed on #bluez was that this could simply be a reference to
> > what address is indicated by the directory (or filename, if that's what
> > we go with) for the device storage, e.g. AddressType=<static|public> and
> > for private resolvable addresses (for which we'd have the public address
> > in storage) we'd need to check if we have any IRK's to know if we need
> > to look for a private address to connect to them. Additionally we could
> > have a SupportedTechnologies list like "BR/EDR,LE", "LE", etc (feel free
> > to suggest a better name if you want).
> 
> Since we will not store private random addresses, and we turn static
> random addresses into a cache. So why do we still need this?

We will need to store exactly the same information for static random
addresses as for public ones, and not just the "core" data but also
profile-specific data. So why would you want to do it in two different
ways? Sounds like that just complicates the implementation for no
particular gain.

Johan

Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Apr 2012 13:45:24 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix registering HCI devices with duplicate
 name
Message-ID: <20120412104521.GA2779@aemeltch-MOBL1>
References: <1334158328-6956-1-git-send-email-marcel@holtmann.org>
 <20120412073829.GC5341@aemeltch-MOBL1>
 <1334224208.16897.138.camel@aeonflux>
 <20120412100328.GF5341@aemeltch-MOBL1>
 <1334225714.16897.142.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334225714.16897.142.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Apr 12, 2012 at 12:15:14PM +0200, Marcel Holtmann wrote:
> then lets fix the logic we have right now. It can not be that hard to
> have this behave correctly. Find the proper next free id and find the
> right location in the list to add it to.

We are highly dependent here on ordered list which is not good IMO,
especially given that BR/EDR shall be first element with id=0. This of
course works well in default situation when we have only 2 controllers.

> > > > BTW: Have you checked my patch version 3.
> > > 
> > > If we have to run through that list twice, then we are doing something
> > > wrong. Also having to run through the whole list seems pointless. We
> > > just need to make sure that the list stays ordered.
> > 
> > We are not running through the whole list, just until found free id.
> 
> You are running the whole list for the bitmask creation and then a
> second time for finding the right location in the list. Fair enough that

Second run is not needed, we can just add to the tail of the list. In most
cases list will still be ordered and this does not matter since we do not
depend on ordered list.

Best regards 
Andrei Emeltchenko 

> the second time you only run until you found a free spot, but
> nevertheless, you run it again.
> 
> Regards
> 
> Marcel
> 
> 

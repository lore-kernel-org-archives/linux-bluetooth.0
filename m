Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Aug 2008 11:55:23 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
    Stefan Seyfried <seife@suse.de>,  <linux-bluetooth@vger.kernel.org>,
     <linux-usb@vger.kernel.org>
Subject: Re: [rfc/rft]power management for btusb
In-Reply-To: <1219246908.7591.348.camel@violet.holtmann.net>
Message-ID: <Pine.LNX.4.44L0.0808201151460.2806-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 20 Aug 2008, Marcel Holtmann wrote:

> Hi Alan,
> 
> > > finally I found the device and setting it to auto makes it actually
> > > suspend. Why is this not default? The driver has to enable it anyway.
> > 
> > If there's no driver then it would take effect right away.  This causes 
> > problems for devices during startup -- the period of time from device 
> > discovery to driver binding is long enough (because there's so much 
> > other activity during bootup) that the device can autosuspend before 
> > the driver is there to prevent it.
> > 
> > For well-behaved devices this wouldn't matter.  But unfortunately there 
> > are lots of devices which break when they suspend.  That's why 
> > level = auto is not the default.
> 
> is there any way to make it default if we know it works all the time?

No, probably not.  But in general we don't know that.  And we do know
that a fair number of devices really are broken in this way -- lots of
printers or scanners have this problem.  Too many for us to want to
keep a blacklist in the kernel, as Oliver mentioned.

The idea is that some desktop management program, like hal, should be 
able to recognize which devices can autosuspend safely and then enable 
them.  That way the whole problem is pushed out to userspace.  :-)

There is one exception: The kernel enables autosuspend automatically 
for hubs.

Alan Stern

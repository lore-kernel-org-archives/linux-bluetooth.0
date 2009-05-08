Return-Path: <cyrus@holtmann.org>
Subject: Re: btusb auto suspend
From: Peter Zijlstra <peterz@infradead.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,  linux-usb@vger.kernel.org
In-Reply-To: <200905082223.16014.oliver@neukum.org>
References: <1241433271.7620.4748.camel@twins>
	 <1241458142.2903.35.camel@localhost.localdomain>
	 <200905082223.16014.oliver@neukum.org>
Content-Type: text/plain
Date: Fri, 08 May 2009 22:26:12 +0200
Message-Id: <1241814372.6404.54.camel@laptop>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2009-05-08 at 22:23 +0200, Oliver Neukum wrote:
> Am Montag, 4. Mai 2009 19:29:02 schrieb Marcel Holtmann:
> > Hi Peter,
> >
> > > What is the current status of btusb auto suspend? btusb not having this
> > > feature basically renders BT useless on mobile devices.
> > >
> > > I found some rfc patches and discussion over on linux-pm/-usb but
> > > couldn't find a clear consensus.
> >
> > I think none of the patches apply anymore. So they have to be redone
> > against the latest -rc4 kernel or bluetooth-testing.git.
> 
> I am porting forward to Linus' tree. I thought they'd safely wait for
> the next merge window.
> 
> > We had some battles with broken Bluetooth hardware that requires to keep
> > the interrupt and bulk URBs in fly, because otherwise the firmware
> > inside the controller can't sync them up and times out. These are all
> > fixed now, but nobody has looked at the auto suspend stuff. Feel free to
> 
> It will have to be changed to work with those buggy devices.
> Do you have a pointer to a page describing the problem in detail?
> 
> > pick Oliver's patches up and send them for review. If you do so, please
> > use linux-bluetooth@vger.kernel.org since I do miss posting on LKML from
> > time to time.
> 
> Peter, are you willing to test?

Sure, I have two laptops with integrated bluetooth to test on.

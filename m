Return-Path: <cyrus@holtmann.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bug 11442] btusb suspend/resume bug...
Date: Tue, 30 Sep 2008 23:44:42 +0200
Cc: David Miller <davem@davemloft.net>,
 linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org,
 bugme-daemon@bugzilla.kernel.org
References: <20080916.155123.181085856.davem@davemloft.net> <200809271541.15963.rjw@sisk.pl> <1222754141.1825.55.camel@violet.holtmann.net>
In-Reply-To: <1222754141.1825.55.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200809302344.42615.rjw@sisk.pl>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday, 30 of September 2008, Marcel Holtmann wrote:
> Hi Rafael,
> 
> > > >> Rafael, can you pull from my tree and test the changes:
> > > >>
> > > >> git://git.kernel.org/pub/scm/linux/kernel/git/holtmann/ 
> > > >> bluetooth-2.6.git
> > > >>
> > > >> It would be interesting if these fixes are enough.
> > > >
> > > > They appear to be enough.  I haven't had any suspend/resume failures  
> > > > with them
> > > > applied.
> > > 
> > > so it works _without_ applying patch-btusb-suspend.
> > 
> > Well, unfortunately I spoke too soon.
> > 
> > I'm still seeing post-hibernation crashes triggered by the bluetooth user land
> > trying to use the device handled by btusb.  They happen every second
> > hibernation, more or less, and apparently they are oopses in various code
> > paths not directly related to bluetooth, like ext3 (memory corruption or
> > what?).
> 
> I pushed two extra patches to my bluetooth-2.6 repository:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/holtmann/bluetooth-2.6.git
> 
> One is fixing a double-free in the error path. This error path can be
> triggered during suspend/resume if the USB core just disconnects the
> device. Please check if that fixes it for you.
> 
> > With patch-btusb-suspend applied I don't see them (actually I have to use
> > a slightly modified version of the patch which is appended).
> > 
> > Interestingly enough, suspend to RAM works without any visible problems.
> 
> As Oliver said, the USB core should do the right thing when no suspend
> and resume callbacks are provided. I looked through the code so many
> times now and I am running out of ideas what can happen.
> 
> Lets try it one last time without the suspend patch, but the double free
> fix and see if that works. Otherwise I really give up.

This time I cannot reproduce the hibernation issue without the suspend patch,
so it appears that your double-free fix works for me.

Thanks,
Rafael

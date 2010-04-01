Return-Path: <cyrus@holtmann.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Parag Warudkar <parag.lkml@gmail.com>
Subject: Re: S2RAM broken on HP 8530p (btusb involved)
Date: Fri, 2 Apr 2010 00:31:10 +0200
Cc: linux-kernel@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org
References: <alpine.DEB.2.00.1003312050370.1876@parag-laptop> <201004012352.18149.rjw@sisk.pl> <alpine.DEB.2.00.1004011814140.2792@parag-laptop>
In-Reply-To: <alpine.DEB.2.00.1004011814140.2792@parag-laptop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201004020031.10632.rjw@sisk.pl>
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 02 April 2010, Parag Warudkar wrote:
> 
> On Thu, 1 Apr 2010, Rafael J. Wysocki wrote:
> 
> > On Thursday 01 April 2010, Parag Warudkar wrote:
> > > 
> > > On Thu, 1 Apr 2010, Rafael J. Wysocki wrote:
> > > 
> > > > Please try:
> > > > 
> > > > # echo devices > /sys/power/pm_test
> > > > # echo mem > /sys/power/state
> > > > 
> > > > and see if that breaks too (it should get back to the command line in about
> > > > 5-10 seconds).
> > > 
> > > That breaks too - hangs similarly during suspend. I enabled RTC tracing 
> > > and every time it prints out different hash matches after reboot - 
> > > tty/tty21, pcie04  and latest is 
> > > 
> > > [    0.865296] pcieport 0000:00:1c.1: hash matches
> > > 
> > > Also when the suspend fails the immediate boot after that I get a USB 
> > > error on startup - unable to enumerate usb device on port 1. This error is 
> > > not present on normal boots.
> > 
> > Well, try the above with the USB controller drivers unloaded.
> > 
> 
> Turns out its not the controller drivers but btusb and friends. Once I 
> removed btusb,sco,bnep,l2cap and family I was able to suspend resume just 
> like before.
> 
> For now I have disabled Bluetooth in BIOS as I don't need it - it is 
> likely that it was disabled earlier and so the suspend/resume was 
> working but looks like after a BIOS update/reset I left it enabled.
> 
> So this does not seem to be a regression to me.
> 
> But may be it should be possible to suspend/resume with bluetooth enabled? 
> :)

Sure.

Adding CCs to the bluetooth people.

Rafael

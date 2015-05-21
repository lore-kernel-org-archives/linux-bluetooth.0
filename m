Return-Path: <cyrus@holtmann.org>
Date: Thu, 21 May 2015 11:26:17 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Takashi Iwai <tiwai@suse.de>, Laura Abbott <labbott@redhat.com>,
    Oliver Neukum <oneukum@suse.com>, Ming Lei <ming.lei@canonical.com>,
    "David S. Miller" <davem@davemloft.net>,
    Laura Abbott <labbott@fedoraproject.org>,
    Johan Hedberg <johan.hedberg@gmail.com>,
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
    "Gustavo F. Padovan" <gustavo@padovan.org>,
    "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    USB list <linux-usb@vger.kernel.org>, netdev <netdev@vger.kernel.org>
Subject: Re: [RESEND][PATCH] Bluetooth: Make request workqueue freezable
In-Reply-To: <33C25745-6839-4858-9A3E-19EC6408ECED@holtmann.org>
Message-ID: <Pine.LNX.4.44L0.1505211112310.1397-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 21 May 2015, Marcel Holtmann wrote:

> Hi Alan,
> 
> >> Then avoiding the failed firmware is no solution, indeed.
> >> If it's a new probe, it should be never executed during resume.
> > 
> > Can you expand this comment?  What's wrong with probing during resume?
> > 
> > The USB stack does carry out probes during resume under certain
> > circumstances.  A driver lacking a reset_resume callback is one of
> > those circumstances.
> 
> in case the platform kills the power to the USB lines, we can never
> do anything about this. I do not want to hack around this in the
> driver.
> 
> What are the cases where we should implement reset_resume and would
> it really help here. Since the btusb.ko driver implements
> suspend/resume support, would reset_resume ever be called?

One of those cases is exactly what you have been talking about: when
the platform kills power to the USB lines during suspend.  The driver's
reset_resume routine will be called during resume, as opposed to the
probe routine being called.  Therefore the driver will be able to tell
that this is not a new device instance.

The other cases are less likely to occur: a device is unable to resume 
normally and requires a reset before it will start working again, or 
something else goes wrong along those lines.

> However I get the feeling someone needs to go back and see if the
> device is the same one and just gets probed again or if it is a new
> one from the USB host stack perspective.

That can be done easily enough by enabling usbcore debugging before 
carrying out the system suspend:

	echo 'module usbcore =p' >/debug/dynamic_debug/control

The debugging information in the kernel log will tell just what 
happened.


On Thu, 21 May 2015, Takashi Iwai wrote:

> At Thu, 21 May 2015 10:18:08 -0400 (EDT),
> Alan Stern wrote:
> > 
> > On Thu, 21 May 2015, Takashi Iwai wrote:
> > 
> > > Then avoiding the failed firmware is no solution, indeed.
> > > If it's a new probe, it should be never executed during resume.
> > 
> > Can you expand this comment?  What's wrong with probing during resume?
> 
> Well, if the probe requires the access to a user-space file, it can't
> be done during resume.  That's the very problem we're seeing now.
> The firmware loader can't help much alone if it's a new device
> object.

But the same thing happens during early boot, if the driver is built 
into the kernel.  When the probe occurs, userspace isn't up and running 
yet, so the firmware loader can't do anything.

Why should probe during resume be any worse than probe during early 
boot?

> > The USB stack does carry out probes during resume under certain
> > circumstances.  A driver lacking a reset_resume callback is one of
> > those circumstances.
> 
> So, having a proper reset_resume in btusb would help in the end?

It might, depending on how the driver is written.  I don't know enough 
about the details of btusb to say.

Alan Stern

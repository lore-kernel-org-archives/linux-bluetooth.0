Return-Path: <cyrus@holtmann.org>
Subject: Re: [rfc/rft]power management for btusb
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: Pavel Machek <pavel@suse.cz>, Stefan Seyfried <seife@suse.de>,
	linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <200808201600.56584.oliver@neukum.org>
References: <200808201142.52620.oliver@neukum.org>
	 <200808201534.11557.oliver@neukum.org>
	 <1219239575.7591.336.camel@violet.holtmann.net>
	 <200808201600.56584.oliver@neukum.org>
Content-Type: text/plain
Date: Wed, 20 Aug 2008 17:25:14 +0200
Message-Id: <1219245914.7591.338.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> > > > > > > > > > > > I tried to run this on my Quad G5, but I never see suspend() or resume()
> > > > > > > > > > > > called. Do I have to do something to make autosuspend work?
> > > > > > > > > > > 
> > > > > > > > > > > echo "auto" > $(directry in sysfs for device)/power/level
> > > > > > > > > > > And you'll see power events in syslog only if you compile with
> > > > > > > > > > > CONFIG_USB_DEBUG
> > > > > > > > > > 
> > > > > > > > > > I only seem to see power/wakeup entries. I don't have power/level. Am I
> > > > > > > > > > missing some configuration option?
> > > > > > > > > 
> > > > > > > > > Probably CONFIG_USB_SUSPEND
> > > > > > > > 
> > > > > > > > that one is on of course. Do you think it makes a difference that it is
> > > > > > > > PowerPC system I am testing this with?
> > > > > > > 
> > > > > > > If it does make a difference, that's a bug. Runtime PM should work
> > > > > > > anyway.
> > > > > > 
> > > > > > I really don't see any calls to suspend() and I am missing the
> > > > > > power/level option. This is the latest 2.6.27-rc3-git tree from Linus.
> > > > > 
> > > > > Odd. Send /proc/config.gz please.
> > > > 
> > > > there you go. It is a nice Quad G5 machine.
> > > 
> > > That should work. Did you perhaps forget to remake your initrd?
> > 
> > no initrd on this system.
> 
> It should work. Are you perhaps looking at the interface level as opposed
> to the device level?

finally I found the device and setting it to auto makes it actually
suspend. Why is this not default? The driver has to enable it anyway.

Regards

Marcel



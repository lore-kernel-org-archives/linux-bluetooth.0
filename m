Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add udev mode to bluetoothd
From: Bastien Nocera <hadess@hadess.net>
To: Stefan Seyfried <seife@suse.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4A320683.7000103@suse.de>
References: <1244741895.11069.1319.camel@cookie.hadess.net>
	 <1244742638.27363.51.camel@violet>  <4A320683.7000103@suse.de>
Content-Type: text/plain
Date: Fri, 12 Jun 2009 09:40:20 +0100
Message-Id: <1244796020.3280.13.camel@snoogens.fab.redhat.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2009-06-12 at 09:40 +0200, Stefan Seyfried wrote:
> Marcel Holtmann wrote:
> > Hi Bastien,
> > 
> >> As discussed on IRC.
> >>
> >> Still needed:
> >> - patch to wait for the bus to startup in udev mode
> 
> Should we really do that? (What if the bus never appears?, how long should we
> wait?)
> The alternative (not overwhelmingly nice, I admit) would be to record
> somewhere in the system that bluetoothd tried to start but could not due to
> the missing bus and then start it "manually" by an init script that is
> guaranteed to run after DBus is started.

Under normal conditions, we'd exit(1) if started and the bus isn't
available, and udev would pick that up, marking our job as failed, and
relaunching us later in the boot process, under coldplug.

Marcel didn't like the idea though.

> I had patches for waiting for the bus long time ago and can dig them out if
> wanted.

Sure, as long as it's not bluez 3.x stuff :)


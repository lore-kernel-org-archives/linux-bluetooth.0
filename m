Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add udev mode to bluetoothd
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: Stefan Seyfried <seife@suse.de>, linux-bluetooth@vger.kernel.org
In-Reply-To: <1244796020.3280.13.camel@snoogens.fab.redhat.com>
References: <1244741895.11069.1319.camel@cookie.hadess.net>
	 <1244742638.27363.51.camel@violet>  <4A320683.7000103@suse.de>
	 <1244796020.3280.13.camel@snoogens.fab.redhat.com>
Content-Type: text/plain
Date: Fri, 12 Jun 2009 17:28:18 +0200
Message-Id: <1244820498.5536.7.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> > >> As discussed on IRC.
> > >>
> > >> Still needed:
> > >> - patch to wait for the bus to startup in udev mode
> > 
> > Should we really do that? (What if the bus never appears?, how long should we
> > wait?)
> > The alternative (not overwhelmingly nice, I admit) would be to record
> > somewhere in the system that bluetoothd tried to start but could not due to
> > the missing bus and then start it "manually" by an init script that is
> > guaranteed to run after DBus is started.
> 
> Under normal conditions, we'd exit(1) if started and the bus isn't
> available, and udev would pick that up, marking our job as failed, and
> relaunching us later in the boot process, under coldplug.
> 
> Marcel didn't like the idea though.

so how does udev handle this exactly. We try bluetoothd and it fails,
then it tries again later? What time exactly? How often? Does this
affect the fast-boot effort?

Regards

Marcel



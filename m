Return-Path: <cyrus@holtmann.org>
Subject: Re: Packaging question
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Seyfried <seife@suse.de>
Cc: linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <48D29276.5060708@suse.de>
References: <48C685F1.9040905@suse.de>
	 <1221084945.13336.31.camel@californication>  <48C8D96A.6060900@suse.de>
	 <1221237288.6695.19.camel@californication>  <48D22F30.1060301@suse.de>
	 <1221758180.6782.22.camel@californication>  <48D29276.5060708@suse.de>
Content-Type: text/plain
Date: Thu, 18 Sep 2008 22:39:37 +0200
Message-Id: <1221770377.6782.32.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

> > we had the discussion for Fedora and we want to start it via udev,
> > however then we need D-Bus before udev runs and that is not an option
> > right now. So the current solution is to just do it via init.d, but in
> > the future we want udev.
> 
> What about the old hack that I had back in the old days that would let hcid
> wait until D-Bus came up? ;-) One problem with init.d is that the daemon is
> running, even if there is no device plugged in...

if we go always polling the D-Bus and try to re-connect it is bad, too.
The solution is to make sure that D-Bus is always running and will never
die. Everything else is just wrong and will break.

Regards

Marcel



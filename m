Return-Path: <cyrus@holtmann.org>
Subject: Re: [rfc/rft]power management for btusb
From: Marcel Holtmann <marcel@holtmann.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
	Stefan Seyfried <seife@suse.de>,
	linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L0.0808201132200.2806-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0808201132200.2806-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Wed, 20 Aug 2008 17:41:48 +0200
Message-Id: <1219246908.7591.348.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alan,

> > finally I found the device and setting it to auto makes it actually
> > suspend. Why is this not default? The driver has to enable it anyway.
> 
> If there's no driver then it would take effect right away.  This causes 
> problems for devices during startup -- the period of time from device 
> discovery to driver binding is long enough (because there's so much 
> other activity during bootup) that the device can autosuspend before 
> the driver is there to prevent it.
> 
> For well-behaved devices this wouldn't matter.  But unfortunately there 
> are lots of devices which break when they suspend.  That's why 
> level = auto is not the default.

is there any way to make it default if we know it works all the time?

Regards

Marcel



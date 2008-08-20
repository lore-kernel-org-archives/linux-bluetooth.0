Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Aug 2008 11:35:20 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
    Stefan Seyfried <seife@suse.de>,  <linux-bluetooth@vger.kernel.org>,
     <linux-usb@vger.kernel.org>
Subject: Re: [rfc/rft]power management for btusb
In-Reply-To: <1219245914.7591.338.camel@violet.holtmann.net>
Message-ID: <Pine.LNX.4.44L0.0808201132200.2806-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 20 Aug 2008, Marcel Holtmann wrote:

> finally I found the device and setting it to auto makes it actually
> suspend. Why is this not default? The driver has to enable it anyway.

If there's no driver then it would take effect right away.  This causes 
problems for devices during startup -- the period of time from device 
discovery to driver binding is long enough (because there's so much 
other activity during bootup) that the device can autosuspend before 
the driver is there to prevent it.

For well-behaved devices this wouldn't matter.  But unfortunately there 
are lots of devices which break when they suspend.  That's why 
level = auto is not the default.

Alan Stern

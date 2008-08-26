Return-Path: <cyrus@holtmann.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Stefan Seyfried <seife@suse.de>
Subject: Re: btusb hibernation/suspend breakage in current -git
Date: Tue, 26 Aug 2008 20:44:53 +0200
Cc: Oliver Neukum <oliver@neukum.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 linux-pm@lists.linux-foundation.org,
 linux-bluetooth@vger.kernel.org,
 Pavel Machek <pavel@suse.cz>,
 linux-usb@vger.kernel.org
References: <200808221520.19791.oliver@neukum.org> <200808261210.09665.rjw@sisk.pl> <20080826114138.GI32522@suse.de>
In-Reply-To: <20080826114138.GI32522@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808262044.54445.rjw@sisk.pl>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday, 26 of August 2008, Stefan Seyfried wrote:
> On Tue, Aug 26, 2008 at 12:10:08PM +0200, Rafael J. Wysocki wrote:
> > > Good. Can you test what happens if you unplug the device while suspended
> > > and hibernated?
> > 
> > It's built-in, I can't unplug it. :-)
> 
> Maybe you can disable it in the BIOS, but this might change the DSDT / other
> system configuration, so it might break resume in other ways :-(

There is a switch that's supposed to disable the radio (rfkill or something).
I used it to switch the radio off while the box was waking up from hibernation
and kbluetooth didn't find the adapter after the resume.  After I've pressed
the "radio off" button again, the bluetooth appears to be functional again.

However, this "radio off" button is shared between bluetooth and wireless
(b43) and there are some surprising interactions.  Nothing seems to be broken,
though.

Thanks,
Rafael

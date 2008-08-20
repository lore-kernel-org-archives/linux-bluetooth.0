Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rfc/rft]power management for btusb
Date: Wed, 20 Aug 2008 14:42:07 +0200
Cc: Pavel Machek <pavel@suse.cz>,
 Stefan Seyfried <seife@suse.de>,
 linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <200808201142.52620.oliver@neukum.org> <200808201405.19720.oliver@neukum.org> <1219235683.7591.326.camel@violet.holtmann.net>
In-Reply-To: <1219235683.7591.326.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808201442.08208.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Mittwoch 20 August 2008 14:34:43 schrieb Marcel Holtmann:
> Hi Oliver,
> 
> > > What are the semantics for usb_autopm_{get,put}_interface? Can we expect
> > > to always get a suspend() and resume() callback?
> > 
> > usb_autopm_get_interface() guarantees that after it returns successsfully
> > the interface (and teh device with it) remains unautosuspended until you
> > call usb_autopm_put_interface. The calls stack with a counter.
> > 
> > You'll get a resume() callback only if the device was actually suspended.
> 
> so a device didn't start out suspended? Too bad, otherwise you could cut
> the logic in the driver a lot.

Devices can have multiple interfaces. Therefore this guarantee is impossible.
 
> I tried to run this on my Quad G5, but I never see suspend() or resume()
> called. Do I have to do something to make autosuspend work?

echo "auto" > $(directry in sysfs for device)/power/level
And you'll see power events in syslog only if you compile with
CONFIG_USB_DEBUG

	Regards
		Oliver

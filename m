Return-Path: <cyrus@holtmann.org>
Subject: Re: [rfc/rft]power management for btusb
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: Pavel Machek <pavel@suse.cz>, Stefan Seyfried <seife@suse.de>,
	linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <200808201405.19720.oliver@neukum.org>
References: <200808201142.52620.oliver@neukum.org>
	 <1219227484.7591.318.camel@violet.holtmann.net>
	 <200808201405.19720.oliver@neukum.org>
Content-Type: text/plain
Date: Wed, 20 Aug 2008 14:34:43 +0200
Message-Id: <1219235683.7591.326.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> > What are the semantics for usb_autopm_{get,put}_interface? Can we expect
> > to always get a suspend() and resume() callback?
> 
> usb_autopm_get_interface() guarantees that after it returns successsfully
> the interface (and teh device with it) remains unautosuspended until you
> call usb_autopm_put_interface. The calls stack with a counter.
> 
> You'll get a resume() callback only if the device was actually suspended.

so a device didn't start out suspended? Too bad, otherwise you could cut
the logic in the driver a lot.

I tried to run this on my Quad G5, but I never see suspend() or resume()
called. Do I have to do something to make autosuspend work?

Regards

Marcel



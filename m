Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rfc/rft]power management for btusb
Date: Wed, 20 Aug 2008 14:05:19 +0200
Cc: Pavel Machek <pavel@suse.cz>,
 Stefan Seyfried <seife@suse.de>,
 linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <200808201142.52620.oliver@neukum.org> <1219227484.7591.318.camel@violet.holtmann.net>
In-Reply-To: <1219227484.7591.318.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808201405.19720.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Mittwoch 20 August 2008 12:18:04 schrieb Marcel Holtmann:
> Hi Oliver,
> 
> > this implements very simple power management for btusb.
> > Comments?
> 
> looks a little but too much.

How so?

> What are the semantics for usb_autopm_{get,put}_interface? Can we expect
> to always get a suspend() and resume() callback?

usb_autopm_get_interface() guarantees that after it returns successsfully
the interface (and teh device with it) remains unautosuspended until you
call usb_autopm_put_interface. The calls stack with a counter.

You'll get a resume() callback only if the device was actually suspended.

> So in open(), do we have to actually start the interrupt URB or can we
> just wait for resume() to be happening?

We have to start the URB.

> I don't wanna misuse the *_RUNNING bits. They are only there to make
> sure that we non re-submit the URBs.

Do you suggest making a copy of these bits at suspend() time?

	Regards
		Oliver

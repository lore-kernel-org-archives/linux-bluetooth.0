Return-Path: <cyrus@holtmann.org>
Subject: Re: [rfc/rft]power management for btusb
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: Pavel Machek <pavel@suse.cz>, Stefan Seyfried <seife@suse.de>,
	linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <200808201142.52620.oliver@neukum.org>
References: <200808201142.52620.oliver@neukum.org>
Content-Type: text/plain
Date: Wed, 20 Aug 2008 12:18:04 +0200
Message-Id: <1219227484.7591.318.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> this implements very simple power management for btusb.
> Comments?

looks a little but too much.

What are the semantics for usb_autopm_{get,put}_interface? Can we expect
to always get a suspend() and resume() callback?

So in open(), do we have to actually start the interrupt URB or can we
just wait for resume() to be happening?

I don't wanna misuse the *_RUNNING bits. They are only there to make
sure that we non re-submit the URBs.

Regards

Marcel



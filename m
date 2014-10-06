Return-Path: <cyrus@holtmann.org>
Message-ID: <1412598268.1132.15.camel@linux-0dmf.site>
Subject: Re: btusb_intr_complete returns -EPIPE
From: Oliver Neukum <oneukum@suse.de>
To: Naveen Kumar Parna <pnaveenkos@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-usb@vger.kernel.org
Date: Mon, 06 Oct 2014 14:24:28 +0200
In-Reply-To: <CAG0bkvK4-gfeYXXsdNg4BKdjxmo1e5d8rKuABohtYNNBHKJwDA@mail.gmail.com>
References: <CAG0bkvK4-gfeYXXsdNg4BKdjxmo1e5d8rKuABohtYNNBHKJwDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2014-10-06 at 17:05 +0530, Naveen Kumar Parna wrote:
> These errors will repeat until sending a proper HCI command on the USB
> bus. Again after some time duration same error will repeats.
> 
> The error -32(-EPIPE) says , Endpoint stalled.  For non-control
> endpoints, reset this status with usb_clear_halt().
> 
> But I don’t see the error(-EPIPE) handling code in btusb module. Does
> anyone has the patch for this scenario?

It really shouldn't stall without reason. We need to know which
transfers stall. A usbmon trace would show you.

	Regards
		Oliver



Return-Path: <cyrus@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <200808190903.05919.oliver@neukum.org>
References: <200807311452.24166.oliver@neukum.org>
	 <200808182326.48365.oliver@neukum.org>
	 <1219118754.7591.70.camel@violet.holtmann.net>
	 <200808190903.05919.oliver@neukum.org>
Content-Type: text/plain
Date: Tue, 19 Aug 2008 09:19:44 +0200
Message-Id: <1219130384.7591.83.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> > However when using the unlink version, this gives me spinlock lockup
> > (with and without your IRQ disable patch). From the backtrace it seems
> > that usb_unanchor_urb is calling spinlock_irq_save here.
> 
> This patch should fix it.

yes, that patch fixes it for me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Together with your IRQ disable patch, this should go into 2.6.27-rc4 and
it should also be submitted for 2.6.26-stable.

So do we have any chance to make usb_set_interface asynchron? For
example have the USB core queue submitted URBs until the new alternate
setting has been selected?

Regards

Marcel



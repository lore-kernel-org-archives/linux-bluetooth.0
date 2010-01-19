Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHes] Implement Bluetooth Wacom tablet's mode change in
 the kernel
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input <linux-input@vger.kernel.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	bgunn@solekai.com, Ping <pinglinux@gmail.com>
In-Reply-To: <1263833399.20565.2905.camel@localhost.localdomain>
References: <1263833399.20565.2905.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 18 Jan 2010 23:29:09 -0800
Message-ID: <1263886149.5591.166.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> Here's a patch to do the Bluetooth Wacom tablet's mode setting in the
> kernel. In the past, it was done in a patch in bluetootd.
> 
> The first patch is probably completely wrong. Right now,
> hid_output_raw_report is done on the intr socket, instead of the ctrl
> socket. If it's correct to do it on the intr socket, we'd need to add
> some API as a way to select the ctrl socket instead for use in that
> driver.

actually the interrupt should be incoming only. So moving the raw output
to the control channel seems fine to. Any reason why it is on the
interrupt channel in the first place?

Regards

Marcel



Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: bt dongle goes awry after too many connections
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAGxYWpZ8cfgtdO8ZX39cPBOs4OZ=PaO5pOHotjBt0u7HsnVXFA@mail.gmail.com>
Date: Mon, 2 Mar 2015 16:17:54 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6EDCDCB4-6F4D-4DE6-88DB-88D333FC2CCC@holtmann.org>
References: <CAGxYWpZ8cfgtdO8ZX39cPBOs4OZ=PaO5pOHotjBt0u7HsnVXFA@mail.gmail.com>
To: Tim Tisdall <tisdall@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tim,

> I have a "0a5c:21e8 Broadcom Corp.BCM20702A0 Bluetooth 4.0" usb
> bluetooth dongle I'm using to connect to multiple BLE devices.  It
> used to be that I could connect to 7 devices with no issues and then
> when I tried to connect to the 8th device I'd get a
> CONNECTION_LIMIT_EXCEEDED error.  In my code I would then tag that
> dongle as having a connection limit of 7 and limit the number of
> connections.
> 
> Recently I was using this code and found that it no longer works.  The
> dongle seems to "successfully" connect to ~13 devices but things don't
> work properly.  At least half of the devices no longer respond to GATT
> commands sent to it.  I issue a GATT command after connecting to each
> device to read some attributes and most simply do nothing (no error,
> no response, nothing).
> 
> Any way, I'm not really familiar with how things are laid out in the
> kernel so I'm not really sure where that CONNECTION_LIMIT_EXCEEDED was
> being created before and why it's no longer working as expected.  I
> tried looking through the git logs in "btusb" and "bluetooth" modules
> and didn't really see anything pertinent.

have to tried to install the firmware for the Broadcom dongle. It could be well that the firmware update fixes a few of these bugs with the LE connection behavior.

You can grab the firmware file from the Windows driver and use the hex2hcd utility to convert it into a format that the btusb.ko kernel driver understands.

Regards

Marcel


Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHes] Add sixpair
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1224083727.5268.3149.camel@cookie.hadess.net>
References: <1224083727.5268.3149.camel@cookie.hadess.net>
Content-Type: text/plain
Date: Thu, 16 Oct 2008 01:52:57 +0200
Message-Id: <1224114777.28173.41.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> Here are the patches to get sixpair support built into BlueZ. It uses
> libusb-1.0 as well as a yet to be merged libusb-1.0 patch to allow
> re-attaching a driver to a device.

so I applied all patches except the changes for the build system. I am
not sure that this is the right way to go.

If we require libusb-1.0, then we should just change our current code
that depends on libusb-0.1 and require libusb-1.0 for all of it.

> Problems left to solve:
> - sixaxis enabler code (as seen in enable_sixaxis() in compat/hidd.c)
> seems to have disappeared from the input plugin. Is that done in the
> kernel now, or was it just removed?

The kernel is not doing it. Seems to be an oversight.

> - After "cable pairing" the device, I need to unplug/replug the adapter,
> or restart bluetoothd. Can anyone think of a better way of getting the
> list of devices updated?

We could use inotify or SIGUSR2 or something to re-read the database.

> - Some minor niggles in the code itself (use D-Bus instead of parsing
> command-line tools)

Of course.

> - udev rule(s) and parsing only the selected device would be necessary
> if not required

If we can do this via the HID bus, then we can do it every time and it
would not affect the controller itself.

Regards

Marcel



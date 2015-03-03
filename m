Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6EDCDCB4-6F4D-4DE6-88DB-88D333FC2CCC@holtmann.org>
References: <CAGxYWpZ8cfgtdO8ZX39cPBOs4OZ=PaO5pOHotjBt0u7HsnVXFA@mail.gmail.com>
	<6EDCDCB4-6F4D-4DE6-88DB-88D333FC2CCC@holtmann.org>
Date: Tue, 3 Mar 2015 11:02:27 -0500
Message-ID: <CAGxYWpY0afTXOW1=jS1dmY7XBg3nR8a8itXiiiXdofKkhkyjKg@mail.gmail.com>
Subject: Re: bt dongle goes awry after too many connections
From: Tim Tisdall <tisdall@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 2, 2015 at 7:17 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Tim,
>
>> I have a "0a5c:21e8 Broadcom Corp.BCM20702A0 Bluetooth 4.0" usb
>
> have to tried to install the firmware for the Broadcom dongle. It could be well that the firmware update fixes a few of these bugs with the LE connection behavior.
>
> You can grab the firmware file from the Windows driver and use the hex2hcd utility to convert it into a format that the btusb.ko kernel driver understands.

We're not using the firmware and weren't using it before either.  Is
it possible there was some hack in place to prevent connecting to more
than 7 sensors and some update has removed that?  I couldn't find
anything in "btusb" or "bluetooth" module git logs, though.

Unfortunately, the kernel I'm having to use on my machine doesn't have
the changes in btusb where it loads the Broadcom firmware for my
device.  However, I just tried my code out on another machine with a
newer kernel (3.13 ubuntu 14.04) AND used the firmware and got the
same result, so I don't think the firmware would help in this
situation.

Without the firmware, the only "driver" that's used by the dongle is
btusb, right?  Or is that some sort of abstraction layer for something
else (a driver that doesn't care if it's usb, pci, etc)?

-Tim

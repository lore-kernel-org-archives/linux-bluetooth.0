Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: bt dongle goes awry after too many connections
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAGxYWpY0afTXOW1=jS1dmY7XBg3nR8a8itXiiiXdofKkhkyjKg@mail.gmail.com>
Date: Tue, 3 Mar 2015 08:19:57 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EC9E947B-7BEA-47D9-B546-F18208D4AE97@holtmann.org>
References: <CAGxYWpZ8cfgtdO8ZX39cPBOs4OZ=PaO5pOHotjBt0u7HsnVXFA@mail.gmail.com> <6EDCDCB4-6F4D-4DE6-88DB-88D333FC2CCC@holtmann.org> <CAGxYWpY0afTXOW1=jS1dmY7XBg3nR8a8itXiiiXdofKkhkyjKg@mail.gmail.com>
To: Tim Tisdall <tisdall@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tim,

>>> I have a "0a5c:21e8 Broadcom Corp.BCM20702A0 Bluetooth 4.0" usb
>> 
>> have to tried to install the firmware for the Broadcom dongle. It could be well that the firmware update fixes a few of these bugs with the LE connection behavior.
>> 
>> You can grab the firmware file from the Windows driver and use the hex2hcd utility to convert it into a format that the btusb.ko kernel driver understands.
> 
> We're not using the firmware and weren't using it before either.  Is
> it possible there was some hack in place to prevent connecting to more
> than 7 sensors and some update has removed that?  I couldn't find
> anything in "btusb" or "bluetooth" module git logs, though.
> 
> Unfortunately, the kernel I'm having to use on my machine doesn't have
> the changes in btusb where it loads the Broadcom firmware for my
> device.  However, I just tried my code out on another machine with a
> newer kernel (3.13 ubuntu 14.04) AND used the firmware and got the
> same result, so I don't think the firmware would help in this
> situation.
> 
> Without the firmware, the only "driver" that's used by the dongle is
> btusb, right?  Or is that some sort of abstraction layer for something
> else (a driver that doesn't care if it's usb, pci, etc)?

it is only btusb talking to the hardware. In the end it is just a transport layer. The real work happens in the Bluetooth core. However that said, we never had a limit on number of LE connections. Nothing there was ever enforced.

If you do not need BR/EDR, you can switch that off and it might free the radio resources you need for the many LE connections. However a 3.13 is not really getting you there. It might actually work there, but I would only trust a 3.18 or 3.19 kernel here.

Regards

Marcel


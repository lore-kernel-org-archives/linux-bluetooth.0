Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5d223510909040942u7ee2ae0ds96e1321b1fab24b9@mail.gmail.com>
References: <5d223510909040942u7ee2ae0ds96e1321b1fab24b9@mail.gmail.com>
Date: Mon, 14 Sep 2009 15:17:02 -0300
Message-ID: <e0ab60670909141117t697926f6gf309b1f24052162b@mail.gmail.com>
Subject: Re: choppy audio on ARM
From: Douglas Lopes Pereira <douglaslopespereira@gmail.com>
To: Rafael Seste <rseste@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Sep 4, 2009 at 1:42 PM, Rafael Seste <rseste@gmail.com> wrote:
>
> Hi all,
>
> A couple of months ago I sent a email about a problem with the
> bluetooth audio on a ARM platform. I have a choppy audio on the
> incoming stream. I still didn't solve this problem but I found a setup
> that this problem doesn't happens.
>
> My ARM device has only one USB port, so I always connect the BT dongle
> in this port. Last week I bought a USB hub and plug it into the usb
> and the BT dongle in the hub. Miraculously this problem disappeared. I
> removed the hub and tried again and the problem returns.
>
> Does anybody has any clue why the USB hub "fixed" this choppy audio???
> Does it use a different USB drivers?
>
> tks in advance
>
> --
> Rafael S. Seste
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

does anyone has more information on that?

I have the same scenario here. Same kernel modules loaded but audio
only works if my bluetooth dongle is connected on my external
self-powered USB Hub.

Check out dmesg output:

- Connecting bluetooth dongle over USB Hub:

usb 1-1: new high speed USB device using orion-ehci and address 19
usb 1-1: configuration #1 chosen from 1 choice
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
usb 1-1.3: new full speed USB device using orion-ehci and address 20
usb 1-1.3: configuration #1 chosen from 1 choice

- Connecting bluetooth directly on Sheeva Plug:

usb 1-1: new full speed USB device using orion-ehci and address 14
usb 1-1: configuration #1 chosen from 1 choice

The only difference is the high device speed device which is my USB Hub.

Can anyone help me to understand what is happening?

Thanks,
Douglas

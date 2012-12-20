Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121220091943.GA5862@x220>
References: <CAFOXTdcaRvGHesU_J7rW93Yp_5d438+x5xryCzAhY9QQL_-Y4Q@mail.gmail.com>
	<20121220080447.GA561@x220>
	<CAFOXTde8iSouGKEVZKG-egvPUr4LAyLnFigVa6avhpqTjXNq8A@mail.gmail.com>
	<20121220091943.GA5862@x220>
Date: Thu, 20 Dec 2012 10:27:15 +0100
Message-ID: <CAFOXTdf9qrtXD0GPDBFLhLX66QGQCgF_VzyS8WWz5xTAH8+0zQ@mail.gmail.com>
Subject: Re: Authentication Rejected when pairing stereo headset
From: Andrey Voropaev <voropaev.andrey@gmail.com>
To: Andrey Voropaev <voropaev.andrey@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Dec 20, 2012 at 10:19 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> First of all, please don't do top posting. It messes up the thread,
> especially when mixed with inline quoting.

Sorry. First time replying to list from gmail. Didn't pay attention to
that little mark at the bottom of the editor :)

> Actually the hcidump helped a lot. It shows an issue on the kernel side:
>
>  < HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9
>      bdaddr 00:1A:7D:25:2C:A4 capability 0x04 oob 0x00 auth 0x03
>      Capability: Reserved (OOB data not present)
>      Authentication: Dedicated Bonding (MITM Protection)
>  > HCI Event: Command Complete (0x0e) plen 10
>      IO Capability Request Reply (0x01|0x002b) ncmd 1
>      status 0x12 bdaddr 00:1A:7D:25:2C:A4
>      Error: Invalid HCI Command Parameters
>
> The IO capability value 0x04 that the kernel is responding with is
> invalid and shouldn't be sent to the controller. This was already fixed
> quite long time ago (about 1 year ago) by the following patch from
> Hemant Gupta: "Bluetooth: Send correct response to IO Capability Request"
>
> It adds the following code to the IO capability handling to avoid 0x04
> from being sent:
>
>         /* Change the IO capability from KeyboardDisplay
>          * to DisplayYesNo as it is not supported by BT spec. */
>         cp.capability = (conn->io_capability == 0x04) ?
>                                         0x01 : conn->io_capability;
>
> It seems however that your kernel is missing this patch and the right
> way forward would be to include it.

I'm using Gentoo with "stable" version 3.5.7. Can you please tell me
which file shall contain this patch? I'll try to find "development"
version of kernel that contains it.

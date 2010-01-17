Return-Path: <cyrus@holtmann.org>
Subject: Re: max 16 hci devices on usb 2.0
From: Marcel Holtmann <marcel@holtmann.org>
To: Bram Jansen <bramsbox@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <BABDE7A517704C42BC70E146983535B6@radon>
References: <BABDE7A517704C42BC70E146983535B6@radon>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 16 Jan 2010 17:44:23 -0800
Message-ID: <1263692663.5591.54.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bram,

> I have a question regarding the connection of 16 hci devices to a linux box.
> I've been looking around for quite some time and I was not able to find
> something useful, therefore I hope anyone of you guys is able to point me in
> the right direction.
> 
> We have used quite a few kernel versions to try to connect 16 hci devices to
> one system with usb 2.0 enabled.
> This gives a problem after 7 devices. Devices hci7-hci15 give timeouts and
> errors after initializing.
> 
> We solved this problem by disabling ehci in the kernel, so the bluetooth had
> to use usb 1.1 (ohci)
> with these settings it works without any problems and all 16 hci devices are
> initialized properly after insertion/boot
> 
> now there has come the need for usb 2.0 on the same system.
> 
> Is there a known solution for this issue?

you better ask such questions on the Linux USB mailing list since I have
no idea why sometimes the hubs causes problems.

As a side note. The 16 HCI devices limit is not fixed actually. You can
just compile your own libbluetooth with a different limit. The kernel
supports as many devices as you have memory :)

Regards

Marcel



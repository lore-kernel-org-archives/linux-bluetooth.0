Return-Path: <jerome.debretagne@gmail.com>
Message-ID: <1473111620.4063.29.camel@gmail.com>
Subject: Re: btattach: auto triggering at boot time by Linux distributions
From: =?ISO-8859-1?Q?J=E9r=F4me?= de Bretagne <jerome.debretagne@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 05 Sep 2016 23:40:20 +0200
In-Reply-To: <72B34103-D15B-463B-B63B-8DD3CE99D712@holtmann.org>
References: 
	<CA+kEDGFm2jko+bC+DuPK1qQx5OXJZTXUj=aWdk+rm9RC8DDCOA@mail.gmail.com>
	 <72B34103-D15B-463B-B63B-8DD3CE99D712@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> the real evolution would be that we get a serial bus (as discussed a
> few weeks ago) which then the UART kernel drivers can enumerate its
> devices on.

I've read this discussion, thanks for the pointer, and I've seen the
latest patch set proposal from Rob Herring reusing the existing serio
bus. 

If I understood correctly, you would like to stop exposing /dev/ttyX
for Bluetooth UART drivers in the long run. Would it mean that the
user-space btattach will then be deprecated and the firmware loading
will be moved into the kernel itself? Or another approach instead?

> Until then, you need an userspace part that triggers btattach with
> the right hardware id on the right /dev/ttySx device node as soon as
> it becomes available. So that means udev rules.

Great, I will investigate the udev rules direction.

>  However the problem is and always has been to figure out what
> hardware is behind what /dev/ttySx. If you are lucky it is part of
> ACPI tables or DT. If you are unlucky you need a DT overlay or
> hardcode it.

I faced that precise limitation when I was trying to find out what was
the chipset ACPI ID on the ThinkPad 8 tablet, to guess which btattach
parameter to use. And I don't remember finding it in the ACPI tables :(

I fear I will have to hardcode it to get started, and then investigate
the usage of a DT overlay in a second step.

Regards,
Jérôme

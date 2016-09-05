Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: btattach: auto triggering at boot time by Linux distributions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1473111620.4063.29.camel@gmail.com>
Date: Mon, 5 Sep 2016 15:31:12 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7D06FCA8-A64C-4437-BEE2-5BA0D1C2F030@holtmann.org>
References: <CA+kEDGFm2jko+bC+DuPK1qQx5OXJZTXUj=aWdk+rm9RC8DDCOA@mail.gmail.com> <72B34103-D15B-463B-B63B-8DD3CE99D712@holtmann.org> <1473111620.4063.29.camel@gmail.com>
To: =?utf-8?Q?J=C3=A9r=C3=B4me_de_Bretagne?=
        <jerome.debretagne@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerome,

>> the real evolution would be that we get a serial bus (as discussed a
>> few weeks ago) which then the UART kernel drivers can enumerate its
>> devices on.
> 
> I've read this discussion, thanks for the pointer, and I've seen the
> latest patch set proposal from Rob Herring reusing the existing serio
> bus. 
> 
> If I understood correctly, you would like to stop exposing /dev/ttyX
> for Bluetooth UART drivers in the long run. Would it mean that the
> user-space btattach will then be deprecated and the firmware loading
> will be moved into the kernel itself? Or another approach instead?

firmware loading is already in the kernel. At least for Broadcom and Intel based devices.

>> Until then, you need an userspace part that triggers btattach with
>> the right hardware id on the right /dev/ttySx device node as soon as
>> it becomes available. So that means udev rules.
> 
> Great, I will investigate the udev rules direction.
> 
>> However the problem is and always has been to figure out what
>> hardware is behind what /dev/ttySx. If you are lucky it is part of
>> ACPI tables or DT. If you are unlucky you need a DT overlay or
>> hardcode it.
> 
> I faced that precise limitation when I was trying to find out what was
> the chipset ACPI ID on the ThinkPad 8 tablet, to guess which btattach
> parameter to use. And I don't remember finding it in the ACPI tables :(
> 
> I fear I will have to hardcode it to get started, and then investigate
> the usage of a DT overlay in a second step.

I do not have the ACPI tables available, but the kernel drivers will map the ACPI ID. So if you look into hci_bcm.c or hci_intel.c you should find the ones. Each chip should have a new ACPI ID on Intel platforms.

Regards

Marcel


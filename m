Return-Path: <loic.poulain@intel.com>
Message-ID: <56DD4CEF.3070300@intel.com>
Date: Mon, 07 Mar 2016 10:42:07 +0100
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?=
 <jerome.debretagne@gmail.com>, Ilya Faenson <ilya.faenson@broadcom.com>,
 linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Broadcom BCM4324(1) rev B5 chipset - Bluetooth support in Linux
 Kernel 4.x ?
References: <CA+kEDGEHfsODon6aOdLU86E9c0Lfs-4bo=ycEZz3MdEa1qLrKw@mail.gmail.com> <56CAD20D.4080609@broadcom.com> <CA+kEDGFX31qxxDsFYR-vdcb1UhH65xoZ0sxKcY9xFxC_J=GNfQ@mail.gmail.com> <56D35080.1010003@intel.com> <CA+kEDGHbzH9VPRUaz5-JPsU5kHTDk8UwGGmt94rGVXiG1KY-Ow@mail.gmail.com> <56D37BAC.6090907@intel.com> <CA+kEDGHz=V+BBxbnQDDKwNgLUFjj_9p85DepRSqArRJUzbyusQ@mail.gmail.com>
In-Reply-To: <CA+kEDGHz=V+BBxbnQDDKwNgLUFjj_9p85DepRSqArRJUzbyusQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerome,

> Maybe this is a naive question about ACPI ID, and not specific to
> Broadcom by the way: could there be a more generic way to gather ACPI
> IDs used by new devices and add them to the kernel on a regular basis?
> They seem to be added almost one by one mainly upon user reports when
> looking at the mailing list. So Bluetooth doesn't work out-of-the-box
> on some systems which would be compatible otherwise, especially the
> less popular ones. Is there no existing driver list to re-use perhaps?

New ACPI ID means that this is a different hardware. So it needs to be
tested before being added into the driver supported list. An already
supported hardware should keep the same ACPI ID, making it work out-of
the-box.

Since this driver is pretty new, this is not surprising that some IDs
are regularly added. This is a good thing. Meaning that people use this
driver and that Broadcom controllers keep good compatibility across
hardware versions.

> Indeed, it is working fine with ttyS1 and the correct binary firmware
> stored at /lib/firmware/brcm/BCM.hcd:
>
>     # btattach -B /dev/ttyS1 -P bcm
>     Attaching BR/EDR controller to /dev/ttyS1
>     Switched line discipline from 0 to 15
>     Device index 0 attached
>
> Finally, is btattach the only command recommended and supported moving
> forward, or should hciattach work as well with that specific
> chipset/tablet (as a transition until most Linux distros switch to
> btattach)?

Absolutely, think btattach is the only recommended way.
Even if you can make it work with hciattach by adding device entry with
correct protocol ID, it is not recommended since hciattach is dedicated
to user-space initialisation (old-way) and code is pretty deprecated.

Regards,
Loic

-- 
Intel Open Source Technology Center
http://oss.intel.com/

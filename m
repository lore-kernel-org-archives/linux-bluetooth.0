Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: btattach: auto triggering at boot time by Linux distributions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+kEDGFm2jko+bC+DuPK1qQx5OXJZTXUj=aWdk+rm9RC8DDCOA@mail.gmail.com>
Date: Sun, 4 Sep 2016 12:30:59 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <72B34103-D15B-463B-B63B-8DD3CE99D712@holtmann.org>
References: <CA+kEDGFm2jko+bC+DuPK1qQx5OXJZTXUj=aWdk+rm9RC8DDCOA@mail.gmail.com>
To: =?utf-8?Q?J=C3=A9r=C3=B4me_de_Bretagne?=
        <jerome.debretagne@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerome,

> From a Linux distribution point of view, what part of the stack is
> expected (or would you recommend) to trigger the user-space btattach
> command, to have Bluetooth enabled automatically at boot?
> 
> On an older computer, hot-plugging a Bluetooth USB adapter starts
> Bluetooth automatically. On a ThinkPad 8 tablet, a manual btattach
> command is currently needed to attach the hardware and load the
> firmware for its Broadcom chip.
> 
> What do distro maintainers need to adapt to achieve the equivalent of
> the USB auto-loading case for btattach-based chipsets, now that
> btattach is starting to be included in some Linux distributions (such
> as in Debian following this report:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=816865 even if only
> in experimental right now)?
> 
> Is it an already planned evolution on BlueZ side? Reading through the
> mailing list, it doesn't seem to be the case but I may have missed a
> discussion.
> 
> If not, any hints would be really appreciated, and especially your
> view on which SW component would be a good candidate to take care of
> this initialization task. Thanks a lot.

the real evolution would be that we get a serial bus (as discussed a few weeks ago) which then the UART kernel drivers can enumerate its devices on.

Until then, you need an userspace part that triggers btattach with the right hardware id on the right /dev/ttySx device node as soon as it becomes available. So that means udev rules. However the problem is and always has been to figure out what hardware is behind what /dev/ttySx. If you are lucky it is part of ACPI tables or DT. If you are unlucky you need a DT overlay or hardcode it.

The pain point is really that the kernel has all the information we need. Except people kept insisting on creating /dev/ttySx devices and let someone else deal with the fact that it is an actual Bluetooth chip behind it.

That said, it has gotten better when we moved power control into the Intel and Broadcom drivers. Which means you no longer need to fiddle with RFKILL to get your GPIOs set up. That was a huge mess as well when people though we just expose the power control of the TTY as RFKILL switches and leave userspace totally in the dark and jump through 10 hoops before getting things working.

Regards

Marcel


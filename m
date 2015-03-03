Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: Why is interleaved scan interleaved ? Can I fix that to do LE and classic at same time ?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD0=r8w9MhKKm8isLY0+3SH0kxBd91z3HiOwpPp_j8fQFnirgw@mail.gmail.com>
Date: Mon, 2 Mar 2015 16:25:29 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <CB23EFA5-1D60-4658-BAAE-8C666AE22052@holtmann.org>
References: <CAD0=r8wZdzJBVq3f9j9iJJOZw2T0JwNiKxto13p9MSR7uL_Ziw@mail.gmail.com> <EE319A64-C3DB-49C5-A87A-BAF245159907@holtmann.org> <CAD0=r8w9MhKKm8isLY0+3SH0kxBd91z3HiOwpPp_j8fQFnirgw@mail.gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

>>> When I do interleaved scan on linux, it's doing LE first, for around
>>> 10 seconds, and then Classic scan for another few seconds on kernel
>>> level.
>>> 
>>> I was playing with Bluetooth on macbook, and noticed that they do both
>>> LE and Classic scan at once. So I tried modifying kernel, I triggered
>>> both LE and classic scan at once by queuing both
>>> HCI_OP_LE_SET_SCAN_ENABLE, and HCI_OP_INQUIRY and it just worked, both
>>> LE and Classic devices were reported.
>>> 
>>> I tested that with CSR, Broadcom and Atheros chips, and all behaved well.
>>> 
>>> Is there any reason why we do interleave instead of both scans at once ?
>> 
>> actually there are chips that do not support BR/EDR inquiry and LE scan at the same time. So for some chips we need this behavior. I think that all chips in platforms running Windows 8 will actually support simultaneous BR/EDR inquiry and LE scan since Microsoft mandated it. However in the embedded SoC world that might not be true actually.
>> 
>> And in the early days of LE, there was almost no chip that was able to handle BR/EDR inquiry and LE scan at the same time. That is why the interleaved behavior exists in the first place.
>> 
>>> I would be more than happy to modify 'interleaved' behaviour, to do
>>> both LE and classic scan at same time.
>> 
>> Introduce HCI_QUIRK_SIMULTAENOUS_DISCOVERY and allow for well know good behaving controller to set it. That way we can slowly move into that direction and keep interleaved behavior as a fallback.
>> 
>> Regards
>> 
>> Marcel
>> 
> 
> So I send my patches previous week, and I just uploaded new version.
> The old version was just starting both scans at once. It was working
> on Atheros, CSR, and Broadcom, but then I find out it doesn't work on
> Intel controllers.

I know for certain that there are some older Atheros controllers that did not support simultaneous service discovery. And I think certain Qualcomm hardware doesn't do either. That might be all fixed now and it might be supported starting certain controller or firmware version, but that is something that should come from the vendor in the end.

> The reason for that was LE scan window equal to LE scan interval. When
> I doubled Scan Interval, Intel devices started working. Apparently
> other controllers don't really care.

Can you be more specific which Intel controllers. We have more than one and also different firmware patches for them. We might need to test this a bit more.

> So now it works on all controllers I have tested with.
> 
> I have however question about Broadcom:
> Simultaenous scan work, when there is firmware patch in /lib/firmware
> (ubuntu have it). If the patch is not present it's not working. Can I
> somehow make this kind of check in btusb.c to set the quirk ?

You can set this quirk from within hdev->setup(). However this is dangerous if it is a maybe thing. In these cases it might be better to keep off. Or actually tie it to firmware build numbers that have been tested to work. You can get the firmware build numbers from the HCI revision information. That it works on one Broadcom controllers does not mean it works on all of them.

> I also have question about scan window and interval: right now I just
> doubled scan interval. This gives more than 12ms of free time that
> BR/EDR scan would use to do inquiry. I fund in spec (Version 4.2 [Vol
> 2, Part E] 6.2 and 6.3) that default Inquiry_Scan_Window is 11.25ms,
> so this should work good. Do you have any suggestions to tune those
> parameters in other way ?

Actually inside the kernel we can not just pick new values. They are driven by the Set Scan Parameters management command. So we need to obey to what userspace gave us.

Regards

Marcel


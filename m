Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: Why is interleaved scan interleaved ? Can I fix that to do LE and classic at same time ?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD0=r8wZdzJBVq3f9j9iJJOZw2T0JwNiKxto13p9MSR7uL_Ziw@mail.gmail.com>
Date: Tue, 24 Feb 2015 19:18:29 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <EE319A64-C3DB-49C5-A87A-BAF245159907@holtmann.org>
References: <CAD0=r8wZdzJBVq3f9j9iJJOZw2T0JwNiKxto13p9MSR7uL_Ziw@mail.gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> When I do interleaved scan on linux, it's doing LE first, for around
> 10 seconds, and then Classic scan for another few seconds on kernel
> level.
> 
> I was playing with Bluetooth on macbook, and noticed that they do both
> LE and Classic scan at once. So I tried modifying kernel, I triggered
> both LE and classic scan at once by queuing both
> HCI_OP_LE_SET_SCAN_ENABLE, and HCI_OP_INQUIRY and it just worked, both
> LE and Classic devices were reported.
> 
> I tested that with CSR, Broadcom and Atheros chips, and all behaved well.
> 
> Is there any reason why we do interleave instead of both scans at once ?

actually there are chips that do not support BR/EDR inquiry and LE scan at the same time. So for some chips we need this behavior. I think that all chips in platforms running Windows 8 will actually support simultaneous BR/EDR inquiry and LE scan since Microsoft mandated it. However in the embedded SoC world that might not be true actually.

And in the early days of LE, there was almost no chip that was able to handle BR/EDR inquiry and LE scan at the same time. That is why the interleaved behavior exists in the first place.

> I would be more than happy to modify 'interleaved' behaviour, to do
> both LE and classic scan at same time.

Introduce HCI_QUIRK_SIMULTAENOUS_DISCOVERY and allow for well know good behaving controller to set it. That way we can slowly move into that direction and keep interleaved behavior as a fallback.

Regards

Marcel


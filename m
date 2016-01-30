Return-Path: <jjmeijer88@gmail.com>
MIME-Version: 1.0
In-Reply-To: <EB5B11A1-B0CC-4C3D-92F3-689BA44D158F@holtmann.org>
References: <1453707843-92704-1-git-send-email-marcel@holtmann.org>
 <20160127154921.GA13196@t440s> <CAA+NYvQ35ZoSRy8dEfctXWpfkAN4NuckFnMobdcwjW4hS7ei0g@mail.gmail.com>
 <EB5B11A1-B0CC-4C3D-92F3-689BA44D158F@holtmann.org>
From: Jaap Jan Meijer <jjmeijer88@gmail.com>
Date: Sat, 30 Jan 2016 16:00:55 +0100
Message-ID: <CAA+NYvS2nkSP=Qxx4yBv1cqYzDpgv4oR+dW+dD___gWcgyyNjQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add missing COMPATIBLE_IOCTL for UART line discipline
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

After doing a proper build it indeed was not necessary to apply the
second patch. Sorry about that, lesson learned.


Regards,

J.J.

2016-01-29 11:44 GMT+01:00 Marcel Holtmann <marcel@holtmann.org>:
> Hi Jaap,
>
>> Could you please also add
>> "[PATCH] Bluetooth: hci_ldisc: Add support for compat_ioctl handling"
>> to get proper ioctl compat functionality?
>>
>> Many thanks in advance,
>
> are you sure that is really needed? I do wonder why we need that. At least with COMPATIBLE_IOCTL the error message should actually change. Can you trace how far we get in the code path.
>
> Regards
>
> Marcel
>

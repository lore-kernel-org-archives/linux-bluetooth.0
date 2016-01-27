Return-Path: <jjmeijer88@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20160127154921.GA13196@t440s>
References: <1453707843-92704-1-git-send-email-marcel@holtmann.org> <20160127154921.GA13196@t440s>
From: Jaap Jan Meijer <jjmeijer88@gmail.com>
Date: Thu, 28 Jan 2016 00:09:01 +0100
Message-ID: <CAA+NYvQ35ZoSRy8dEfctXWpfkAN4NuckFnMobdcwjW4hS7ei0g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add missing COMPATIBLE_IOCTL for UART line discipline
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

Could you please also add
"[PATCH] Bluetooth: hci_ldisc: Add support for compat_ioctl handling"
to get proper ioctl compat functionality?

Many thanks in advance,

J.J.

2016-01-27 16:49 GMT+01:00 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi Marcel,
>
> On Mon, Jan 25, 2016, Marcel Holtmann wrote:
>> The HCIUARTGETDEVICE, HCIUARTSETFLAGS and HCIUARTGETFLAGS ioctl are
>> missing the COMPATIBLE_IOCTL declaration.
>>
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>>  fs/compat_ioctl.c | 3 +++
>>  1 file changed, 3 insertions(+)
>
> Applied to bluetooth.git. Thanks.
>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Return-Path: <cyrus@holtmann.org>
Message-ID: <54BABE91.8020609@gmail.com>
Date: Sat, 17 Jan 2015 22:57:05 +0300
From: Dmitry Tunin <hanipouspilot@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] ath3k: Add support of AR3012 bluetooth 13d3:3423 device
References: <54B98679.5060104@gmail.com> <2E4EB7E1-D16C-4633-8E86-337D42190298@holtmann.org> <54BA1CC9.8060601@gmail.com> <F80A6947-61FA-46A1-8742-51129F4E18C3@holtmann.org>
In-Reply-To: <F80A6947-61FA-46A1-8742-51129F4E18C3@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Any ideas what may be wrong? Is the tree URL correct or there is another bluetooth-next branch I dot know about?
I just clean cloned it again and applied with no problem.

17.01.2015 21:59, Marcel Holtmann пишет:
> Hi Dmitry,
>
> please do not top post on this mailing list.
>
>> This patch is against git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
>> Or is it another branch?
>>
>> I pulled it again, but still no changes. Why it can be?
>
> it neither applies with git am, nor manually running patch.
>
> checking file drivers/bluetooth/ath3k.c
> Hunk #1 FAILED at 108.
> Hunk #2 FAILED at 162.
> 2 out of 2 hunks FAILED
> checking file drivers/bluetooth/btusb.c
> Hunk #1 FAILED at 189.
> 1 out of 1 hunk FAILED
>
> Regards
>
> Marcel
>

Return-Path: <cyrus@holtmann.org>
Message-ID: <4D357014.8020600@atheros.com>
Date: Tue, 18 Jan 2011 16:18:52 +0530
From: Bala Shanmugam <sbalashanmugam@atheros.com>
MIME-Version: 1.0
To: Alexander Holler <holler@ahsoftware.de>
CC: "Gustavo F. Padovan" <padovan@profusion.mobi>, Marcel Holtmann
	<marcel@holtmann.org>, SongXing Xu <SongXing.Xu@Atheros.com>, Luis Rodriguez
	<Luis.Rodriguez@Atheros.com>, Vikram Kandukuri
	<Vikram.Kandukuri@Atheros.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] ath3k: reduce memory usage
References: <1290456541-3812-1-git-send-email-holler@ahsoftware.de> <20110113190800.GA13675@vigoh> <4D2F6DE5.5090109@ahsoftware.de>
In-Reply-To: <4D2F6DE5.5090109@ahsoftware.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 1/14/2011 2:55 AM, Alexander Holler wrote:
> Hello,
>
> On 13.01.2011 20:08, Gustavo F. Padovan wrote:
>> Hi Alexander,
>>
>> * Alexander Holler<holler@ahsoftware.de>   [2010-11-22 21:09:01 +0100]:
>>
>>> There is no need to hold the firmware in memory.
>>>
>>> Signed-off-by: Alexander Holler<holler@ahsoftware.de>
>>> ---
>>>    drivers/bluetooth/ath3k.c |   75 ++++++++++++---------------------------------
>>>    1 files changed, 20 insertions(+), 55 deletions(-)
>> I'm assuming you tested it a lot. Patch has been applied. Thanks.
> Yes, I'm using it here haven't had a problem with that patch.
>
> Thanks,
>
> Alexander
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Thanks Alex for the patch.
Its working.

Regards,
Bala.

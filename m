Return-Path: <cyrus@holtmann.org>
Message-ID: <4D2F6DE5.5090109@ahsoftware.de>
Date: Thu, 13 Jan 2011 22:25:57 +0100
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
CC: Marcel Holtmann <marcel@holtmann.org>, Alicke Xu <sxu@atheros.com>,
 "Luis R. Rodriguez" <lrodriguez@atheros.com>,
 Vikram Kandukuri <vikram.kandukuri@atheros.com>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] ath3k: reduce memory usage
References: <1290456541-3812-1-git-send-email-holler@ahsoftware.de> <20110113190800.GA13675@vigoh>
In-Reply-To: <20110113190800.GA13675@vigoh>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

On 13.01.2011 20:08, Gustavo F. Padovan wrote:
> Hi Alexander,
>
> * Alexander Holler<holler@ahsoftware.de>  [2010-11-22 21:09:01 +0100]:
>
>> There is no need to hold the firmware in memory.
>>
>> Signed-off-by: Alexander Holler<holler@ahsoftware.de>
>> ---
>>   drivers/bluetooth/ath3k.c |   75 ++++++++++++---------------------------------
>>   1 files changed, 20 insertions(+), 55 deletions(-)
>
> I'm assuming you tested it a lot. Patch has been applied. Thanks.

Yes, I'm using it here haven't had a problem with that patch.

Thanks,

Alexander

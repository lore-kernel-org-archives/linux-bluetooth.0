Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1344319961.2083.41.camel@aeonflux>
References: <1344316065-2032-1-git-send-email-sachin.kamat@linaro.org>
	<1344319961.2083.41.camel@aeonflux>
Date: Thu, 23 Aug 2012 20:46:32 +0530
Message-ID: <CAK9yfHwbx5R7h8UjGfcZEN=oijbddNNi--BrXWVuK_+p_JF4yw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Use module_platform_driver() in btwilink.c file
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

Looks like the following patch is missed out from your tree.



On 7 August 2012 11:42, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Sachin,
>
>> module_platform_driver() makes the code simpler by eliminating module_init
>> and module_exit calls.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>> This patch is based on bluetooth-next tree and is compile tested.
>> ---
>>  drivers/bluetooth/btwilink.c |   16 +---------------
>>  1 files changed, 1 insertions(+), 15 deletions(-)
>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
>
> Regards
>
> Marcel
>
>



-- 
With warm regards,
Sachin

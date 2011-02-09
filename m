Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110209134740.GA2597@joana>
References: <1297253680-4412-1-git-send-email-pavan_savoy@ti.com>
	<20110209134740.GA2597@joana>
Date: Wed, 9 Feb 2011 19:19:05 +0530
Message-ID: <AANLkTi=ZFP4b2fe6howMR3cb8yHs=+eJnVWqTA33Vu-f@mail.gmail.com>
Subject: Re: [PATCH v10] Bluetooth: btwilink driver
From: Pavan Savoy <pavan_savoy@ti.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Feb 9, 2011 at 7:17 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi Pavan,
>
> * pavan_savoy@ti.com <pavan_savoy@ti.com> [2011-02-09 06:14:40 -0600]:
>
>> From: Pavan Savoy <pavan_savoy@ti.com>
>>
>> Gustavo,
>>
>> reposting v10,
>> fixing the really long goto label.
>> (from Ville) moving the reg_status before register.
>>
>> Find below the patch version v9.
>> Have taken care of Ville's comments.
>> In addition fixed the issue seen when built as module, with
>> repeated probe/remove of the platform driver.
>>
>> patch v8 comments taken care,
>>
>> As suggested, the modifications to TI ST driver to remove the bluetooth
>> references have been made and the changes have been merged to the
>> linux-next tree.
>>
>> Find below the patch for the btwilink driver,
>> I have taken care of your following comments,
>> 1. channel IDs and the offsets are now being taken from the
>> header file hci.h.
>> 2. removed the un-necessary BT_ERR.
>> 3. changed the order during return from st_register.
>> 4. continue to unregister even if 1st unregister fails.
>>
>> Please review and provide comments,
>>
>> Thanks & Regards,
>> Pavan Savoy
>>
>> -- patch description --
>>
>> This is the bluetooth protocol driver for the TI WiLink7 chipsets.
>> Texas Instrument's WiLink chipsets combine wireless technologies
>> like BT, FM, GPS and WLAN onto a single chip.
>>
>> This Bluetooth driver works on top of the TI_ST shared transport
>> line discipline driver which also allows other drivers like
>> FM V4L2 and GPS character driver to make use of the same UART interface.
>>
>> Kconfig and Makefile modifications to enable the Bluetooth
>> driver for Texas Instrument's WiLink 7 chipset.
>>
>> Signed-off-by: Pavan Savoy <pavan_savoy@ti.com>
>> ---
>>  drivers/bluetooth/Kconfig    |   10 +
>>  drivers/bluetooth/Makefile   |    1 +
>>  drivers/bluetooth/btwilink.c |  395 ++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 406 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/bluetooth/btwilink.c
>
> Look good to me now. ;)

Thanks.

> The patch need to go through Greg's tree, together with the modifications in
> the core driver. Then,
>
> Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

So, I post it to lkml (& greg) now - to get it merged into his tree correct ?


> --
> Gustavo F. Padovan
> http://profusion.mobi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

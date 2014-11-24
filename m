Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        Xinming Hu <huxm@marvell.com>, Cathy Luo
	<cluo@marvell.com>,
        Avinash Patil <patila@marvell.com>
Date: Mon, 24 Nov 2014 01:55:45 -0800
Subject: RE: [RESEND PATCH v3] Bluetooth: btmrvl add firmware dump support
Message-ID: <5FF020A1CFFEEC49BD1E09530C4FF5951B15A83042@SC-VEXCH1.marvell.com>
References: <1416498414-9583-1-git-send-email-akarwar@marvell.com>
 <1596A22A-E632-4C05-9233-3907AE41EBCE@holtmann.org>
In-Reply-To: <1596A22A-E632-4C05-9233-3907AE41EBCE@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Thanks for your comments.

>> +
>> +	if (result)
>> +		btmrvl_firmware_dump(priv);
>> +	else
>> +		return -EINVAL;
>
>lets turn this around.
>
>	if (!result)
>		return -EINVAL;
>
>	btmrvl_firmware_dump(priv);
>
>Doing it this way makes it a lot easier to read.

Sure. We will take care of this in updated version.

>> a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
>> index 38ad662..389e6f1 100644
>> --- a/drivers/bluetooth/btmrvl_drv.h
>> +++ b/drivers/bluetooth/btmrvl_drv.h
>> @@ -22,6 +22,7 @@
>> #include <linux/kthread.h>
>> #include <linux/bitops.h>
>> #include <linux/slab.h>
>> +#include <linux/devcoredump.h>
>
>I overlooked this before. Why does this include need to be in the header
>file?
>

We will move this check to btmrvl_sdio.c where "dev_coredumpv()" API has be=
en used.

>> #include "btmrvl_drv.h"
>> #include "btmrvl_sdio.h"
>> @@ -335,6 +336,14 @@ int btmrvl_prepare_command(struct btmrvl_private
>*priv)
>> 	return ret;
>> }
>>
>> +void btmrvl_firmware_dump(struct btmrvl_private *priv) {
>> +	if (priv->firmware_dump)
>> +		priv->firmware_dump(priv);
>> +	else
>> +		BT_ERR("firmware dump error : not defined!\n"); }
>
>Actually coming to think about it, it would be better to not expose the
>debugfs entry if the firmware_dump callback is not defined. Is it
>possible to change that code that way?
>

Yes. This error message is redundant. We need to get rid of it to avoid exp=
osing debugfs entry.

>> +
>> +		}
>> +
>> +		BT_INFO("%s\n", buf);
>
>I do not think that BT_INFO etc. functions need the \n at the end. You
>might want to fix that in the code for all places.
>

We will prepare a separate patch to fix this in existing code and update fi=
rmware dump support patch accordingly.

Regards,
Amitkumar

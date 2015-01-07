Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>,
        Cathy Luo
	<cluo@marvell.com>
Date: Tue, 6 Jan 2015 21:36:53 -0800
Subject: RE: [PATCH] Bluetooth: btmrvl: fix card reset and suspend race issue
Message-ID: <5FF020A1CFFEEC49BD1E09530C4FF5951B1617963E@SC-VEXCH1.marvell.com>
References: <1420538205-12901-1-git-send-email-akarwar@marvell.com>
 <AFEE3FAB-C05E-4F2F-873F-28061AB962F9@holtmann.org>
In-Reply-To: <AFEE3FAB-C05E-4F2F-873F-28061AB962F9@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>
>Hi Amitkumar,
>
>> Sometimes suspend thread queues a command and wait for it's response,
>> meanwhile WLAN driver power cycles the card which leads to crash. This
>> patch makes sure that suspend thread is woken up in remove path.
>>
>> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
>> ---
>> drivers/bluetooth/btmrvl_main.c | 11 ++++++++---
>> 1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btmrvl_main.c
>> b/drivers/bluetooth/btmrvl_main.c index c4a542c..27fa98f 100644
>> --- a/drivers/bluetooth/btmrvl_main.c
>> +++ b/drivers/bluetooth/btmrvl_main.c
>> @@ -207,10 +207,14 @@ static int btmrvl_send_sync_cmd(struct
>btmrvl_private *priv, u16 opcode,
>> 	wake_up_interruptible(&priv->main_thread.wait_q);
>>
>> 	if (!wait_event_interruptible_timeout(priv->adapter->cmd_wait_q,
>> -				priv->adapter->cmd_complete,
>> +				priv->adapter->cmd_complete ||
>> +				priv->surprise_removed,
>> 				msecs_to_jiffies(WAIT_UNTIL_CMD_RESP)))
>
>I know that even before this patch the coding style was off, but please
>do not make it worse. So lets fix the coding style here as well.
>
>> 		return -ETIMEDOUT;
>>
>> +	if (priv->surprise_removed)
>> +		return -EFAULT;
>> +
>> 	return 0;
>> }
>>
>> @@ -292,9 +296,10 @@ int btmrvl_enable_hs(struct btmrvl_private *priv)
>> 	}
>>
>> 	ret =3D wait_event_interruptible_timeout(adapter->event_hs_wait_q,
>> -					       adapter->hs_state,
>> +					       adapter->hs_state ||
>> +					       priv->surprise_removed,
>> 			msecs_to_jiffies(WAIT_UNTIL_HS_STATE_CHANGED));
>
>Same here. I would have the mecs_to_jiffies in the constant declaration.
>

Thanks for your comments. I will create a separate patch to move mecs_to_ji=
ffies to macro definition and coding style and send updated version.

BR,
Amit

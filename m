Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B812CDB465
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Oct 2023 09:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjJNJJf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Oct 2023 05:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjJNJJd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Oct 2023 05:09:33 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86372CE
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Oct 2023 02:09:30 -0700 (PDT)
Received: from [192.168.0.233] (ip5f5bf23c.dynamic.kabel-deutschland.de [95.91.242.60])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D6AB861E5FE01;
        Sat, 14 Oct 2023 11:09:23 +0200 (CEST)
Message-ID: <e706186e-e64f-490f-9162-11bfdc589619@molgen.mpg.de>
Date:   Sat, 14 Oct 2023 11:09:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ] btdev: Broadcast EXT_ADV packets every 200 ms
To:     Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
References: <20231014074716.1866266-1-arkadiusz.bokowy@gmail.com>
Content-Language: en-US
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20231014074716.1866266-1-arkadiusz.bokowy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Arkadiusz,


Thank you for your patch.

Am 14.10.23 um 09:47 schrieb Arkadiusz Bokowy:
> Real BLE devices transmit LE advertisement report packages in given
> intervals (typically in range between 20 ms and 10.24 s). With current
> kernel module Bluetooth stack implementation it is possible that the
> first LE meta packet just after enabling scanning will be lost. It is
> not an issue for real devices, because more advertisement reports will
> be delivered later (in given interval time).
> 
> This patch changes optimistic implementation of sending only one LE
> meta packets just after enabling scanning to sending LE meta packets
> in 200 ms intervals. Such behavior will better emulate real HCI and
> will workaround the issue of dropping the very first LE meta packet

(The verb *work around* is spelled with a space.)

> by the kernel.

Could you please describe your test setup? I guess you optimized the 200 
ms for your setup, and that is the reason you did not choose an even 
lower value like 100 ms?

> ---
>   emulator/btdev.c | 102 +++++++++++++++++------------------------------
>   1 file changed, 36 insertions(+), 66 deletions(-)
> 
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index 65ad0a40c..3840c6150 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -100,7 +100,8 @@ struct le_ext_adv {
>   	uint8_t adv_data_len;
>   	uint8_t scan_data[252];
>   	uint8_t scan_data_len;
> -	unsigned int id;
> +	unsigned int broadcast_id;
> +	unsigned int timeout_id;
>   };
>   
>   struct le_cig {
> @@ -547,8 +548,10 @@ static void le_ext_adv_free(void *data)
>   	/* Remove to queue */
>   	queue_remove(ext_adv->dev->le_ext_adv, ext_adv);
>   
> -	if (ext_adv->id)
> -		timeout_remove(ext_adv->id);
> +	if (ext_adv->broadcast_id)
> +		timeout_remove(ext_adv->broadcast_id);
> +	if (ext_adv->timeout_id)
> +		timeout_remove(ext_adv->timeout_id);
>   
>   	free(ext_adv);
>   }
> @@ -4682,9 +4685,13 @@ static void ext_adv_disable(void *data, void *user_data)
>   	if (handle && ext_adv->handle != handle)
>   		return;
>   
> -	if (ext_adv->id) {
> -		timeout_remove(ext_adv->id);
> -		ext_adv->id = 0;
> +	if (ext_adv->broadcast_id) {
> +		timeout_remove(ext_adv->broadcast_id);
> +		ext_adv->broadcast_id = 0;
> +	}
> +	if (ext_adv->timeout_id) {
> +		timeout_remove(ext_adv->timeout_id);
> +		ext_adv->timeout_id = 0;
>   	}
>   
>   	ext_adv->enable = 0x00;
> @@ -4901,9 +4908,10 @@ static void send_ext_adv(struct btdev *btdev, const struct btdev *remote,
>   					1 + 24 + meta_event.lear.data_len);
>   }
>   
> -static void le_set_ext_adv_enable_complete(struct btdev *btdev,
> -						struct le_ext_adv *ext_adv)
> +static bool ext_adv_broadcast(void *user_data)
>   {
> +	struct le_ext_adv *ext_adv = user_data;
> +	struct btdev *btdev = ext_adv->dev;

Are these used?

Why rename the function?

>   	uint16_t report_type;
>   	int i;
>   
> @@ -4939,7 +4947,10 @@ static void le_set_ext_adv_enable_complete(struct btdev *btdev,
>   							report_type, true);
>   		}
>   	}
> +
> +	return true;
>   }
> +
>   static void adv_set_terminate(struct btdev *dev, uint8_t status, uint8_t handle,
>   					uint16_t conn_handle, uint8_t num_evts)
>   {
> @@ -4958,7 +4969,7 @@ static bool ext_adv_timeout(void *user_data)
>   {
>   	struct le_ext_adv *adv = user_data;
>   
> -	adv->id = 0;
> +	adv->timeout_id = 0;
>   	adv_set_terminate(adv->dev, BT_HCI_ERR_ADV_TIMEOUT, adv->handle,
>   								0x0000, 0x00);
>   	le_ext_adv_free(adv);
> @@ -5043,32 +5054,29 @@ static int cmd_set_ext_adv_enable(struct btdev *dev, const void *data,
>   
>   		if (!cmd->enable)
>   			ext_adv_disable(ext_adv, NULL);
> -		else if (eas->duration)
> -			ext_adv->id = timeout_add(eas->duration * 10,
> -							ext_adv_timeout,
> +		else {
> +			/* BLE advertising interval shall be between 20 ms
> +			 * and 10.24 s in 0.625 ms steps. Most devices which
> +			 * require fast advertising use interval between

an interval

> +			 * 100 ms and 500 ms.
> +			 */
> +			ext_adv->broadcast_id = timeout_add(200 /* 200 ms */,
> +							ext_adv_broadcast,
>   							ext_adv, NULL);
> +			if (eas->duration) {
> +				unsigned int duration_ms = eas->duration * 10;
> +				ext_adv->timeout_id = timeout_add(duration_ms,
> +								ext_adv_timeout,
> +								ext_adv, NULL);
> +			}
> +		}
> +
>   	}
>   
>   exit_complete:
>   	cmd_complete(dev, BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE, &status,
>   							sizeof(status));
>   
> -	if (status == BT_HCI_ERR_SUCCESS && cmd->enable) {
> -		/* Go through each sets and send adv event to peer device */
> -		for (i = 0; i < cmd->num_of_sets; i++) {
> -			const struct bt_hci_cmd_ext_adv_set *eas;
> -			struct le_ext_adv *ext_adv;
> -
> -			eas = data + sizeof(*cmd) + (sizeof(*eas) * i);
> -
> -			ext_adv = queue_find(dev->le_ext_adv,
> -						match_ext_adv_handle,
> -						UINT_TO_PTR(eas->handle));
> -			if (ext_adv)
> -				le_set_ext_adv_enable_complete(dev, ext_adv);
> -		}
> -	}
> -
>   	return 0;
>   }
>   
> @@ -5378,43 +5386,6 @@ done:
>   	return 0;
>   }
>   
> -static void scan_ext_adv(struct btdev *dev, struct btdev *remote)
> -{
> -	const struct queue_entry *entry;
> -
> -	for (entry = queue_get_entries(remote->le_ext_adv); entry;
> -							entry = entry->next) {
> -		struct le_ext_adv *ext_adv = entry->data;
> -		uint16_t report_type;
> -
> -		if (!ext_adv->enable)
> -			continue;
> -
> -		if (!ext_adv_match_addr(dev, ext_adv))
> -			continue;
> -
> -		report_type = get_ext_adv_type(ext_adv->type);
> -		send_ext_adv(dev, remote, ext_adv, report_type, false);
> -
> -		if (dev->le_scan_type != 0x01)
> -			continue;
> -
> -		/* if scannable bit is set the send scan response */
> -		if (ext_adv->type & 0x02) {
> -			if (ext_adv->type == 0x13)
> -				report_type = 0x1b;
> -			else if (ext_adv->type == 0x12)
> -				report_type = 0x1a;
> -			else if (!(ext_adv->type & 0x10))
> -				report_type &= 0x08;
> -			else
> -				continue;
> -
> -			send_ext_adv(dev, remote, ext_adv, report_type, true);
> -		}
> -	}
> -}
> -
>   static void scan_pa(struct btdev *dev, struct btdev *remote)
>   {
>   	if (dev->le_pa_sync_handle != INV_HANDLE || !remote->le_pa_enable)
> @@ -5440,7 +5411,6 @@ static int cmd_set_ext_scan_enable_complete(struct btdev *dev, const void *data,
>   		if (!btdev_list[i] || btdev_list[i] == dev)
>   			continue;
>   
> -		scan_ext_adv(dev, btdev_list[i]);
>   		scan_pa(dev, btdev_list[i]);
>   	}

Excuse my ignorance, but the remove code is really not necessary anymore?


Kind regards,

Paul

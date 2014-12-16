Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Gu Chaojie <chao.jie.gu@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 2/3] shared/gatt-client:Add CSRK part to support signed write
Date: Tue, 16 Dec 2014 13:43:33 +0100
Message-ID: <3207826.Qk1HKCf0LW@uw000953>
In-Reply-To: <1415351073-4362-3-git-send-email-chao.jie.gu@intel.com>
References: <1415351073-4362-1-git-send-email-chao.jie.gu@intel.com> <1415351073-4362-3-git-send-email-chao.jie.gu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gu Chaojie,

There should be space after ":" in commit prefix.

On Friday 07 of November 2014 17:04:32 Gu Chaojie wrote:
> ---
>  src/shared/gatt-client.c | 21 ++++++++++++++++-----
>  src/shared/gatt-client.h |  4 ++++
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 8689368..0d406f5 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -1987,19 +1987,20 @@ bool bt_gatt_client_read_long_value(struct bt_gatt_client *client,
>  bool bt_gatt_client_write_without_response(struct bt_gatt_client *client,
>  					uint16_t value_handle,
>  					bool signed_write,
> -					uint8_t *value, uint16_t length) {
> +					uint8_t *value, uint16_t length)
> +{

Code style fixes should be in separate patch.

>  	uint8_t pdu[2 + length];
>  
>  	if (!client)
>  		return 0;
>  
> -	/* TODO: Support this once bt_att_send supports signed writes. */
> -	if (signed_write)
> -		return 0;
> -
>  	put_le16(value_handle, pdu);
>  	memcpy(pdu + 2, value, length);
>  
> +	if (signed_write)
> +		return bt_att_send(client->att, BT_ATT_OP_SIGNED_WRITE_CMD,
> +					pdu, sizeof(pdu), NULL, NULL, NULL);
> +
>  	return bt_att_send(client->att, BT_ATT_OP_WRITE_CMD, pdu, sizeof(pdu),
>  							NULL, NULL, NULL);
>  }
> @@ -2480,3 +2481,13 @@ bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
>  	client->need_notify_cleanup = true;
>  	return true;
>  }
> +
> +bool bt_gatt_client_set_local_csrk(struct bt_gatt_client *client,
> +				uint32_t local_sign_cnt,
> +				uint8_t local_key[16])
> +{
> +	if (!client)
> +		return false;
> +
> +	return bt_att_set_local_csrk(client->att, local_sign_cnt, local_key);
> +}
> diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
> index adccfc5..5429576 100644
> --- a/src/shared/gatt-client.h
> +++ b/src/shared/gatt-client.h
> @@ -171,3 +171,7 @@ bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
>  				bt_gatt_client_destroy_func_t destroy);
>  bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
>  							unsigned int id);
> +
> +bool bt_gatt_client_set_local_csrk(struct bt_gatt_client *client,
> +				uint32_t local_sign_cnt,
> +				uint8_t local_key[16]);

just name those sign_cnt and key. 

-- 
Best regards, 
Szymon Janc

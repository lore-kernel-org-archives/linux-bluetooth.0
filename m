Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v3 2/4] shared/gatt-client: Add CSRK part to support signed write
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1411717728-15415-3-git-send-email-chao.jie.gu@intel.com>
Date: Fri, 26 Sep 2014 11:55:48 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9AF598FF-82F3-499C-8739-72947EDA695A@holtmann.org>
References: <1411717728-15415-1-git-send-email-chao.jie.gu@intel.com> <1411717728-15415-3-git-send-email-chao.jie.gu@intel.com>
To: Gu Chaojie <chao.jie.gu@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chajie,

> Compared with patch v2, remove type enum in CSRK funciton for btgatt-client
> tool to easy use this API.
> 
> ---
> src/shared/gatt-client.c |   27 ++++++++++++++++++++++-----
> src/shared/gatt-client.h |    4 ++++
> 2 files changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 6dc8e95..aee3969 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -1753,19 +1753,26 @@ bool bt_gatt_client_read_long_value(struct bt_gatt_client *client,
> bool bt_gatt_client_write_without_response(struct bt_gatt_client *client,
> 					uint16_t value_handle,
> 					bool signed_write,
> -					uint8_t *value, uint16_t length) {
> +					uint8_t *value, uint16_t length)
> +{
> 	uint8_t pdu[2 + length];
> 
> 	if (!client)
> 		return 0;
> 
> -	/* TODO: Support this once bt_att_send supports signed writes. */
> -	if (signed_write)
> -		return 0;
> -
> 	put_le16(value_handle, pdu);
> 	memcpy(pdu + 2, value, length);
> 
> +	if (signed_write) {
> +		if (bt_att_local_csrk_is_valid(client->att))
> +			return bt_att_send(client->att,
> +					BT_ATT_OP_SIGNED_WRITE_CMD,
> +					pdu, sizeof(pdu), NULL, NULL, NULL);
> +		else
> +			return 0;
> +
> +	}
> +
> 	return bt_att_send(client->att, BT_ATT_OP_WRITE_CMD, pdu, sizeof(pdu),
> 							NULL, NULL, NULL);
> }
> @@ -2246,3 +2253,13 @@ bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
> 	client->need_notify_cleanup = true;
> 	return true;
> }
> +
> +bool bt_gatt_client_set_local_csrk(struct bt_gatt_client *client,
> +				bool valid_local_csrk,
> +				uint8_t key[16])
> +{
> +	if (!client)
> +		return false;
> +
> +	return bt_att_set_local_csrk(client->att, valid_local_csrk, key);
> +}
> diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
> index 6807f6b..0684f30 100644
> --- a/src/shared/gatt-client.h
> +++ b/src/shared/gatt-client.h
> @@ -162,3 +162,7 @@ bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
> 				bt_gatt_client_destroy_func_t destroy);
> bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
> 							unsigned int id);
> +
> +bool bt_gatt_client_set_local_csrk(struct bt_gatt_client *client,
> +				bool valid_local_csrk,
> +				uint8_t key[16]);

why do we have the parameter valid_local_csrk. I find that highly confusing. If you do not have a valid CSRK, then do not call this function. It should be that simple.

Regards

Marcel


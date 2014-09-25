Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 3/4] shared/gatt-client: Add CSRK part to support signed write
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1411626931-8290-4-git-send-email-chao.jie.gu@intel.com>
Date: Thu, 25 Sep 2014 10:34:28 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <11CFD543-0D3D-4DBA-AF30-6294FFC4FAFD@holtmann.org>
References: <1411626931-8290-1-git-send-email-chao.jie.gu@intel.com> <1411626931-8290-4-git-send-email-chao.jie.gu@intel.com>
To: Gu Chaojie <chao.jie.gu@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chaojie,

> This patch Add set CSRK API to btgatt-client tool and add verfiy CSRK
> valid before bt_att_send signed write commmand to remote side.
> 
> ---
> src/shared/gatt-client.c |   21 +++++++++++++++++++--
> src/shared/gatt-client.h |    5 +++++
> 2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index b1619c6..93ef6d0 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -983,9 +983,15 @@ bool bt_gatt_client_write_without_response(struct bt_gatt_client *client,
> 	put_le16(value_handle, pdu);
> 	memcpy(pdu + 2, value, length);
> 
> -	if (signed_write)
> -		return bt_att_send(client->att, BT_ATT_OP_SIGNED_WRITE_CMD,
> +	if (signed_write) {
> +		if (bt_att_csrk_is_valid(client->att, LOCAL_CSRK))
> +			return bt_att_send(client->att,
> +					BT_ATT_OP_SIGNED_WRITE_CMD,
> 					pdu, sizeof(pdu), NULL, NULL, NULL);
> +		else
> +			return 0;
> +
> +	}
> 
> 	return bt_att_send(client->att, BT_ATT_OP_WRITE_CMD, pdu, sizeof(pdu),
> 							NULL, NULL, NULL);
> @@ -1357,3 +1363,14 @@ bool bt_gatt_client_write_long_value(struct bt_gatt_client *client,
> 
> 	return true;
> }
> +
> +bool bt_gatt_client_set_csrk(struct bt_gatt_client *client,
> +				enum bt_csrk_type type,
> +				bool valid_csrk,
> +				uint8_t key[16])
> +{
> +	if (!client)
> +		return false;
> +
> +	return bt_att_set_csrk(client->att, type, valid_csrk, key);
> +}
> diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
> index 8b0d334..01b01e9 100644
> --- a/src/shared/gatt-client.h
> +++ b/src/shared/gatt-client.h
> @@ -123,3 +123,8 @@ bool bt_gatt_client_write_long_value(struct bt_gatt_client *client,
> 				bt_gatt_client_write_long_callback_t callback,
> 				void *user_data,
> 				bt_gatt_client_destroy_func_t destroy);
> +
> +bool bt_gatt_client_set_csrk(struct bt_gatt_client *client,
> +				enum bt_csrk_type type,
> +				bool valid_csrk,
> +				uint8_t key[16]);

I prefer if we just have to separate function here:

	bt_gatt_client_set_local_csrk()
	bt_gatt_client_set_peer_csrk()

Introducing a type enum does not make a call to this API clearer. Naming the function here is a lot more helpful.

Regards

Marcel


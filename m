Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] android/gatt: Unify read by type and read by group type
Date: Mon, 01 Dec 2014 12:45:07 +0100
Message-ID: <2134908.GLzoqXHzbb@uw000953>
In-Reply-To: <1416991660-21828-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1416991660-21828-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wednesday 26 of November 2014 09:47:37 Jakub Tyszkowski wrote:
> These two functions were veary similar but inconsisten in used error
> codes and freeing allocated data.
> ---
>  android/gatt.c | 89 ++++++++++++++++++----------------------------------------
>  1 file changed, 27 insertions(+), 62 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 092473c..6d79e61 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -5895,71 +5895,27 @@ static const struct ipc_handler cmd_handlers[] = {
>  		sizeof(struct hal_cmd_gatt_client_read_batchscan_reports) },
>  };
>  
> -static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
> -						struct gatt_device *device)
> -{
> -	uint16_t start, end;
> -	int len;
> -	bt_uuid_t uuid;
> -	struct queue *q;
> -
> -	len = dec_read_by_grp_req(cmd, cmd_len, &start, &end, &uuid);
> -	if (!len)
> -		return ATT_ECODE_INVALID_PDU;
> -
> -	if (start > end || start == 0)
> -		return ATT_ECODE_INVALID_HANDLE;
> -
> -	q = queue_new();
> -	if (!q)
> -		return ATT_ECODE_INSUFF_RESOURCES;
> -
> -	gatt_db_read_by_group_type(gatt_db, start, end, uuid, q);
> -
> -	if (queue_isempty(q)) {
> -		queue_destroy(q, NULL);
> -		return ATT_ECODE_ATTR_NOT_FOUND;
> -	}
> -
> -	while (queue_peek_head(q)) {
> -		struct gatt_db_attribute *attrib = queue_pop_head(q);
> -		struct pending_request *entry;
> -
> -		entry = new0(struct pending_request, 1);
> -		if (!entry) {
> -			queue_destroy(q, destroy_pending_request);
> -			return ATT_ECODE_UNLIKELY;
> -		}
> -
> -		entry->attrib = attrib;
> -		entry->state = REQUEST_INIT;
> -
> -		if (!queue_push_tail(device->pending_requests, entry)) {
> -			queue_remove_all(device->pending_requests, NULL, NULL,
> -						destroy_pending_request);
> -			free(entry);
> -			queue_destroy(q, NULL);
> -			return ATT_ECODE_UNLIKELY;
> -		}
> -	}
> -
> -	queue_destroy(q, NULL);
> -	process_dev_pending_requests(device, cmd[0]);
> -
> -	return 0;
> -}
> -
>  static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
>  						struct gatt_device *device)
>  {
>  	uint16_t start, end;
> -	uint16_t len;
> +	uint16_t len = 0;
>  	bt_uuid_t uuid;
>  	struct queue *q;
>  
>  	DBG("");
>  
> -	len = dec_read_by_type_req(cmd, cmd_len, &start, &end, &uuid);
> +	switch (cmd[0]) {
> +	case ATT_OP_READ_BY_TYPE_REQ:
> +		len = dec_read_by_type_req(cmd, cmd_len, &start, &end, &uuid);
> +		break;
> +	case ATT_OP_READ_BY_GROUP_REQ:
> +		len = dec_read_by_grp_req(cmd, cmd_len, &start, &end, &uuid);
> +		break;
> +	default:
> +		break;
> +	}
> +
>  	if (!len)
>  		return ATT_ECODE_INVALID_PDU;
>  
> @@ -5970,7 +5926,16 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
>  	if (!q)
>  		return ATT_ECODE_INSUFF_RESOURCES;
>  
> -	gatt_db_read_by_type(gatt_db, start, end, uuid, q);
> +	switch (cmd[0]) {
> +	case ATT_OP_READ_BY_TYPE_REQ:
> +		gatt_db_read_by_type(gatt_db, start, end, uuid, q);
> +		break;
> +	case ATT_OP_READ_BY_GROUP_REQ:
> +		gatt_db_read_by_group_type(gatt_db, start, end, uuid, q);
> +		break;
> +	default:
> +		break;
> +	}
>  
>  	if (queue_isempty(q)) {
>  		queue_destroy(q, NULL);
> @@ -5989,13 +5954,15 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
>  
>  		data->state = REQUEST_INIT;
>  		data->attrib = attrib;
> -		if (!queue_push_tail(device->pending_requests, data))
> +		if (!queue_push_tail(device->pending_requests, data)) {
>  			free(data);
> +			queue_destroy(q, NULL);
> +			return ATT_ECODE_INSUFF_RESOURCES;
> +		}
>  	}
>  
>  	queue_destroy(q, NULL);
> -
> -	process_dev_pending_requests(device, ATT_OP_READ_BY_TYPE_REQ);
> +	process_dev_pending_requests(device, cmd[0]);
>  
>  	return 0;
>  }
> @@ -6518,8 +6485,6 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
>  
>  	switch (ipdu[0]) {
>  	case ATT_OP_READ_BY_GROUP_REQ:
> -		status = read_by_group_type(ipdu, len, dev);
> -		break;
>  	case ATT_OP_READ_BY_TYPE_REQ:
>  		status = read_by_type(ipdu, len, dev);
>  		break;
> 

Patches 1-3 applied. Thanks.

-- 
Best regards, 
Szymon Janc

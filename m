Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 07/10] android/gatt: Improve send_dev_complete_response even further
Date: Fri, 13 Feb 2015 12:35:05 +0100
Message-ID: <1712631.jR0ON48mpS@uw000953>
In-Reply-To: <1423665248-5121-7-git-send-email-jakub.tyszkowski@tieto.com>
References: <1423665248-5121-1-git-send-email-jakub.tyszkowski@tieto.com> <1423665248-5121-7-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wednesday 11 of February 2015 15:34:05 Jakub Tyszkowski wrote:
> We can use 'queue_remove_all' for response filtering instead of manually
> repacking them to yet another queue.
> ---
>  android/gatt.c | 104 ++++++++++++++++++++++++---------------------------------
>  1 file changed, 43 insertions(+), 61 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 19232f7..49bcda2 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -4437,6 +4437,22 @@ static bool match_pending_dev_request(const void *data, const void *user_data)
>  	return !pending_request->completed;
>  }
>  
> +struct invalid_response_match {
> +	int length;
> +	bool *remove;

I'd prefer to avoid such hacks.

> +};
> +
> +static bool remove_invalid_requests(const void *data, const void *match_data)
> +{
> +	const struct pending_request *val = data;
> +	const struct invalid_response_match *match = match_data;
> +
> +	if (val->length != match->length || val->error)
> +		*match->remove = true;
> +
> +	return *match->remove;
> +}
> +
>  static void send_dev_complete_response(struct gatt_device *device,
>  								uint8_t opcode)
>  {
> @@ -4470,40 +4486,20 @@ static void send_dev_complete_response(struct gatt_device *device,
>  	case ATT_OP_READ_BY_TYPE_REQ: {
>  		struct att_data_list *adl;
>  		int iterator = 0;
> -		int length;
> -		struct queue *temp;
> -
> -		temp = queue_new();
> -		if (!temp)
> -			goto done;
> -
> -		val = queue_pop_head(device->pending_requests);
> -		if (!val) {
> -			queue_destroy(temp, NULL);
> -			error = ATT_ECODE_ATTR_NOT_FOUND;
> -			goto done;
> -		}
> -
> -		if (val->error) {
> -			queue_destroy(temp, NULL);
> -			error = val->error;
> -			destroy_pending_request(val);
> -			goto done;
> -		}
> -
> -		length = val->length;
> -
> -		while (val && val->length == length && val->error == 0) {
> -			queue_push_tail(temp, val);
> -			val = queue_pop_head(device->pending_requests);
> -		}
> -
> -		adl = att_data_list_alloc(queue_length(temp),
> -						sizeof(uint16_t) + length);
> +		bool remove = false;
> +		struct invalid_response_match match;
> +		struct queue *requests = device->pending_requests;
> +
> +		/* Remove all after error or value length change. */
> +		match.remove = &remove;
> +		match.length = val->length;
> +		queue_remove_all(requests, remove_invalid_requests, &match,
> +						destroy_pending_request);

Please check if queue_remove_if() was more suitable here.

>  
> -		destroy_pending_request(val);
> +		adl = att_data_list_alloc(queue_length(requests),
> +						sizeof(uint16_t) + val->length);
>  
> -		val = queue_pop_head(temp);
> +		val = queue_pop_head(requests);
>  		while (val) {
>  			uint8_t *value = adl->data[iterator++];
>  			uint16_t handle;
> @@ -4514,14 +4510,12 @@ static void send_dev_complete_response(struct gatt_device *device,
>  			memcpy(&value[2], val->value, val->length);
>  
>  			destroy_pending_request(val);
> -			val = queue_pop_head(temp);
> +			val = queue_pop_head(requests);
>  		}
>  
>  		len = enc_read_by_type_resp(adl, rsp, mtu);
>  
>  		att_data_list_free(adl);
> -		queue_destroy(temp, destroy_pending_request);
> -
>  		break;
>  	}
>  	case ATT_OP_READ_BLOB_REQ:
> @@ -4534,31 +4528,21 @@ static void send_dev_complete_response(struct gatt_device *device,
>  	case ATT_OP_READ_BY_GROUP_REQ: {
>  		struct att_data_list *adl;
>  		int iterator = 0;
> -		int length;
> -		struct queue *temp;
> -
> -		temp = queue_new();
> -		if (!temp)
> -			goto done;
> -
> -		val = queue_pop_head(device->pending_requests);
> -		if (!val) {
> -			queue_destroy(temp, NULL);
> -			error = ATT_ECODE_ATTR_NOT_FOUND;
> -			goto done;
> -		}
> -
> -		length = val->length;
> -
> -		while (val && val->length == length) {
> -			queue_push_tail(temp, val);
> -			val = queue_pop_head(device->pending_requests);
> -		}
> +		bool remove = false;
> +		struct invalid_response_match match;
> +		struct queue *requests = device->pending_requests;
> +
> +		/* Remove all after error or value length change. */
> +		match.remove = &remove;
> +		match.length = val->length;
> +		queue_remove_all(requests, remove_invalid_requests, &match,
> +						destroy_pending_request);
>  
> -		adl = att_data_list_alloc(queue_length(temp),
> -						2 * sizeof(uint16_t) + length);
> +		adl = att_data_list_alloc(queue_length(requests),
> +							2 * sizeof(uint16_t) +
> +							val->length);
>  
> -		val = queue_pop_head(temp);
> +		val = queue_pop_head(requests);
>  		while (val) {
>  			uint8_t *value = adl->data[iterator++];
>  			uint16_t start_handle, end_handle;
> @@ -4572,14 +4556,12 @@ static void send_dev_complete_response(struct gatt_device *device,
>  			memcpy(&value[4], val->value, val->length);
>  
>  			destroy_pending_request(val);
> -			val = queue_pop_head(temp);
> +			val = queue_pop_head(requests);
>  		}
>  
>  		len = enc_read_by_grp_resp(adl, rsp, mtu);
>  
>  		att_data_list_free(adl);
> -		queue_destroy(temp, destroy_pending_request);
> -
>  		break;
>  	}
>  	case ATT_OP_FIND_BY_TYPE_REQ: {
> 

-- 
Best regards, 
Szymon Janc

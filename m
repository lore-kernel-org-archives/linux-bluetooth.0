Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 01/10] android/gatt: Replace request state with boolean
Date: Fri, 13 Feb 2015 12:49:44 +0100
Message-ID: <1658969.V8rH4AEXo2@uw000953>
In-Reply-To: <1423665248-5121-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1423665248-5121-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wednesday 11 of February 2015 15:33:59 Jakub Tyszkowski wrote:
> As there are two states we can instead use boolean value.
> ---
>  android/gatt.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 8e58e41..b0ce1a8 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -690,11 +690,6 @@ static void destroy_gatt_app(void *data)
>  	free(app);
>  }
>  
> -enum pend_req_state {
> -	REQUEST_PENDING,
> -	REQUEST_DONE,
> -};
> -
>  struct pending_request {
>  	struct gatt_db_attribute *attrib;
>  	int length;
> @@ -704,7 +699,7 @@ struct pending_request {
>  	uint8_t *filter_value;
>  	uint16_t filter_vlen;
>  
> -	enum pend_req_state state;
> +	bool completed;
>  	uint8_t error;
>  };
>  
> @@ -4475,7 +4470,7 @@ static bool match_pending_dev_request(const void *data, const void *user_data)
>  {
>  	const struct pending_request *pending_request = data;
>  
> -	return pending_request->state == REQUEST_PENDING;
> +	return !pending_request->completed;
>  }
>  
>  static void send_dev_complete_response(struct gatt_device *device,
> @@ -4830,7 +4825,7 @@ static void attribute_read_cb(struct gatt_db_attribute *attrib, int err,
>  	resp_data->length = length;
>  	resp_data->error = error;
>  
> -	resp_data->state = REQUEST_DONE;
> +	resp_data->completed = true;
>  
>  	if (!length)
>  		return;
> @@ -4856,7 +4851,7 @@ static void read_requested_attributes(void *data, void *user_data)
>  	attrib = resp_data->attrib;
>  	if (!attrib) {
>  		resp_data->error = ATT_ECODE_ATTR_NOT_FOUND;
> -		resp_data->state = REQUEST_DONE;
> +		resp_data->completed = true;
>  		return;
>  	}
>  
> @@ -4874,7 +4869,7 @@ static void read_requested_attributes(void *data, void *user_data)
>  							permissions);
>  	if (error != 0) {
>  		resp_data->error = error;
> -		resp_data->state = REQUEST_DONE;
> +		resp_data->completed = true;
>  		return;
>  	}
>  
> @@ -5650,7 +5645,7 @@ static void handle_server_send_response(const void *buf, uint16_t len)
>  
>  		/* Cast status to uint8_t, due to (byte) cast in java layer. */
>  		req->error = err_to_att((uint8_t) cmd->status);
> -		req->state = REQUEST_DONE;
> +		req->completed = true;
>  
>  		/*
>  		 * FIXME: Handle situation when not all server applications
> @@ -6493,7 +6488,7 @@ static void attribute_write_cb(struct gatt_db_attribute *attrib, int err,
>  	data->attrib = attrib;
>  	data->error = error;
>  
> -	data->state = REQUEST_DONE;
> +	data->completed = true;
>  }
>  
>  static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,

Patches 1-4, 6, 8 and 9 are now applied. Thanks.

-- 
Best regards, 
Szymon Janc

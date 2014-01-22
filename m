Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/hidhost: Fix vid and pid information
Date: Thu, 23 Jan 2014 00:09:44 +0100
Message-ID: <3119456.1yRZGeEzBd@athlon>
In-Reply-To: <1390412797-23093-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1390412797-23093-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Wednesday 22 January 2014 18:46:37 Andrzej Kaczmarek wrote:
> For HID device vendor, product and version numbers should be retrieved
> using Device ID profile which is mandatory for devices implementing
> HIDP.
> ---
>  android/hidhost.c | 74
> +++++++++++++++++++++++++++++++++++++++++-------------- 1 file changed, 56
> insertions(+), 18 deletions(-)
> 
> diff --git a/android/hidhost.c b/android/hidhost.c
> index bb55f5e..23935da 100644
> --- a/android/hidhost.c
> +++ b/android/hidhost.c
> @@ -648,18 +648,6 @@ static void hid_sdp_search_cb(sdp_list_t *recs, int
> err, gpointer data) sdp_record_t *rec = list->data;
>  		sdp_data_t *data;
> 
> -		data = sdp_data_get(rec, SDP_ATTR_VENDOR_ID);
> -		if (data)
> -			dev->vendor = data->val.uint16;
> -
> -		data = sdp_data_get(rec, SDP_ATTR_PRODUCT_ID);
> -		if (data)
> -			dev->product = data->val.uint16;
> -
> -		data = sdp_data_get(rec, SDP_ATTR_VERSION);
> -		if (data)
> -			dev->version = data->val.uint16;
> -
>  		data = sdp_data_get(rec, SDP_ATTR_HID_COUNTRY_CODE);
>  		if (data)
>  			dev->country = data->val.uint8;
> @@ -722,6 +710,56 @@ fail:
>  	hid_device_free(dev);
>  }
> 
> +static void hid_sdp_did_search_cb(sdp_list_t *recs, int err, gpointer data)
> +{
> +	struct hid_device *dev = data;
> +	sdp_list_t *list;
> +	GError *gerr = NULL;

gerr is not used in the function, but I've fixed this (and some other minors) 
and pushed patch upstream. Thanks.

> +	uuid_t uuid;
> +
> +	DBG("");
> +
> +	if (err < 0) {
> +		error("Unable to get Device ID SDP record: %s", strerror(-err));
> +		goto fail;
> +	}
> +
> +	if (!recs || !recs->data) {
> +		error("No SDP records found");
> +		goto fail;
> +	}
> +
> +	for (list = recs; list != NULL; list = list->next) {
> +		sdp_record_t *rec = list->data;
> +		sdp_data_t *data;
> +
> +		data = sdp_data_get(rec, SDP_ATTR_VENDOR_ID);
> +		if (data)
> +			dev->vendor = data->val.uint16;
> +
> +		data = sdp_data_get(rec, SDP_ATTR_PRODUCT_ID);
> +		if (data)
> +			dev->product = data->val.uint16;
> +
> +		data = sdp_data_get(rec, SDP_ATTR_VERSION);
> +		if (data)
> +			dev->version = data->val.uint16;
> +	}
> +
> +	bt_string2uuid(&uuid, HID_UUID);
> +	if (bt_search_service(&adapter_addr, &dev->dst, &uuid,
> +				hid_sdp_search_cb, dev, NULL, 0) < 0) {
> +		error("failed to search sdp details");
> +		goto fail;
> +	}
> +
> +	return;
> +
> +fail:
> +	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_DISCONNECTED);
> +	hid_device_free(dev);
> +}
> +
>  static void bt_hid_connect(const void *buf, uint16_t len)
>  {
>  	const struct hal_cmd_hidhost_connect *cmd = buf;
> @@ -749,10 +787,10 @@ static void bt_hid_connect(const void *buf, uint16_t
> len) ba2str(&dev->dst, addr);
>  	DBG("connecting to %s", addr);
> 
> -	bt_string2uuid(&uuid, HID_UUID);
> +	bt_string2uuid(&uuid, PNP_UUID);
>  	if (bt_search_service(&adapter_addr, &dev->dst, &uuid,
> -					hid_sdp_search_cb, dev, NULL, 0) < 0) {
> -		error("Failed to search sdp details");
> +					hid_sdp_did_search_cb, dev, NULL, 0) < 0) {
> +		error("Failed to search did sdp details");
>  		hid_device_free(dev);
>  		status = HAL_STATUS_FAILED;
>  		goto failed;
> @@ -1242,10 +1280,10 @@ static void connect_cb(GIOChannel *chan, GError
> *err, gpointer user_data) dev->ctrl_io = g_io_channel_ref(chan);
>  		dev->uhid_fd = -1;
> 
> -		bt_string2uuid(&uuid, HID_UUID);
> +		bt_string2uuid(&uuid, PNP_UUID);
>  		if (bt_search_service(&src, &dev->dst, &uuid,
> -					hid_sdp_search_cb, dev, NULL, 0) < 0) {
> -			error("failed to search sdp details");
> +					hid_sdp_did_search_cb, dev, NULL, 0) < 0) {
> +			error("failed to search did sdp details");
>  			hid_device_free(dev);
>  			return;
>  		}

-- 
Szymon K. Janc
szymon.janc@gmail.com

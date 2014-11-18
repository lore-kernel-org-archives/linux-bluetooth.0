Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 13/14] android/handsfree-client: Implement handling AT+BIND and +BIND
Date: Tue, 18 Nov 2014 22:09:32 +0100
Message-ID: <3719316.nzptrfuKRx@leonov>
In-Reply-To: <1415789377-20458-14-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415789377-20458-1-git-send-email-lukasz.rymanowski@tieto.com> <1415789377-20458-14-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Wednesday 12 of November 2014 11:49:36 Lukasz Rymanowski wrote:
> ---
>  android/handsfree-client.c | 47
> +++++++++++++++++++++++++++++++++++++++++++--- 1 file changed, 44
> insertions(+), 3 deletions(-)
> 
> diff --git a/android/handsfree-client.c b/android/handsfree-client.c
> index 73898ea..4338c11 100644
> --- a/android/handsfree-client.c
> +++ b/android/handsfree-client.c
> @@ -674,10 +674,23 @@ done:
> 
>  static void handle_get_last_vc_tag_num(const void *buf, uint16_t len)
>  {
> -	DBG("Not Implemented");
> +	struct device *dev;
> +	uint8_t status;
> +
> +	dev = find_default_device();
> +	if (!dev) {
> +		status = HAL_STATUS_FAILED;
> +		goto done;
> +	}
> +
> +	if (hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL, "AT+BINP=1"))
> +		status = HAL_STATUS_SUCCESS;
> +	else
> +		status = HAL_STATUS_FAILED;
> +
> +done:
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
> -					HAL_OP_HF_CLIENT_GET_LAST_VOICE_TAG_NUM,
> -					HAL_STATUS_UNSUPPORTED);
> +			HAL_OP_HF_CLIENT_GET_LAST_VOICE_TAG_NUM, status);
>  }
> 
>  static void disconnect_watch(void *user_data)
> @@ -994,6 +1007,33 @@ static void cops_cb(struct hfp_context *context, void
> *user_data) sizeof(*ev) + ev->name_len, ev);
>  }
> 
> +static void binp_cb(struct hfp_context *context, void *user_data)
> +{
> +	uint8_t buf[IPC_MTU];
> +	struct hal_ev_hf_client_last_void_call_tag_num *ev = (void *) buf;
> +	char number[255];

Why 255? According to spec it should be 32 digits max.

> +
> +	DBG("");
> +
> +	if (!context) {
> +		error("hf-client: incorrect COPS response");
> +		return;
> +	}
> +
> +	if (!hfp_context_get_string(context, number, sizeof(number))) {
> +		error("hf-client: incorrect COPS response");
> +		return;
> +	}
> +
> +	memset(buf, 0, sizeof(buf));
> +	ev->number_len = strlen(number) + 1;
> +	memcpy(ev->number, number, ev->number_len);

Could extract directly to ev->number.

> +
> +	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +					HAL_EV_CLIENT_LAST_VOICE_CALL_TAG_NUM,
> +					sizeof(*ev) + ev->number_len, ev);
> +}
> +
>  static void slc_completed(struct device *dev)
>  {
>  	int i;
> @@ -1023,6 +1063,7 @@ static void slc_completed(struct device *dev)
>  	hfp_hf_register(dev->hf, ciev_cb, "+CIEV", dev, NULL);
>  	hfp_hf_register(dev->hf, cops_cb, "+COPS", dev, NULL);
>  	hfp_hf_register(dev->hf, cnum_cb, "+CNUM", dev, NULL);
> +	hfp_hf_register(dev->hf, binp_cb, "+BINP", dev, NULL);
> 
>  	if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL, "AT+COPS=3,0"))
>  		info("hf-client: Could not send AT+COPS=3,0");

-- 
BR
Szymon Janc

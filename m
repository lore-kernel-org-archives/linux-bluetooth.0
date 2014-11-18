Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 11/14] android/handsfree-client: Retrieve subscriber number information
Date: Tue, 18 Nov 2014 21:52:47 +0100
Message-ID: <10571607.171qZOYuRz@leonov>
In-Reply-To: <1415789377-20458-12-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415789377-20458-1-git-send-email-lukasz.rymanowski@tieto.com> <1415789377-20458-12-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Wednesday 12 of November 2014 11:49:34 Lukasz Rymanowski wrote:
> ---
>  android/handsfree-client.c | 73
> ++++++++++++++++++++++++++++++++++++++++++++-- 1 file changed, 71
> insertions(+), 2 deletions(-)
> 
> diff --git a/android/handsfree-client.c b/android/handsfree-client.c
> index 6fe5495..bc3e2cd 100644
> --- a/android/handsfree-client.c
> +++ b/android/handsfree-client.c
> @@ -627,10 +627,26 @@ done:
> 
>  static void handle_retrieve_subscr_info(const void *buf, uint16_t len)
>  {
> -	DBG("Not Implemented");
> +	struct device *dev;
> +	uint8_t status;
> +
> +	DBG("");
> +
> +	dev = find_default_device();
> +	if (!dev) {
> +		status = HAL_STATUS_FAILED;
> +		goto done;
> +	}
> +
> +	if (hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL, "AT+CNUM"))
> +		status = HAL_STATUS_SUCCESS;
> +	else
> +		status = HAL_STATUS_FAILED;
> +
> +done:
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
>  					HAL_OP_HF_CLIENT_RETRIEVE_SUBSCR_INFO,
> -					HAL_STATUS_UNSUPPORTED);
> +					status);
>  }
> 
>  static void handle_send_dtmf(const void *buf, uint16_t len)
> @@ -873,6 +889,58 @@ static void ciev_cb(struct hfp_context *context, void
> *user_data) }
>  }
> 
> +static void cnum_cb(struct hfp_context *context, void *user_data)
> +{
> +	uint8_t buf[IPC_MTU];
> +	struct hal_ev_hf_client_subscriber_service_info *ev = (void *) buf;
> +	char number[16];
> +	uint32_t service;

unsigned int

> +
> +	DBG("");
> +
> +	if (!context) {
> +		error("hf-client: incorrect CNUM response");
> +		return;
> +	}

Should not happen.

> +
> +	/* Alpha field is empty string, just skip it*/

missing space before */

> +	hfp_context_skip_field(context);
> +
> +	if (!hfp_context_get_string(context, number, sizeof(number))) {
> +		error("hf-client: Could not get number");
> +		return;
> +	}
> +
> +	/* Type is not used in Android */
> +	hfp_context_skip_field(context);
> +
> +	/* Speed field is empty string, just skip it*/
> +	hfp_context_skip_field(context);
> +
> +	if (!hfp_context_get_number(context, &service))
> +		return;
> +
> +	memset(buf, 0, sizeof(buf));
> +	ev->name_len = strlen(number) + 1;
> +	memcpy(ev->name, number, ev->name_len);

Could avoid memset and memcpy and extract number directly to ev->name.

> +
> +	switch (service) {
> +	case 4:
> +		ev->type = HAL_HF_CLIENT_SUBSCR_TYPE_VOICE;
> +		break;
> +	case 5:
> +		ev->type = HAL_HF_CLIENT_SUBSCR_TYPE_FAX;
> +		break;
> +	default:
> +		ev->type = HAL_HF_CLIENT_SUBSCR_TYPE_UNKNOWN;
> +		break;
> +	}
> +
> +	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +					HAL_EV_CLIENT_SUBSCRIBER_SERVICE_INFO,
> +					sizeof(*ev) + ev->name_len, ev);
> +}
> +
>  static void cops_cb(struct hfp_context *context, void *user_data)
>  {
>  	uint8_t buf[IPC_MTU];
> @@ -938,6 +1006,7 @@ static void slc_completed(struct device *dev)
>  	hfp_hf_register(dev->hf, clcc_cb, "+CLCC", dev, NULL);
>  	hfp_hf_register(dev->hf, ciev_cb, "+CIEV", dev, NULL);
>  	hfp_hf_register(dev->hf, cops_cb, "+COPS", dev, NULL);
> +	hfp_hf_register(dev->hf, cnum_cb, "+CNUM", dev, NULL);
> 
>  	if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL, "AT+COPS=3,0"))
>  		info("hf-client: Could not send AT+COPS=3,0");

-- 
BR
Szymon Janc

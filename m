Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 04/14] android/handsfree-client: Add call action implementation
Date: Tue, 18 Nov 2014 17:24:30 +0100
Message-ID: <1805345.tlqmFpnIb9@uw000953>
In-Reply-To: <1415789377-20458-5-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415789377-20458-1-git-send-email-lukasz.rymanowski@tieto.com> <1415789377-20458-5-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Wednesday 12 of November 2014 11:49:27 Lukasz Rymanowski wrote:
> ---
>  android/handsfree-client.c | 99 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 2 deletions(-)
> 
> diff --git a/android/handsfree-client.c b/android/handsfree-client.c
> index 4dfe9fb..97ff228 100644
> --- a/android/handsfree-client.c
> +++ b/android/handsfree-client.c
> @@ -499,9 +499,79 @@ done:
>  
>  static void handle_call_action(const void *buf, uint16_t len)
>  {
> -	DBG("Not Implemented");
> +	const struct hal_cmd_hf_client_call_action *cmd = buf;
> +	struct device *dev;
> +	uint8_t status;
> +	bool ret;
> +
> +	DBG("");
> +
> +	dev = find_default_device();
> +	if (!dev) {
> +		status = HAL_STATUS_FAILED;
> +		goto done;
> +	}
> +
> +	switch (cmd->action) {
> +	case HAL_HF_CLIENT_ACTION_CHLD_0:
> +		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
> +								"AT+CHLD=0");
> +		break;
> +	case HAL_HF_CLIENT_ACTION_CHLD_1:
> +		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
> +								"AT+CHLD=1");
> +		break;
> +	case HAL_HF_CLIENT_ACTION_CHLD_2:
> +		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb,
> +							NULL, "AT+CHLD=2");
> +		break;
> +	case HAL_HF_CLIENT_ACTION_CHLD_3:
> +		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
> +								"AT+CHLD=3");
> +		break;
> +	case HAL_HF_CLIENT_ACTION_CHLD_4:
> +		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
> +								"AT+CHLD=4");
> +		break;
> +	case HAL_HF_CLIENT_ACTION_CHLD_1x:
> +		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
> +						"AT+CHLD=1%d", cmd->index);

cmd->index is unsigned type. (BTW it seems to be int on HAL API, should
we update IPC to match this..?)

> +		break;
> +	case HAL_HF_CLIENT_ACTION_CHLD_2x:
> +		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
> +						"AT+CHLD=2%d", cmd->index);
> +		break;
> +	case HAL_HF_CLIENT_ACTION_ATA:
> +		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
> +									"ATA");
> +		break;
> +	case HAL_HF_CLIENT_ACTION_CHUP:
> +		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
> +								"AT+CHUP");
> +		break;
> +	case HAL_HF_CLIENT_ACTION_BRTH_0:
> +		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
> +								"AT+BTRH=0");
> +		break;
> +	case HAL_HF_CLIENT_ACTION_BRTH_1:
> +		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
> +								"AT+BTRH=1");
> +		break;
> +	case HAL_HF_CLIENT_ACTION_BRTH_2:
> +		ret = hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL,
> +								"AT+BTRH=2");
> +		break;
> +	default:
> +		error("hf-client: Unknown action %d", cmd->action);
> +		ret = false;
> +		break;
> +	}
> +
> +	status = ret ? HAL_STATUS_SUCCESS : HAL_STATUS_FAILED;
> +
> +done:
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
> -			HAL_OP_HF_CLIENT_CALL_ACTION, HAL_STATUS_UNSUPPORTED);
> +					HAL_OP_HF_CLIENT_CALL_ACTION, status);
>  }
>  
>  static void handle_query_current_calls(const void *buf, uint16_t len)
> @@ -650,6 +720,30 @@ static void vgs_cb(struct hfp_context *context, void *user_data)
>  			HAL_EV_CLIENT_VOLUME_CHANGED, sizeof(ev), &ev);
>  }
>  
> +static void brth_cb(struct hfp_context *context, void *user_data)
> +{
> +	struct hal_ev_hf_client_response_and_hold_status ev;
> +	uint32_t val;

unsigned int

> +
> +	DBG("");
> +
> +	if (!context) {
> +		error("hf-client: incorrect BTRH response");
> +		return;
> +	}
> +
> +	if (!hfp_context_get_number(context, &val)) {
> +		error("hf-client: incorrect BTRH response. Can not get val");
> +		return;
> +	}
> +
> +	ev.status = val;

Value should be verified with IPC type cause it is later mapped to enum.

> +
> +	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +				HAL_EV_HF_CLIENT_RESPONSE_AND_HOLD_STATUS,
> +				sizeof(ev), &ev);
> +}
> +
>  static void slc_completed(struct device *dev)
>  {
>  	DBG("");
> @@ -664,6 +758,7 @@ static void slc_completed(struct device *dev)
>  	hfp_hf_register(dev->hf, bvra_cb, "+BRVA", dev, NULL);
>  	hfp_hf_register(dev->hf, vgm_cb, "+VGM", dev, NULL);
>  	hfp_hf_register(dev->hf, vgs_cb, "+VGS", dev, NULL);
> +	hfp_hf_register(dev->hf, brth_cb, "+BTRH", dev, NULL);
>  }
>  
>  static void slc_chld_cb(struct hfp_context *context, void *user_data)
> 

-- 
Best regards, 
Szymon Janc

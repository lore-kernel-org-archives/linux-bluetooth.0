Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 01/14] android/handsfree-client: Add handle start/stop vr
Date: Tue, 18 Nov 2014 17:04:57 +0100
Message-ID: <1472620.sIY3hqnIje@uw000953>
In-Reply-To: <1415789377-20458-2-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415789377-20458-1-git-send-email-lukasz.rymanowski@tieto.com> <1415789377-20458-2-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Wednesday 12 of November 2014 11:49:24 Lukasz Rymanowski wrote:
> This patch implements start/stop voice recogniction command handling.
> It also introduce find_default_device which returns connected device.
> 
> Note that for now we support only one device as this is HAL limitation
> ---
>  android/handsfree-client.c | 106 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 102 insertions(+), 4 deletions(-)
> 
> diff --git a/android/handsfree-client.c b/android/handsfree-client.c
> index c576ae8..d8b0bb1 100644
> --- a/android/handsfree-client.c
> +++ b/android/handsfree-client.c
> @@ -135,6 +135,11 @@ static uint32_t hfp_hf_record_id = 0;
>  static struct queue *devices = NULL;
>  static GIOChannel *hfp_hf_server = NULL;
>  
> +static struct device *find_default_device(void)
> +{
> +	return queue_peek_head(devices);
> +}
> +
>  static bool match_by_bdaddr(const void *data, const void *user_data)
>  {
>  	const bdaddr_t *addr1 = data;
> @@ -293,18 +298,95 @@ static void handle_disconnect_audio(const void *buf, uint16_t len)
>  					HAL_STATUS_UNSUPPORTED);
>  }
>  
> +static void cmd_complete_cb(enum hfp_result result, enum hfp_error cme_err,
> +							void *user_data)
> +{
> +	struct hal_ev_hf_client_command_complete ev;
> +
> +	DBG("");
> +
> +	memset(&ev, 0, sizeof(ev));
> +
> +	switch (result) {
> +	case HFP_RESULT_OK:
> +		ev.type = HAL_HF_CLIENT_CMD_COMP_OK;
> +		break;
> +	case HFP_RESULT_NO_CARRIER:
> +		ev.type = HAL_HF_CLIENT_CMD_COMP_ERR_NO_CARRIER;
> +		break;
> +	case HFP_RESULT_ERROR:
> +		ev.type = HAL_HF_CLIENT_CMD_COMP_ERR;
> +		break;
> +	case HFP_RESULT_BUSY:
> +		ev.type = HAL_HF_CLIENT_CMD_COMP_ERR_BUSY;
> +		break;
> +	case HFP_RESULT_NO_ANSWER:
> +		ev.type = HAL_HF_CLIENT_CMD_COMP_ERR_NO_ANSWER;
> +		break;
> +	case HFP_RESULT_DELAYED:
> +		ev.type = HAL_HF_CLIENT_CMD_COMP_ERR_DELAYED;
> +		break;
> +	case HFP_RESULT_BLACKLISTED:
> +		ev.type = HAL_HF_CLIENT_CMD_COMP_ERR_BACKLISTED;
> +		break;
> +	case HFP_RESULT_CME_ERROR:
> +		ev.type = HAL_HF_CLIENT_CMD_COMP_ERR_CME;
> +		ev.cme = cme_err;
> +		break;
> +	default:
> +		error("hf-client: Unknown error code %d", result);
> +		ev.type = HAL_HF_CLIENT_CMD_COMP_ERR;
> +		break;
> +	}
> +
> +	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +			HAL_EV_CLIENT_COMMAND_COMPLETE, sizeof(ev), &ev);
> +}
> +
>  static void handle_start_vr(const void *buf, uint16_t len)
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
> +	if (hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL, "AT+BVRA=1"))
> +		status = HAL_STATUS_SUCCESS;
> +	else
> +		status = HAL_STATUS_FAILED;
> +
> +done:
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
> -			HAL_OP_HF_CLIENT_START_VR, HAL_STATUS_UNSUPPORTED);
> +			HAL_OP_HF_CLIENT_START_VR, status);
>  }
>  
>  static void handle_stop_vr(const void *buf, uint16_t len)
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
> +	if (hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL, "AT+BVRA=0"))
> +		status = HAL_STATUS_SUCCESS;
> +	else
> +		status = HAL_STATUS_FAILED;
> +
> +done:
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
> -			HAL_OP_HF_CLIENT_STOP_VR, HAL_STATUS_UNSUPPORTED);
> +			HAL_OP_HF_CLIENT_STOP_VR, status);
>  }
>  
>  static void handle_volume_control(const void *buf, uint16_t len)
> @@ -447,6 +529,20 @@ static void get_local_codecs_string(struct device *dev, char *buf,
>  	}
>  }
>  
> +static void bvra_cb(struct hfp_context *context, void *user_data)
> +{
> +	struct hal_ev_hf_client_vr_state ev;
> +	uint32_t val;

Should be unsigned int.

> +
> +	if (!hfp_context_get_number(context, &val))
> +		return;
> +
> +	ev.state = val ? HAL_HF_CLIENT_VR_STARTED : HAL_HF_CLIENT_VR_STOPPED;

We should verify if val is valid ie.
if (!hfp_context_get_number(context, &val) || val > 1)
  return;


> +
> +	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +				HAL_EV_HF_CLIENT_VR_STATE, sizeof(ev), &ev);
> +}
> +
>  static void slc_completed(struct device *dev)
>  {
>  	DBG("");
> @@ -457,6 +553,8 @@ static void slc_completed(struct device *dev)
>  	 * TODO: Notify Android with indicators, register unsolicited result
>  	 * handlers
>  	 */
> +
> +	hfp_hf_register(dev->hf, bvra_cb, "+BRVA", dev, NULL);
>  }
>  
>  static void slc_chld_cb(struct hfp_context *context, void *user_data)
> 

-- 
Best regards, 
Szymon Janc

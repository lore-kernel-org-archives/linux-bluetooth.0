Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/5] android/handsfree-client: Implement audio connect/disconnect
Date: Thu, 27 Nov 2014 21:51:12 +0100
Message-ID: <101224339.xf6gZFyOGS@athlon>
In-Reply-To: <1416912448-28177-4-git-send-email-lukasz.rymanowski@tieto.com>
References: <1416912448-28177-1-git-send-email-lukasz.rymanowski@tieto.com> <1416912448-28177-4-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Tuesday 25 November 2014 11:47:26 Lukasz Rymanowski wrote:
> In this patch also set_audio_state function has been moved

One more thing: set_audio_state() was introduced in PATCH 2/5. Why not put it 
in right place from beginning?

> ---
>  android/handsfree-client.c | 100
> +++++++++++++++++++++++++++++++++------------ 1 file changed, 75
> insertions(+), 25 deletions(-)
> 
> diff --git a/android/handsfree-client.c b/android/handsfree-client.c
> index 432b9a1..4118b7e 100644
> --- a/android/handsfree-client.c
> +++ b/android/handsfree-client.c
> @@ -292,19 +292,89 @@ done:
>  			HAL_OP_HF_CLIENT_DISCONNECT, status);
>  }
> 
> +static bool connect_sco(struct device *dev)
> +{
> +	/* TODO: handle codec negotiation */
> +
> +	return bt_sco_connect(sco, &dev->bdaddr, 0);
> +}
> +
> +static void set_audio_state(struct device *dev, uint8_t state)
> +{
> +	struct hal_ev_hf_client_audio_state ev;
> +	char address[18];
> +
> +	if (dev->audio_state == state)
> +		return;
> +
> +	dev->audio_state = state;
> +
> +	ba2str(&dev->bdaddr, address);
> +	DBG("device %s audio state %u", address, state);
> +
> +	bdaddr2android(&dev->bdaddr, ev.bdaddr);
> +	ev.state = state;
> +
> +	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +				HAL_EV_HF_CLIENT_AUDIO_STATE, sizeof(ev), &ev);
> +}
> +
>  static void handle_connect_audio(const void *buf, uint16_t len)
>  {
> -	DBG("Not Implemented");
> +	const struct hal_cmd_hf_client_connect_audio *cmd = (void *) buf;
> +	struct device *dev;
> +	uint8_t status;
> +	bdaddr_t bdaddr;
> +
> +	DBG("");
> +
> +	android2bdaddr(&cmd->bdaddr, &bdaddr);
> +
> +	dev = find_device(&bdaddr);
> +	if (!dev || dev->state != HAL_HF_CLIENT_CONN_STATE_SLC_CONNECTED ||
> +		dev->audio_state != HAL_HF_CLIENT_AUDIO_STATE_DISCONNECTED) {
> +		error("hf-client: Cannot create SCO, check SLC or audio state");
> +		status = HAL_STATUS_FAILED;
> +		goto done;
> +	}
> +
> +	if (connect_sco(dev)) {
> +		status = HAL_STATUS_SUCCESS;
> +		set_audio_state(dev, HAL_HF_CLIENT_AUDIO_STATE_CONNECTING);
> +	} else {
> +		status = HAL_STATUS_FAILED;
> +	}
> +
> +done:
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
> -			HAL_OP_HF_CLIENT_CONNECT_AUDIO, HAL_STATUS_UNSUPPORTED);
> +					HAL_OP_HF_CLIENT_CONNECT_AUDIO, status);
>  }
> 
>  static void handle_disconnect_audio(const void *buf, uint16_t len)
>  {
> -	DBG("Not Implemented");
> +	const struct hal_cmd_hf_client_disconnect_audio *cmd = (void *) buf;
> +	struct device *dev;
> +	uint8_t status;
> +	bdaddr_t bdaddr;
> +
> +	DBG("");
> +
> +	android2bdaddr(&cmd->bdaddr, &bdaddr);
> +
> +	dev = find_device(&bdaddr);
> +	if (!dev ||
> +		dev->audio_state == HAL_HF_CLIENT_AUDIO_STATE_DISCONNECTED) {
> +		error("hf-client: Device not found or audio not connected");
> +		status = HAL_STATUS_FAILED;
> +		goto done;
> +	}
> +
> +	bt_sco_disconnect(sco);
> +	status = HAL_STATUS_SUCCESS;
> +
> +done:
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
> -					HAL_OP_HF_CLIENT_DISCONNECT_AUDIO,
> -					HAL_STATUS_UNSUPPORTED);
> +				HAL_OP_HF_CLIENT_DISCONNECT_AUDIO, status);
>  }
> 
>  static void cmd_complete_cb(enum hfp_result result, enum hfp_error cme_err,
> @@ -2011,26 +2081,6 @@ static void cleanup_hfp_hf(void)
>  	}
>  }
> 
> -static void set_audio_state(struct device *dev, uint8_t state)
> -{
> -	struct hal_ev_hf_client_audio_state ev;
> -	char address[18];
> -
> -	if (dev->audio_state == state)
> -		return;
> -
> -	dev->audio_state = state;
> -
> -	ba2str(&dev->bdaddr, address);
> -	DBG("device %s audio state %u", address, state);
> -
> -	bdaddr2android(&dev->bdaddr, ev.bdaddr);
> -	ev.state = state;
> -
> -	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
> -				HAL_EV_HF_CLIENT_AUDIO_STATE, sizeof(ev), &ev);
> -}
> -
>  static bool confirm_sco_cb(const bdaddr_t *addr, uint16_t *voice_settings)
>  {
>  	struct device *dev;

-- 
Szymon K. Janc
szymon.janc@gmail.com

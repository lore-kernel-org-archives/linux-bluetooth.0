Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 07/14] android/handsfree-client: Add support for +CIEV events
Date: Tue, 18 Nov 2014 20:54:15 +0100
Message-ID: <56655494.JMbJnzc3p6@leonov>
In-Reply-To: <1415789377-20458-8-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415789377-20458-1-git-send-email-lukasz.rymanowski@tieto.com> <1415789377-20458-8-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Wednesday 12 of November 2014 11:49:30 Lukasz Rymanowski wrote:
> ---
>  android/handsfree-client.c | 133
> ++++++++++++++++++++++++++++++++++++++++++++- 1 file changed, 132
> insertions(+), 1 deletion(-)
> 
> diff --git a/android/handsfree-client.c b/android/handsfree-client.c
> index d5899b0..97202d5 100644
> --- a/android/handsfree-client.c
> +++ b/android/handsfree-client.c
> @@ -95,11 +95,14 @@ enum hfp_indicator {
>  	HFP_INDICATOR_LAST
>  };
> 
> +typedef void (*ciev_func_t)(uint8_t val);
> +
>  struct indicator {
>  	uint8_t index;
>  	uint32_t min;
>  	uint32_t max;
>  	uint32_t val;
> +	ciev_func_t cb;
>  };
> 
>  struct hfp_codec {
> @@ -819,7 +822,39 @@ static void clcc_cb(struct hfp_context *context, void
> *user_data) }
> 
>  	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
> -			HAL_EV_HF_CLIENT_CURRENT_CALL, sizeof(*ev), ev);
> +					HAL_EV_HF_CLIENT_CURRENT_CALL,
> +					sizeof(*ev) + ev->number_len, ev);
> +}

Shouldn't this be part of 06/14 ?

> +
> +static void ciev_cb(struct hfp_context *context, void *user_data)
> +{
> +	struct device *dev = user_data;
> +	uint32_t index, val;

unsigned int

> +	int i;
> +
> +	DBG("");
> +
> +	if (!context) {
> +		error("hf-client: incorrect CLCC response");
> +		return;
> +	}

Callbacks are guaranteed to be called with valid context, so there is no need 
to check that (I think this affects multiple callbacks in other patches as 
well).

> +
> +	if (!hfp_context_get_number(context, &index))
> +		return;
> +
> +	if (!hfp_context_get_number(context, &val))
> +		return;
> +
> +	for (i = 0; i < HFP_INDICATOR_LAST; i++) {
> +		if (dev->ag_ind[i].index != index)
> +			continue;
> +
> +		if (dev->ag_ind[i].cb) {
> +			dev->ag_ind[i].val = val;
> +			dev->ag_ind[i].cb(val);
> +			return;
> +		}
> +	}
>  }
> 
>  static void slc_completed(struct device *dev)
> @@ -838,6 +873,7 @@ static void slc_completed(struct device *dev)
>  	hfp_hf_register(dev->hf, vgs_cb, "+VGS", dev, NULL);
>  	hfp_hf_register(dev->hf, brth_cb, "+BTRH", dev, NULL);
>  	hfp_hf_register(dev->hf, clcc_cb, "+CLCC", dev, NULL);
> +	hfp_hf_register(dev->hf, ciev_cb, "+CIEV", dev, NULL);
>  }
> 
>  static void slc_chld_cb(struct hfp_context *context, void *user_data)
> @@ -1008,6 +1044,94 @@ failed:
>  	slc_error(dev);
>  }
> 
> +static void ciev_service_cb(uint8_t val)
> +{
> +	struct hal_ev_hf_client_net_state ev;
> +
> +	DBG("");
> +
> +	ev.state = val;

This maps to enum so should be sanitized to IPC defines.
(those below as well)

> +
> +	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +				HAL_EV_HF_CLIENT_NET_STATE, sizeof(ev), &ev);
> +}
> +
> +static void ciev_call_cb(uint8_t val)
> +{
> +	struct hal_ev_hf_client_call_indicator ev;
> +
> +	DBG("");
> +
> +	ev.call = val;
> +
> +	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +			HAL_EV_HF_CLIENT_CALL_INDICATOR, sizeof(ev), &ev);
> +}
> +
> +static void ciev_callsetup_cb(uint8_t val)
> +{
> +	struct hal_ev_hf_client_call_setup_indicator ev;
> +
> +	DBG("");
> +
> +	ev.call_setup = val;
> +
> +	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +					HAL_EV_HF_CLIENT_CALL_SETUP_INDICATOR,
> +					sizeof(ev), &ev);
> +}
> +
> +static void ciev_callheld_cb(uint8_t val)
> +{
> +	struct hal_ev_hf_client_call_held_indicator ev;
> +
> +	DBG("");
> +
> +	ev.call_held = val;
> +
> +	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +					HAL_EV_HF_CLIENT_CALL_HELD_INDICATOR,
> +					sizeof(ev), &ev);
> +}
> +
> +static void ciev_signal_cb(uint8_t val)
> +{
> +	struct hal_ev_hf_client_net_signal_strength ev;
> +
> +	DBG("");
> +
> +	ev.signal_strength = val;
> +
> +	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +					HAL_EV_HF_CLIENT_NET_SIGNAL_STRENGTH,
> +					sizeof(ev), &ev);
> +}
> +
> +static void ciev_roam_cb(uint8_t val)
> +{
> +	struct hal_ev_hf_client_net_roaming_type ev;
> +
> +	DBG("");
> +
> +	ev.state = val;
> +
> +	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +					HAL_EV_HF_CLIENT_NET_ROAMING_TYPE,
> +					sizeof(ev), &ev);
> +}
> +
> +static void ciev_battchg_cb(uint8_t val)
> +{
> +	struct hal_ev_hf_client_battery_level ev;
> +
> +	DBG("");
> +
> +	ev.battery_level = val;
> +
> +	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +			HAL_EV_HF_CLIENT_BATTERY_LEVEL, sizeof(ev), &ev);
> +}
> +
>  static void set_indicator_parameters(uint8_t index, const char *indicator,
>  						unsigned int min,
>  						unsigned int max,
> @@ -1021,6 +1145,7 @@ static void set_indicator_parameters(uint8_t index,
> const char *indicator, ag_ind[HFP_INDICATOR_SERVICE].index = index;
>  		ag_ind[HFP_INDICATOR_SERVICE].min = min;
>  		ag_ind[HFP_INDICATOR_SERVICE].max = max;
> +		ag_ind[HFP_INDICATOR_SERVICE].cb = ciev_service_cb;
>  		return;
>  	}
> 
> @@ -1028,6 +1153,7 @@ static void set_indicator_parameters(uint8_t index,
> const char *indicator, ag_ind[HFP_INDICATOR_CALL].index = index;
>  		ag_ind[HFP_INDICATOR_CALL].min = min;
>  		ag_ind[HFP_INDICATOR_CALL].max = max;
> +		ag_ind[HFP_INDICATOR_CALL].cb = ciev_call_cb;
>  		return;
>  	}
> 
> @@ -1035,6 +1161,7 @@ static void set_indicator_parameters(uint8_t index,
> const char *indicator, ag_ind[HFP_INDICATOR_CALLSETUP].index = index;
>  		ag_ind[HFP_INDICATOR_CALLSETUP].min = min;
>  		ag_ind[HFP_INDICATOR_CALLSETUP].max = max;
> +		ag_ind[HFP_INDICATOR_CALLSETUP].cb = ciev_callsetup_cb;
>  		return;
>  	}
> 
> @@ -1042,6 +1169,7 @@ static void set_indicator_parameters(uint8_t index,
> const char *indicator, ag_ind[HFP_INDICATOR_CALLHELD].index = index;
>  		ag_ind[HFP_INDICATOR_CALLHELD].min = min;
>  		ag_ind[HFP_INDICATOR_CALLHELD].max = max;
> +		ag_ind[HFP_INDICATOR_CALLHELD].cb = ciev_callheld_cb;
>  		return;
>  	}
> 
> @@ -1049,6 +1177,7 @@ static void set_indicator_parameters(uint8_t index,
> const char *indicator, ag_ind[HFP_INDICATOR_SIGNAL].index = index;
>  		ag_ind[HFP_INDICATOR_SIGNAL].min = min;
>  		ag_ind[HFP_INDICATOR_SIGNAL].max = max;
> +		ag_ind[HFP_INDICATOR_SIGNAL].cb = ciev_signal_cb;
>  		return;
>  	}
> 
> @@ -1056,6 +1185,7 @@ static void set_indicator_parameters(uint8_t index,
> const char *indicator, ag_ind[HFP_INDICATOR_ROAM].index = index;
>  		ag_ind[HFP_INDICATOR_ROAM].min = min;
>  		ag_ind[HFP_INDICATOR_ROAM].max = max;
> +		ag_ind[HFP_INDICATOR_ROAM].cb = ciev_roam_cb;
>  		return;
>  	}
> 
> @@ -1063,6 +1193,7 @@ static void set_indicator_parameters(uint8_t index,
> const char *indicator, ag_ind[HFP_INDICATOR_BATTCHG].index = index;
>  		ag_ind[HFP_INDICATOR_BATTCHG].min = min;
>  		ag_ind[HFP_INDICATOR_BATTCHG].max = max;
> +		ag_ind[HFP_INDICATOR_BATTCHG].cb = ciev_battchg_cb;
>  		return;
>  	}

-- 
BR
Szymon Janc

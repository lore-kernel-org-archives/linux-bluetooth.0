Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] android/handsfree: Be more strict on SLC creation
Date: Fri, 31 Oct 2014 20:14:29 +0100
Message-ID: <108831214.UXe0fpUToK@leonov>
In-Reply-To: <1414746546-19132-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1414746546-19132-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Friday 31 of October 2014 10:09:06 Lukasz Rymanowski wrote:
> In case of any issue during SLC creation lets just drop the link
> ---
> v2: added check on CMER callback
> 
>  android/handsfree.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/android/handsfree.c b/android/handsfree.c
> index 595919a..d7c6937 100644
> --- a/android/handsfree.c
> +++ b/android/handsfree.c
> @@ -1193,6 +1193,9 @@ static void at_cmd_cmer(struct hfp_gw_result *result,
> enum hfp_gw_cmd_type type, }
> 
>  	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
> +
> +	if (dev->state != HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED)
> +		hfp_gw_disconnect(dev->gw);
>  }
> 
>  static void at_cmd_cind(struct hfp_gw_result *result, enum hfp_gw_cmd_type
> type, @@ -1251,6 +1254,9 @@ static void at_cmd_cind(struct hfp_gw_result
> *result, enum hfp_gw_cmd_type type, }
> 
>  	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
> +
> +	if (dev->state != HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED)
> +		hfp_gw_disconnect(dev->gw);
>  }
> 
>  static void at_cmd_brsf(struct hfp_gw_result *result, enum hfp_gw_cmd_type
> type, @@ -1280,6 +1286,9 @@ static void at_cmd_brsf(struct hfp_gw_result
> *result, enum hfp_gw_cmd_type type, }
> 
>  	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
> +
> +	if (dev->state != HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED)
> +		hfp_gw_disconnect(dev->gw);
>  }
> 
>  static void at_cmd_chld(struct hfp_gw_result *result, enum hfp_gw_cmd_type
> type, @@ -1319,6 +1328,9 @@ static void at_cmd_chld(struct hfp_gw_result
> *result, enum hfp_gw_cmd_type type, }
> 
>  	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
> +
> +	if (dev->state != HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED)
> +		hfp_gw_disconnect(dev->gw);
>  }
> 
>  static struct hfp_codec *find_codec_by_type(struct hf_device *dev, uint8_t
> type) @@ -1392,6 +1404,9 @@ static void at_cmd_bac(struct hfp_gw_result
> *result, enum hfp_gw_cmd_type type,
> 
>  failed:
>  	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
> +
> +	if (dev->state != HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED)
> +		hfp_gw_disconnect(dev->gw);
>  }
> 
>  static void register_slc_at(struct hf_device *dev)

Applied, thanks.

-- 
BR
Szymon Janc

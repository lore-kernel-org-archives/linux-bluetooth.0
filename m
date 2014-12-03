Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/bluetooth: Add support to read LE features by Android
Date: Wed, 03 Dec 2014 10:04:10 +0100
Message-ID: <3501439.5pFPeTDH5C@uw000953>
In-Reply-To: <1417443480-608-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1417443480-608-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Monday 01 of December 2014 15:18:00 Lukasz Rymanowski wrote:
> This patch adds support to read LE features by Android framework.
> For now we set all to 0.
> ---
>  android/bluetooth.c | 18 ++++++++++++++++++
>  android/hal-msg.h   |  1 +
>  2 files changed, 19 insertions(+)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index f79ca37..989f5d5 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -176,6 +176,7 @@ static struct {
>  
>  	char *name;
>  
> +	uint8_t le_features[8];

I'm still not sure how we get required info but I think we should construct
this on-demand to avoid doubling state ie. local_privacy_enabled can be get
from current_settings.

>  	uint32_t current_settings;
>  	uint32_t supported_settings;
>  
> @@ -189,6 +190,7 @@ static struct {
>  	.index = MGMT_INDEX_NONE,
>  	.dev_class = 0,
>  	.name = NULL,
> +	.le_features = {0},
>  	.current_settings = 0,
>  	.supported_settings = 0,
>  	.cur_discovery_type = SCAN_TYPE_NONE,
> @@ -3784,6 +3786,14 @@ static uint8_t get_adapter_discoverable_timeout(void)
>  	return HAL_STATUS_SUCCESS;
>  }
>  
> +static uint8_t get_adapter_le_features(void)
> +{
> +	send_adapter_property(HAL_PROP_ADAPTER_LOCAL_LE_FEAT,
> +					sizeof(adapter.le_features),
> +					&adapter.le_features[0]);
> +	return HAL_STATUS_SUCCESS;
> +}
> +
>  static void handle_get_adapter_prop_cmd(const void *buf, uint16_t len)
>  {
>  	const struct hal_cmd_get_adapter_prop *cmd = buf;
> @@ -3817,6 +3827,9 @@ static void handle_get_adapter_prop_cmd(const void *buf, uint16_t len)
>  	case HAL_PROP_ADAPTER_DISC_TIMEOUT:
>  		status = get_adapter_discoverable_timeout();
>  		break;
> +	case HAL_PROP_ADAPTER_LOCAL_LE_FEAT:
> +		status = get_adapter_le_features();
> +		break;
>  	default:
>  		status = HAL_STATUS_FAILED;
>  		break;
> @@ -3898,6 +3911,11 @@ static void get_adapter_properties(void)
>  									uuids);
>  	ev->num_props++;
>  
> +	size += fill_hal_prop(buf + size, HAL_PROP_ADAPTER_LOCAL_LE_FEAT,
> +			sizeof(adapter.le_features), &adapter.le_features[0]);

adapter.le_features instead of &adapter.le_features[0]

> +
> +	ev->num_props++;
> +
>  	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
>  				HAL_EV_ADAPTER_PROPS_CHANGED, size, buf);
>  }
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index 33b53c5..67c6573 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -142,6 +142,7 @@ struct hal_prop_device_info {
>  	uint16_t manufacturer;
>  } __attribute__((packed));
>  
> +#define HAL_PROP_ADAPTER_LOCAL_LE_FEAT		0x0d
>  #define HAL_PROP_DEVICE_TIMESTAMP		0xFF
>  
>  #define HAL_ADAPTER_SCAN_MODE_NONE		0x00
> 

-- 
Best regards, 
Szymon Janc

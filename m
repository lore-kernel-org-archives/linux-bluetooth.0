Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] android/client: Add support to read local le features
Date: Thu, 27 Nov 2014 12:20:57 +0100
Message-ID: <1482662.kF47smfGG4@uw000953>
In-Reply-To: <1417080540-16430-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1417080540-16430-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Thursday 27 of November 2014 10:29:00 Lukasz Rymanowski wrote:
> ---
>  android/hal-utils.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/android/hal-utils.c b/android/hal-utils.c
> index 05e8920..f18a82c 100644
> --- a/android/hal-utils.c
> +++ b/android/hal-utils.c
> @@ -22,6 +22,7 @@
>  
>  #include <cutils/properties.h>
>  
> +#include "hal.h"
>  #include "hal-utils.h"
>  
>  /*
> @@ -116,6 +117,7 @@ INTMAP(bt_ssp_variant_t, -1, "(unknown)")
>  	DELEMENT(BT_SSP_VARIANT_PASSKEY_NOTIFICATION),
>  ENDMAP
>  
> +#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
>  INTMAP(bt_property_type_t, -1, "(unknown)")
>  	DELEMENT(BT_PROPERTY_BDNAME),
>  	DELEMENT(BT_PROPERTY_BDADDR),
> @@ -129,8 +131,26 @@ INTMAP(bt_property_type_t, -1, "(unknown)")
>  	DELEMENT(BT_PROPERTY_REMOTE_FRIENDLY_NAME),
>  	DELEMENT(BT_PROPERTY_REMOTE_RSSI),
>  	DELEMENT(BT_PROPERTY_REMOTE_VERSION_INFO),
> +	DELEMENT(BT_PROPERTY_LOCAL_LE_FEATURES),
>  	DELEMENT(BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP),
>  ENDMAP
> +#else
> +INTMAP(bt_property_type_t, -1, "(unknown)")
> +	DELEMENT(BT_PROPERTY_BDNAME),
> +	DELEMENT(BT_PROPERTY_BDADDR),
> +	DELEMENT(BT_PROPERTY_UUIDS),
> +	DELEMENT(BT_PROPERTY_CLASS_OF_DEVICE),
> +	DELEMENT(BT_PROPERTY_TYPE_OF_DEVICE),
> +	DELEMENT(BT_PROPERTY_SERVICE_RECORD),
> +	DELEMENT(BT_PROPERTY_ADAPTER_SCAN_MODE),
> +	DELEMENT(BT_PROPERTY_ADAPTER_BONDED_DEVICES),
> +	DELEMENT(BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT),
> +	DELEMENT(BT_PROPERTY_REMOTE_FRIENDLY_NAME),
> +	DELEMENT(BT_PROPERTY_REMOTE_RSSI),
> +	DELEMENT(BT_PROPERTY_REMOTE_VERSION_INFO),
> +	DELEMENT(BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP),
> +ENDMAP
> +#endif
>  
>  INTMAP(bt_cb_thread_evt, -1, "(unknown)")
>  	DELEMENT(ASSOCIATE_JVM),
> @@ -326,7 +346,55 @@ const char *btproperty2str(const bt_property_t *property)
>  						rec->channel, rec->name);
>  		}
>  		break;
> +#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
> +	case BT_PROPERTY_LOCAL_LE_FEATURES:
> +		{
> +			bt_local_le_features_t *f = property->val;
> +			int l;
> +			uint16_t s;
> +
> +			l = sprintf(p, "{\n");
> +			p += l;
> +
> +			l = sprintf(p, "Privacy supported: %s,\n",
> +						f->local_privacy_enabled ?
> +						"TRUE" : "FALSE");
> +			p += l;
> +
> +			l = sprintf(p, "Num of advertising instances: %u,\n",
> +							f->max_adv_instance);
> +			p += l;
> +
> +			l = sprintf(p, "PRA offloading support: %s,\n",
> +						f->rpa_offload_supported ?
> +						"TRUE" : "FALSE");
> +
> +			p += l;
>  
> +			l = sprintf(p, "Num of offloaded IRKs: %u,\n",
> +							f->max_irk_list_size);
> +			p += l;
> +
> +			l = sprintf(p, "Num of offloaded scan filters: %u,\n",
> +						f->max_adv_filter_supported);
> +			p += l;
> +
> +			s = (f->scan_result_storage_size_hibyte << 8) +
> +					f->scan_result_storage_size_lobyte;
> +
> +			l = sprintf(p, "Num of offloaded scan results: %u,\n",
> +									s);
> +			p += l;
> +
> +			l = sprintf(p, "Activity & energy report support: %s\n",
> +					f->activity_energy_info_supported ?
> +					"TRUE" : "FALSE");
> +			p += l;
> +
> +			sprintf(p, "}");
> +		}
> +		break;
> +#endif
>  	default:
>  		sprintf(p, "%p", property->val);
>  	}
> 

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc

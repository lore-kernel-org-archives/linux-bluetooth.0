Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/6] android/hal-mce: Add skeleton for MCE HAL
Date: Fri, 03 Oct 2014 13:26:07 +0200
Message-ID: <1970483.kN1WvSl8Od@uw000953>
In-Reply-To: <1411383708-28621-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1411383708-28621-1-git-send-email-grzegorz.kolodziejczyk@tieto.com> <1411383708-28621-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Monday 22 of September 2014 13:01:46 Grzegorz Kolodziejczyk wrote:
> This adds skeleton with stubs and proper build system entries.
> ---
>  android/Android.mk           |  1 +
>  android/Makefile.am          |  1 +
>  android/hal-bluetooth.c      |  3 ++
>  android/hal-map-client.c     | 92 ++++++++++++++++++++++++++++++++++++++++++++
>  android/hal-msg.h            |  3 +-
>  android/hal.h                |  2 +
>  android/hardware/bluetooth.h |  1 +
>  7 files changed, 102 insertions(+), 1 deletion(-)
>  create mode 100644 android/hal-map-client.c
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index 4a14474..6dfd801 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -128,6 +128,7 @@ LOCAL_SRC_FILES := \
>  	bluez/android/hal-gatt.c \
>  	bluez/android/hal-utils.c \
>  	bluez/android/hal-health.c \
> +	bluez/android/hal-map-client.c \
>  
>  ifeq ($(BLUEZ_EXTENSIONS), true)
>  LOCAL_SRC_FILES += bluez/android/hal-handsfree-client.c
> diff --git a/android/Makefile.am b/android/Makefile.am
> index 9980c4c..92f3df1 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -77,6 +77,7 @@ android_bluetooth_default_la_SOURCES = android/hal.h android/hal-bluetooth.c \
>  					android/hal-handsfree.c \
>  					android/hal-handsfree-client.c \
>  					android/hal-gatt.c \
> +					android/hal-map-client.c \
>  					android/hardware/bluetooth.h \
>  					android/hardware/bt_av.h \
>  					android/hardware/bt_gatt.h \
> diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
> index 7c8c2ee..2706773 100644
> --- a/android/hal-bluetooth.c
> +++ b/android/hal-bluetooth.c
> @@ -786,6 +786,9 @@ static const void *get_profile_interface(const char *profile_id)
>  #if BLUEZ_EXTENSIONS
>  	if (!strcmp(profile_id, BT_PROFILE_HANDSFREE_CLIENT_ID))
>  		return bt_get_hf_client_interface();
> +
> +	if (!strcmp(profile_id, BT_PROFILE_MAP_CLIENT_ID))
> +		return bt_get_map_client_interface();
>  #endif
>  
>  	return NULL;
> diff --git a/android/hal-map-client.c b/android/hal-map-client.c
> new file mode 100644
> index 0000000..7fb3011
> --- /dev/null
> +++ b/android/hal-map-client.c
> @@ -0,0 +1,92 @@
> +/*
> + * Copyright (C) 2014 Intel Corporation
> + *
> + * Licensed under the Apache License, Version 2.0 (the "License");
> + * you may not use this file except in compliance with the License.
> + * You may obtain a copy of the License at
> + *
> + *      http://www.apache.org/licenses/LICENSE-2.0
> + *
> + * Unless required by applicable law or agreed to in writing, software
> + * distributed under the License is distributed on an "AS IS" BASIS,
> + * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
> + * See the License for the specific language governing permissions and
> + * limitations under the License.
> + *
> + */
> +
> +#include <stdbool.h>
> +
> +#include "hal-log.h"
> +#include "hal.h"
> +#include "hal-msg.h"
> +#include "hal-ipc.h"
> +
> +static const btmce_callbacks_t *cbs = NULL;
> +
> +static bool interface_ready(void)
> +{
> +	return cbs != NULL;
> +}
> +
> +/* Event Handlers */
> +
> +static void handle_remote_mas_instances(void *buf, uint16_t len, int fd)
> +{
> +
> +}
> +
> +/* handlers will be called from notification thread context,
> + * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
> + */

Multiline comment should be like
/*
 * foo
 * bar
 */

> +static const struct hal_ipc_handler ev_handlers[] = {
> +	/* HAL_EV_MCE_REMOTE_MAS_INSTANCES */
> +	{ handle_remote_mas_instances, true,
> +			sizeof(struct hal_ev_map_client_remote_mas_instances) }
> +};
> +
> +/* API */
> +
> +static bt_status_t get_remote_mas_instances(bt_bdaddr_t *bd_addr)
> +{
> +	return BT_STATUS_UNSUPPORTED;
> +}
> +
> +static bt_status_t init(btmce_callbacks_t *callbacks)
> +{
> +	struct hal_cmd_register_module cmd;
> +	int ret;
> +
> +	DBG("");
> +
> +	if (interface_ready())
> +		return BT_STATUS_DONE;
> +
> +	cbs = callbacks;
> +
> +	hal_ipc_register(HAL_SERVICE_ID_MAP_CLIENT, ev_handlers,
> +				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
> +
> +	cmd.service_id = HAL_SERVICE_ID_MAP_CLIENT;
> +
> +	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
> +					sizeof(cmd), &cmd, 0, NULL, NULL);
> +
> +	if (ret != BT_STATUS_SUCCESS) {
> +		cbs = NULL;
> +		hal_ipc_unregister(HAL_SERVICE_ID_MAP_CLIENT);
> +	}
> +
> +	return ret;
> +}
> +
> +static btmce_interface_t iface = {
> +	.size = sizeof(iface),
> +	.init = init,
> +	.get_remote_mas_instances = get_remote_mas_instances
> +};
> +
> +btmce_interface_t *bt_get_map_client_interface(void)
> +{
> +	return &iface;
> +}
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index ca5f5a1..d13b6ce 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -36,8 +36,9 @@ static const char BLUEZ_HAL_SK_PATH[] = "\0bluez_hal_socket";
>  #define HAL_SERVICE_ID_AVRCP		8
>  #define HAL_SERVICE_ID_GATT		9
>  #define HAL_SERVICE_ID_HANDSFREE_CLIENT	10
> +#define HAL_SERVICE_ID_MAP_CLIENT	11
>  
> -#define HAL_SERVICE_ID_MAX HAL_SERVICE_ID_HANDSFREE_CLIENT
> +#define HAL_SERVICE_ID_MAX HAL_SERVICE_ID_MAP_CLIENT
>  
>  /* Core Service */
>  
> diff --git a/android/hal.h b/android/hal.h
> index c34022d..cff1b35 100644
> --- a/android/hal.h
> +++ b/android/hal.h
> @@ -26,6 +26,7 @@
>  #include <hardware/bt_gatt_client.h>
>  #include <hardware/bt_gatt_server.h>
>  #include <hardware/bt_hl.h>
> +#include <hardware/bt_mce.h>
>  
>  #ifdef BLUEZ_EXTENSIONS
>  #include <hardware/bt_hf_client.h>
> @@ -39,6 +40,7 @@ btrc_interface_t *bt_get_avrcp_interface(void);
>  bthf_interface_t *bt_get_handsfree_interface(void);
>  btgatt_interface_t *bt_get_gatt_interface(void);
>  bthl_interface_t *bt_get_health_interface(void);
> +btmce_interface_t *bt_get_map_client_interface(void);
>  
>  #ifdef BLUEZ_EXTENSIONS
>  bthf_client_interface_t *bt_get_hf_client_interface(void);
> diff --git a/android/hardware/bluetooth.h b/android/hardware/bluetooth.h
> index 0d3283b..b957c6f 100644
> --- a/android/hardware/bluetooth.h
> +++ b/android/hardware/bluetooth.h
> @@ -43,6 +43,7 @@ __BEGIN_DECLS
>  #define BT_PROFILE_SOCKETS_ID "socket"
>  #define BT_PROFILE_HIDHOST_ID "hidhost"
>  #define BT_PROFILE_PAN_ID "pan"
> +#define BT_PROFILE_MAP_CLIENT_ID "map_client"
>  
>  #define BT_PROFILE_GATT_ID "gatt"
>  #define BT_PROFILE_AV_RC_ID "avrcp"
> 

-- 
Best regards, 
Szymon Janc

Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: Re: [PATCH v2 04/16] android/hf-client: Add hf-client HAL skeleton
Date: Thu, 11 Sep 2014 13:48:05 +0200
Message-ID: <1519965.r84ipGVZYs@uw000953>
In-Reply-To: <1410348854-26249-5-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410348854-26249-1-git-send-email-lukasz.rymanowski@tieto.com> <1410348854-26249-5-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Wednesday 10 of September 2014 13:34:02 Lukasz Rymanowski wrote:
> ---
>  android/Makefile.am     |   2 +
>  android/hal-bluetooth.c |   3 ++
>  android/hal-hf-client.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++
>  android/hal.h           |   2 +
>  4 files changed, 108 insertions(+)
>  create mode 100644 android/hal-hf-client.c
> 
> diff --git a/android/Makefile.am b/android/Makefile.am
> index e92ccf1..9464df7 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -75,6 +75,7 @@ android_bluetooth_default_la_SOURCES = android/hal.h android/hal-bluetooth.c \
>  					android/hal-a2dp.c \
>  					android/hal-avrcp.c \
>  					android/hal-handsfree.c \
> +					android/hal-hf-client.c \

hal-handsfree-client.c

>  					android/hal-gatt.c \
>  					android/hardware/bluetooth.h \
>  					android/hardware/bt_av.h \
> @@ -88,6 +89,7 @@ android_bluetooth_default_la_SOURCES = android/hal.h android/hal-bluetooth.c \
>  					android/hardware/bt_pan.h \
>  					android/hardware/bt_rc.h \
>  					android/hardware/bt_sock.h \
> +					android/hardware/bt_hf_client.h \
>  					android/hardware/hardware.h \
>  					android/cutils/properties.h \
>  					android/ipc-common.h \
> diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
> index 44eddbd..dd2c9b8 100644
> --- a/android/hal-bluetooth.c
> +++ b/android/hal-bluetooth.c
> @@ -783,6 +783,9 @@ static const void *get_profile_interface(const char *profile_id)
>  	if (!strcmp(profile_id, BT_PROFILE_HEALTH_ID))
>  		return bt_get_health_interface();
>  
> +	if (!strcmp(profile_id, BT_PROFILE_HANDSFREE_CLIENT_ID))
> +		return bt_get_hf_client_interface();
> +
>  	return NULL;
>  }
>  
> diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
> new file mode 100644
> index 0000000..40553ff
> --- /dev/null
> +++ b/android/hal-hf-client.c
> @@ -0,0 +1,101 @@
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
> +#include <stddef.h>
> +#include <string.h>
> +#include <stdlib.h>
> +
> +#include <cutils/properties.h>
> +
> +#include "hal-log.h"
> +#include "hal.h"
> +#include "hal-msg.h"
> +#include "ipc-common.h"
> +#include "hal-ipc.h"
> +
> +static const bthf_client_callbacks_t *cbs = NULL;
> +
> +static bool interface_ready(void)
> +{
> +	return cbs != NULL;
> +}
> +
> +/*
> + * handlers will be called from notification thread context,
> + * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
> + */
> +static const struct hal_ipc_handler ev_handlers[] = {
> +};
> +
> +static bt_status_t init(bthf_client_callbacks_t *callbacks)
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
> +	hal_ipc_register(HAL_SERVICE_ID_HF_CLIENT, ev_handlers,
> +				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
> +
> +	cmd.service_id = HAL_SERVICE_ID_HF_CLIENT;
> +
> +	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
> +					sizeof(cmd), &cmd, NULL, NULL, NULL);
> +
> +	if (ret != BT_STATUS_SUCCESS) {
> +		cbs = NULL;
> +		hal_ipc_unregister(HAL_SERVICE_ID_HF_CLIENT);
> +	}
> +
> +	return ret;
> +}
> +
> +static void cleanup(void)
> +{
> +	struct hal_cmd_unregister_module cmd;
> +
> +	DBG("");
> +
> +	if (!interface_ready())
> +		return;
> +
> +	cbs = NULL;
> +
> +	cmd.service_id = HAL_SERVICE_ID_HF_CLIENT;
> +
> +	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
> +					sizeof(cmd), &cmd, NULL, NULL, NULL);
> +
> +	hal_ipc_unregister(HAL_SERVICE_ID_HF_CLIENT);
> +}
> +
> +static bthf_client_interface_t iface = {
> +	.size = sizeof(iface),
> +	.init = init,
> +	.cleanup = cleanup
> +};
> +
> +bthf_client_interface_t *bt_get_hf_client_interface(void)
> +{
> +	return &iface;
> +}
> diff --git a/android/hal.h b/android/hal.h
> index 6998e9a..be81ed9 100644
> --- a/android/hal.h
> +++ b/android/hal.h
> @@ -26,6 +26,7 @@
>  #include <hardware/bt_gatt_client.h>
>  #include <hardware/bt_gatt_server.h>
>  #include <hardware/bt_hl.h>
> +#include <hardware/bt_hf_client.h>
>  
>  btsock_interface_t *bt_get_socket_interface(void);
>  bthh_interface_t *bt_get_hidhost_interface(void);
> @@ -35,6 +36,7 @@ btrc_interface_t *bt_get_avrcp_interface(void);
>  bthf_interface_t *bt_get_handsfree_interface(void);
>  btgatt_interface_t *bt_get_gatt_interface(void);
>  bthl_interface_t *bt_get_health_interface(void);
> +bthf_client_interface_t *bt_get_hf_client_interface(void);
>  
>  void bt_thread_associate(void);
>  void bt_thread_disassociate(void);
> 

-- 
Best regards, 
Szymon Janc

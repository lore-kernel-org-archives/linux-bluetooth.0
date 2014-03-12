Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 07/15] android/hal-health: Add hal-health file
Date: Wed, 12 Mar 2014 20:53:39 +0100
Message-ID: <4044318.cAyboNQova@athlon>
In-Reply-To: <1394637058-586-8-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1394637058-586-8-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Wednesday 12 March 2014 17:10:50 Ravi kumar Veeramally wrote:
> Add hal-health.c and initial get interface method.
> ---
>  android/Android.mk   |  1 +
>  android/Makefile.am  |  1 +
>  android/hal-health.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  android/hal.h        |  2 ++
>  4 files changed, 46 insertions(+)
>  create mode 100644 android/hal-health.c
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index 49bf108..0352beb 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -121,6 +121,7 @@ LOCAL_SRC_FILES := \
>  	bluez/android/hal-handsfree.c \
>  	bluez/android/hal-gatt.c \
>  	bluez/android/hal-utils.c \
> +	bluez/android/hal-health.c \
> 
>  LOCAL_C_INCLUDES += \
>  	$(call include-path-for, system-core) \
> diff --git a/android/Makefile.am b/android/Makefile.am
> index bbd3d2f..d2cfed6 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -52,6 +52,7 @@ plugin_LTLIBRARIES += android/bluetooth.default.la
>  android_bluetooth_default_la_SOURCES = android/hal.h
> android/hal-bluetooth.c \ android/hal-socket.c \
>  					android/hal-hidhost.c \
> +					android/hal-health.c \
>  					android/hal-pan.c \
>  					android/hal-a2dp.c \
>  					android/hal-avrcp.c \
> diff --git a/android/hal-health.c b/android/hal-health.c
> new file mode 100644
> index 0000000..55db7f6
> --- /dev/null
> +++ b/android/hal-health.c
> @@ -0,0 +1,42 @@
> +/*
> + * Copyright (C) 2013 Intel Corporation

Shouldn't that be 2014?

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
> + * See the License for the specific language governing permissions and + *
> limitations under the License.
> + *
> + */
> +
> +#include <stdbool.h>
> +#include <stddef.h>
> +#include <string.h>
> +#include <stdlib.h>
> +
> +#include "hal-log.h"
> +#include "hal.h"
> +#include "hal-msg.h"
> +#include "ipc-common.h"
> +#include "hal-ipc.h"
> +
> +static bthl_interface_t health_if = {
> +	.size = sizeof(health_if),
> +	.init = NULL,
> +	.register_application = NULL,
> +	.unregister_application = NULL,
> +	.connect_channel = NULL,
> +	.destroy_channel = NULL,
> +	.cleanup = NULL
> +};
> +
> +bthl_interface_t *bt_get_health_interface(void)
> +{
> +	return &health_if;
> +}
> diff --git a/android/hal.h b/android/hal.h
> index b1c0216..6998e9a 100644
> --- a/android/hal.h
> +++ b/android/hal.h
> @@ -25,6 +25,7 @@
>  #include <hardware/bt_gatt.h>
>  #include <hardware/bt_gatt_client.h>
>  #include <hardware/bt_gatt_server.h>
> +#include <hardware/bt_hl.h>
> 
>  btsock_interface_t *bt_get_socket_interface(void);
>  bthh_interface_t *bt_get_hidhost_interface(void);
> @@ -33,6 +34,7 @@ btav_interface_t *bt_get_a2dp_interface(void);
>  btrc_interface_t *bt_get_avrcp_interface(void);
>  bthf_interface_t *bt_get_handsfree_interface(void);
>  btgatt_interface_t *bt_get_gatt_interface(void);
> +bthl_interface_t *bt_get_health_interface(void);
> 

This should be called from get_profile_interface() in hal-bluetooth.c

>  void bt_thread_associate(void);
>  void bt_thread_disassociate(void);

-- 
Szymon K. Janc
szymon.janc@gmail.com

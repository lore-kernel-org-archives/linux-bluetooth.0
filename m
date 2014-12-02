Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 2/2] android/avrcp: Initial support for AVRCP controller interface
Date: Tue, 02 Dec 2014 18:24:31 +0100
Message-ID: <1665825.84DJKl8bKg@uw000953>
In-Reply-To: <1416564895-18577-2-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1416564895-18577-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1416564895-18577-2-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Friday 21 of November 2014 12:14:55 Ravi kumar Veeramally wrote:
> Initial register and unregister service functionality provided.
> Either AVRCP target or controller role registered not both at
> a time.
> ---
>  android/Android.mk                |   1 +
>  android/Makefile.am               |   1 +
>  android/avrcp-ctrl.c              | 132 ++++++++++++++++++++++++++++++++++++++
>  android/{avrcp.h => avrcp-ctrl.h} |  11 ++--
>  android/avrcp.c                   |  11 ++++
>  android/avrcp.h                   |   1 +
>  android/main.c                    |  12 ++++
>  7 files changed, 163 insertions(+), 6 deletions(-)
>  create mode 100644 android/avrcp-ctrl.c
>  copy android/{avrcp.h => avrcp-ctrl.h} (75%)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index 34c6186..73b65fe 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -49,6 +49,7 @@ LOCAL_SRC_FILES := \
>  	bluez/android/avctp.c \
>  	bluez/android/avrcp-common.c \
>  	bluez/android/avrcp.c \
> +	bluez/android/avrcp-ctrl.c \
>  	bluez/android/avrcp-lib.c \
>  	bluez/android/pan.c \
>  	bluez/android/handsfree.c \
> diff --git a/android/Makefile.am b/android/Makefile.am
> index 98b8a3a..5a6f3ee 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -39,6 +39,7 @@ android_bluetoothd_SOURCES = android/main.c \
>  				android/avctp.h android/avctp.c \
>  				android/avrcp-common.h android/avrcp-common.c \
>  				android/avrcp.h android/avrcp.c \
> +				android/avrcp-ctrl.h android/avrcp-ctrl.c \
>  				android/avrcp-lib.h android/avrcp-lib.c \
>  				android/socket.h android/socket.c \
>  				android/pan.h android/pan.c \
> diff --git a/android/avrcp-ctrl.c b/android/avrcp-ctrl.c
> new file mode 100644
> index 0000000..ec247d2
> --- /dev/null
> +++ b/android/avrcp-ctrl.c
> @@ -0,0 +1,132 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2014  Intel Corporation. All rights reserved.
> + *
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <errno.h>
> +#include <glib.h>
> +
> +#include "btio/btio.h"
> +#include "lib/bluetooth.h"
> +#include "lib/sdp.h"
> +#include "lib/sdp_lib.h"
> +#include "src/sdp-client.h"
> +#include "src/shared/util.h"
> +#include "src/log.h"
> +
> +#include "avctp.h"
> +#include "avrcp-lib.h"
> +#include "hal-msg.h"
> +#include "ipc-common.h"
> +#include "ipc.h"
> +#include "bluetooth.h"
> +#include "avrcp.h"
> +#include "avrcp-ctrl.h"
> +#include "avrcp-common.h"
> +#include "utils.h"
> +
> +#define L2CAP_PSM_AVCTP 0x17
> +
> +#define AVRCP_FEATURE_CATEGORY_1        0x0001
> +#define AVRCP_FEATURE_CATEGORY_2        0x0002
> +#define AVRCP_FEATURE_CATEGORY_3        0x0004
> +#define AVRCP_FEATURE_CATEGORY_4        0x0008
> +
> +static bdaddr_t adapter_addr;
> +static uint32_t record_ct_id = 0;
> +static struct ipc *hal_ipc = NULL;
> +
> +static void handle_send_passthrough(const void *buf, uint16_t len)
> +{
> +	DBG("Not Implemented");
> +
> +	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_AVRCP_CTRL,
> +					HAL_OP_AVRCP_CTRL_SEND_PASSTHROUGH,
> +							HAL_STATUS_UNSUPPORTED);
> +}
> +
> +static const struct ipc_handler cmd_handlers[] = {
> +	/* HAL_OP_AVRCP_CTRL_SEND_PASSTHROUGH */
> +	{ handle_send_passthrough, false,
> +			sizeof(struct hal_cmd_avrcp_ctrl_send_passthrough) },
> +};
> +
> +bool bt_avrcp_ctrl_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
> +{
> +	sdp_record_t *rec;
> +	uint16_t features;
> +
> +	DBG("");
> +
> +	if (!bt_is_avrcp_registered()) {
> +		error("avrcp-ctrl: avrcp target already registered");
> +		return false;
> +	}
> +
> +	bacpy(&adapter_addr, addr);
> +
> +	features = AVRCP_FEATURE_CATEGORY_2 | AVRCP_FEATURE_CATEGORY_3 |
> +						AVRCP_FEATURE_CATEGORY_4;
> +
> +	rec = avrcp_ct_record(features);
> +	if (!rec) {
> +		error("avrcp-ctrl: Failed to allocate AVRCP CT record");
> +		goto fail;
> +	}
> +
> +	if (bt_adapter_add_record(rec, 0) < 0) {
> +		error("avrcp-ctrl: Failed to register AVRCP CT record");
> +		sdp_record_free(rec);
> +		goto fail;
> +	}
> +	record_ct_id = rec->handle;
> +
> +	hal_ipc = ipc;
> +
> +	ipc_register(hal_ipc, HAL_SERVICE_ID_AVRCP_CTRL, cmd_handlers,
> +						G_N_ELEMENTS(cmd_handlers));
> +
> +	return true;
> +fail:
> +	return false;
> +}
> +
> +void bt_avrcp_ctrl_unregister(void)
> +{
> +	DBG("");
> +
> +	ipc_unregister(hal_ipc, HAL_SERVICE_ID_AVRCP_CTRL);
> +	hal_ipc = NULL;
> +
> +	bt_adapter_remove_record(record_ct_id);
> +	record_ct_id = 0;
> +}
> +
> +bool bt_is_avrcp_ctrl_registered(void)
> +{
> +	return (hal_ipc != NULL);
> +}

I don't like this. If we are going to have common code that can
be shared between those two HALs then this is not needed.
(I might have been not clear enough in our IRC discussion about that thought)

Since you decided to have common code both HALs should be able to run
concurrently eg. avrcp-common would handle sharing AVRCP session and respective
HALs implementation would handle IPC API only (this is just a suggestion).


> diff --git a/android/avrcp.h b/android/avrcp-ctrl.h
> similarity index 75%
> copy from android/avrcp.h
> copy to android/avrcp-ctrl.h
> index 11e79b7..72608e7 100644
> --- a/android/avrcp.h
> +++ b/android/avrcp-ctrl.h
> @@ -2,7 +2,7 @@
>   *
>   *  BlueZ - Bluetooth protocol stack for Linux
>   *
> - *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2014  Intel Corporation. All rights reserved.
>   *
>   *
>   *  This library is free software; you can redistribute it and/or
> @@ -21,8 +21,7 @@
>   *
>   */
>  
> -bool bt_avrcp_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
> -void bt_avrcp_unregister(void);
> -
> -void bt_avrcp_connect(const bdaddr_t *dst);
> -void bt_avrcp_disconnect(const bdaddr_t *dst);
> +bool bt_avrcp_ctrl_register(struct ipc *ipc, const bdaddr_t *addr,
> +								uint8_t mode);
> +void bt_avrcp_ctrl_unregister(void);
> +bool bt_is_avrcp_ctrl_registered(void);
> diff --git a/android/avrcp.c b/android/avrcp.c
> index d06ecc4..26f8d73 100644
> --- a/android/avrcp.c
> +++ b/android/avrcp.c
> @@ -46,6 +46,7 @@
>  #include "bluetooth.h"
>  #include "avrcp.h"
>  #include "avrcp-common.h"
> +#include "avrcp-ctrl.h"
>  #include "utils.h"
>  
>  #define L2CAP_PSM_AVCTP 0x17
> @@ -920,6 +921,11 @@ bool bt_avrcp_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
>  
>  	DBG("");
>  
> +	if (!bt_is_avrcp_ctrl_registered()) {
> +		error("AVRCP: avrcp controller already registered");
> +		return false;
> +	}
> +
>  	bacpy(&adapter_addr, addr);
>  
>  	server = bt_io_listen(NULL, confirm_cb, NULL, NULL, &err,
> @@ -1040,3 +1046,8 @@ void bt_avrcp_disconnect(const bdaddr_t *dst)
>  
>  	avrcp_device_remove(dev);
>  }
> +
> +bool bt_is_avrcp_registered(void)
> +{
> +	return (hal_ipc != NULL);
> +}
> diff --git a/android/avrcp.h b/android/avrcp.h
> index 11e79b7..4411d5c 100644
> --- a/android/avrcp.h
> +++ b/android/avrcp.h
> @@ -26,3 +26,4 @@ void bt_avrcp_unregister(void);
>  
>  void bt_avrcp_connect(const bdaddr_t *dst);
>  void bt_avrcp_disconnect(const bdaddr_t *dst);
> +bool bt_is_avrcp_registered(void);
> diff --git a/android/main.c b/android/main.c
> index 58dd9ab..66203b7 100644
> --- a/android/main.c
> +++ b/android/main.c
> @@ -64,6 +64,7 @@
>  #include "handsfree-client.h"
>  #include "map-client.h"
>  #include "utils.h"
> +#include "avrcp-ctrl.h"
>  
>  #define DEFAULT_VENDOR "BlueZ"
>  #define DEFAULT_MODEL "BlueZ for Android"
> @@ -208,6 +209,14 @@ static void service_register(const void *buf, uint16_t len)
>  		}
>  
>  		break;
> +	case HAL_SERVICE_ID_AVRCP_CTRL:
> +		if (!bt_avrcp_ctrl_register(hal_ipc, &adapter_bdaddr,
> +								m->mode)) {
> +			status = HAL_STATUS_FAILED;
> +			goto failed;
> +		}
> +
> +		break;
>  	case HAL_SERVICE_ID_HANDSFREE:
>  		if (!bt_handsfree_register(hal_ipc, &adapter_bdaddr, m->mode,
>  							m->max_clients)) {
> @@ -286,6 +295,9 @@ static bool unregister_service(uint8_t id)
>  	case HAL_SERVICE_ID_AVRCP:
>  		bt_avrcp_unregister();
>  		break;
> +	case HAL_SERVICE_ID_AVRCP_CTRL:
> +		bt_avrcp_ctrl_unregister();
> +		break;
>  	case HAL_SERVICE_ID_HANDSFREE:
>  		bt_handsfree_unregister();
>  		break;
> 

-- 
Best regards, 
Szymon Janc

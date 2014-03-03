Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] android/gatt: Add initial files
Date: Mon, 03 Mar 2014 16:16:19 +0100
Message-ID: <12230450.Fb4KDTjX9d@uw000953>
In-Reply-To: <1393858267-27487-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393858267-27487-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Monday 03 of March 2014 15:51:06 Grzegorz Kolodziejczyk wrote:
> This adds initial daemon code for GATT profile.
> ---
>  android/Android.mk  |  1 +
>  android/Makefile.am |  1 +
>  android/gatt.c      | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  android/gatt.h      | 25 +++++++++++++++++++++++++
>  android/main.c      | 14 ++++++++++++++
>  5 files changed, 85 insertions(+)
>  create mode 100644 android/gatt.c
>  create mode 100644 android/gatt.h
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index 56b86ba..429a4b8 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -42,6 +42,7 @@ LOCAL_SRC_FILES := \
>  	bluez/android/avrcp-lib.c \
>  	bluez/android/pan.c \
>  	bluez/android/handsfree.c \
> +	bluez/android/gatt.c
>  	bluez/src/log.c \
>  	bluez/src/shared/mgmt.c \
>  	bluez/src/shared/util.c \
> diff --git a/android/Makefile.am b/android/Makefile.am
> index 31f905c..6be6cda 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -40,6 +40,7 @@ android_bluetoothd_SOURCES = android/main.c \
>  				android/socket.h android/socket.c \
>  				android/pan.h android/pan.c \
>  				android/handsfree.h android/handsfree.c \
> +				android/gatt.h android/gatt.c \
>  				btio/btio.h btio/btio.c \
>  				src/sdp-client.h src/sdp-client.c \
>  				profiles/network/bnep.h profiles/network/bnep.c
> diff --git a/android/gatt.c b/android/gatt.c
> new file mode 100644
> index 0000000..f577446
> --- /dev/null
> +++ b/android/gatt.c
> @@ -0,0 +1,44 @@
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
> +#include <stdbool.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +
> +#include "ipc.h"
> +#include "lib/bluetooth.h"
> +#include "gatt.h"
> +
> +bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
> +{
> +	return false;
> +}
> +
> +void bt_gatt_unregister(void)
> +{
> +
> +}
> diff --git a/android/gatt.h b/android/gatt.h
> new file mode 100644
> index 0000000..d4392d9
> --- /dev/null
> +++ b/android/gatt.h
> @@ -0,0 +1,25 @@
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
> +bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr);
> +void bt_gatt_unregister(void);
> diff --git a/android/main.c b/android/main.c
> index a6742ef..104211a 100644
> --- a/android/main.c
> +++ b/android/main.c
> @@ -58,6 +58,7 @@
>  #include "pan.h"
>  #include "avrcp.h"
>  #include "handsfree.h"
> +#include "gatt.h"
>  
>  #define STARTUP_GRACE_SECONDS 5
>  #define SHUTDOWN_GRACE_SECONDS 10
> @@ -126,6 +127,13 @@ static void service_register(const void *buf, uint16_t len)
>  		}
>  
>  		break;
> +	case HAL_SERVICE_ID_GATT:
> +		if (!bt_gatt_register(hal_ipc, &adapter_bdaddr)) {
> +			status = HAL_STATUS_FAILED;
> +			goto failed;
> +		}
> +
> +		break;
>  	default:
>  		DBG("service %u not supported", m->service_id);
>  		status = HAL_STATUS_FAILED;
> @@ -175,6 +183,9 @@ static void service_unregister(const void *buf, uint16_t len)
>  	case HAL_SERVICE_ID_HANDSFREE:
>  		bt_handsfree_unregister();
>  		break;
> +	case HAL_SERVICE_ID_GATT:
> +		bt_gatt_unregister();
> +		break;
>  	default:
>  		/* This would indicate bug in HAL, as unregister should not be
>  		 * called in init failed */
> @@ -371,6 +382,9 @@ static void cleanup_services(void)
>  		case HAL_SERVICE_ID_HANDSFREE:
>  			bt_handsfree_unregister();
>  			break;
> +		case HAL_SERVICE_ID_GATT:
> +			bt_gatt_unregister();
> +			break;
>  		}
>  
>  		services[i] = false;
> 

Both patches applied, thanks.

-- 
Best regards, 
Szymon Janc

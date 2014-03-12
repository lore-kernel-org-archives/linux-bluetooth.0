Return-Path: <cyrus@holtmann.org>
Message-ID: <53209B6A.8030403@linux.intel.com>
Date: Wed, 12 Mar 2014 19:37:46 +0200
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
CC: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 15/15] android/health: Add health.c|h file with basic
 calls
References: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>	<1394637058-586-16-git-send-email-ravikumar.veeramally@linux.intel.com> <CAMv5Gbf16uUaLpYVPq_5J_6d93-PXXUEsKXRvCHuyLfODE4nuA@mail.gmail.com>
In-Reply-To: <CAMv5Gbf16uUaLpYVPq_5J_6d93-PXXUEsKXRvCHuyLfODE4nuA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 03/12/2014 05:18 PM, Grzegorz Kolodziejczyk wrote:
> On 12 March 2014 16:10, Ravi kumar Veeramally
> <ravikumar.veeramally@linux.intel.com> wrote:
>> Add health.c|h with basic calls for register and unregister profile.
>> ---
>>   android/Android.mk  |   1 +
>>   android/Makefile.am |   1 +
>>   android/health.c    | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   android/health.h    |  25 ++++++++++++
>>   android/main.c      |  10 +++++
>>   5 files changed, 152 insertions(+)
>>   create mode 100644 android/health.c
>>   create mode 100644 android/health.h
>>
>> diff --git a/android/Android.mk b/android/Android.mk
>> index 0352beb..34e21ea 100644
>> --- a/android/Android.mk
>> +++ b/android/Android.mk
>> @@ -43,6 +43,7 @@ LOCAL_SRC_FILES := \
>>          bluez/android/pan.c \
>>          bluez/android/handsfree.c \
>>          bluez/android/gatt.c \
>> +       bluez/android/health.c \
>>          bluez/src/log.c \
>>          bluez/src/shared/mgmt.c \
>>          bluez/src/shared/util.c \
>> diff --git a/android/Makefile.am b/android/Makefile.am
>> index d2cfed6..adfb14c 100644
>> --- a/android/Makefile.am
>> +++ b/android/Makefile.am
>> @@ -41,6 +41,7 @@ android_bluetoothd_SOURCES = android/main.c \
>>                                  android/pan.h android/pan.c \
>>                                  android/handsfree.h android/handsfree.c \
>>                                  android/gatt.h android/gatt.c \
>> +                               android/health.h android/health.c \
>>                                  btio/btio.h btio/btio.c \
>>                                  src/sdp-client.h src/sdp-client.c \
>>                                  profiles/network/bnep.h profiles/network/bnep.c
>> diff --git a/android/health.c b/android/health.c
>> new file mode 100644
>> index 0000000..6359b11
>> --- /dev/null
>> +++ b/android/health.c
>> @@ -0,0 +1,115 @@
>> +/*
>> + *
>> + *  BlueZ - Bluetooth protocol stack for Linux
>> + *
>> + *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
>> + *
>> + *
>> + *  This library is free software; you can redistribute it and/or
>> + *  modify it under the terms of the GNU Lesser General Public
>> + *  License as published by the Free Software Foundation; either
>> + *  version 2.1 of the License, or (at your option) any later version.
>> + *
>> + *  This library is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + *  Lesser General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU Lesser General Public
>> + *  License along with this library; if not, write to the Free Software
>> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> + *
>> + */
>> +
>> +#ifdef HAVE_CONFIG_H
>> +#include <config.h>
>> +#endif
>> +
>> +#include <stdint.h>
>> +#include <stdbool.h>
>> +#include <errno.h>
>> +#include <unistd.h>
>> +#include <glib.h>
>> +
>> +#include "lib/bluetooth.h"
>> +#include "lib/sdp.h"
>> +#include "lib/sdp_lib.h"
>> +#include "src/log.h"
>> +
>> +#include "hal-msg.h"
>> +#include "ipc-common.h"
>> +#include "ipc.h"
>> +#include "utils.h"
>> +#include "bluetooth.h"
>> +#include "health.h"
>> +
>> +static bdaddr_t adapter_addr;
>> +static struct ipc *hal_ipc = NULL;
>> +
>> +static void bt_health_register_app(const void *buf, uint16_t len)
>> +{
>> +       DBG("Not implemented");
>> +
>> +       ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_REG_APP,
>> +                                                       HAL_STATUS_UNSUPPORTED);
>> +}
>> +
>> +static void bt_health_unregister_app(const void *buf, uint16_t len)
>> +{
>> +       DBG("Not implemented");
>> +
>> +       ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_UNREG_APP,
>> +                                                       HAL_STATUS_UNSUPPORTED);
>> +}
>> +
>> +static void bt_health_connect_channel(const void *buf, uint16_t len)
>> +{
>> +       DBG("Not implemented");
>> +
>> +       ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
>> +                       HAL_OP_HEALTH_CONNECT_CHANNEL, HAL_STATUS_UNSUPPORTED);
>> +}
>> +
>> +static void bt_health_destroy_channel(const void *buf, uint16_t len)
>> +{
>> +       DBG("Not implemented");
>> +
>> +       ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
>> +                       HAL_OP_HEALTH_DESTROY_CHANNEL, HAL_STATUS_UNSUPPORTED);
>> +}
>> +
>> +static const struct ipc_handler cmd_handlers[] = {
>> +       /* HAL_OP_HEALTH_REG_APP */
>> +       { bt_health_register_app, false,
>> +                               sizeof(struct hal_cmd_health_reg_app) },
>> +       /* HAL_OP_HEALTH_UNREG_APP */
>> +       { bt_health_unregister_app, false,
>> +                               sizeof(struct hal_cmd_health_unreg_app) },
>> +       /* HAL_OP_HEALTH_CONNECT_CHANNEL */
>> +       { bt_health_connect_channel, false,
>> +                               sizeof(struct hal_cmd_health_connect_channel) },
>> +       /* HAL_OP_HEALTH_DESTROY_CHANNEL */
>> +       { bt_health_destroy_channel, false,
>> +                               sizeof(struct hal_cmd_health_destroy_channel) },
>> +};
>> +
>> +bool bt_health_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
>> +{
>> +       DBG("");
>> +
>> +       bacpy(&adapter_addr, addr);
>> +
>> +       hal_ipc = ipc;
>> +       ipc_register(hal_ipc, HAL_SERVICE_ID_HEALTH, cmd_handlers,
>> +                                               G_N_ELEMENTS(cmd_handlers));
>> +
>> +       return true;
>> +}
>> +
>> +void bt_health_unregister(void)
>> +{
>> +       DBG("");
>> +
>> +       ipc_unregister(hal_ipc, HAL_SERVICE_ID_HEALTH);
>> +       hal_ipc = NULL;
>> +}
>> diff --git a/android/health.h b/android/health.h
>> new file mode 100644
>> index 0000000..38a58c0
>> --- /dev/null
>> +++ b/android/health.h
>> @@ -0,0 +1,25 @@
>> +/*
>> + *
>> + *  BlueZ - Bluetooth protocol stack for Linux
>> + *
>> + *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
>> + *
>> + *
>> + *  This library is free software; you can redistribute it and/or
>> + *  modify it under the terms of the GNU Lesser General Public
>> + *  License as published by the Free Software Foundation; either
>> + *  version 2.1 of the License, or (at your option) any later version.
>> + *
>> + *  This library is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + *  Lesser General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU Lesser General Public
>> + *  License along with this library; if not, write to the Free Software
>> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> + *
>> + */
>> +
>> +bool bt_health_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
>> +void bt_health_unregister(void);
>> diff --git a/android/main.c b/android/main.c
>> index a34f885..9423619 100644
>> --- a/android/main.c
>> +++ b/android/main.c
>> @@ -59,6 +59,7 @@
>>   #include "avrcp.h"
>>   #include "handsfree.h"
>>   #include "gatt.h"
>> +#include "health.h"
>>
>>   #define STARTUP_GRACE_SECONDS 5
>>   #define SHUTDOWN_GRACE_SECONDS 10
>> @@ -133,6 +134,12 @@ static void service_register(const void *buf, uint16_t len)
>>                          goto failed;
>>                  }
> Missing brake here.
   Ok, I will fix it.

  Thanks,
  Ravi.

>> +       case HAL_SERVICE_ID_HEALTH:
>> +               if (!bt_health_register(hal_ipc, &adapter_bdaddr, m->mode)) {
>> +                       status = HAL_STATUS_FAILED;
>> +                       goto failed;
>> +               }
>> +
>>                  break;
>>          default:
>>                  DBG("service %u not supported", m->service_id);
>> @@ -186,6 +193,9 @@ static void service_unregister(const void *buf, uint16_t len)
>>          case HAL_SERVICE_ID_GATT:
>>                  bt_gatt_unregister();
>>                  break;
>> +       case HAL_SERVICE_ID_HEALTH:
>> +               bt_health_unregister();
>> +               break;
>>          default:
>>                  /* This would indicate bug in HAL, as unregister should not be
>>                   * called in init failed */
>> --
>> 1.8.3.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Best regards,
> Grzegorz Kolodziejczyk
>
> On 12 March 2014 16:10, Ravi kumar Veeramally
> <ravikumar.veeramally@linux.intel.com> wrote:
>> Add health.c|h with basic calls for register and unregister profile.
>> ---
>>   android/Android.mk  |   1 +
>>   android/Makefile.am |   1 +
>>   android/health.c    | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   android/health.h    |  25 ++++++++++++
>>   android/main.c      |  10 +++++
>>   5 files changed, 152 insertions(+)
>>   create mode 100644 android/health.c
>>   create mode 100644 android/health.h
>>
>> diff --git a/android/Android.mk b/android/Android.mk
>> index 0352beb..34e21ea 100644
>> --- a/android/Android.mk
>> +++ b/android/Android.mk
>> @@ -43,6 +43,7 @@ LOCAL_SRC_FILES := \
>>          bluez/android/pan.c \
>>          bluez/android/handsfree.c \
>>          bluez/android/gatt.c \
>> +       bluez/android/health.c \
>>          bluez/src/log.c \
>>          bluez/src/shared/mgmt.c \
>>          bluez/src/shared/util.c \
>> diff --git a/android/Makefile.am b/android/Makefile.am
>> index d2cfed6..adfb14c 100644
>> --- a/android/Makefile.am
>> +++ b/android/Makefile.am
>> @@ -41,6 +41,7 @@ android_bluetoothd_SOURCES = android/main.c \
>>                                  android/pan.h android/pan.c \
>>                                  android/handsfree.h android/handsfree.c \
>>                                  android/gatt.h android/gatt.c \
>> +                               android/health.h android/health.c \
>>                                  btio/btio.h btio/btio.c \
>>                                  src/sdp-client.h src/sdp-client.c \
>>                                  profiles/network/bnep.h profiles/network/bnep.c
>> diff --git a/android/health.c b/android/health.c
>> new file mode 100644
>> index 0000000..6359b11
>> --- /dev/null
>> +++ b/android/health.c
>> @@ -0,0 +1,115 @@
>> +/*
>> + *
>> + *  BlueZ - Bluetooth protocol stack for Linux
>> + *
>> + *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
>> + *
>> + *
>> + *  This library is free software; you can redistribute it and/or
>> + *  modify it under the terms of the GNU Lesser General Public
>> + *  License as published by the Free Software Foundation; either
>> + *  version 2.1 of the License, or (at your option) any later version.
>> + *
>> + *  This library is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + *  Lesser General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU Lesser General Public
>> + *  License along with this library; if not, write to the Free Software
>> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> + *
>> + */
>> +
>> +#ifdef HAVE_CONFIG_H
>> +#include <config.h>
>> +#endif
>> +
>> +#include <stdint.h>
>> +#include <stdbool.h>
>> +#include <errno.h>
>> +#include <unistd.h>
>> +#include <glib.h>
>> +
>> +#include "lib/bluetooth.h"
>> +#include "lib/sdp.h"
>> +#include "lib/sdp_lib.h"
>> +#include "src/log.h"
>> +
>> +#include "hal-msg.h"
>> +#include "ipc-common.h"
>> +#include "ipc.h"
>> +#include "utils.h"
>> +#include "bluetooth.h"
>> +#include "health.h"
>> +
>> +static bdaddr_t adapter_addr;
>> +static struct ipc *hal_ipc = NULL;
>> +
>> +static void bt_health_register_app(const void *buf, uint16_t len)
>> +{
>> +       DBG("Not implemented");
>> +
>> +       ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_REG_APP,
>> +                                                       HAL_STATUS_UNSUPPORTED);
>> +}
>> +
>> +static void bt_health_unregister_app(const void *buf, uint16_t len)
>> +{
>> +       DBG("Not implemented");
>> +
>> +       ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_UNREG_APP,
>> +                                                       HAL_STATUS_UNSUPPORTED);
>> +}
>> +
>> +static void bt_health_connect_channel(const void *buf, uint16_t len)
>> +{
>> +       DBG("Not implemented");
>> +
>> +       ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
>> +                       HAL_OP_HEALTH_CONNECT_CHANNEL, HAL_STATUS_UNSUPPORTED);
>> +}
>> +
>> +static void bt_health_destroy_channel(const void *buf, uint16_t len)
>> +{
>> +       DBG("Not implemented");
>> +
>> +       ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
>> +                       HAL_OP_HEALTH_DESTROY_CHANNEL, HAL_STATUS_UNSUPPORTED);
>> +}
>> +
>> +static const struct ipc_handler cmd_handlers[] = {
>> +       /* HAL_OP_HEALTH_REG_APP */
>> +       { bt_health_register_app, false,
>> +                               sizeof(struct hal_cmd_health_reg_app) },
>> +       /* HAL_OP_HEALTH_UNREG_APP */
>> +       { bt_health_unregister_app, false,
>> +                               sizeof(struct hal_cmd_health_unreg_app) },
>> +       /* HAL_OP_HEALTH_CONNECT_CHANNEL */
>> +       { bt_health_connect_channel, false,
>> +                               sizeof(struct hal_cmd_health_connect_channel) },
>> +       /* HAL_OP_HEALTH_DESTROY_CHANNEL */
>> +       { bt_health_destroy_channel, false,
>> +                               sizeof(struct hal_cmd_health_destroy_channel) },
>> +};
>> +
>> +bool bt_health_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
>> +{
>> +       DBG("");
>> +
>> +       bacpy(&adapter_addr, addr);
>> +
>> +       hal_ipc = ipc;
>> +       ipc_register(hal_ipc, HAL_SERVICE_ID_HEALTH, cmd_handlers,
>> +                                               G_N_ELEMENTS(cmd_handlers));
>> +
>> +       return true;
>> +}
>> +
>> +void bt_health_unregister(void)
>> +{
>> +       DBG("");
>> +
>> +       ipc_unregister(hal_ipc, HAL_SERVICE_ID_HEALTH);
>> +       hal_ipc = NULL;
>> +}
>> diff --git a/android/health.h b/android/health.h
>> new file mode 100644
>> index 0000000..38a58c0
>> --- /dev/null
>> +++ b/android/health.h
>> @@ -0,0 +1,25 @@
>> +/*
>> + *
>> + *  BlueZ - Bluetooth protocol stack for Linux
>> + *
>> + *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
>> + *
>> + *
>> + *  This library is free software; you can redistribute it and/or
>> + *  modify it under the terms of the GNU Lesser General Public
>> + *  License as published by the Free Software Foundation; either
>> + *  version 2.1 of the License, or (at your option) any later version.
>> + *
>> + *  This library is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + *  Lesser General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU Lesser General Public
>> + *  License along with this library; if not, write to the Free Software
>> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> + *
>> + */
>> +
>> +bool bt_health_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
>> +void bt_health_unregister(void);
>> diff --git a/android/main.c b/android/main.c
>> index a34f885..9423619 100644
>> --- a/android/main.c
>> +++ b/android/main.c
>> @@ -59,6 +59,7 @@
>>   #include "avrcp.h"
>>   #include "handsfree.h"
>>   #include "gatt.h"
>> +#include "health.h"
>>
>>   #define STARTUP_GRACE_SECONDS 5
>>   #define SHUTDOWN_GRACE_SECONDS 10
>> @@ -133,6 +134,12 @@ static void service_register(const void *buf, uint16_t len)
>>                          goto failed;
>>                  }
>>
>> +       case HAL_SERVICE_ID_HEALTH:
>> +               if (!bt_health_register(hal_ipc, &adapter_bdaddr, m->mode)) {
>> +                       status = HAL_STATUS_FAILED;
>> +                       goto failed;
>> +               }
>> +
>>                  break;
>>          default:
>>                  DBG("service %u not supported", m->service_id);
>> @@ -186,6 +193,9 @@ static void service_unregister(const void *buf, uint16_t len)
>>          case HAL_SERVICE_ID_GATT:
>>                  bt_gatt_unregister();
>>                  break;
>> +       case HAL_SERVICE_ID_HEALTH:
>> +               bt_health_unregister();
>> +               break;
>>          default:
>>                  /* This would indicate bug in HAL, as unregister should not be
>>                   * called in init failed */
>> --
>> 1.8.3.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


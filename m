Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCHv3 04/15] android: Enable Socket interface
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381243883-2745-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Wed, 9 Oct 2013 21:15:49 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E467C940-9DB3-4426-9708-C5FA6CB65E3E@holtmann.org>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1381243883-2745-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1381243883-2745-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Returns socket interface, use header hal.h to avoid externs.
> ---
> android/hal.h           |   18 ++++++++++++++++++
> android/hal_bluetooth.c |   11 +++++++++++
> 2 files changed, 29 insertions(+)
> create mode 100644 android/hal.h
> 
> diff --git a/android/hal.h b/android/hal.h
> new file mode 100644
> index 0000000..40fbf03
> --- /dev/null
> +++ b/android/hal.h
> @@ -0,0 +1,18 @@
> +/*
> + * Copyright (C) 2013 Intel Corporation
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
> +btsock_interface_t *bt_get_sock_interface(void);
> diff --git a/android/hal_bluetooth.c b/android/hal_bluetooth.c
> index 9970374..00f3e8d 100644
> --- a/android/hal_bluetooth.c
> +++ b/android/hal_bluetooth.c
> @@ -21,10 +21,13 @@
> #include <stdbool.h>
> 
> #include <hardware/bluetooth.h>
> +#include <hardware/bt_sock.h>
> 
> #define LOG_TAG "BlueZ"
> #include <cutils/log.h>
> 
> +#include "hal.h"
> +
> bt_callbacks_t *bt_hal_cbacks = NULL;
> 
> static bool interface_ready(void)
> @@ -32,6 +35,11 @@ static bool interface_ready(void)
> 	return bt_hal_cbacks != NULL;
> }
> 
> +static bool is_profile(const char *profile, const char *str)
> +{
> +	return strcmp(profile, str) == 0;
> +}
> +
> static int init(bt_callbacks_t *callbacks)
> {
> 	ALOGD(__func__);
> @@ -246,6 +254,9 @@ static const void *get_profile_interface(const char *profile_id)
> 	if (interface_ready() == false)
> 		return NULL;
> 
> +	if (is_profile(profile_id, BT_PROFILE_SOCKETS_ID))
> +		return bt_get_sock_interface();
> +

just use if (!strcmp(profile_id, BT_PROFILE…) here. It is as short and does not obfuscate with a function that does exactly the same anyway.

Regards

Marcel


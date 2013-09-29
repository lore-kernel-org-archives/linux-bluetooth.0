Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [RFC 08/16] android: Add Android HAL callback task
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380291161-10232-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Sun, 29 Sep 2013 15:22:48 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E81B411F-45CC-4500-AA74-6E150512A67D@holtmann.org>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1380291161-10232-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Android HAL callback task listens for messages from BlueZ GPL daemon.
> ---
> android/Android.mk      |    6 ++
> android/hal_cb_thread.c |  144 +++++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 150 insertions(+)
> create mode 100644 android/hal_cb_thread.c
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index f9c73a2..e892249 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -37,10 +37,16 @@ include $(CLEAR_VARS)
> 
> LOCAL_SRC_FILES := \
> 	hal_bluetooth.c \
> +	hal_cb_thread.c \
> 	hal_bt_sock.c \
> 
> LOCAL_SHARED_LIBRARIES := \
> 	libcutils \
> +	libglib \
> +
> +LOCAL_C_INCLUDES := \
> +	$(call include-path-for, glib) \
> +	$(call include-path-for, glib)/glib \
> 
> LOCAL_MODULE := bluetooth.default
> LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
> diff --git a/android/hal_cb_thread.c b/android/hal_cb_thread.c
> new file mode 100644
> index 0000000..b7aebe8
> --- /dev/null
> +++ b/android/hal_cb_thread.c
> @@ -0,0 +1,144 @@
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
> +#include <glib.h>
> +#include <stdbool.h>
> +#include <sys/socket.h>
> +#include <sys/stat.h>
> +#include <sys/un.h>
> +#include <errno.h>
> +
> +#include <hardware/bluetooth.h>
> +
> +#define LOG_TAG "BlueZ"
> +#include <cutils/log.h>
> +
> +#include "hal_msg.h"
> +
> +#define HAL_CBACK(base, cb_function, ...)				\
> +	do {								\
> +		if (base && base->cb_function) {			\
> +			ALOGI("CB %s->%s", #base, #cb_function);	\
> +			base->cb_function(__VA_ARGS__);			\
> +		} else {						\
> +			ALOGE("%s: Callback is NULL", __func__);	\
> +		}							\
> +	} while (0)
> +
> +static GMainLoop *event_loop;
> +
> +extern bt_callbacks_t *bt_hal_cbacks;
> +
> +static void bthal_thread_associate(void)
> +{
> +	ALOGI(__func__);
> +
> +	HAL_CBACK(bt_hal_cbacks, thread_evt_cb, ASSOCIATE_JVM);
> +}
> +
> +static void bthal_thread_disassociate(void)
> +{
> +	ALOGI(__func__);
> +
> +	HAL_CBACK(bt_hal_cbacks, thread_evt_cb, DISASSOCIATE_JVM);
> +
> +	bt_hal_cbacks = NULL;
> +}
> +
> +void process_msg(struct hal_msg_hdr *msg)
> +{
> +	ALOGI(__func__);
> +
> +	/* TODO: Process messages from daemon */
> +}
> +
> +static gboolean hal_session_event(GIOChannel *iochan, GIOCondition cond,
> +				  gpointer data)
> +{
> +	struct hal_msg_hdr msg;
> +	int sock, len, size;
> +	uint8_t *buf;
> +
> +	if (cond & (G_IO_NVAL | G_IO_HUP | G_IO_ERR)) {
> +		ALOGE("%s: error condition %d", __func__, cond);
> +		return FALSE;
> +	}
> +
> +	sock = g_io_channel_unix_get_fd(iochan);
> +
> +	len = recv(sock, &msg, sizeof(msg), MSG_PEEK);
> +	if (len <= 0) {
> +		ALOGE("%s: recv(): %s %d", __func__, strerror(errno), sock);
> +		return FALSE;
> +	}
> +
> +	size = sizeof(msg) + msg.len;
> +
> +	ALOGD("%s: Read first %d bytes, total %d", __func__, len, size);
> +
> +	buf = malloc(size);
> +	if (buf == NULL)
> +		return FALSE;
> +
> +	len = recv(sock, buf, size, 0);
> +	if (len != size) {
> +		ALOGE("%s: recv(): %s %d", __func__, strerror(errno), sock);
> +		free(buf);
> +		return FALSE;
> +	}
> +
> +	process_msg((struct hal_msg_hdr *) buf);
> +
> +	free(buf);
> +
> +	return TRUE;
> +}
> +
> +int hal_cb_init_sock(int sock)
> +{
> +	GIOChannel *iochan;
> +	int id;
> +
> +	ALOGD("%s: sock %d", __func__, sock);
> +
> +	iochan = g_io_channel_unix_new(sock);
> +	g_io_channel_set_close_on_unref(iochan, TRUE);
> +
> +	id = g_io_add_watch(iochan, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
> +			    hal_session_event, &sock);
> +
> +	ALOGD("%s: Add chan %p watch id %d", __func__, iochan, id);

why are we bothering with a GLib mainloop here. We are in a threaded environment anyway, so lets just use threads for reader and writer IO.

In addition, I prefer to have the HAL code GLib free. There is really no point in linking GLib into that one.

Regards

Marcel


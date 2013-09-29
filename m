Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [RFC 11/16] android: sdp: Reuse BlueZ SDP server in Android
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380291161-10232-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Sun, 29 Sep 2013 15:31:24 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B13A32F7-6E42-43FA-B821-D1815119ABBC@holtmann.org>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1380291161-10232-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Reuse existing SDP server code in Android GPL daemon.
> ---
> Makefile.android     |    7 +++++--
> android/Android.mk   |    6 ++++++
> android/bt_adapter.c |    5 ++++-
> android/main.c       |   27 +++++++++++++++++++++++++++
> android/main.h       |   25 +++++++++++++++++++++++++
> 5 files changed, 67 insertions(+), 3 deletions(-)
> create mode 100644 android/main.h
> 
> diff --git a/Makefile.android b/Makefile.android
> index 3e6fec0..bf82928 100644
> --- a/Makefile.android
> +++ b/Makefile.android
> @@ -3,7 +3,10 @@ if ANDROID_DAEMON
> noinst_PROGRAMS += android/bluezd
> 
> android_bluezd_SOURCES = android/main.c src/log.c \
> +				src/sdpd-database.c src/sdpd-server.c \
> +				src/sdpd-service.c src/sdpd-request.c \
> 				src/shared/util.h src/shared/util.c \
> -				src/shared/mgmt.h src/shared/mgmt.c
> -android_bluezd_LDADD = @GLIB_LIBS@
> +				src/shared/mgmt.h src/shared/mgmt.c \
> +				android/bt_adapter.h android/bt_adapter.c
> +android_bluezd_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
> endif
> diff --git a/android/Android.mk b/android/Android.mk
> index 36f8798..08e35e4 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -9,6 +9,11 @@ include $(CLEAR_VARS)
> LOCAL_SRC_FILES := \
> 	log.c \
> 	main.c \
> +	bt_adapter.c \
> +	../src/sdpd-database.c \
> +	../src/sdpd-service.c \
> +	../src/sdpd-request.c \
> +	../src/sdpd-server.c \
> 
> LOCAL_C_INCLUDES := \
> 	$(call include-path-for, glib) \
> @@ -24,6 +29,7 @@ LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
> LOCAL_SHARED_LIBRARIES := \
> 	libglib \
> 	libbluez \
> +	libbluetooth \
> 
> LOCAL_MODULE := bluezd
> 
> diff --git a/android/bt_adapter.c b/android/bt_adapter.c
> index 9f64839..42facb6 100644
> --- a/android/bt_adapter.c
> +++ b/android/bt_adapter.c
> @@ -23,6 +23,7 @@
> 
> #include "bt_adapter.h"
> #include "log.h"
> +#include "main.h"
> #include "src/shared/mgmt.h"
> 
> struct bt_device *bt_device_ref(struct bt_device *device)
> @@ -118,7 +119,7 @@ void adapter_start(struct bt_adapter *adapter)
> 
> 	/* TODO: CB: report scan mode */
> 
> -	/* TODO: SDP start here */
> +	sdp_start();
> 
> 	/* TODO: CB: report state on */
> }
> @@ -126,4 +127,6 @@ void adapter_start(struct bt_adapter *adapter)
> void adapter_stop(struct bt_adapter *adapter)
> {
> 	DBG("disabled %u", adapter->dev_id);
> +
> +	sdp_stop();
> }
> diff --git a/android/main.c b/android/main.c
> index 4792919..5fef095 100644
> --- a/android/main.c
> +++ b/android/main.c
> @@ -36,6 +36,8 @@
> 
> #include "log.h"
> #include "hcid.h"
> +#include "sdpd.h"
> +#include "main.h"
> 
> #include "lib/bluetooth.h"
> #include "lib/mgmt.h"
> @@ -43,12 +45,37 @@
> 
> #define SHUTDOWN_GRACE_SECONDS 10
> 
> +struct main_opts main_opts;
> +

where is this main_opts coming from. I rather not have this.

> static GMainLoop *event_loop;
> static struct mgmt *mgmt_if = NULL;
> 
> static uint8_t mgmt_version = 0;
> static uint8_t mgmt_revision = 0;
> 
> +GList *adapter_list = NULL;
> +struct bt_adapter *default_adapter = NULL;

Why are this public variables.

> +
> +int sdp_start(void)
> +{
> +	uint16_t mtu = 0;
> +	uint32_t flags = 0;
> +
> +	DBG("");
> +
> +	/* sdpd-server use these settings */
> +	memset(&main_opts, 0, sizeof(main_opts));
> +
> +	return start_sdp_server(mtu, flags);

Just fill in mtu and flags manually here. No need for variable declaration above.

> +}
> +
> +void sdp_stop(void)
> +{
> +	DBG("");
> +
> +	stop_sdp_server();
> +}
> +
> void btd_exit(void)
> {
> 	g_main_loop_quit(event_loop);
> diff --git a/android/main.h b/android/main.h
> new file mode 100644
> index 0000000..6ecad14
> --- /dev/null
> +++ b/android/main.h
> @@ -0,0 +1,25 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2013  Intel Corporation. All rights reserved.
> + *
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +int sdp_start(void);
> +void sdp_stop(void);

Regards

Marcel


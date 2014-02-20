Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Feb 2014 11:03:26 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 1/4] shared: Add initial AVRCP code
Message-ID: <20140220090324.GD2654@aemeltch-MOBL1>
References: <1392734435-2182-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392734435-2182-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On Tue, Feb 18, 2014 at 04:40:32PM +0200, Luiz Augusto von Dentz wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> The patch makes AVRCP to be transport agnostic so that it can be used in
> with socket pair to build unit tests.
> 
> The idea is that all AVRCP specific logic will stay on src/shared/avrcp
> and connecting handling elsewhere.

Any comments about the patch? We need this one to start doing AVRCP unit tests.

Best regards 
Andrei Emeltchenko 


> ---
> v2: Fix not updating Android.mk with new location of the files
> 
>  android/Android.mk              |  1 +
>  android/Makefile.am             |  1 +
>  android/avrcp.c                 | 42 ++++++++++++-----------
>  src/shared/avrcp.c              | 75 +++++++++++++++++++++++++++++++++++++++++
>  {android => src/shared}/avrcp.h | 13 ++++---
>  5 files changed, 108 insertions(+), 24 deletions(-)
>  create mode 100644 src/shared/avrcp.c
>  copy {android => src/shared}/avrcp.h (65%)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index 2481a2c..4f8a17a 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -49,6 +49,7 @@ LOCAL_SRC_FILES := \
>  	bluez/src/shared/ringbuf.c \
>  	bluez/src/shared/hfp.c \
>  	bluez/src/shared/io-glib.c \
> +	bluez/src/shared/avrcp.c \
>  	bluez/src/sdpd-database.c \
>  	bluez/src/sdpd-service.c \
>  	bluez/src/sdpd-request.c \
> diff --git a/android/Makefile.am b/android/Makefile.am
> index 1913b42..3cc0687 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -29,6 +29,7 @@ android_bluetoothd_SOURCES = android/main.c \
>  				src/shared/mgmt.h src/shared/mgmt.c \
>  				src/shared/ringbuf.h src/shared/ringbuf.c \
>  				src/shared/hfp.h src/shared/hfp.c \
> +				src/shared/avrcp.h src/shared/avrcp.c \
>  				android/bluetooth.h android/bluetooth.c \
>  				android/hidhost.h android/hidhost.c \
>  				android/ipc.h android/ipc.c \
> diff --git a/android/avrcp.c b/android/avrcp.c
> index b8304f5..65b3417 100644
> --- a/android/avrcp.c
> +++ b/android/avrcp.c
> @@ -32,12 +32,12 @@
>  #include "lib/bluetooth.h"
>  #include "lib/sdp.h"
>  #include "lib/sdp_lib.h"
> +#include "src/shared/avrcp.h"
>  #include "src/log.h"
>  #include "bluetooth.h"
>  #include "avrcp.h"
>  #include "hal-msg.h"
>  #include "ipc.h"
> -#include "avctp.h"
>  
>  #define L2CAP_PSM_AVCTP 0x17
>  
> @@ -53,7 +53,7 @@ static GIOChannel *server = NULL;
>  
>  struct avrcp_device {
>  	bdaddr_t	dst;
> -	struct avctp	*session;
> +	struct avrcp	*session;
>  	GIOChannel	*io;
>  };
>  
> @@ -133,7 +133,7 @@ static void avrcp_device_free(void *data)
>  	struct avrcp_device *dev = data;
>  
>  	if (dev->session)
> -		avctp_shutdown(dev->session);
> +		avrcp_shutdown(dev->session);
>  
>  	if (dev->io) {
>  		g_io_channel_shutdown(dev->io, FALSE, NULL);
> @@ -168,6 +168,17 @@ static int device_cmp(gconstpointer s, gconstpointer user_data)
>  	return bacmp(&dev->dst, dst);
>  }
>  
> +static struct avrcp_device *avrcp_device_find(const bdaddr_t *dst)
> +{
> +	GSList *l;
> +
> +	l = g_slist_find_custom(devices, dst, device_cmp);
> +	if (!l)
> +		return NULL;
> +
> +	return l->data;
> +}
> +
>  static void disconnect_cb(void *data)
>  {
>  	struct avrcp_device *dev = data;
> @@ -186,7 +197,6 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
>  	char address[18];
>  	uint16_t imtu, omtu;
>  	GError *gerr = NULL;
> -	GSList *l;
>  	int fd;
>  
>  	if (err) {
> @@ -209,9 +219,8 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
>  
>  	ba2str(&dst, address);
>  
> -	l = g_slist_find_custom(devices, &dst, device_cmp);
> -	if (l) {
> -		dev = l->data;
> +	dev = avrcp_device_find(&dst);
> +	if (dev) {
>  		if (dev->session) {
>  			error("Unexpected connection");
>  			return;
> @@ -222,17 +231,17 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
>  	}
>  
>  	fd = g_io_channel_unix_get_fd(chan);
> -	dev->session = avctp_new(fd, imtu, omtu, 0x0100);
>  
> +	dev->session = avrcp_new(fd, imtu, omtu, 0x0100);
>  	if (!dev->session) {
>  		avrcp_device_free(dev);
>  		return;
>  	}
>  
> -	avctp_set_destroy_cb(dev->session, disconnect_cb, dev);
> +	avrcp_set_destroy_cb(dev->session, disconnect_cb, dev);
>  
>  	/* FIXME: get the real name of the device */
> -	avctp_init_uinput(dev->session, "bluetooth", address);
> +	avrcp_init_uinput(dev->session, "bluetooth", address);
>  
>  	g_io_channel_set_close_on_unref(chan, FALSE);
>  
> @@ -331,12 +340,10 @@ void bt_avrcp_connect(const bdaddr_t *dst)
>  {
>  	struct avrcp_device *dev;
>  	char addr[18];
> -	GSList *l;
>  
>  	DBG("");
>  
> -	l = g_slist_find_custom(devices, dst, device_cmp);
> -	if (l)
> +	if (avrcp_device_find(dst))
>  		return;
>  
>  	dev = avrcp_device_new(dst);
> @@ -352,18 +359,15 @@ void bt_avrcp_connect(const bdaddr_t *dst)
>  void bt_avrcp_disconnect(const bdaddr_t *dst)
>  {
>  	struct avrcp_device *dev;
> -	GSList *l;
>  
>  	DBG("");
>  
> -	l = g_slist_find_custom(devices, dst, device_cmp);
> -	if (!l)
> +	dev = avrcp_device_find(dst);
> +	if (!dev)
>  		return;
>  
> -	dev = l->data;
> -
>  	if (dev->session) {
> -		avctp_shutdown(dev->session);
> +		avrcp_shutdown(dev->session);
>  		return;
>  	}
>  
> diff --git a/src/shared/avrcp.c b/src/shared/avrcp.c
> new file mode 100644
> index 0000000..32bd703
> --- /dev/null
> +++ b/src/shared/avrcp.c
> @@ -0,0 +1,75 @@
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
> +#include <glib.h>
> +
> +#include "lib/bluetooth.h"
> +
> +#include "src/log.h"
> +
> +#include "android/avctp.h"
> +#include "avrcp.h"
> +
> +struct avrcp {
> +	struct avctp	*session;
> +};
> +
> +void avrcp_shutdown(struct avrcp *session)
> +{
> +	if (session->session)
> +		avctp_shutdown(session->session);
> +
> +	g_free(session);
> +}
> +
> +struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
> +{
> +	struct avrcp *session;
> +
> +	session = g_new0(struct avrcp, 1);
> +
> +	session->session = avctp_new(fd, imtu, omtu, version);
> +	if (!session->session) {
> +		g_free(session);
> +		return NULL;
> +	}
> +
> +	return session;
> +}
> +
> +void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
> +							void *user_data)
> +{
> +	avctp_set_destroy_cb(session->session, cb, user_data);
> +}
> +
> +int avrcp_init_uinput(struct avrcp *session, const char *name,
> +							const char *address)
> +{
> +	return avctp_init_uinput(session->session, name, address);
> +}
> diff --git a/android/avrcp.h b/src/shared/avrcp.h
> similarity index 65%
> copy from android/avrcp.h
> copy to src/shared/avrcp.h
> index 1fcd953..7955d56 100644
> --- a/android/avrcp.h
> +++ b/src/shared/avrcp.h
> @@ -2,7 +2,7 @@
>   *
>   *  BlueZ - Bluetooth protocol stack for Linux
>   *
> - *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2014  Intel Corporation. All rights reserved.
>   *
>   *
>   *  This library is free software; you can redistribute it and/or
> @@ -21,8 +21,11 @@
>   *
>   */
>  
> -bool bt_avrcp_register(const bdaddr_t *addr);
> -void bt_avrcp_unregister(void);
> +typedef void (*avrcp_destroy_cb_t) (void *user_data);
>  
> -void bt_avrcp_connect(const bdaddr_t *dst);
> -void bt_avrcp_disconnect(const bdaddr_t *dst);
> +struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version);
> +void avrcp_shutdown(struct avrcp *session);
> +void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
> +							void *user_data);
> +int avrcp_init_uinput(struct avrcp *session, const char *name,
> +							const char *address);
> -- 
> 1.8.5.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

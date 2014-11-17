Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1422188.O9Smbsxirk@uw000953>
References: <1415027137-11850-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1422188.O9Smbsxirk@uw000953>
Date: Mon, 17 Nov 2014 11:01:53 +0100
Message-ID: <CAMudyAvzNKsD3rZHH+HGcJgn27v6rnFtmGrpui-6wynaqy=LzQ@mail.gmail.com>
Subject: Re: [PATCH] android/sco: Add sco helper lib
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 14 November 2014 13:04, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi Łukasz,
>
> On Monday 03 of November 2014 16:05:37 Lukasz Rymanowski wrote:
>> This patch adds sco lib which gives means to create SCO object with
>> API to create listening socket, connect and disconnect.
>>
>> This is going to be common code for HFP HF and HFP GW.
>> For now we support only one SCO at the time.
>>
>> Before creating listening SCO socket, remember to register confirm
>> and connect callbacks. Those are called on incoming connection.
>>
>> Sco lib is not aware about voice settings. Those must be provided
>> on bt_sco_connect or in confirm callback.
>>
>> This patch also adds this lib to Android build.
>> ---
>>  android/Android.mk  |   1 +
>>  android/Makefile.am |   1 +
>>  android/sco.c       | 307 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  android/sco.h       |  52 +++++++++
>>  4 files changed, 361 insertions(+)
>>  create mode 100644 android/sco.c
>>  create mode 100644 android/sco.h
>>
>> diff --git a/android/Android.mk b/android/Android.mk
>> index aefe41c..dbbcdb2 100644
>> --- a/android/Android.mk
>> +++ b/android/Android.mk
>> @@ -56,6 +56,7 @@ LOCAL_SRC_FILES := \
>>       bluez/android/handsfree-client.c \
>>       bluez/android/gatt.c \
>>       bluez/android/health.c \
>> +     bluez/android/sco.c \
>>       bluez/profiles/health/mcap.c \
>>       bluez/android/map-client.c \
>>       bluez/src/log.c \
>> diff --git a/android/Makefile.am b/android/Makefile.am
>> index 496fbc4..4edb007 100644
>> --- a/android/Makefile.am
>> +++ b/android/Makefile.am
>> @@ -40,6 +40,7 @@ android_bluetoothd_SOURCES = android/main.c \
>>                               android/avrcp.h android/avrcp.c \
>>                               android/avrcp-lib.h android/avrcp-lib.c \
>>                               android/socket.h android/socket.c \
>> +                             android/sco.h android/sco.c \
>>                               android/pan.h android/pan.c \
>>                               android/handsfree.h android/handsfree.c \
>>                               android/handsfree-client.c android/handsfree-client.h \
>> diff --git a/android/sco.c b/android/sco.c
>> new file mode 100644
>> index 0000000..ebb81ad
>> --- /dev/null
>> +++ b/android/sco.c
>> @@ -0,0 +1,307 @@
>> +/*
>> + *
>> + *  BlueZ - Bluetooth protocol stack for Linux
>> + *
>> + *  Copyright (C) 2014 Intel Corporation. All rights reserved.
>> + *
>> + *  This program is free software; you can redistribute it and/or modify
>> + *  it under the terms of the GNU General Public License as published by
>> + *  the Free Software Foundation; either version 2 of the License, or
>> + *  (at your option) any later version.
>> + *
>> + *  This program is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *  GNU General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU General Public License
>> + *  along with this program; if not, write to the Free Software
>> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> + *
>> + */
>> +
>> +#ifdef HAVE_CONFIG_H
>> +#include <config.h>
>> +#endif
>> +
>> +#include <stdlib.h>
>> +#include <stdbool.h>
>> +#include <errno.h>
>> +
>> +#include <glib.h>
>> +
>> +#include "lib/bluetooth.h"
>> +#include "btio/btio.h"
>> +#include "src/log.h"
>> +
>> +#include "sco.h"
>> +
>> +struct bt_sco {
>> +     int ref_count;
>> +
>> +     GIOChannel *server_io;
>> +
>> +     GIOChannel *io;
>> +     guint watch;
>> +
>> +     bdaddr_t local_addr;
>> +     bdaddr_t remote_addr;
>> +
>> +     bt_sco_conn_confirm_cb_func_t confirm_cb;
>> +     bt_sco_conn_cb_func_t connect_cb;
>> +     bt_sco_disconn_cb_func_t disconnect_cb;
>> +};
>> +
>> +/* We support only one sco for the moment */
>> +static bool sco_in_use = false;
>> +
>> +struct bt_sco *bt_sco_new(const bdaddr_t *addr)
>> +{
>> +     struct bt_sco *sco = NULL;
>
> This initialization is not needed.
>
>> +
>> +     if (sco_in_use)
>> +             return NULL;
>
> Put comment about single user here.
>
>> +
>> +     sco = g_try_new0(struct bt_sco, 1);
>> +     if (!sco)
>> +             return NULL;
>
> Lets not use glib if it is not necessary, so new0() here.
>
>> +
>> +     bacpy(&sco->local_addr, addr);
>> +
>> +     sco_in_use  = true;
>> +
>> +     return bt_sco_ref(sco);
>> +}
>> +
>> +struct bt_sco *bt_sco_ref(struct bt_sco *sco)
>> +{
>> +     if (!sco)
>> +             return NULL;
>> +
>> +     __sync_fetch_and_add(&sco->ref_count, 1);
>> +
>> +     return sco;
>> +}
>> +
>> +static void sco_free(struct bt_sco *sco)
>> +{
>> +     if (sco->server_io) {
>> +             g_io_channel_shutdown(sco->server_io, TRUE, NULL);
>> +             g_io_channel_unref(sco->server_io);
>> +     }
>> +
>> +     if (sco->io) {
>> +             g_io_channel_shutdown(sco->io, TRUE, NULL);
>> +             g_io_channel_unref(sco->io);
>> +     }
>> +
>> +     g_free(sco);
>> +     sco_in_use  = false;
>> +}
>> +
>> +void bt_sco_unref(struct bt_sco *sco)
>> +{
>> +     DBG("");
>> +
>> +     if (!sco)
>> +             return;
>> +
>> +     if (__sync_sub_and_fetch(&sco->ref_count, 1))
>> +             return;
>> +
>> +     sco_free(sco);
>> +}
>> +
>> +static void clear_remote_address(struct bt_sco *sco)
>> +{
>> +     memset(&sco->remote_addr, 0, sizeof(bdaddr_t));
>> +}
>> +
>> +static gboolean disconnect_watch(GIOChannel *chan, GIOCondition cond,
>> +                                                     gpointer user_data)
>> +{
>> +     struct bt_sco *sco = user_data;
>> +
>> +     g_io_channel_shutdown(sco->io, TRUE, NULL);
>> +     g_io_channel_unref(sco->io);
>> +     sco->io = NULL;
>> +
>> +     DBG("");
>> +
>> +     sco->watch = 0;
>> +
>> +     sco->disconnect_cb(&sco->remote_addr);
>> +
>> +     clear_remote_address(sco);
>> +
>> +     return FALSE;
>> +}
>> +
>> +static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
>> +{
>> +     struct bt_sco *sco = user_data;
>> +
>> +     DBG("");
>> +
>> +     if (err) {
>> +             error("sco: audio connect failed (%s)", err->message);
>> +
>> +             sco->connect_cb(SCO_STATUS_ERROR, &sco->remote_addr);
>
> We should be checking if callbacks are set. If callback is missing then we
> should probably just fail respective operation.

I will keep here as it is but instead will make sure that
connect_sco_cb is not called if connect_cb is not set

>
>> +
>> +             clear_remote_address(sco);
>> +
>> +             return;
>> +     }
>> +
>> +     g_io_channel_set_close_on_unref(chan, TRUE);
>> +
>> +     sco->io = g_io_channel_ref(chan);
>> +     sco->watch = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
>> +                                                     disconnect_watch, sco);
>> +
>> +     sco->connect_cb(SCO_STATUS_OK, &sco->remote_addr);
>> +}
>> +
>> +static void confirm_sco_cb(GIOChannel *chan, gpointer user_data)
>> +{
>> +     char address[18];
>> +     bdaddr_t bdaddr;
>> +     GError *err = NULL;
>> +     struct bt_sco *sco = user_data;
>> +     uint32_t voice_settings;
>
> voice_settings is uint16 in btio.
>
>> +
>> +     DBG("");
>> +
>> +     bt_io_get(chan, &err,
>> +                     BT_IO_OPT_DEST, address,
>> +                     BT_IO_OPT_DEST_BDADDR, &bdaddr,
>> +                     BT_IO_OPT_INVALID);
>> +     if (err) {
>> +             error("sco: audio confirm failed (%s)", err->message);
>> +             g_error_free(err);
>> +             goto drop;
>> +     }
>> +
>> +     if (!sco->confirm_cb(&bdaddr, &voice_settings)) {
>> +             error("sco: audio connection from %s rejected", address);
>> +             goto drop;
>> +     }
>> +
>> +     bacpy(&sco->remote_addr, &bdaddr);
>> +
>> +     DBG("incoming SCO connection from %s, voice settings %d", address,
>
> voice_settings is unsigned. (maybe print it as 0x%x ?)
>
>> +                                                             voice_settings);
>> +
>> +     err = NULL;
>> +     bt_io_set(chan, &err, BT_IO_OPT_VOICE, voice_settings,
>> +                                                     BT_IO_OPT_INVALID);
>> +     if (err) {
>> +             error("sco: Could not set voice settings (%s)", err->message);
>> +             g_error_free(err);
>> +             goto drop;
>> +     }
>> +
>> +     if (!bt_io_accept(chan, connect_sco_cb, sco, NULL, NULL)) {
>> +             error("sco: failed to accept audio connection");
>> +             goto drop;
>> +     }
>> +
>> +     return;
>> +
>> +drop:
>> +     g_io_channel_shutdown(chan, TRUE, NULL);
>> +}
>> +
>> +bool bt_sco_listen(struct bt_sco *sco)
>> +{
>> +     GError *err = NULL;
>> +
>> +     sco->server_io = bt_io_listen(NULL, confirm_sco_cb, sco, NULL, &err,
>> +                                                     BT_IO_OPT_SOURCE_BDADDR,
>> +                                                     &sco->local_addr,
>> +                                                     BT_IO_OPT_INVALID);
>> +     if (!sco->server_io) {
>> +             error("sco: Failed to listen on SCO: %s", err->message);
>> +             g_error_free(err);
>> +             return false;
>> +     }
>> +
>> +     return true;
>> +}
>
> There is no way to stop listening other than unreferencing sco so maybe
> this should be done inside new()?

I will move it to bt_sco_new(). I did this way so user has time to set
confirm_cb and connect_cb.
WIth new v2 we can start listen right away on bt_sco_new(). and if
callbacks are not set sco will be rejected without user notification.

>
>> +
>> +bool bt_sco_connect(struct bt_sco *sco, const bdaddr_t *addr,
>> +                                                     uint16_t voice_settings)
>> +{
>> +     GIOChannel *io;
>> +     GError *gerr = NULL;
>> +
>> +     DBG("");
>
> So we allow multiple SCO connections?
>
>> +
>> +     io = bt_io_connect(connect_sco_cb, sco, NULL, &gerr,
>> +                             BT_IO_OPT_SOURCE_BDADDR, &sco->local_addr,
>> +                             BT_IO_OPT_DEST_BDADDR, addr,
>> +                             BT_IO_OPT_VOICE, voice_settings,
>> +                             BT_IO_OPT_INVALID);
>> +
>> +     if (!io) {
>> +             error("sco: unable to connect audio: %s", gerr->message);
>> +             g_error_free(gerr);
>> +             return false;
>> +     }
>> +
>> +     g_io_channel_unref(io);
>> +
>> +     bacpy(&sco->remote_addr, addr);
>> +
>> +     return true;
>
> I think we should be able to cancel outgoing connection.
true, will add that.
>
>> +}
>> +
>> +void bt_sco_disconnect(struct bt_sco *sco)
>> +{
>> +     if (sco->watch) {
>> +             g_source_remove(sco->watch);
>> +             sco->watch = 0;
>> +     }
>> +
>> +     g_io_channel_shutdown(sco->io, TRUE, NULL);
>> +     g_io_channel_unref(sco->io);
>> +     sco->io = NULL;
>
> This will crash if sco is not connected. (and there is no api to check if it is).
>
>> +
>> +     clear_remote_address(sco);
>> +}
>> +
>> +bool bt_sco_get_fd_and_mtu(struct bt_sco *sco, int *fd, uint16_t *mtu)
>> +{
>> +     GError *err;
>> +
>> +     if (!sco->io || !fd || !mtu)
>> +             return false;
>> +
>> +     err = NULL;
>> +     if (!bt_io_get(sco->io, &err, BT_IO_OPT_MTU, mtu, BT_IO_OPT_INVALID)) {
>> +                     error("Unable to get MTU: %s\n", err->message);
>> +                     g_clear_error(&err);
>> +                     return false;
>> +             }
>> +
>> +     *fd = g_io_channel_unix_get_fd(sco->io);
>> +
>> +     return true;
>> +}
>> +
>> +void bt_sco_set_confirm_cb(struct bt_sco *sco,
>> +                                     bt_sco_conn_confirm_cb_func_t func)
>> +{
>> +     sco->confirm_cb = func;
>> +}
>> +
>> +void bt_sco_set_connect_cb(struct bt_sco *sco, bt_sco_conn_cb_func_t func)
>> +{
>> +     sco->connect_cb = func;
>> +}
>> +
>> +void bt_sco_set_disconnect_cb(struct bt_sco *sco,
>> +                                             bt_sco_disconn_cb_func_t func)
>> +{
>> +     sco->disconnect_cb = func;
>> +}
>> diff --git a/android/sco.h b/android/sco.h
>> new file mode 100644
>> index 0000000..491e633
>> --- /dev/null
>> +++ b/android/sco.h
>> @@ -0,0 +1,52 @@
>> +/*
>> + *
>> + *  BlueZ - Bluetooth protocol stack for Linux
>> + *
>> + *  Copyright (C) 2014  Intel Corporation. All rights reserved.
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
>> +enum sco_status {
>> +     SCO_STATUS_OK,
>> +     SCO_STATUS_ERROR,
>> +};
>> +
>> +struct bt_sco;
>> +
>> +struct bt_sco *bt_sco_new(const bdaddr_t *adapter_addr);
>
> Name this local_addr, also declarations and definitions should be consistent
> ie. in sco.c you name this just addr
>
>> +
>> +struct bt_sco *bt_sco_ref(struct bt_sco *sco);
>> +void bt_sco_unref(struct bt_sco *sco);
>> +
>> +bool bt_sco_listen(struct bt_sco *sco);
>> +bool bt_sco_connect(struct bt_sco *sco, const bdaddr_t *remote_addr,
>> +                                             uint16_t voice_settings);
>> +void bt_sco_disconnect(struct bt_sco *sco);
>> +bool bt_sco_get_fd_and_mtu(struct bt_sco *sco, int *fd, uint16_t *mtu);
>> +
>
> Callbacks should have user_data (and possibly destroy handler for it), this is
> to avoid relaying on static data (or loopups) in callers.
>
>> +typedef bool (*bt_sco_conn_confirm_cb_func_t) (const bdaddr_t *remote_addr,
>> +                                             uint32_t *voice_settings);
>
> name this bt_sco_confirm_func_t, voice settings should be uint16.
>
>> +typedef void (*bt_sco_conn_cb_func_t) (enum sco_status status,
>> +                                                     const bdaddr_t *addr);
>
> bt_sco_conn_func_t,  also lets keep addr first parameter.
>
>> +typedef void (*bt_sco_disconn_cb_func_t) (const bdaddr_t *addr);
>> +
>> +void bt_sco_set_confirm_cb(struct bt_sco *sco,
>> +                                     bt_sco_conn_confirm_cb_func_t func);
>> +void bt_sco_set_connect_cb(struct bt_sco *sco, bt_sco_conn_cb_func_t func);
>> +void bt_sco_set_disconnect_cb(struct bt_sco *sco,
>> +                                             bt_sco_disconn_cb_func_t func);
>>
>
> Also in general I think this lib should be a bit more robust in case of invalid
> calls, like checking for valid sco, cb presence etc. (similar to what we have
> shared/).
>
Will improve it, however I assume it as a internal lib/wrapper for
android use case only.

> --
> Best regards,
> Szymon Janc

\Lukasz

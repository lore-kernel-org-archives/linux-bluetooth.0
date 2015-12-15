Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1449557617-3413-1-git-send-email-hychao@chromium.org>
References: <1449557617-3413-1-git-send-email-hychao@chromium.org>
Date: Tue, 15 Dec 2015 15:49:05 -0200
Message-ID: <CABBYNZK-0g8Q4u8UCEuPic7sxXYnT0yP7S0vn+643Pa24Kze_w@mail.gmail.com>
Subject: Re: [PATCH] audio/a2dp - Fix unbalanced setup ref/unref
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Hsin-Yu Chao <hychao@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hsin-Yu,

On Tue, Dec 8, 2015 at 4:53 AM, Hsin-Yu Chao <hychao@chromium.org> wrote:
> A crash was observed with backtrace below at setup_unref() inside
> a2dp_cancel(). Evidence is showing that this crash occurred after
> commit 33b447d where additional setup_unref() is being called.
> Remove a suspious setup_unref() call in 0889e24 which might be
> the cause to this crash.
>
> (libc-2.19.so -abort.c:89 ) abort
> (libc-2.19.so -libc_fatal.c:175 ) __libc_message
> (libc-2.19.so -malloc.c:4991 ) malloc_printerr
> (libc-2.19.so -malloc.c:3837 ) _int_free
> (bluetoothd -a2dp.c:2150 ) a2dp_cancel
> (bluetoothd -transport.c:231 ) media_owner_remove
> (bluetoothd -transport.c:244 ) media_transport_remove_owner
> (bluetoothd -transport.c:734 ) media_transport_free
> (bluetoothd -object.c:658 ) remove_interface
> (bluetoothd -object.c:1382 ) g_dbus_unregister_interface
> (bluetoothd -transport.c:182 ) media_transport_destroy
> (bluetoothd -media.c:246 ) clear_endpoint
> (bluetoothd -media.c:468 ) release_endpoint
> (bluetoothd -media.c:1879 ) path_free
> (bluetoothd -object.c:658 ) remove_interface
> (bluetoothd -object.c:1382 ) g_dbus_unregister_interface
> (libglib-2.0.so.0.3400.3 -gslist.c:894 ) g_slist_foreach
> (bluetoothd -adapter.c:4171 ) adapter_remove
> (bluetoothd -adapter.c:7453 ) index_removed
> (bluetoothd -queue.c:251 ) queue_foreach
> (bluetoothd -mgmt.c:280 ) can_read_data
> (bluetoothd -io-glib.c:170 ) watch_callback
> (libglib-2.0.so.0.3400.3 -gmain.c:2715 ) g_main_context_dispatch
> (libglib-2.0.so.0.3400.3 -gmain.c:3290 ) g_main_context_iterate
> (libglib-2.0.so.0.3400.3 -gmain.c:3484 ) g_main_loop_run
> (bluetoothd -main.c:661 ) main
> (libc-2.19.so -libc-start.c:292 ) __libc_start_main
>
> Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
> ---
>  profiles/audio/a2dp.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index 82e75bf..63c9366 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -450,8 +450,6 @@ done:
>                 setup->err = NULL;
>         }
>
> -       setup_unref(setup);

Im not following why this one would be causing the problem,
auto_config would only be called by endpoint_setconf_cb but that
doesn't show in the backtrace? There is something wrong if that is
happening since that means there is a pending AVDTP SetConfiguration
indication being cancelled by the a2dp_cancel which should only cancel
outgoing requests, anyway a better fix would be check if setup is
valid:

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index b0fea7c..9fa952f 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -419,6 +419,10 @@ static gboolean auto_config(gpointer data)
        struct btd_device *dev = NULL;
        struct btd_service *service;

+       /* Check if setup is valid */
+       if (!g_slist_find(setups, setup))
+               return FALSE;
+
        /* Check if configuration was aborted */
        if (setup->sep->stream == NULL)
                return FALSE;
-- 
Luiz Augusto von Dentz

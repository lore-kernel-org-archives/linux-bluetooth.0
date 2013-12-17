Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1387231516-4127-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1387231516-4127-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Date: Tue, 17 Dec 2013 11:09:20 +0200
Message-ID: <CABBYNZJmKJmyS_mBvAA3-No=cAu0DGEx1jXBHoSDphZOHQK-_A@mail.gmail.com>
Subject: Re: [PATCH_v2 1/6] android/pan: Rename pan_device_free to destroy_pan_device
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tue, Dec 17, 2013 at 12:05 AM, Ravi kumar Veeramally
<ravikumar.veeramally@linux.intel.com> wrote:
> Renaming function name because it does more than freeing memory.
> Also moving disconnect notification call to destory_pan_device
> reduce redundancy.
> ---
>  android/pan.c | 51 +++++++++++++++++++++++----------------------------
>  1 file changed, 23 insertions(+), 28 deletions(-)
>
> diff --git a/android/pan.c b/android/pan.c
> index e410f54..ec589cf 100644
> --- a/android/pan.c
> +++ b/android/pan.c
> @@ -65,24 +65,6 @@ static int device_cmp(gconstpointer s, gconstpointer user_data)
>         return bacmp(&dev->dst, dst);
>  }
>
> -static void pan_device_free(struct pan_device *dev)
> -{
> -       local_role = HAL_PAN_ROLE_NONE;
> -
> -       if (dev->watch > 0) {
> -               g_source_remove(dev->watch);
> -               dev->watch = 0;
> -       }
> -
> -       if (dev->io) {
> -               g_io_channel_unref(dev->io);
> -               dev->io = NULL;
> -       }
> -
> -       devices = g_slist_remove(devices, dev);
> -       g_free(dev);
> -}
> -
>  static void bt_pan_notify_conn_state(struct pan_device *dev, uint8_t state)
>  {
>         struct hal_ev_pan_conn_state ev;
> @@ -121,6 +103,25 @@ static void bt_pan_notify_ctrl_state(struct pan_device *dev, uint8_t state)
>                                                                         &ev);
>  }
>
> +static void destroy_pan_device(struct pan_device *dev)
> +{
> +       local_role = HAL_PAN_ROLE_NONE;
> +
> +       if (dev->watch > 0) {
> +               g_source_remove(dev->watch);
> +               dev->watch = 0;
> +       }
> +
> +       if (dev->io) {
> +               g_io_channel_unref(dev->io);
> +               dev->io = NULL;
> +       }
> +
> +       bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
> +       devices = g_slist_remove(devices, dev);
> +       g_free(dev);
> +}
> +
>  static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
>                                                                 gpointer data)
>  {
> @@ -130,8 +131,7 @@ static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
>
>         bnep_if_down(dev->iface);
>         bnep_conndel(&dev->dst);
> -       bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
> -       pan_device_free(dev);
> +       destroy_pan_device(dev);
>
>         return FALSE;
>  }
> @@ -145,8 +145,7 @@ static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
>         if (err < 0) {
>                 error("bnep connect req failed: %s", strerror(-err));
>                 bnep_conndel(&dev->dst);
> -               bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
> -               pan_device_free(dev);
> +               destroy_pan_device(dev);
>                 return;
>         }
>
> @@ -189,8 +188,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
>         return;
>
>  fail:
> -       bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
> -       pan_device_free(dev);
> +       destroy_pan_device(dev);
>  }
>
>  static void bt_pan_connect(const void *buf, uint16_t len)
> @@ -292,10 +290,7 @@ static void bt_pan_disconnect(const void *buf, uint16_t len)
>
>         bnep_if_down(dev->iface);
>         bnep_conndel(&dst);
> -
> -       bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
> -       pan_device_free(dev);
> -
> +       destroy_pan_device(dev);
>         status = HAL_STATUS_SUCCESS;
>
>  failed:
> --
> 1.8.3.2

Have a look at android/a2dp.c, after sending disconnected you can
probably free the device since there is no use for it while
disconnected.



-- 
Luiz Augusto von Dentz

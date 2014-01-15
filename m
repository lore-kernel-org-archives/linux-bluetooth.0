Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1389700090-3642-1-git-send-email-luiz.dentz@gmail.com>
References: <1389700090-3642-1-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 15 Jan 2014 14:55:43 +0200
Message-ID: <CABBYNZJqwKMh-pT+hGn-XaZBaj_7zGt6gL0vQ1-6VAAR=ykLCQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] android/A2DP: Add handling of incoming
 transport connection
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jan 14, 2014 at 1:48 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds handling of incoming transport connection attempt.
> ---
>  android/a2dp.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 60 insertions(+), 4 deletions(-)
>
> diff --git a/android/a2dp.c b/android/a2dp.c
> index 9f3164a..aab0940 100644
> --- a/android/a2dp.c
> +++ b/android/a2dp.c
> @@ -477,6 +477,60 @@ static const struct ipc_handler cmd_handlers[] = {
>         { bt_a2dp_disconnect, false, sizeof(struct hal_cmd_a2dp_disconnect) },
>  };
>
> +static struct a2dp_setup *find_setup_by_device(struct a2dp_device *dev)
> +{
> +       GSList *l;
> +
> +       for (l = setups; l; l = g_slist_next(l)) {
> +               struct a2dp_setup *setup = l->data;
> +
> +               if (setup->dev == dev)
> +                       return setup;
> +       }
> +
> +       return NULL;
> +}
> +
> +static void transport_connect_cb(GIOChannel *chan, GError *err,
> +                                                       gpointer user_data)
> +{
> +       struct a2dp_device *dev = user_data;
> +       struct a2dp_setup *setup;
> +       uint16_t imtu, omtu;
> +       GError *gerr = NULL;
> +       int fd;
> +
> +       if (err) {
> +               error("%s", err->message);
> +               return;
> +       }
> +
> +       setup = find_setup_by_device(dev);
> +       if (!setup) {
> +               error("Unable to find stream setup");
> +               return;
> +       }
> +
> +       bt_io_get(chan, &gerr,
> +                       BT_IO_OPT_IMTU, &imtu,
> +                       BT_IO_OPT_OMTU, &omtu,
> +                       BT_IO_OPT_INVALID);
> +       if (gerr) {
> +               error("%s", gerr->message);
> +               g_error_free(gerr);
> +               return;
> +       }
> +
> +       fd = g_io_channel_unix_get_fd(chan);
> +
> +       if (!avdtp_stream_set_transport(setup->stream, fd, imtu, omtu)) {
> +               error("avdtp_stream_set_transport: failed");
> +               return;
> +       }
> +
> +       g_io_channel_set_close_on_unref(chan, FALSE);
> +}
> +
>  static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
>  {
>         struct a2dp_device *dev;
> @@ -501,13 +555,15 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
>                 return;
>         }
>
> -       l = g_slist_find_custom(devices, &dst, device_cmp);
> -       if (l)
> -               return;
> -
>         ba2str(&dst, address);
>         DBG("Incoming connection from %s", address);
>
> +       l = g_slist_find_custom(devices, &dst, device_cmp);
> +       if (l) {
> +               transport_connect_cb(chan, err, l->data);
> +               return;
> +       }
> +
>         dev = a2dp_device_new(&dst);
>         signaling_connect_cb(chan, err, dev);
>  }
> --
> 1.8.4.2

Pushed.


-- 
Luiz Augusto von Dentz

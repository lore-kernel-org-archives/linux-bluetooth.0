Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1315317353-14412-5-git-send-email-frederic.dalleau@linux.intel.com>
References: <1315317353-14412-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1315317353-14412-5-git-send-email-frederic.dalleau@linux.intel.com>
Date: Wed, 21 Sep 2011 11:46:20 +0300
Message-ID: <CABBYNZL9=w6NaRVckochMocx9ZDQW-nvE0e5k95O0C0Y2cXNOg@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] Set state to "connecting" on connection requested
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2011/9/6 Frédéric Dalleau <frederic.dalleau@linux.intel.com>:
> Make sure that state changes to disconnected on
> errors (authorization refused, disconnect, sdp)
> This change will become necessary when
> integrating the Audio interface which rely on
> state change to confirm that connection
> has started successfully.
> ---
>  audio/gateway.c |   29 +++++++++++++++++++----------
>  audio/manager.c |    6 ++++--
>  2 files changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/audio/gateway.c b/audio/gateway.c
> index b788de7..945477e 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -323,8 +323,6 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *err,
>                goto fail;
>        }
>
> -       change_state(dev, GATEWAY_STATE_CONNECTING);
> -
>        sk = g_io_channel_unix_get_fd(chan);
>
>        gw->rfcomm = g_io_channel_ref(chan);
> @@ -387,17 +385,23 @@ static void get_incoming_record_cb(sdp_list_t *recs, int err,
>        if (err < 0) {
>                error("Unable to get service record: %s (%d)", strerror(-err),
>                                        -err);
> -               return;
> +               goto fail;
>        }
>
>        if (!recs || !recs->data) {
>                error("No records found");
> -               return;
> +               goto fail;
>        }
>
>        gw->version = get_remote_profile_version(recs->data);
> -       if (gw->version > 0)
> -               rfcomm_connect_cb(gw->incoming, gerr, dev);
> +       if (gw->version == 0)
> +               goto fail;
> +
> +       rfcomm_connect_cb(gw->incoming, gerr, dev);
> +       return;
> +
> +fail:
> +       gateway_close(dev);
>  }
>
>  static void unregister_incoming(gpointer user_data)
> @@ -423,8 +427,11 @@ static void rfcomm_incoming_cb(GIOChannel *chan, GError *err,
>        sdp_uuid16_create(&uuid, HANDSFREE_AGW_SVCLASS_ID);
>        if (bt_search_service(&dev->src, &dev->dst, &uuid,
>                                                get_incoming_record_cb, dev,
> -                                               unregister_incoming) < 0)
> -               unregister_incoming(dev);
> +                                               unregister_incoming) == 0)
> +               return;
> +
> +       unregister_incoming(dev);
> +       gateway_close(dev);
>  }
>
>  static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
> @@ -499,8 +506,6 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
>        }
>
>        g_io_channel_unref(io);
> -
> -       change_state(dev, GATEWAY_STATE_CONNECTING);
>        return;
>
>  fail:
> @@ -520,6 +525,7 @@ static int get_records(struct audio_device *device)
>  {
>        uuid_t uuid;
>
> +       change_state(device, GATEWAY_STATE_CONNECTING);
>        sdp_uuid16_create(&uuid, HANDSFREE_AGW_SVCLASS_ID);
>        return bt_search_service(&device->src, &device->dst, &uuid,
>                                get_record_cb, device, NULL);
> @@ -764,6 +770,8 @@ int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *io)
>
>        dev->gateway->rfcomm = g_io_channel_ref(io);
>
> +       change_state(dev, GATEWAY_STATE_CONNECTING);
> +
>        return 0;
>  }
>
> @@ -795,6 +803,7 @@ void gateway_start_service(struct audio_device *dev)
>        if (!bt_io_accept(gw->rfcomm, rfcomm_incoming_cb, dev, NULL, &err)) {
>                error("bt_io_accept: %s", err->message);
>                g_error_free(err);
> +               gateway_close(dev);
>        }
>  }
>
> diff --git a/audio/manager.c b/audio/manager.c
> index 33b4f5f..b0a4aa1 100644
> --- a/audio/manager.c
> +++ b/audio/manager.c
> @@ -544,9 +544,10 @@ static void gateway_auth_cb(DBusError *derr, void *user_data)
>  {
>        struct audio_device *device = user_data;
>
> -       if (derr && dbus_error_is_set(derr))
> +       if (derr && dbus_error_is_set(derr)) {
>                error("Access denied: %s", derr->message);
> -       else {
> +               gateway_set_state(device, GATEWAY_STATE_DISCONNECTED);
> +       } else {
>                char ag_address[18];
>
>                ba2str(&device->dst, ag_address);
> @@ -605,6 +606,7 @@ static void hf_io_cb(GIOChannel *chan, gpointer data)
>                                                gateway_auth_cb, device);
>        if (perr < 0) {
>                DBG("Authorization denied!");
> +               gateway_set_state(device, GATEWAY_STATE_DISCONNECTED);
>                goto drop;
>        }
>
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Ack

-- 
Luiz Augusto von Dentz

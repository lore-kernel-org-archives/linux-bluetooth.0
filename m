Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1314373178-11337-9-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314373178-11337-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1314373178-11337-9-git-send-email-frederic.dalleau@linux.intel.com>
Date: Mon, 29 Aug 2011 11:45:20 +0300
Message-ID: <CABBYNZJzZNQbH5EfnFePsWiVmjmcmOaiQk-MBaiX=W9a_aF+Wg@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] Remove occurences of sco_start_cb
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2011/8/26 Frédéric Dalleau <frederic.dalleau@linux.intel.com>:
> ---
>  audio/gateway.c |   28 ++++++----------------------
>  1 files changed, 6 insertions(+), 22 deletions(-)
>
> diff --git a/audio/gateway.c b/audio/gateway.c
> index e145ced..34c57df 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -71,8 +71,6 @@ struct gateway {
>        GIOChannel *rfcomm;
>        GIOChannel *sco;
>        GIOChannel *incoming;
> -       gateway_stream_cb_t sco_start_cb;
> -       void *sco_start_cb_data;
>        GSList *callbacks;
>        struct hf_agent *agent;
>        DBusMessage *msg;
> @@ -259,9 +257,6 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
>
>        change_state(dev, GATEWAY_STATE_PLAYING);
>
> -       if (gw->sco_start_cb)
> -               gw->sco_start_cb(dev, 0, gw->sco_start_cb_data);
> -
>        run_connect_cb(dev, 0);
>  }
>
> @@ -316,8 +311,6 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *err,
>
>        if (err) {
>                error("connect(): %s", err->message);
> -               if (gw->sco_start_cb)
> -                       gw->sco_start_cb(dev, err->code, gw->sco_start_cb_data);
>                goto fail;
>        }
>
> @@ -353,7 +346,7 @@ fail:
>                g_dbus_send_message(dev->conn, reply);
>        }
>
> -       change_state(dev, GATEWAY_STATE_DISCONNECTED);
> +       gateway_close(dev);
>  }
>
>  static int get_remote_profile_version(sdp_record_t *rec)
> @@ -498,7 +491,6 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
>                                BT_IO_OPT_INVALID);
>        if (!io) {
>                error("Unable to connect: %s", gerr->message);
> -               gateway_close(dev);
>                goto fail;
>        }
>
> @@ -512,16 +504,10 @@ fail:
>                g_dbus_send_message(dev->conn, reply);
>        }
>
> -       change_state(dev, GATEWAY_STATE_DISCONNECTED);
> -
> -       if (!gerr)
> -               g_set_error(&gerr, BT_IO_ERROR, BT_IO_ERROR_FAILED,
> -                               "connect: %s (%d)", strerror(-err), -err);
> -
> -       if (gw->sco_start_cb)
> -               gw->sco_start_cb(dev, -err, gw->sco_start_cb_data);
> +       gateway_close(dev);
>
> -       g_error_free(gerr);
> +       if (gerr)
> +               g_error_free(gerr);
>  }
>
>  static int get_records(struct audio_device *device)
> @@ -571,11 +557,10 @@ int gateway_close(struct audio_device *device)
>                g_io_channel_shutdown(gw->sco, TRUE, NULL);
>                g_io_channel_unref(gw->sco);
>                gw->sco = NULL;
> -               gw->sco_start_cb = NULL;
> -               gw->sco_start_cb_data = NULL;
>        }
>
>        change_state(device, GATEWAY_STATE_DISCONNECTED);
> +       run_connect_cb(device, -EIO);
>
>        return 0;
>  }
> @@ -904,8 +889,7 @@ void gateway_suspend_stream(struct audio_device *dev)
>        g_io_channel_shutdown(gw->sco, TRUE, NULL);
>        g_io_channel_unref(gw->sco);
>        gw->sco = NULL;
> -       gw->sco_start_cb = NULL;
> -       gw->sco_start_cb_data = NULL;
> +       run_connect_cb(dev, -ECONNABORTED);
>        change_state(dev, GATEWAY_STATE_CONNECTED);
>  }
>
> --
> 1.7.1

As I said I would merge this where you actually change the way the
callbacks works.

-- 
Luiz Augusto von Dentz

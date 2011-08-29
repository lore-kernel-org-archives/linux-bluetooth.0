Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1314373178-11337-8-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314373178-11337-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1314373178-11337-8-git-send-email-frederic.dalleau@linux.intel.com>
Date: Mon, 29 Aug 2011 11:43:29 +0300
Message-ID: <CABBYNZJ70+kbGyYW+f7xMWk+Z_Z8vaNNyHpxUnXiLTvyjZyjGQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] Asynchronously run gateway_config_stream cb
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
>  audio/gateway.c |   16 ++++++++--------
>  audio/unix.c    |    7 ++-----
>  2 files changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/audio/gateway.c b/audio/gateway.c
> index 93ff4b9..e145ced 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -841,21 +841,21 @@ unsigned int gateway_request_stream(struct audio_device *dev,
>        return id;
>  }
>
> -int gateway_config_stream(struct audio_device *dev, gateway_stream_cb_t sco_cb,
> +int gateway_config_stream(struct audio_device *dev, gateway_stream_cb_t cb,
>                                void *user_data)
>  {
>        struct gateway *gw = dev->gateway;
> +       unsigned int id;
> +
> +       id = connect_cb_new(gw, cb, user_data);
>
>        if (!gw->rfcomm) {
> -               gw->sco_start_cb = sco_cb;
> -               gw->sco_start_cb_data = user_data;
> -               return get_records(dev);
> +               get_records(dev);
> +       } else if (cb) {
> +               g_idle_add(request_stream_cb, dev);
>        }
>
> -       if (sco_cb)
> -               sco_cb(dev, 0, user_data);
> -
> -       return 0;
> +       return id;
>  }
>
>  gboolean gateway_cancel_stream(struct audio_device *dev, unsigned int id)
> diff --git a/audio/unix.c b/audio/unix.c
> index 111fc57..d16cbd4 100644
> --- a/audio/unix.c
> +++ b/audio/unix.c
> @@ -1045,11 +1045,8 @@ static void start_config(struct audio_device *dev, struct unix_client *client)
>                client->cancel = headset_cancel_stream;
>                break;
>        case TYPE_GATEWAY:
> -               if (gateway_config_stream(dev, gateway_setup_complete, client) >= 0) {
> -                       client->cancel = gateway_cancel_stream;
> -                       id = 1;
> -               } else
> -                       id = 0;
> +               id = gateway_config_stream(dev, gateway_setup_complete, client);
> +               client->cancel = gateway_cancel_stream;
>                break;
>
>        default:
> --
> 1.7.1

It looks like this is also related to the change how gateway callbacks
works, actually the code in unix.c would self generate its id, so
perhaps this should be merged where you change the return of
gateway_config_stream?


-- 
Luiz Augusto von Dentz

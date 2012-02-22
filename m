Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329842810-13449-2-git-send-email-frederic.dalleau@linux.intel.com>
References: <1329842810-13449-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1329842810-13449-2-git-send-email-frederic.dalleau@linux.intel.com>
Date: Wed, 22 Feb 2012 10:43:08 +0200
Message-ID: <CABBYNZLwHsRwAMEGqZg-RQF5iW77OJXsKWhvG2gjZr+qVh+v0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gateway: Fix crash if SCO connection fails
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

2012/2/21 Frédéric Dalleau <frederic.dalleau@linux.intel.com>:
> In some situations, a connect callback is created, but
> this callback is not added to media_owner. Thus when the owner
> is destroyed and at rfcomm disconnect, the callback is executed
> with an invalid pointer.
> ---
>  audio/gateway.c |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)
>
> diff --git a/audio/gateway.c b/audio/gateway.c
> index 163f7b5..131f93f 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -836,12 +836,9 @@ unsigned int gateway_request_stream(struct audio_device *dev,
>                                gateway_stream_cb_t cb, void *user_data)
>  {
>        struct gateway *gw = dev->gateway;
> -       unsigned int id;
>        GError *err = NULL;
>        GIOChannel *io;
>
> -       id = connect_cb_new(gw, cb, user_data);
> -
>        if (!gw->rfcomm)
>                get_records(dev);
>        else if (!gw->sco) {
> @@ -858,7 +855,7 @@ unsigned int gateway_request_stream(struct audio_device *dev,
>        } else
>                g_idle_add(request_stream_cb, dev);
>
> -       return id;
> +       return connect_cb_new(gw, cb, user_data);
>  }
>
>  int gateway_config_stream(struct audio_device *dev, gateway_stream_cb_t cb,
> --
> 1.7.5.4

Ack

-- 
Luiz Augusto von Dentz

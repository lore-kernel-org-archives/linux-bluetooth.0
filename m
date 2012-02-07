Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328634264-9931-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1328634264-9931-1-git-send-email-frederic.dalleau@linux.intel.com>
Date: Tue, 7 Feb 2012 20:07:45 +0200
Message-ID: <CABBYNZJameNM2VOMRK=qvZLGfUNM+Zhr6YgYS0vs+UwACSz-9Q@mail.gmail.com>
Subject: Re: [PATCH] gateway: Fix crash if SCO connection fails
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2012/2/7 Frédéric Dalleau <frederic.dalleau@linux.intel.com>:
> In some situations, a connect callback is created, but
> this callback is not added to media_owner. Thus when the owner
> is destroyed and at rfcomm disconnect, the callback is executed
> with an invalid pointer.
> ---
>  audio/gateway.c |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)
>
> diff --git a/audio/gateway.c b/audio/gateway.c
> index bde3e02..fc453dd 100644
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

It doesn't seems this change anything since the id is always returned
anyway, have you tried to reproduce it while running with valgrind?


-- 
Luiz Augusto von Dentz

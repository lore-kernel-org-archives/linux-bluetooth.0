Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1315317353-14412-7-git-send-email-frederic.dalleau@linux.intel.com>
References: <1315317353-14412-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1315317353-14412-7-git-send-email-frederic.dalleau@linux.intel.com>
Date: Wed, 21 Sep 2011 11:54:13 +0300
Message-ID: <CABBYNZKCgWcvo4r_Um-iq_JqWvu9fshks3Nuj4eAg4uBq8Rc0A@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] Check all states before allowing gw connection
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2011/9/6 Frédéric Dalleau <frederic.dalleau@linux.intel.com>:
> ---
>  audio/gateway.c |    6 ++++++
>  audio/gateway.h |    1 +
>  audio/manager.c |    2 +-
>  3 files changed, 8 insertions(+), 1 deletions(-)
>
> diff --git a/audio/gateway.c b/audio/gateway.c
> index f3e6c6a..f2b25d5 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -764,6 +764,12 @@ gboolean gateway_is_connected(struct audio_device *dev)
>                        dev->gateway->state == GATEWAY_STATE_CONNECTED);
>  }
>
> +gboolean gateway_is_active(struct audio_device *dev)
> +{
> +       return (dev && dev->gateway &&
> +                       dev->gateway->state != GATEWAY_STATE_DISCONNECTED);

How about changing this to something similar as headset_is_active, IMO
the caller should verify if the device has the gateway interface
otherwise it may generate duplicates checks and extra code.

> +}
> +
>  int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *io)
>  {
>        if (!io)
> diff --git a/audio/gateway.h b/audio/gateway.h
> index a8ed2f2..77f5787 100644
> --- a/audio/gateway.h
> +++ b/audio/gateway.h
> @@ -57,6 +57,7 @@ typedef void (*gateway_stream_cb_t) (struct audio_device *dev, GError *err,
>  void gateway_set_state(struct audio_device *dev, gateway_state_t new_state);
>  void gateway_unregister(struct audio_device *dev);
>  struct gateway *gateway_init(struct audio_device *device);
> +gboolean gateway_is_active(struct audio_device *dev);
>  gboolean gateway_is_connected(struct audio_device *dev);
>  int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *io);
>  int gateway_connect_sco(struct audio_device *dev, GIOChannel *chan);
> diff --git a/audio/manager.c b/audio/manager.c
> index b0a4aa1..64a78e9 100644
> --- a/audio/manager.c
> +++ b/audio/manager.c
> @@ -592,7 +592,7 @@ static void hf_io_cb(GIOChannel *chan, gpointer data)
>                        goto drop;
>        }
>
> -       if (gateway_is_connected(device)) {
> +       if (gateway_is_active(device)) {
>                DBG("Refusing new connection since one already exists");
>                goto drop;
>        }
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Luiz Augusto von Dentz

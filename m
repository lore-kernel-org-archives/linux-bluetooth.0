Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1314373178-11337-4-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314373178-11337-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1314373178-11337-4-git-send-email-frederic.dalleau@linux.intel.com>
Date: Mon, 29 Aug 2011 11:28:15 +0300
Message-ID: <CABBYNZJsYfwrNk9j-RiDnwDQ9=iWY099L7X+A1F2WCw+JYWZcw@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] Cancel pending callback if stream is canceled
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
>  audio/gateway.c |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
>
> diff --git a/audio/gateway.c b/audio/gateway.c
> index 8cbaeb4..c5f21e6 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -859,7 +859,27 @@ int gateway_config_stream(struct audio_device *dev, gateway_stream_cb_t sco_cb,
>
>  gboolean gateway_cancel_stream(struct audio_device *dev, unsigned int id)
>  {
> +       struct gateway *gw = dev->gateway;
> +       GSList *l;
> +       struct connect_cb *cb = NULL;
> +
> +       for (l = gw->callbacks; l != NULL; l = l->next) {
> +               struct connect_cb *tmp = l->data;
> +
> +               if (tmp->id == id) {
> +                       cb = tmp;
> +                       break;
> +               }
> +       }
> +
> +       if (!cb)
> +               return FALSE;
> +
> +       gw->callbacks = g_slist_remove(gw->callbacks, cb);
> +       g_free(cb);
> +
>        gateway_suspend_stream(dev);
> +
>        return TRUE;
>  }
>
> --
> 1.7.1
>

Ack.


-- 
Luiz Augusto von Dentz

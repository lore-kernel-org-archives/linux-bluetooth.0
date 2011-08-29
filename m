Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1314373178-11337-2-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314373178-11337-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1314373178-11337-2-git-send-email-frederic.dalleau@linux.intel.com>
Date: Mon, 29 Aug 2011 11:23:39 +0300
Message-ID: <CABBYNZLkv=6auntB2iY63Ca3z9vH4qW9+0hj6XVWPbmY7cq0Hg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] Fix disconnect SCO at same time than RFCOMM
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2011/8/26 Frédéric Dalleau <frederic.dalleau@linux.intel.com>:
> If RFCOMM disconnects, SCO should be disconnected too.
> ---
>  audio/gateway.c |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)
>
> diff --git a/audio/gateway.c b/audio/gateway.c
> index 142b12e..59c91dd 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -222,15 +222,10 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
>  static gboolean rfcomm_disconnect_cb(GIOChannel *chan, GIOCondition cond,
>                        struct audio_device *dev)
>  {
> -       struct gateway *gw = dev->gateway;
> -
>        if (cond & G_IO_NVAL)
>                return FALSE;
>
> -       g_io_channel_shutdown(gw->rfcomm, TRUE, NULL);
> -       g_io_channel_unref(gw->rfcomm);
> -       gw->rfcomm = NULL;
> -       change_state(dev, GATEWAY_STATE_DISCONNECTED);
> +       gateway_close(dev);
>
>        return FALSE;
>  }
> --
> 1.7.1
>

Looks good, ack.

-- 
Luiz Augusto von Dentz

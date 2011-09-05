Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1314805732-30418-4-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314805732-30418-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1314805732-30418-4-git-send-email-frederic.dalleau@linux.intel.com>
Date: Mon, 5 Sep 2011 11:00:09 +0300
Message-ID: <CABBYNZJceDp_=As1qXCmo7apQL2mbVxTbFH63MDstd2BtXvB4g@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] Fix state to "playing" on SCO establishment
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2011/8/31 Frédéric Dalleau <frederic.dalleau@linux.intel.com>:
> ---
>  audio/gateway.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/audio/gateway.c b/audio/gateway.c
> index ee33d79..7b6c535 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -255,6 +255,7 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
>        g_io_add_watch(gw->sco, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
>                                (GIOFunc) sco_io_cb, dev);
>
> +       change_state(dev, GATEWAY_STATE_PLAYING);
>        run_connect_cb(dev, NULL);
>  }
>
> --
> 1.7.1

Ack.


-- 
Luiz Augusto von Dentz

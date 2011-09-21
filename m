Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1315317353-14412-4-git-send-email-frederic.dalleau@linux.intel.com>
References: <1315317353-14412-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1315317353-14412-4-git-send-email-frederic.dalleau@linux.intel.com>
Date: Wed, 21 Sep 2011 11:42:41 +0300
Message-ID: <CABBYNZ+xuP5D1=Z4Q5qbhPG7BsOP=UjFU_YCE1ZdtpCc1N_ARA@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] Fix state to "playing" on SCO establishment
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
>  audio/gateway.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/audio/gateway.c b/audio/gateway.c
> index 4c28721..b788de7 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -260,6 +260,7 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
>        g_io_add_watch(gw->sco, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
>                                (GIOFunc) sco_io_cb, dev);
>
> +       change_state(dev, GATEWAY_STATE_PLAYING);
>        run_connect_cb(dev, NULL);
>  }
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

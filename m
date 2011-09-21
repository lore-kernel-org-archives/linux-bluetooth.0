Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1315317353-14412-6-git-send-email-frederic.dalleau@linux.intel.com>
References: <1315317353-14412-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1315317353-14412-6-git-send-email-frederic.dalleau@linux.intel.com>
Date: Wed, 21 Sep 2011 11:47:23 +0300
Message-ID: <CABBYNZJx=7uEbE+vf4Kf7dnVOrsDBcWkCirC9ossckan3C5jpQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] Fix reference count issue in incoming connections
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2011/9/6 Frédéric Dalleau <frederic.dalleau@linux.intel.com>:
> In case of incoming RFCOMM connection, manager
> calls gateway_connect_rfcomm which already take
> reference to GIOChannel, hence no need to take
> another one.
> ---
>  audio/gateway.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/audio/gateway.c b/audio/gateway.c
> index 945477e..f3e6c6a 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -325,7 +325,8 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *err,
>
>        sk = g_io_channel_unix_get_fd(chan);
>
> -       gw->rfcomm = g_io_channel_ref(chan);
> +       if (gw->rfcomm == NULL)
> +               gw->rfcomm = g_io_channel_ref(chan);
>
>        ret = agent_sendfd(gw->agent, sk, newconnection_reply, dev);
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

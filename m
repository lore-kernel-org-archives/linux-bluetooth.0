Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1314027047-5476-8-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314027047-5476-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1314027047-5476-8-git-send-email-frederic.dalleau@linux.intel.com>
Date: Wed, 24 Aug 2011 13:57:43 +0300
Message-ID: <CABBYNZLwzKwHbU0wMpvFcwp9ZRF46WvJ0Usx=0U-YonyrN+jkw@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] Fix invalid state at SCO disconnect in gateway
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2011/8/22 Frédéric Dalleau <frederic.dalleau@linux.intel.com>:
> If SCO disconnects after RFCOMM, do not change state to connected.
> ---
>  audio/gateway.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/audio/gateway.c b/audio/gateway.c
> index c3c4019..d41bbc3 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -191,7 +191,9 @@ static gboolean sco_io_cb(GIOChannel *chan, GIOCondition cond,
>        g_io_channel_shutdown(gw->sco, TRUE, NULL);
>        g_io_channel_unref(gw->sco);
>        gw->sco = NULL;
> -       change_state(dev, GATEWAY_STATE_CONNECTED);
> +
> +       if (gw->rfcomm)
> +               change_state(dev, GATEWAY_STATE_CONNECTED);
>
>        return FALSE;
>  }
> --
> 1.7.1
>

This looks like a workaround, the watch should not be active anymore
if rfcomm is disconnected so there is a bug somewhere else.

-- 
Luiz Augusto von Dentz

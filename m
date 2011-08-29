Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1314373178-11337-5-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314373178-11337-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1314373178-11337-5-git-send-email-frederic.dalleau@linux.intel.com>
Date: Mon, 29 Aug 2011 11:29:00 +0300
Message-ID: <CABBYNZJJN9-bi8VGzM8W5qBaEQ90YKVFODGTtUdXaLNiEDimLA@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] Fix state to "playing" on SCO establishment
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
>  audio/gateway.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/audio/gateway.c b/audio/gateway.c
> index c5f21e6..7bab77c 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -261,6 +261,8 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
>
>        g_io_add_watch(gw->sco, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
>                                (GIOFunc) sco_io_cb, dev);
> +
> +       change_state(dev, GATEWAY_STATE_PLAYING);
>  }
>
>  static gboolean rfcomm_disconnect_cb(GIOChannel *chan, GIOCondition cond,
> --
> 1.7.1

Ack.

-- 
Luiz Augusto von Dentz

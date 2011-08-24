Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1314027047-5476-7-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314027047-5476-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1314027047-5476-7-git-send-email-frederic.dalleau@linux.intel.com>
Date: Wed, 24 Aug 2011 13:54:31 +0300
Message-ID: <CABBYNZK0DDYou3w6AQ7xoqW2urYs7jHvuCrRUWezxCd9-pkTPQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] Set state to "connecting" when AG connects.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2011/8/22 Frédéric Dalleau <frederic.dalleau@linux.intel.com>:
> This state is used by media.c to trigger pulseaudio configuration.
> ---
>  audio/gateway.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/audio/gateway.c b/audio/gateway.c
> index 425ad16..c3c4019 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -284,6 +284,8 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *err,
>                goto fail;
>        }
>
> +       change_state(dev, GATEWAY_STATE_CONNECTING);
> +
>        sk = g_io_channel_unix_get_fd(chan);
>
>        gw->rfcomm = g_io_channel_ref(chan);
> --
> 1.7.1
>
> --

Ack

-- 
Luiz Augusto von Dentz

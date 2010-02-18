Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Feb 2010 14:09:39 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Mark inuse flag whenever a stream is configured
Message-ID: <20100218170939.GA15898@jh-x301>
References: <2d5a2c101002180604u7cecd3ecsa3a047c3c28bcf61@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2d5a2c101002180604u7cecd3ecsa3a047c3c28bcf61@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Feb 18, 2010, Luiz Augusto von Dentz wrote:
> Currently it was only marked when acting as the initiator.
> ---
>  audio/avdtp.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/audio/avdtp.c b/audio/avdtp.c
> index efed9b6..2591845 100644
> --- a/audio/avdtp.c
> +++ b/audio/avdtp.c
> @@ -1426,6 +1426,7 @@ static gboolean avdtp_setconf_cmd(struct avdtp
> *session, uint8_t transaction,
>  	}
> 
>  	sep->stream = stream;
> +	sep->info.inuse = 1;
>  	session->streams = g_slist_append(session->streams, stream);
> 
>  	avdtp_sep_set_state(session, sep, AVDTP_STATE_CONFIGURED);

The patch has been pushed upstream. Thanks.

Johan

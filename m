Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1330613135-16552-1-git-send-email-michal.labedzki@tieto.com>
References: <1330613135-16552-1-git-send-email-michal.labedzki@tieto.com>
Date: Thu, 1 Mar 2012 17:50:09 +0200
Message-ID: <CABBYNZJw1QNhpa3PinPQaugZRr0QcLcamdgvUvTuOEUoeJXTvg@mail.gmail.com>
Subject: Re: [PATCH 1/3] avrcp: Fix response ctype of AbortContinuingResponse
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com,
	vani.patel@stericsson.com, joohi.rastogi@stericsson.com,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Thu, Mar 1, 2012 at 4:45 PM, Michal Labedzki
<michal.labedzki@tieto.com> wrote:
> Request ctype of "AbortContinuingResponse" is CONTROL, so response should be
> ACCEPTED instead of STABLE. This affect PTS Test Case for TP/RCR/BV-04-C.
> ---
>  audio/avrcp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index c9ec314..4573133 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -986,7 +986,7 @@ static uint8_t avrcp_handle_abort_continuing(struct avrcp_player *player,
>        player_abort_pending_pdu(player);
>        pdu->params_len = 0;
>
> -       return AVC_CTYPE_STABLE;
> +       return AVC_CTYPE_ACCEPTED;
>
>  err:
>        pdu->params_len = htons(1);
> --
> on behalf of ST-Ericsson
>
> --

Lucas can you take a look and ack this, it should be very straight forward.


-- 
Luiz Augusto von Dentz

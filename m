Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334135558-21866-2-git-send-email-michal.labedzki@tieto.com>
References: <1334135558-21866-1-git-send-email-michal.labedzki@tieto.com>
	<1334135558-21866-2-git-send-email-michal.labedzki@tieto.com>
Date: Wed, 11 Apr 2012 13:48:22 +0300
Message-ID: <CABBYNZKK+6UyXxJ=eethVf9AOMknMsty93tFaKeP_gpkzrFtdg@mail.gmail.com>
Subject: Re: [PATCH 1/3] AVRCP: Add missing capability for TrackReachedEnd
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, lucas.demarchi@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Wed, Apr 11, 2012 at 12:12 PM, Michal Labedzki
<michal.labedzki@tieto.com> wrote:
> Add missing capability for TrackReachedEnd.
> ---
>  audio/avrcp.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index 8eba046..d456023 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -557,11 +557,12 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp_player *player,
>
>                return AVC_CTYPE_STABLE;
>        case CAP_EVENTS_SUPPORTED:
> -               pdu->params_len = htons(5);
> -               pdu->params[1] = 3;
> +               pdu->params_len = htons(2 + 4);

I think we could have params_lens done latter using params[1] e.g
pdu->params_len = htons(2 + pdu->params[1]) to make it simpler to add
new events.

> +               pdu->params[1] = 4;
>                pdu->params[2] = AVRCP_EVENT_STATUS_CHANGED;
>                pdu->params[3] = AVRCP_EVENT_TRACK_CHANGED;
>                pdu->params[4] = AVRCP_EVENT_TRACK_REACHED_START;
> +               pdu->params[5] = AVRCP_EVENT_TRACK_REACHED_END;
>
>                return AVC_CTYPE_STABLE;
>        }
> --
> on behalf of ST-Ericsson

The rest looks good.

-- 
Luiz Augusto von Dentz

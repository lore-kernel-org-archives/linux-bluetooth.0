Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1330613135-16552-1-git-send-email-michal.labedzki@tieto.com>
References: <1330613135-16552-1-git-send-email-michal.labedzki@tieto.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Fri, 2 Mar 2012 14:16:27 -0300
Message-ID: <CAMOw1v6vqzPSz0awNy1XNHFAjfoRqf76e1ERAbQ-fmEipMGH-A@mail.gmail.com>
Subject: Re: [PATCH 1/3] avrcp: Fix response ctype of AbortContinuingResponse
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com,
	vani.patel@stericsson.com, joohi.rastogi@stericsson.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Mar 1, 2012 at 11:45 AM, Michal Labedzki
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

What version of PTS you are running? It seems like PTS was accepting
it  before. Last time I checked it was passing exactly this test, but
searching PTS bugs I found this:

https://www.bluetooth.org/pts/issues/view_issue.cfm?id=8043 (Created:
10-Jun-11     by: Bradford Ayres     ID: 38385)


So you have my ACK here.


Lucas De Marchi

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334243001-17016-3-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com> <1334243001-17016-3-git-send-email-s.syam@samsung.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Thu, 12 Apr 2012 17:30:02 -0300
Message-ID: <CAMOw1v4Xohsu5nW8+LECEgsUHUFwTh_3ZtaEqLztgbd-NtKv2w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 02/19] avrcp: Fix the response ctype of SetPlayerApplicationSettingValue
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Apr 12, 2012 at 12:02 PM, Syam Sidhardhan <s.syam@samsung.com> wrote:
> Request ctype of "SetPlayerApplicationSettingValue" is CONTROL,
> so response should be ACCEPTED instead of STABLE.
> ---
>  audio/avrcp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index 8eba046..70e5bbf 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -791,7 +791,7 @@ static uint8_t avrcp_handle_set_player_value(struct avrcp_player *player,
>        if (len) {
>                pdu->params_len = 0;
>
> -               return AVC_CTYPE_STABLE;
> +               return AVC_CTYPE_ACCEPTED;

Similar to "e8e323e avrcp: Fix response ctype of AbortContinuingResponse"

Ack.


Lucas De Marchi

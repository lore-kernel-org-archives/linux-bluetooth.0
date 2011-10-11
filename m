Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1318332898-21272-2-git-send-email-dmitriy.paliy@nokia.com>
References: <1318332898-21272-1-git-send-email-dmitriy.paliy@nokia.com>
	<1318332898-21272-2-git-send-email-dmitriy.paliy@nokia.com>
Date: Tue, 11 Oct 2011 15:12:18 +0300
Message-ID: <CABBYNZJ8Stu6wLEC-6urfi6SWn6nkYeeAuKiWg76Bz0bOAGCKQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] Fix call status in +CLCC for maemo6 telephony
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Tue, Oct 11, 2011 at 2:34 PM, Dmitriy Paliy <dmitriy.paliy@nokia.com> wrote:
> If list current calls is requested when there is second incoming call
> and csd call status is CSD_CALL_STATUS_PROCEEDING, then returned 'state
> of the call' value in +CLCC is 4 (incoming, MT call), which is incorrect.
> Indication than proceeds from incoming to waiting state.
>
> This patch sets the corresponding value to 5 (waiting, MT call) in
> maemo6 telephony driver for the second call.
> ---
>  audio/telephony-maemo6.c |   12 ++++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
> index 102daeb..82cb274 100644
> --- a/audio/telephony-maemo6.c
> +++ b/audio/telephony-maemo6.c
> @@ -932,8 +932,16 @@ static int csd_status_to_hfp(struct csd_call *call)
>                /* PROCEEDING can happen in outgoing/incoming */
>                if (call->originating)
>                        return CALL_STATUS_DIALING;
> -               else
> -                       return CALL_STATUS_INCOMING;
> +
> +               /*
> +                * PROCEEDING is followed by WAITING CSD status, therefore
> +                * second incoming call status indication is set immediately
> +                * to waiting.
> +                */
> +               if (g_slist_length(active_calls) > 0)
> +                       return CALL_STATUS_WAITING;
> +
> +               return CALL_STATUS_INCOMING;
>        case CSD_CALL_STATUS_COMING:
>                return CALL_STATUS_INCOMING;
>        case CSD_CALL_STATUS_MO_ALERTING:
> --
> 1.7.4.1
>

Ack.

-- 
Luiz Augusto von Dentz

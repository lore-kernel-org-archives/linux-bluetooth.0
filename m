Return-Path: <cyrus@holtmann.org>
Message-ID: <4D7F9410.5020609@codeaurora.org>
Date: Tue, 15 Mar 2011 09:30:08 -0700
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Arun Raghavan <arun.raghavan@collabora.co.uk>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Always reset the remote SEP when reconfiguring A2DP
References: <1300199261-27481-1-git-send-email-arun.raghavan@collabora.co.uk> <1300199261-27481-2-git-send-email-arun.raghavan@collabora.co.uk>
In-Reply-To: <1300199261-27481-2-git-send-email-arun.raghavan@collabora.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch violates the AVDTP specification, as indicated in other 
email. SEID may not be changed by RECONFIGURE.

On 3/15/2011 7:27 AM, Arun Raghavan wrote:
> This forces the remote SEP to be recalculated when reconfiguring an A2DP
> stream. This is required, for example, when reconfiguring the sink to
> accept MPEG audio instead of SBC (and thus the remote SEID changes).
> ---
>   audio/a2dp.c |    5 ++---
>   1 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/audio/a2dp.c b/audio/a2dp.c
> index 3407d6f..27759b8 100644
> --- a/audio/a2dp.c
> +++ b/audio/a2dp.c
> @@ -1101,9 +1101,6 @@ static void close_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
>   		return;
>   	}
>
> -	if (!setup->rsep)
> -		setup->rsep = avdtp_stream_get_remote_sep(stream);
> -
>   	if (setup->reconfigure)
>   		g_timeout_add(RECONFIGURE_TIMEOUT, a2dp_reconfigure, setup);
>   }
> @@ -2048,6 +2045,7 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
>   			if (a2dp_sep_get_lock(tmp))
>   				goto failed;
>   			setup->reconfigure = TRUE;
> +			setup->rsep = NULL;
>   			if (avdtp_close(session, tmp->stream, FALSE)<  0) {
>   				error("avdtp_close failed");
>   				goto failed;
> @@ -2077,6 +2075,7 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
>   			g_idle_add((GSourceFunc) finalize_config, setup);
>   		} else if (!setup->reconfigure) {
>   			setup->reconfigure = TRUE;
> +			setup->rsep = NULL;
>   			if (avdtp_close(session, sep->stream, FALSE)<  0) {
>   				error("avdtp_close failed");
>   				goto failed;


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

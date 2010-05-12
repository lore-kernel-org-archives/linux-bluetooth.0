Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1273486527-7855-8-git-send-email-sancane@gmail.com>
References: <1273486527-7855-1-git-send-email-sancane@gmail.com>
	 <1273486527-7855-2-git-send-email-sancane@gmail.com>
	 <1273486527-7855-3-git-send-email-sancane@gmail.com>
	 <1273486527-7855-4-git-send-email-sancane@gmail.com>
	 <1273486527-7855-5-git-send-email-sancane@gmail.com>
	 <1273486527-7855-6-git-send-email-sancane@gmail.com>
	 <1273486527-7855-7-git-send-email-sancane@gmail.com>
	 <1273486527-7855-8-git-send-email-sancane@gmail.com>
Date: Wed, 12 May 2010 11:33:13 -0300
Message-ID: <AANLkTikhyI_MBRgVAV3CpQ7_bSqUXqKdkarY1VTI_kI-@mail.gmail.com>
Subject: Re: [PATCH 08/25] Profiles using MCAP can close a MCL deciding if it
	should be cached
From: Raul Herbster <raul.herbster@signove.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

2010/5/10 Santiago Carot-Nemesio <sancane@gmail.com>:
> From: Santiago Carot Nemesio <sancane@gmail.com>
>
> ---
>  mcap/mcap.c |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
>
> diff --git a/mcap/mcap.c b/mcap/mcap.c
> index 0112154..8f6fb78 100644
> --- a/mcap/mcap.c
> +++ b/mcap/mcap.c
> @@ -305,6 +305,23 @@ static void mcap_uncache_mcl(struct mcap_mcl *mcl)
>        mcl->ctrl &= ~MCAP_CTRL_FREE;
>  }
>
> +void mcap_close_mcl(struct mcap_mcl *mcl, gboolean cache)
> +{
> +       if (!mcl)
> +               return;
> +
> +       if (mcl->cc) {
> +               g_io_channel_shutdown(mcl->cc, TRUE, NULL);
> +               g_io_channel_unref(mcl->cc);
> +               mcl->cc = NULL;
> +       }
> +
> +       mcl->state = MCL_IDLE;
> +
> +       if (!cache)
> +               mcl->ctrl |= MCAP_CTRL_NOCACHE;
> +}
> +

According to MCAP spec (page 10, section 2.1.2), when the CC is
closed, all of its associated DCs are closed as well. In fact, DCs are
propely closed on mcap_mcl_free , but not on mcap_close_mcl. So, which
one really closes MCL?

[]´s
--Raul

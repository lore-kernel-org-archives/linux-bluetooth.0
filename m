Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Nov 2010 15:37:17 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Do not increment mdl reference in reconnections
Message-ID: <20101122143717.GB2303@jh-x301>
References: <1290413446-5391-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290413446-5391-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Nov 22, 2010, Santiago Carot-Nemesio wrote:
> diff --git a/health/hdp.c b/health/hdp.c
> index 2e06a6b..769e300 100644
> --- a/health/hdp.c
> +++ b/health/hdp.c
> @@ -921,7 +921,8 @@ static void hdp_mcap_mdl_connected_cb(struct mcap_mdl *mdl, void *data)
>  		return;
>  
>  	chan = dev->ndc;
> -	chan->mdl = mcap_mdl_ref(mdl);
> +	if (!chan->mdl)
> +		chan->mdl = mcap_mdl_ref(mdl);
>  
>  	if (!g_slist_find(dev->channels, chan))
>  		dev->channels = g_slist_prepend(dev->channels,

Pushed upstream. Do try to be more verbose in your commit messages
please. Also have the summary lines of fix commits (like this one)
starting with "Fix ..." so they can be easily detected e.g. when doing
summaries for release changelogs.

Johan

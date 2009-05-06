Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 May 2009 12:30:49 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Forrest Zhao <forrest.zhao@intel.com>
Cc: linux-bluetooth@vger.kernel.org, forrest.zhao@gmail.com
Subject: Re: [PATCH] in headset_init(), it's possible that hs->hfp_handle
	is not set, so we should not check hs->hfp_handle in
	headset_connect_cb()
Message-ID: <20090506093049.GA31559@localhost>
References: <1241601540-6540-1-git-send-email-forrest.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1241601540-6540-1-git-send-email-forrest.zhao@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

On Wed, May 06, 2009, Forrest Zhao wrote:
> We found this bug when developing the HFP plugin for telephonyd.
> 
> ---
>  audio/headset.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/audio/headset.c b/audio/headset.c
> index 9f6b736..9b9be17 100644
> --- a/audio/headset.c
> +++ b/audio/headset.c
> @@ -1304,8 +1304,7 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
>  	else
>  		hs->auto_dc = FALSE;
>  
> -	if (server_is_enabled(&dev->src, HANDSFREE_SVCLASS_ID) &&
> -			hs->hfp_handle != 0)
> +	if (server_is_enabled(&dev->src, HANDSFREE_SVCLASS_ID))
>  		hs->hfp_active = TRUE;
>  	else
>  		hs->hfp_active = FALSE;

I don't see how that's a bug. hs->hfp_active should be true only when we
are connected to HFP. server_is_enabled(src, HANDSFREE_SVCLASS_ID) is
supposed to return true if HFP support is enabled in general. These are
two separate things (we could be connected to HSP even though HFP support
is enabled if the headset only supports HSP, i.e. hs->hfp_handle == 0 in
this case).

Johan

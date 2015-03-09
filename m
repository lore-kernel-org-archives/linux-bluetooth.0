Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 01/15] android/pan: Fix removing PAN NAP bridge
Date: Mon, 09 Mar 2015 16:20:56 +0100
Message-ID: <1479658.pmZNq35avF@uw000953>
In-Reply-To: <1425401999-21203-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1425401999-21203-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Tuesday 03 of March 2015 17:59:45 Grzegorz Kolodziejczyk wrote:
> PAN NAP bridge shouldn't be removed if bnep server add fails. Pan device
> remove function is decreasing amount of connected devices, if count will
> be zero - NAP bridge will be removed.
> ---
>  android/pan.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/android/pan.c b/android/pan.c
> index 972af89..511f4fd 100644
> --- a/android/pan.c
> +++ b/android/pan.c
> @@ -517,7 +517,6 @@ static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
>  
>  	if (bnep_server_add(sk, dst_role, BNEP_BRIDGE, dev->iface,
>  							&dev->dst) < 0) {
> -		nap_remove_bridge();
>  		error("server_connadd failed");
>  		rsp = BNEP_CONN_NOT_ALLOWED;
>  		goto failed;
> 

Patches 1-3 and updated 8-9 are now applied.

-- 
Best regards, 
Szymon Janc

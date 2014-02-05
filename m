Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/handsfree: Fix memory leak
Date: Wed, 05 Feb 2014 14:45:04 +0100
Message-ID: <2288067.6fyM9vSbUZ@uw000953>
In-Reply-To: <1391597459-3791-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391597459-3791-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wednesday 05 of February 2014 12:50:59 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Free classes if sdp_get_access_protos fails.
> ---
>  android/handsfree.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/android/handsfree.c b/android/handsfree.c
> index edf3d27..9482b2e 100644
> --- a/android/handsfree.c
> +++ b/android/handsfree.c
> @@ -229,6 +229,7 @@ static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
>  
>  	if (sdp_get_access_protos(recs->data, &protos) < 0) {
>  		error("handsfree: unable to get access protocols from record");
> +		sdp_list_free(classes, free);
>  		goto fail;
>  	}
>  

Applied, thanks.

-- 
Best regards, 
Szymon Janc

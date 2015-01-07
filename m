Return-Path: <cyrus@holtmann.org>
Date: Wed, 7 Jan 2015 11:17:19 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] shared/hfp: Remove dead code
Message-ID: <20150107091314.GA11678@aemeltch-MOBL1>
References: <1419254211-6211-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419254211-6211-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

On Mon, Dec 22, 2014 at 03:16:51PM +0200, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Remove dead code since free_tmp initialized to false.
> ---
>  src/shared/hfp.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/src/shared/hfp.c b/src/shared/hfp.c
> index 9d937a5..05a8563 100644
> --- a/src/shared/hfp.c
> +++ b/src/shared/hfp.c
> @@ -1192,10 +1192,6 @@ static void hf_process_input(struct hfp_hf *hfp)
>  	if (len == ringbuf_len(hfp->read_buf))
>  		goto done;
>  
> -	/* If we are here second time for some reason, that is wrong */
> -	if (free_tmp)
> -		goto done;
> -
>  	str2 = ringbuf_peek(hfp->read_buf, len, &len2);
>  	if (!str2)
>  		goto done;
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

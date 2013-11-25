Return-Path: <cyrus@holtmann.org>
Date: Mon, 25 Nov 2013 14:41:18 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] fixup add missing break (sjanc review)
Message-ID: <20131125124117.GA29190@aemeltch-MOBL1>
References: <1385109295-11445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1385132551-20775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385132551-20775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Nov 22, 2013 at 05:02:31PM +0200, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com

this one merged to patch 1

Best regards 
Andrei Emeltchenko 

> 
> ---
>  android/socket.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/android/socket.c b/android/socket.c
> index 70e2307..7b9e41b 100644
> --- a/android/socket.c
> +++ b/android/socket.c
> @@ -852,6 +852,9 @@ static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
>  		sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free,
>  									NULL);
>  		sdp_list_free(protos, NULL);
> +
> +		if (chan)
> +			break;
>  	}
>  
>  	if (chan <= 0) {
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

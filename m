Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Aug 2014 11:48:05 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv4 01/12] core: Remove unneeded assignment
Message-ID: <20140801084802.GA9036@aemeltch-MOBL1>
References: <1405587306-20020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1406643661-29323-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406643661-29323-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

On Tue, Jul 29, 2014 at 05:20:50PM +0300, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Variable rfcomm is never used after assignment
> ---
>  src/profile.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/src/profile.c b/src/profile.c
> index 528525a..7aca3be 100644
> --- a/src/profile.c
> +++ b/src/profile.c
> @@ -1272,7 +1272,6 @@ static uint32_t ext_start_servers(struct ext_profile *ext,
>  			error("RFCOMM server failed for %s: %s",
>  						ext->name, err->message);
>  			g_free(rfcomm);
> -			rfcomm = NULL;
>  			g_clear_error(&err);
>  			goto failed;
>  		} else {
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

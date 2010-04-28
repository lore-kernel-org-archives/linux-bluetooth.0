Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Apr 2010 18:55:55 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	gustavo@padovan.org
Subject: Re: [PATCH] Set l2cap mode always
Message-ID: <20100428155555.GB11157@jh-x301>
References: <1271282625-11666-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1271282625-11666-1-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Apr 14, 2010, Gustavo F. Padovan wrote:
> As ERTM can be the default mode with SOCK_STREAM we have to set
> opts.mode always.
> ---
>  test/l2test.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/test/l2test.c b/test/l2test.c
> index 9413070..0bb46f3 100644
> --- a/test/l2test.c
> +++ b/test/l2test.c
> @@ -228,8 +228,7 @@ static int do_connect(char *svr)
>  	/* Set new options */
>  	opts.omtu = omtu;
>  	opts.imtu = imtu;
> -	if (rfcmode > 0)
> -		opts.mode = rfcmode;
> +	opts.mode = rfcmode;
>  
>  	opts.fcs = fcs;
>  	opts.txwin_size = txwin_size;

This one is also upstream now.

Johan

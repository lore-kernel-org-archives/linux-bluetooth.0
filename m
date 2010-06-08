Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Jun 2010 14:21:16 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] sbc: Fix redundant null check on calling free()
Message-ID: <20100608062116.GA16634@jh-x301>
References: <1275732870-15889-1-git-send-email-gustavo@padovan.org>
 <1275732870-15889-2-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1275732870-15889-2-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Sat, Jun 05, 2010, Gustavo F. Padovan wrote:
> Issues found by smatch static check: http://smatch.sourceforge.net/
> ---
>  sbc/sbc.c    |    3 +--
>  sbc/sbcdec.c |    9 +++------
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/sbc/sbc.c b/sbc/sbc.c
> index edd152f..86399dd 100644
> --- a/sbc/sbc.c
> +++ b/sbc/sbc.c
> @@ -1138,8 +1138,7 @@ void sbc_finish(sbc_t *sbc)
>  	if (!sbc)
>  		return;
>  
> -	if (sbc->priv_alloc_base)
> -		free(sbc->priv_alloc_base);
> +	free(sbc->priv_alloc_base);

I'm a bit hesitant at removing these NULL checks since older libc
versions might need them. Any comments from Marcel?

Johan

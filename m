Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 May 2012 16:51:19 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Ido Yariv <ido@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] attrib-server: Allow zero length attribute update
Message-ID: <20120528195119.GB6742@samus>
References: <1338229985-27293-1-git-send-email-ido@wizery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338229985-27293-1-git-send-email-ido@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ido,

On 21:33 Mon 28 May, Ido Yariv wrote:
> attrib_db_update always fails when g_try_realloc returns NULL, not
> taking into account that the length passed to g_try_realloc could be
> zero. In this case, g_try_realloc frees the currently allocated memory
> and returns NULL.
> As a result, not only will attrib_db_update fail needlessly, a
> use-after-free could occur as the attribute's length will still hold the
> length of the freed buffer.
> 
> Fix this by only returning an error if the length is non-zero.
> ---

Patch looks good.

>  src/attrib-server.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/src/attrib-server.c b/src/attrib-server.c
> index 3291e2d..dd1bba4 100644
> --- a/src/attrib-server.c
> +++ b/src/attrib-server.c
> @@ -1456,7 +1456,7 @@ int attrib_db_update(struct btd_adapter *adapter, uint16_t handle,
>  	a = dl->data;
>  
>  	a->data = g_try_realloc(a->data, len);
> -	if (a->data == NULL)
> +	if (len && a->data == NULL)
>  		return -ENOMEM;
>  
>  	a->len = len;
> -- 
> 1.7.7.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius

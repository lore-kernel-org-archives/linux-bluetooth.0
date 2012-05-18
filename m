Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 May 2012 23:36:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] sdp: Remove unnecessary memset()
Message-ID: <20120518203645.GA17650@x220.P-661HNU-F1>
References: <1337373183-28241-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337373183-28241-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, May 18, 2012, Anderson Lizardo wrote:
> The memory referenced by "u" pointer is initialized right after the
> memset() call.
> ---
>  lib/sdp.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/lib/sdp.c b/lib/sdp.c
> index 81e328e..3dcef60 100644
> --- a/lib/sdp.c
> +++ b/lib/sdp.c
> @@ -1934,7 +1934,6 @@ int sdp_get_uuidseq_attr(const sdp_record_t *rec, uint16_t attr,
>  			if (!u)
>  				goto fail;
>  
> -			memset(u, 0, sizeof(uuid_t));
>  			*u = d->val.uuid;
>  			*seqp = sdp_list_append(*seqp, u);
>  		}

Applied. Thanks.

Johan

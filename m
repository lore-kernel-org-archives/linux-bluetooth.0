Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] shared/gap: Fix memory leak in gap
Date: Fri, 19 Dec 2014 13:29:39 +0100
Message-ID: <3389986.jiWvF7HSzQ@uw000953>
In-Reply-To: <1418991181-3826-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1418991181-3826-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Friday 19 of December 2014 14:13:01 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Allocated irk memory was never assigned.
> ---
>  src/shared/gap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/shared/gap.c b/src/shared/gap.c
> index 19059e8..3536c1c 100644
> --- a/src/shared/gap.c
> +++ b/src/shared/gap.c
> @@ -276,5 +276,5 @@ bool bt_gap_add_peer_irk(struct bt_gap *gap, uint8_t addr_type,
>  	memcpy(irk->addr, addr, 6);
>  	memcpy(irk->key, key, 16);
>  
> -	return true;
> +	return queue_push_tail(gap->irk_list, irk);
>  }

For sanity this should free irk if push failed.

-- 
Best regards, 
Szymon Janc

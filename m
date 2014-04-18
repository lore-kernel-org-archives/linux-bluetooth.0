Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/6] android/gatt: Remove redundant code
Date: Fri, 18 Apr 2014 15:25:37 +0200
Message-ID: <1926493.D67Z9kgO2k@uw000953>
In-Reply-To: <1397781624-23817-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397781624-23817-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Friday 18 of April 2014 02:40:19 Andrzej Kaczmarek wrote:
> cache_all_srvc_chars is called only with empty queue so it's redundant
> to handle this condition again inside function.
> ---
>  android/gatt.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index e339789..59bcd23 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -1739,10 +1739,6 @@ static void cache_all_srvc_chars(GSList *characteristics, struct queue *q)
>  	uint16_t inst_id = 0;
>  	bt_uuid_t uuid;
>  
> -	/* Refresh characteristics cache if already exist */
> -	if (!queue_isempty(q))
> -		queue_remove_all(q, NULL, NULL, destroy_characteristic);
> -
>  	for (; characteristics; characteristics = characteristics->next) {
>  		struct characteristic *ch;
>  
> 

All patches applied, thanks.

-- 
Best regards, 
Szymon Janc

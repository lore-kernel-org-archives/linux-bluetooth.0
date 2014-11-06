Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 1/2] android/gatt: Initialize includes queue
Date: Thu, 06 Nov 2014 16:18:54 +0100
Message-ID: <6616870.MsaVgd0J2X@uw000953>
In-Reply-To: <1415278626-20784-1-git-send-email-marcin.kraglak@tieto.com>
References: <1415278626-20784-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thursday 06 of November 2014 13:57:05 Marcin Kraglak wrote:
> Initialize included queue even if service is Secondary Service.
> ---
>  android/gatt.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 7cf612f..6b57145 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -318,8 +318,7 @@ static void destroy_service(void *data)
>  	 * So we need to free service memory only once but we need to destroy
>  	 * two queues
>  	 */
> -	if (srvc->primary)
> -		queue_destroy(srvc->included, NULL);
> +	queue_destroy(srvc->included, NULL);
>  
>  	free(srvc);
>  }
> @@ -1081,6 +1080,14 @@ static struct service *create_service(uint8_t id, bool primary, char *uuid,
>  		return NULL;
>  	}
>  
> +	s->included = queue_new();
> +	if (!s->included) {
> +		error("gatt: Cannot allocate memory for included queue");
> +		queue_destroy(s->chars, NULL);
> +		free(s);
> +		return NULL;
> +	}
> +
>  	if (bt_string_to_uuid(&s->id.uuid, uuid) < 0) {
>  		error("gatt: Cannot convert string to uuid");
>  		queue_destroy(s->chars, NULL);
> @@ -1092,20 +1099,10 @@ static struct service *create_service(uint8_t id, bool primary, char *uuid,
>  
>  	/* Put primary service to our local list */
>  	s->primary = primary;
> -	if (s->primary) {
> +	if (s->primary)
>  		memcpy(&s->prim, data, sizeof(s->prim));
> -	} else {
> +	else
>  		memcpy(&s->incl, data, sizeof(s->incl));
> -		return s;
> -	}
> -
> -	/* For primary service allocate queue for included services */
> -	s->included = queue_new();
> -	if (!s->included) {
> -		queue_destroy(s->chars, NULL);
> -		free(s);
> -		return NULL;
> -	}
>  
>  	return s;
>  }

Both patches applied, thanks. 

-- 
Best regards, 
Szymon Janc

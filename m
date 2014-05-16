Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] shared/gatt: Fix freeing uninitialized attributes
Date: Fri, 16 May 2014 14:36:18 +0200
Message-ID: <2765194.znkhuiMyg3@uw000953>
In-Reply-To: <1400234827-24438-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400234827-24438-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Friday 16 of May 2014 12:07:07 Marcin Kraglak wrote:
> Don't free uninitialized attributes. It could cause NULL pointer
> dereference.
> ---
>  src/shared/gatt-db.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index d9f63be..36316af 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -99,6 +99,10 @@ static void attribute_destroy(void *data)
>  {
>  	struct gatt_db_attribute *attribute = data;
>  
> +	/* Attribute was not initialized by user */
> +	if (!attribute)
> +		return;
> +
>  	free(attribute->value);
>  	free(attribute);
>  }
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc

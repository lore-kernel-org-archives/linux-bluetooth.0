Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android/gatt: Remove not needed empty line and redundand tab
Date: Fri, 11 Apr 2014 16:15:11 +0200
Message-ID: <4263594.itegEJ4iVI@uw000953>
In-Reply-To: <1397212190-3240-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1397212190-3240-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Friday 11 of April 2014 12:29:48 Grzegorz Kolodziejczyk wrote:
> ---
>  android/gatt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 15e788a..4e548c8 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -126,7 +126,7 @@ static bool scanning = false;
>  
>  static struct queue *gatt_clients = NULL;
>  static struct queue *gatt_servers = NULL;
> -static struct queue *conn_list	= NULL;		/* Connected devices */
> +static struct queue *conn_list = NULL;		/* Connected devices */
>  static struct queue *conn_wait_queue = NULL;	/* Devs waiting to connect */
>  static struct queue *disc_dev_list = NULL;	/* Disconnected devices */
>  
> @@ -140,7 +140,6 @@ static void android2uuid(const uint8_t *uuid, bt_uuid_t *dst)
>  
>  	for (i = 0; i < 16; i++)
>  		dst->value.u128.data[i] = uuid[15 - i];
> -
>  }
>  
>  static void uuid2android(const bt_uuid_t *src, uint8_t *uuid)
> 

This patch is pushed, others need rebase. Thanks.

-- 
Best regards, 
Szymon Janc

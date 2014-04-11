Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 5/5] android/gatt: Fix type of status parameter
Date: Fri, 11 Apr 2014 15:37:29 +0200
Message-ID: <2675315.WyPcCgPKWo@uw000953>
In-Reply-To: <1397143805-17809-6-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397143805-17809-1-git-send-email-lukasz.rymanowski@tieto.com> <1397143805-17809-6-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Thursday 10 of April 2014 17:30:05 Lukasz Rymanowski wrote:
> ---
>  android/gatt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 235e9e4..cdca424 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -509,7 +509,7 @@ static void connection_cleanup(struct gatt_device *device)
>  }
>  
>  static void send_client_disconnect_notify(int32_t id, struct gatt_device *dev,
> -								uint8_t status)
> +								int32_t status)
>  {
>  	struct hal_ev_gatt_client_disconnect ev;
>  
> 

I've applied this patch, but please check why this function is always called
success status. Shouldn't we call this callback with fail status if
handle_client_disconnect() failed?

-- 
Best regards, 
Szymon Janc

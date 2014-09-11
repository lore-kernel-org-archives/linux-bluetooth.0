Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 01/14] android/tester: Fix characteristic instance ID
Date: Thu, 11 Sep 2014 10:32:01 +0200
Message-ID: <2695017.9mdRHVIbgt@uw000953>
In-Reply-To: <1410415732-23212-1-git-send-email-marcin.kraglak@tieto.com>
References: <1410415732-23212-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thursday 11 of September 2014 08:08:39 Marcin Kraglak wrote:
> Characteristics instance id starts from 1.
> ---
>  android/tester-gatt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/tester-gatt.c b/android/tester-gatt.c
> index 2067ec3..1507803 100644
> --- a/android/tester-gatt.c
> +++ b/android/tester-gatt.c
> @@ -148,7 +148,7 @@ static btgatt_srvc_id_t service_2 = {
>  };
>  
>  static btgatt_gatt_id_t characteristic_1 = {
> -	.inst_id = 0,
> +	.inst_id = 1,
>  	.uuid.uu = {0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
>  			0x00, 0x10, 0x00, 0x00,  0x19, 0x00, 0x00, 0x00}
>  };

All patches applied, thanks. 

-- 
Best regards, 
Szymon Janc

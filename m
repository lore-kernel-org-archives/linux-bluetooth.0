Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: Re: [PATCH] android/pts: Bump PTS version for GATT
Date: Mon, 14 Apr 2014 11:45:34 +0200
Message-ID: <2254112.EGLGQHfA7Q@uw000953>
In-Reply-To: <1397401702-5762-1-git-send-email-sebastian.chlad@tieto.com>
References: <1397401702-5762-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Sunday 13 of April 2014 17:08:22 Sebastian Chlad wrote:
> ---
>  android/pics-gatt.txt  | 2 +-
>  android/pixit-gatt.txt | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/android/pics-gatt.txt b/android/pics-gatt.txt
> index 8abf8c2..f3e8199 100644
> --- a/android/pics-gatt.txt
> +++ b/android/pics-gatt.txt
> @@ -1,6 +1,6 @@
>  GATT PICS for the PTS tool.
>  
> -PTS version: 5.0
> +PTS version: 5.1
>  
>  * - different than PTS defaults
>  
> diff --git a/android/pixit-gatt.txt b/android/pixit-gatt.txt
> index 7bb8a28..c073452 100644
> --- a/android/pixit-gatt.txt
> +++ b/android/pixit-gatt.txt
> @@ -1,6 +1,6 @@
>  GATT PIXIT for the PTS tool.
>  
> -PTS version: 5.0
> +PTS version: 5.1
>  
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> @@ -26,6 +26,6 @@ TSPX_mtu_size						23
>  TSPX_pin_code						0000
>  TSPX_use_dynamic_pin					FALSE
>  TSPX_delete_ltk						FALSE
> -TSPX_characteristic_readable
> +TSPX_characteristic_readable				FALSE
>  TSPX_tester_appearance					0000
>  -------------------------------------------------------------------------------
> 

Pushed. Thanks.

-- 
Best regards, 
Szymon Janc

Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/tester: Fix build error
Date: Wed, 03 Sep 2014 16:07:57 +0200
Message-ID: <6353699.fM38oMxFUZ@uw000953>
In-Reply-To: <1409726878-14547-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409726878-14547-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Wednesday 03 of September 2014 08:47:58 Lukasz Rymanowski wrote:
> This fix following error seen when building with gcc 4.6.3
> 
> android/tester-gatt.c:135:2: error: initialized field overwritten
> [-Werror=override-init]
> android/tester-gatt.c:135:2: error: (near initialization for
> ‘service_1’) [-Werror=override-init]
> android/tester-gatt.c:142:2: error: initialized field overwritten
> [-Werror=override-init]
> android/tester-gatt.c:142:2: error: (near initialization for
> ‘service_2’) [-Werror=override-init]
> ---
>  android/tester-gatt.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/android/tester-gatt.c b/android/tester-gatt.c
> index 625d949..2067ec3 100644
> --- a/android/tester-gatt.c
> +++ b/android/tester-gatt.c
> @@ -131,16 +131,20 @@ static struct bt_action_data bearer_type = {
>  
>  static btgatt_srvc_id_t service_1 = {
>  	.is_primary = true,
> -	.id.inst_id = 0,
> -	.id.uuid.uu = {0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
> +	.id = {
> +		.inst_id = 0,
> +		.uuid.uu = {0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
>  			0x00, 0x10, 0x00, 0x00,  0x00, 0x18, 0x00, 0x00}
> +	}
>  };
>  
>  static btgatt_srvc_id_t service_2 = {
>  	.is_primary = true,
> -	.id.inst_id = 1,
> -	.id.uuid.uu = {0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
> -			0x00, 0x10, 0x00, 0x00,  0x01, 0x18, 0x00, 0x00}
> +	.id = {
> +		.inst_id = 1,
> +		.uuid.uu = {0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
> +			0x00, 0x10, 0x00, 0x00,  0x01, 0x18, 0x00, 0x00},
> +	}
>  };
>  
>  static btgatt_gatt_id_t characteristic_1 = {

Applied. Thanks. 

-- 
Best regards, 
Szymon Janc

Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] android/gatt: Fix sign_cnt increment
Date: Mon, 06 Oct 2014 15:50:16 +0200
Message-ID: <706305081.yQHgjJLZMt@uw000953>
In-Reply-To: <1412583238-3307-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1412581779-22424-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1412583238-3307-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Monday 06 of October 2014 11:13:58 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/gatt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index dbe067f..718b137 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -3169,7 +3169,7 @@ static guint signed_write_cmd(struct gatt_device *dev, uint16_t handle,
>  		return 0;
>  	}
>  
> -	bt_update_sign_counter(&dev->bdaddr, LOCAL_CSRK, sign_cnt++);
> +	bt_update_sign_counter(&dev->bdaddr, LOCAL_CSRK, ++sign_cnt);
>  
>  	return res;
>  }

Applied. Thanks. 

-- 
Best regards, 
Szymon Janc

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412581779-22424-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1412581779-22424-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 6 Oct 2014 13:06:49 +0200
Message-ID: <CAN_7+YZg2pYzzZZW6j+D918vEpQxe+tfEL0NNciU4wuz0_FD0g@mail.gmail.com>
Subject: Re: [PATCH] android/gatt: Fix unneeded increment
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Oct 6, 2014 at 9:49 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> ---
>  android/gatt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/android/gatt.c b/android/gatt.c
> index dbe067f..ecd1813 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -3169,7 +3169,7 @@ static guint signed_write_cmd(struct gatt_device *dev, uint16_t handle,
>                 return 0;
>         }
>
> -       bt_update_sign_counter(&dev->bdaddr, LOCAL_CSRK, sign_cnt++);
> +       bt_update_sign_counter(&dev->bdaddr, LOCAL_CSRK, sign_cnt);

Your rfc:  "[RFC] android/gatt: Fix sign_cnt increment" shall be used
instead of this patch.

Thanks
\Lukasz
>
>         return res;
>  }
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

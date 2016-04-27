Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1461744108-21366-2-git-send-email-beaufort.francois@gmail.com>
References: <1461744108-21366-1-git-send-email-beaufort.francois@gmail.com>
	<1461744108-21366-2-git-send-email-beaufort.francois@gmail.com>
Date: Wed, 27 Apr 2016 11:47:24 +0300
Message-ID: <CABBYNZJGcppzwCEWWpoKxt2ci7UBOzTYY03cxGqzysVm1+BtNA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Set RSSI_THRESHOLD to 2
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Francois Beaufort <beaufort.francois@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Francois,

On Wed, Apr 27, 2016 at 11:01 AM, Francois Beaufort
<beaufort.francois@gmail.com> wrote:
> ---
>  src/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/device.c b/src/device.c
> index 5269ee8..1caeee7 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -85,7 +85,7 @@
>  #define MIN(a, b) ((a) < (b) ? (a) : (b))
>  #endif
>
> -#define RSSI_THRESHOLD         8
> +#define RSSI_THRESHOLD         2
>
>  #define GATT_PRIM_SVC_UUID_STR "2800"
>  #define GATT_SND_SVC_UUID_STR  "2801"
> --
> 2.7.0

Do you guys have any numbers here?  This will probably spam more the
bus with the same device being notified more often, also some
controllers may not sense that small variation on RSSI or employ some
filter for duplicated values although HCI inquiry don't seem to
support that.

-- 
Luiz Augusto von Dentz

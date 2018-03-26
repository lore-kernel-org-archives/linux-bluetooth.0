Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180323142714.30687-2-szymon.janc@codecoup.pl>
References: <20180323142714.30687-1-szymon.janc@codecoup.pl> <20180323142714.30687-2-szymon.janc@codecoup.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 26 Mar 2018 12:35:49 +0300
Message-ID: <CABBYNZLTtzKZW_K=49i7Gu-c4ubpb9qneUakWUa3vWC3ykrCkA@mail.gmail.com>
Subject: Re: [PATCH 2/2] device: Fix storing GATT attributes
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Mar 23, 2018 at 4:27 PM, Szymon Janc <szymon.janc@codecoup.pl> wrote:
> This fix two issues:
>  - not storing attributes after pairing if device is using RPA
>  - storing attributes for temporary device if it is using static
>    or public address
> ---
>  src/device.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index f26d6e3d2..102e812e6 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -2333,11 +2333,12 @@ static void device_svc_resolved(struct btd_device *dev, uint8_t browse_type,
>                 dev->pending_paired = false;
>         }
>
> -       if (!dev->temporary)
> +       if (!dev->temporary) {
>                 store_device_info(dev);
>
> -       if (bdaddr_type != BDADDR_BREDR && err == 0)
> -               store_services(dev);
> +               if (bdaddr_type != BDADDR_BREDR && err == 0)
> +                       store_services(dev);
> +       }
>
>         if (req)
>                 browse_request_complete(req, browse_type, bdaddr_type, err);
> @@ -5278,6 +5279,12 @@ void btd_device_set_temporary(struct btd_device *device, bool temporary)
>                 adapter_whitelist_add(device->adapter, device);
>
>         store_device_info(device);
> +
> +       /* attributes were not cached when resolved if device was temporary */

Minor thing, I guess you should use the term stored instead cached as
the attributes are cached in memory just not stored in the storage.

> +       if (device->bdaddr_type != BDADDR_BREDR &&
> +                       device->le_state.svc_resolved &&
> +                       g_slist_length(device->primaries) != 0)
> +               store_services(device);
>  }
>
>  void btd_device_set_trusted(struct btd_device *device, gboolean trusted)
> --
> 2.14.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

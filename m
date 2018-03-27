Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180326141153.16430-1-szymon.janc@codecoup.pl>
References: <20180326141153.16430-1-szymon.janc@codecoup.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 27 Mar 2018 14:08:21 +0300
Message-ID: <CABBYNZ+DUTHnzTQH=5QxDyg3Rz6X1Z-0szOKr-NediKfVKTzXA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] device: Change storage warning to debug messages
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Mar 26, 2018 at 5:11 PM, Szymon Janc <szymon.janc@codecoup.pl> wrote:
> It is normal for device to have private address so there is no reason
> to issue warning message when not storing data for it.
> ---
>  src/device.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 780458fd7..b43e21658 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -480,7 +480,7 @@ static void store_device_info(struct btd_device *device)
>                 return;
>
>         if (device_address_is_private(device)) {
> -               warn("Can't store info for private addressed device %s",
> +               DBG("Can't store info for private addressed device %s",
>                                                                 device->path);
>                 return;
>         }
> @@ -497,7 +497,7 @@ void device_store_cached_name(struct btd_device *dev, const char *name)
>         gsize length = 0;
>
>         if (device_address_is_private(dev)) {
> -               warn("Can't store name for private addressed device %s",
> +               DBG("Can't store name for private addressed device %s",
>                                                                 dev->path);
>                 return;
>         }
> @@ -2012,7 +2012,7 @@ static void store_services(struct btd_device *device)
>         gsize length = 0;
>
>         if (device_address_is_private(device)) {
> -               warn("Can't store services for private addressed device %s",
> +               DBG("Can't store services for private addressed device %s",
>                                                                 device->path);
>                 return;
>         }
> @@ -2200,7 +2200,7 @@ static void store_gatt_db(struct btd_device *device)
>         struct gatt_saver saver;
>
>         if (device_address_is_private(device)) {
> -               warn("Can't store GATT db for private addressed device %s",
> +               DBG("Can't store GATT db for private addressed device %s",
>                                                                 device->path);
>                 return;
>         }
> --
> 2.14.3

Applied, thanks.

-- 
Luiz Augusto von Dentz

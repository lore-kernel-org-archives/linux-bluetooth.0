Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1417437257-13368-1-git-send-email-biman.paul@samsung.com>
References: <1417437257-13368-1-git-send-email-biman.paul@samsung.com>
Date: Mon, 1 Dec 2014 16:58:17 +0200
Message-ID: <CABBYNZLxVcQAMLapsABSbeNDW8J1=x-RE2ttSFXVN0XFJjH7yw@mail.gmail.com>
Subject: Re: [PATCH 1/1] core: Store Device information immediately after
 saving LinkKey information
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Biman Paul <biman.paul@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Dec 1, 2014 at 2:34 PM, Biman Paul <biman.paul@samsung.com> wrote:
> If bluetooth is turned off while pairing is in progress, sometimes
> Linkey information is present but device (Class of Device) information is missing.
>
> This patch stores the device information immediately after Linkkey
> information is saved so that Class of Device information is stored.
> ---
>  src/adapter.c |    2 ++
>  src/device.c  |    2 +-
>  src/device.h  |    1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 3f0ee86..83132c2 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -5989,6 +5989,8 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
>
>                 if (device_is_temporary(device))
>                         btd_device_set_temporary(device, FALSE);
> +
> +               store_device_info(device);
>         }

I guess you can probably store in btd_device_set_temporary, the only
problem is that at this point we don't have any services yet, anyway I
think it is acceptable to store this info in 2 stages first the
pairing details and then the services because they are anyway two
different operations and unpairing the device will cause too much
trouble since the remote might have stored the link-key.

>         bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
> diff --git a/src/device.c b/src/device.c
> index 025743f..fe2fd83 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -402,7 +402,7 @@ static bool device_address_is_private(struct btd_device *dev)
>         }
>  }
>
> -static void store_device_info(struct btd_device *device)
> +void store_device_info(struct btd_device *device)
>  {
>         if (device->temporary || device->store_id > 0)
>                 return;
> diff --git a/src/device.h b/src/device.h
> index 2e0473e..e8cfd8b 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -33,6 +33,7 @@ struct btd_device *device_create_from_storage(struct btd_adapter *adapter,
>  char *btd_device_get_storage_path(struct btd_device *device,
>                                 const char *filename);
>
> +void store_device_info(struct btd_device *device);
>  void btd_device_device_set_name(struct btd_device *device, const char *name);
>  void device_store_cached_name(struct btd_device *dev, const char *name);
>  void device_get_name(struct btd_device *device, char *name, size_t len);
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

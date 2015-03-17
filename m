Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1426583595-28502-1-git-send-email-luiz.dentz@gmail.com>
References: <1426583595-28502-1-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 17 Mar 2015 17:46:59 +0200
Message-ID: <CABBYNZKX4X0r432Q-V1uFYGqZxgOL+Y=nNKi8ReC01O+9K0s_Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] core/device: Fix btd_device_set_temporary
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Mar 17, 2015 at 11:13 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> In case the device is set as not temporary it should trigger
> store_device_info but the function checks if temporary flag is set but
> since currently the code only set the flag after the call nothing really
> happens.
> ---
>  src/device.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 97c0523..6100341 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4474,17 +4474,19 @@ void btd_device_set_temporary(struct btd_device *device, gboolean temporary)
>
>         DBG("temporary %d", temporary);
>
> +       device->temporary = temporary;
> +
>         if (temporary) {
>                 if (device->bredr)
>                         adapter_whitelist_remove(device->adapter, device);
>                 adapter_connect_list_remove(device->adapter, device);
> -       } else {
> -               if (device->bredr)
> -                       adapter_whitelist_add(device->adapter, device);
> -               store_device_info(device);
> +               return;
>         }
>
> -       device->temporary = temporary;
> +       if (device->bredr)
> +               adapter_whitelist_add(device->adapter, device);
> +
> +       store_device_info(device);
>  }
>
>  void btd_device_set_trusted(struct btd_device *device, gboolean trusted)
> --
> 2.1.0

Applied.


-- 
Luiz Augusto von Dentz

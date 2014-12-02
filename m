Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1417500258-20694-1-git-send-email-biman.paul@samsung.com>
References: <1417500258-20694-1-git-send-email-biman.paul@samsung.com>
Date: Tue, 2 Dec 2014 15:54:52 +0200
Message-ID: <CABBYNZLvFy2UGsi_f+y3pVTqtfY+TyWL==og+K5N7a10r3=fZg@mail.gmail.com>
Subject: Re: [PATCHv2] core: Store Device information immediately after saving
 LinkKey information
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Biman Paul <biman.paul@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Dec 2, 2014 at 8:04 AM, Biman Paul <biman.paul@samsung.com> wrote:
> If bluetooth is turned off while pairing is in progress, sometimes
> Linkey information is present but device (Class of Device) information is missing.
>
> This patch stores the device information immediately after Linkkey
> information is saved so that Class of Device information is stored.
> ---
>  src/device.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/src/device.c b/src/device.c
> index 025743f..e9630ed 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4031,6 +4031,7 @@ void btd_device_set_temporary(struct btd_device *device, gboolean temporary)
>         } else {
>                 if (device->bredr)
>                         adapter_whitelist_add(device->adapter, device);
> +               store_device_info(device);
>         }
>
>         device->temporary = temporary;
> --
> 1.7.9.5

Applied after changing the format to 50/72 as described in HACKING
document, please follow that next time.


-- 
Luiz Augusto von Dentz

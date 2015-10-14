Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1444221707-29732-1-git-send-email-luiz.dentz@gmail.com>
References: <1444221707-29732-1-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 14 Oct 2015 11:09:15 +0300
Message-ID: <CABBYNZLwg195_5HvZ+1DYJP4bUz+-oatuf+6usqqp+RF8W5QhA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] deviceinfo: Enable external flag
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Oct 7, 2015 at 3:41 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This enable attributes to be accessed over D-Bus.
> ---
>  profiles/deviceinfo/deviceinfo.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
> index a0e9951..6ee018c 100644
> --- a/profiles/deviceinfo/deviceinfo.c
> +++ b/profiles/deviceinfo/deviceinfo.c
> @@ -191,6 +191,7 @@ static int deviceinfo_driver_probe(struct btd_service *service)
>  static struct btd_profile deviceinfo_profile = {
>         .name           = "deviceinfo",
>         .remote_uuid    = DEVICE_INFORMATION_UUID,
> +       .external       = true,
>         .device_probe   = deviceinfo_driver_probe,
>         .device_remove  = deviceinfo_driver_remove
>  };
> --
> 2.4.3

Applied.


-- 
Luiz Augusto von Dentz

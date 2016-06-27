Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1466682028-10937-1-git-send-email-luiz.dentz@gmail.com>
References: <1466682028-10937-1-git-send-email-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 27 Jun 2016 17:14:20 +0300
Message-ID: <CABBYNZ+ZreMA2SV90u4K2BmAy3phKhVjGQpu1Jyzikm3y3SkCg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core/device: Don't even attempt to load name if
 address is private
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jun 23, 2016 at 2:40 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Device with private address does not have their name stored so it makes
> not sense to attempt to load their names.
> ---
>  src/device.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index 83a794e..5506bc9 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -2655,6 +2655,9 @@ static char *load_cached_name(struct btd_device *device, const char *local,
>         char *str = NULL;
>         int len;
>
> +       if (device_address_is_private(device))
> +               return NULL;
> +
>         snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
>
>         key_file = g_key_file_new();
> --
> 2.5.5

Applied.



-- 
Luiz Augusto von Dentz

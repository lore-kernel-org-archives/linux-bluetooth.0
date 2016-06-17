Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160616132913.13138-2-tobias.svehagen@gmail.com>
References: <20160616132913.13138-1-tobias.svehagen@gmail.com> <20160616132913.13138-2-tobias.svehagen@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 17 Jun 2016 11:45:31 +0300
Message-ID: <CABBYNZJ05RGoEOWhE0ZKDUmn6DbjtNqe3HotR+rY2J=UmaYFVg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] tools/gatt-service: Fix iteration through options
To: Tobias Svehagen <tobias.svehagen@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tobias,

On Thu, Jun 16, 2016 at 4:29 PM, Tobias Svehagen
<tobias.svehagen@gmail.com> wrote:
> Fixes an infinite loop when trying to read a descriptor and the
> ReadValue call has at least one option.
> ---
>  tools/gatt-service.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/gatt-service.c b/tools/gatt-service.c
> index 0c78c4d..1cf8b3c 100644
> --- a/tools/gatt-service.c
> +++ b/tools/gatt-service.c
> @@ -407,6 +407,8 @@ static int parse_options(DBusMessageIter *iter, const char **device)
>                         dbus_message_iter_get_basic(&value, device);
>                         printf("Device: %s\n", *device);
>                 }
> +
> +               dbus_message_iter_next(&dict);
>         }
>
>         return 0;
> --
> 2.8.3

Applied, thanks.

-- 
Luiz Augusto von Dentz

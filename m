Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160616132913.13138-1-tobias.svehagen@gmail.com>
References: <20160616132913.13138-1-tobias.svehagen@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 17 Jun 2016 11:44:54 +0300
Message-ID: <CABBYNZJ6X5u=jL5q=mDj4NKU=rSA1gxXBxJMYPk1xjeKq=y=_Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] src/gatt-client: Fix iteration through options
To: Tobias Svehagen <tobias.svehagen@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tobias,

On Thu, Jun 16, 2016 at 4:29 PM, Tobias Svehagen
<tobias.svehagen@gmail.com> wrote:
> Fix infinite loop when trying to read/write a characteristic or
> a descriptor and the ReadValue/WriteValue call has at least one
> option.
> ---
>  src/gatt-client.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index 0cbacca..6fc0d19 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -401,6 +401,8 @@ static int parse_options(DBusMessageIter *iter, uint16_t *offset)
>                                 return -EINVAL;
>                         dbus_message_iter_get_basic(&value, offset);
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

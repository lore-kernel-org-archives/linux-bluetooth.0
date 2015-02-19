Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1424304754-11874-1-git-send-email-armansito@chromium.org>
References: <1424304754-11874-1-git-send-email-armansito@chromium.org>
Date: Thu, 19 Feb 2015 14:18:30 +0200
Message-ID: <CABBYNZKqWE-Vzpa0ZQvHTi0L0+5yv3e0d9DsrUa10OzC_KgWPg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] shared/gatt-db: Don't fail if realloc returns NULL
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Thu, Feb 19, 2015 at 2:12 AM, Arman Uguray <armansito@chromium.org> wrote:
> gatt_db_attribute_write returns false if realloc returns NULL in the
> case where there is no callback. If the write is performed with a 0
> length value and 0 offset, realloc will return NULL according to its
> specification (as it will practically act as 'free'). This patch fixes
> the code so that this case isn't treated as an error.
> ---
>  src/shared/gatt-db.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 3d2e690..b331f54 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -1464,7 +1464,7 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
>         }
>
>         /* Guard against invalid access if offset equals to value length */
> -       value = offset == attrib->value_len ? NULL : &attrib->value[offset];
> +       value = attrib->value_len - offset ? &attrib->value[offset] : NULL;

Im not following why you are changing read as well here? Btw, all this
does is reverse the check so Im not sure how it would make any
difference.

>
>         func(attrib, 0, value, attrib->value_len - offset, user_data);
>
> @@ -1557,15 +1557,14 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
>                 void *buf;
>
>                 buf = realloc(attrib->value, len + offset);
> -               if (!buf)
> +               if (!buf && len + offset > 0)
>                         return false;

We should not reach realloc in this case, Id say we return if len == 0
since it should really be a nop, for clearing there already exists
gatt_db_attribute_reset and I don't think it worth complicating more
the code bellow.

> -               attrib->value = buf;
> -
>                 /* Init data in the first allocation */
> -               if (!attrib->value_len)
> -                       memset(attrib->value, 0, offset);
> +               if (!attrib->value)
> +                       memset(buf, 0, offset);
>
> +               attrib->value = buf;
>                 attrib->value_len = len + offset;
>         }
>
> --
> 2.2.0.rc0.207.ga3a616c
>



-- 
Luiz Augusto von Dentz

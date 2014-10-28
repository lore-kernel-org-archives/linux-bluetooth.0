Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414513123-5689-7-git-send-email-luiz.dentz@gmail.com>
References: <1414513123-5689-1-git-send-email-luiz.dentz@gmail.com>
	<1414513123-5689-7-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 28 Oct 2014 15:30:18 -0700
Message-ID: <CAHrH25S04qADGehBAbmEWxEqqg0gcKB0k9JJPtDdbsTq=HLx1Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] shared/gatt-db: Add gatt_db_attribute_write
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Oct 28, 2014 at 9:18 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  src/shared/gatt-db.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index b5b6c72..5a912f8 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -900,7 +900,7 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
>                 return true;
>         }
>
> -       /* Check length boundary if value is stored in the db */
> +       /* Check boundary if value is stored in the db */
>         if (offset >= attrib->value_len)
>                 return false;
>
> @@ -916,5 +916,33 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
>                                         gatt_db_attribute_write_t func,
>                                         void *user_data)
>  {
> -       return false;
> +       if (!attrib)
> +               return false;
> +
> +       if (attrib->write_func) {
> +               attrib->write_func(attrib->handle, offset, value, len, opcode,
> +                                               bdaddr, attrib->user_data);
> +               return true;
> +       }
> +
> +       /* For values stored in db allocate on demand */
> +       if (!attrib->value) {
> +               attrib->value = malloc0(len + offset);
> +               if (!attrib->value)
> +                       return false;
> +               attrib->value_len = len + offset;
> +       } else if (offset >= attrib->value_len ||
> +                               len > (unsigned) (attrib->value_len - offset)) {
> +               attrib->value = realloc(attrib->value, len + offset);

I wouldn't immediately modify attrib->value here. Use a temporary, so
that if realloc fails, the write will fail but the attribute value
will remain unmodified.

> +               if (!attrib->value)
> +                       return 0;

return false, to be consistent with the previous block.

> +               attrib->value_len = len + offset;
> +       }
> +
> +       memcpy(&attrib->value[offset], value, len);

I'm still not sure about allowing writes if attrib->write_func is
NULL. My thinking is, if the write_func is not set, then this
attribute is not writable so we always return false. This is
automatically the case for all declaration attributes since they
wouldn't have write permission. All other writes will then always be
delegated to the upper layer. This would keep things a bit simpler I
think, especially since we wouldn't want some accidental usage of
gatt_db_attribute_write on a declaration handle to break the database.

> +
> +       if (func)
> +               func(attrib, 0, user_data);
> +
> +       return true;
>  }
> --
> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
Arman

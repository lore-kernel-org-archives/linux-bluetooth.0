Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414425900-21784-7-git-send-email-luiz.dentz@gmail.com>
References: <1414425900-21784-1-git-send-email-luiz.dentz@gmail.com>
	<1414425900-21784-7-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 27 Oct 2014 11:43:57 -0700
Message-ID: <CAHrH25SZZZ_Kb_cmJPetKpoTsLzBJk5wTLNmu40GUFEQQbx=FA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 7/9] shared/gatt-db: Add gatt_db_attribute_write
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,


>
> ---
>  src/shared/gatt-db.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index acd2e9a..4ff7358 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -906,5 +906,20 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
>                                         gatt_db_attribute_write_t func,
>                                         void *user_data)
>  {
> -       return false;
> +       if (!attrib)
> +               return false;
> +
> +       if (offset > attrib->value_len ||
> +                               len > (unsigned) (attrib->value_len - offset))
> +               return false;

Won't this incorrectly fail if the attribute value has a variable
length? Quoted from Core v4.1 Vol 3 ATT: 3.4.5.1 Write Request: "If
the attribute value has a variable length, then the attribute value
shall be truncated or lengthened to match the length of the Attribute
Value parameter". So we can't really make assumptions on value_len
here.

Also, if the attribute value is being implemented by the higher layer,
then won't the value_len field of the attribute structure be invalid
in general? Unless we always cache the full value in the attribute
structure based on the last time gatt-db invoked the read callback but
then this would still incorrectly fail if we never read the attribute
value beforehand.

I think we can assume that all attributes that are created without a
write callback are not writable. I think we should always delegate
writes to a callback and just return false here if the callback was
never set (this would mean that the attribute is not writable). The
callback can perform the necessary offset and length checks as needed
by the service it's implementing, so we wouldn't end up making any
assumptions there.

> +
> +       if (attrib->write_func) {
> +               attrib->write_func(attrib->handle, offset, value, len, opcode,
> +                                               bdaddr, attrib->user_data);
> +               return true;
> +       }
> +
> +       memcpy(&attrib->value[offset], value, len);
> +
> +       return true;
>  }
> --

Cheers,
Arman

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414158494-12020-1-git-send-email-luiz.dentz@gmail.com>
References: <1414158494-12020-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 24 Oct 2014 09:56:19 -0700
Message-ID: <CAHrH25ScMKevmBxzaOqtg3pvk-tzje5YRF--rEENAXXAPouAqQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/gatt-db: Expose gatt_db_attribute
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Oct 24, 2014 at 6:48 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This is just a draft API to reduce the lookups in gatt_db and make it
> a little bit more convenient for batch operations, so the general idea
> is to be able to get a hold of it via gatt_db_get_attribute but also
> replace the handles in the queues with proper attributes so the server
> code don't have to lookup again when reading/writing, checking
> permissions, or any other operation that can be done directly.
> ---
>  src/shared/gatt-db.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> index 8d18434..ab7469a 100644
> --- a/src/shared/gatt-db.h
> +++ b/src/shared/gatt-db.h
> @@ -96,3 +96,25 @@ bool gatt_db_get_service_uuid(struct gatt_db *db, uint16_t handle,
>
>  bool gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle,
>                                                         uint32_t *permissions);
> +
> +struct gatt_db_attribute;
> +
> +struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *attrib,
> +                                       uint16_t handle, uint16_t offset);
> +

What's the offset parameter here for? Why not just get the attribute by handle?


> +const bt_uuid_t *gatt_db_attribute_get_type(struct gatt_db_attribute *attrib);
> +
> +bool gatt_db_attribute_get_service_uuid(struct gatt_db_attribute *attrib,
> +                                                       bt_uuid_t *uuid);
> +
> +bool gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib,
> +                                                       uint32_t *permissions);
> +
> +bool gatt_db_attribute_read(struct gatt_db_attribute *attrib,
> +                                       uint8_t opcode, bdaddr_t *bdaddr,
> +                                       void *callback, void *user_data);
> +
> +bool gatt_db_attribute_write(struct gatt_db_attribute *attrib,
> +                                       const uint8_t *value, size_t len,
> +                                       uint8_t opcode, bdaddr_t *bdaddr,
> +                                       void *callback, void *user_data);
> --

Are these functions meant to replace the existing gatt_db_read, etc?
We might as well just replace all of those with functions that accept
a struct gatt_db_attribute. So that all functions would be preceded by
a call to gatt_db_get_attribute, followed by one of these functions.
Unless you want to keep the other functions as helpers that accomplish
the same thing.

> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
Arman

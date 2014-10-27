Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414425900-21784-1-git-send-email-luiz.dentz@gmail.com>
References: <1414425900-21784-1-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 27 Oct 2014 11:57:15 -0700
Message-ID: <CAHrH25RzmJBWa2O42jQZTgQbx4Pvzy06rkq+S9Bw=ZrdBWp2Dw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/9] shared/gatt-db: Expose gatt_db_attribute
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Oct 27, 2014 at 9:04 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This is the new API to reduce the lookups in gatt_db and make it
> a little bit more convenient for batch operations, so the general idea
> is to be able to get a hold of it via gatt_db_get_attribute but also
> replace the handles in the queues with proper attributes so the server
> code don't have to lookup again when reading/writing, checking
> permissions, or any other operation that can be done directly.
> ---
>  src/shared/gatt-db.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/gatt-db.h | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 82 insertions(+)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index b3f95d2..75fdff2 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -793,3 +793,52 @@ bool gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle,
>         return true;
>
>  }
> +
> +struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
> +                                                       uint16_t handle)
> +{
> +       return NULL;
> +}
> +
> +uint16_t gatt_db_attribute_get_start_handle(struct gatt_db_attribute *attrib)
> +{
> +       return 0;
> +}
> +
> +uint16_t gatt_db_attribute_get_end_handle(struct gatt_db_attribute *attrib)
> +{
> +       return 0;
> +}
> +
> +const bt_uuid_t *gatt_db_attribute_get_type(struct gatt_db_attribute *attrib)
> +{
> +       return NULL;
> +}
> +
> +bool gatt_db_attribute_get_service_uuid(struct gatt_db_attribute *attrib,
> +                                                       bt_uuid_t *uuid)
> +{
> +       return false;
> +}
> +
> +bool gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib,
> +                                                       uint32_t *permissions)
> +{
> +       return false;
> +}
> +
> +bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
> +                               uint8_t opcode, bdaddr_t *bdaddr,
> +                               gatt_db_attribute_read_t func, void *user_data)
> +{
> +       return false;
> +}
> +
> +bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
> +                                       const uint8_t *value, size_t len,
> +                                       uint8_t opcode, bdaddr_t *bdaddr,
> +                                       gatt_db_attribute_write_t func,
> +                                       void *user_data)
> +{
> +       return false;
> +}
> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> index 8d18434..0c16e88 100644
> --- a/src/shared/gatt-db.h
> +++ b/src/shared/gatt-db.h
> @@ -96,3 +96,36 @@ bool gatt_db_get_service_uuid(struct gatt_db *db, uint16_t handle,
>
>  bool gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle,
>                                                         uint32_t *permissions);
> +
> +struct gatt_db_attribute;
> +
> +struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
> +                                                       uint16_t handle);
> +
> +uint16_t gatt_db_attribute_get_start_handle(struct gatt_db_attribute *attrib);
> +uint16_t gatt_db_attribute_get_end_handle(struct gatt_db_attribute *attrib);
> +
> +const bt_uuid_t *gatt_db_attribute_get_type(struct gatt_db_attribute *attrib);
> +
> +bool gatt_db_attribute_get_service_uuid(struct gatt_db_attribute *attrib,
> +                                                       bt_uuid_t *uuid);
> +
> +bool gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib,
> +                                                       uint32_t *permissions);
> +
> +typedef void (*gatt_db_attribute_read_t) (struct gatt_db_attribute *attrib,
> +                                       int err, uint8_t *value, size_t length,
> +                                       void *user_data);

So we currently have gatt_db_read_t and gatt_db_write_t, which are
stored with the attribute, and gatt_db_attribute_read_t and
gatt_db_attribute_write_t which are used to report the result of a
read or write. I think this is a bit confusing. Should we call these
something like gatt_db_read_complete_t or gatt_db_read_result_func_t
perhaps?

Also, won't we also have to change gatt_db_read_t and gatt_db_write_t
signatures to accept the result functions? If the read/write is being
handled by a callback, then they should report the result back using
the new callbacks. This way the code can be uniform regardless of
whether the result was obtained directly from the database or was
delegated to a callback (or at least this is what I was trying to do
in the patch set I sent out last week).

> +
> +bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
> +                               uint8_t opcode, bdaddr_t *bdaddr,
> +                               gatt_db_attribute_read_t func, void *user_data);
> +
> +typedef void (*gatt_db_attribute_write_t) (struct gatt_db_attribute *attrib,
> +                                               int err, void *user_data);
> +
> +bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
> +                                       const uint8_t *value, size_t len,
> +                                       uint8_t opcode, bdaddr_t *bdaddr,
> +                                       gatt_db_attribute_write_t func,
> +                                       void *user_data);
> --
> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
Arman

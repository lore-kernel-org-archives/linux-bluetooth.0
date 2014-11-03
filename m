Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415030776-5440-1-git-send-email-luiz.dentz@gmail.com>
References: <1415030776-5440-1-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 3 Nov 2014 12:02:12 -0800
Message-ID: <CAHrH25S5q_WKNP1Q4jqUM5CLE6Y4yQ0oxenpwMAxgQh=FLwkBg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/gatt-db: Rework API
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On Mon, Nov 3, 2014 at 8:06 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Send as RFC to collect for feedback regarding API decisions, the
> question is if we shall expose gatt_db_service or let the user access
> it via gatt_db_attrib since it is quite easy to access it internally.
>
> Either way this will end up in heavy changes to android/gatt.c since it
> is very dependent on access by handle.
> ---
>  src/shared/gatt-db.h | 97 ++++++++++++++++++++++++----------------------------
>  1 file changed, 45 insertions(+), 52 deletions(-)
>
> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> index 15be67f..4d9bfc1 100644
> --- a/src/shared/gatt-db.h
> +++ b/src/shared/gatt-db.h
> @@ -22,43 +22,62 @@
>   */
>
>  struct gatt_db;
> +struct gatt_db_service;
> +struct gatt_db_attribute;
>
>  struct gatt_db *gatt_db_new(void);
>  void gatt_db_destroy(struct gatt_db *db);
>
> -uint16_t gatt_db_add_service(struct gatt_db *db, const bt_uuid_t *uuid,
> -                                       bool primary, uint16_t num_handles);
> -bool gatt_db_remove_service(struct gatt_db *db, uint16_t handle);
> +struct gatt_db_service *gatt_db_add_service(struct gatt_db *db,
> +                                               const bt_uuid_t *uuid,
> +                                               bool primary,
> +                                               uint16_t num_handles);
> +bool gatt_db_remove_service(struct gatt_db *db,
> +                                       struct gatt_db_service *service);
>

Hmm, I'm a bit unsure about exposing a gatt_db_service, since I don't
see the gain from it. There is also the whole ownership issue, since
the object the pointer is referencing would be owned by gatt_db but by
returning it from gatt_db_add_service, we're implying that profiles
can hold on to it. So maybe we should return a handle from here and
add a function like gatt_db_get_service(db, handle) to obtain the
service pointer on demand? I still don't see the use though, since
this is pretty much only used with gatt_db_add_characteristic and
gatt_db_add_char_desc.

> -typedef void (*gatt_db_read_t) (uint16_t handle, uint16_t offset,
> -                                       uint8_t att_opcode, bdaddr_t *bdaddr,
> -                                       void *user_data);
> +uint16_t gatt_db_service_get_handle(struct gatt_db_service *service);
>
> -typedef void (*gatt_db_write_t) (uint16_t handle, uint16_t offset,
> -                                       const uint8_t *value, size_t len,
> -                                       uint8_t att_opcode, bdaddr_t *bdaddr,
> +typedef void (*gatt_db_attribute_read_t) (struct gatt_db_attribute *attrib,
> +                                       int err, uint8_t *value, size_t length,
>                                         void *user_data);
>
> -uint16_t gatt_db_add_characteristic(struct gatt_db *db, uint16_t handle,
> -                                               const bt_uuid_t *uuid,
> -                                               uint32_t permissions,
> -                                               uint8_t properties,
> -                                               gatt_db_read_t read_func,
> -                                               gatt_db_write_t write_func,
> -                                               void *user_data);
> +typedef void (*gatt_db_read_t) (struct gatt_db_attribute *attrib,
> +                               uint16_t offset, uint8_t opcode,
> +                               bdaddr_t *bdaddr,
> +                               gatt_db_attribute_read_t func, void *func_data,
> +                               void *user_data);

It's still not obvious by reading the typedefs and argument names that
"func" of type "gatt_db_attribute_read_t" should be used by
gatt_db_read_t to report the result of the read operation. Let's
either change the argument names to "result_func" (or something like
that if you have a better name in mind) or at least put in comments
here that a gatt_db_read_t implementation must invoke "func" to signal
the completion of the read procedure. IMO we should to make this
really obvious so that when a developer wants to implement a plugin,
they don't have to dig through existing profile code to figure this
out. Same thing for the write callbacks.

To that note, we should probably have a well documented example plugin
to replace the outdated once and possibly a gatt client/server guide
somewhere in doc/ eventually.

>
> -uint16_t gatt_db_add_char_descriptor(struct gatt_db *db, uint16_t handle,
> -                                               const bt_uuid_t *uuid,
> -                                               uint32_t permissions,
> -                                               gatt_db_read_t read_func,
> -                                               gatt_db_write_t write_func,
> -                                               void *user_data);
> +typedef void (*gatt_db_attribute_write_t) (struct gatt_db_attribute *attrib,
> +                                               int err, void *user_data);
> +
> +typedef void (*gatt_db_write_t) (struct gatt_db_attribute *attrib,
> +                               uint16_t offset, const uint8_t *value,
> +                               size_t len, uint8_t opcode, bdaddr_t *bdaddr,
> +                               gatt_db_attribute_write_t func, void *func_data,
> +                               void *user_data);
> +
> +struct gatt_db_attribute *
> +gatt_db_service_add_characteristic(struct gatt_db_service *service,
> +                                       const bt_uuid_t *uuid,
> +                                       uint32_t permissions,
> +                                       uint8_t properties,
> +                                       gatt_db_read_t read_func,
> +                                       gatt_db_write_t write_func,
> +                                       void *user_data);
>
> -uint16_t gatt_db_add_included_service(struct gatt_db *db, uint16_t handle,
> -                                               uint16_t included_handle);
> +struct gatt_db_attribute *
> +gatt_db_service_add_descriptor(struct gatt_db_service *service,
> +                                       const bt_uuid_t *uuid,
> +                                       uint32_t permissions,
> +                                       gatt_db_read_t read_func,
> +                                       gatt_db_write_t write_func,
> +                                       void *user_data);
> +
> +struct gatt_db_attribute *
> +gatt_db_service_add_included(struct gatt_db_service *service,
> +                                       struct gatt_db_service *include);
>
> -bool gatt_db_service_set_active(struct gatt_db *db, uint16_t handle,
> -                                                               bool active);
> +bool gatt_db_service_set_active(struct gatt_db_service *service, bool active);
>
>  void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
>                                                         uint16_t end_handle,
> @@ -79,25 +98,6 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
>                                                         uint16_t end_handle,
>                                                         struct queue *queue);
>
> -bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
> -                                       uint8_t att_opcode, bdaddr_t *bdaddr,
> -                                       uint8_t **value, int *length);
> -
> -bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
> -                                       const uint8_t *value, size_t len,
> -                                       uint8_t att_opcode, bdaddr_t *bdaddr);
> -
> -const bt_uuid_t *gatt_db_get_attribute_type(struct gatt_db *db,
> -                                                       uint16_t handle);
> -
> -uint16_t gatt_db_get_end_handle(struct gatt_db *db, uint16_t handle);
> -bool gatt_db_get_service_uuid(struct gatt_db *db, uint16_t handle,
> -                                                       bt_uuid_t *uuid);
> -
> -bool gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle,
> -                                                       uint32_t *permissions);
> -
> -struct gatt_db_attribute;
>
>  struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
>                                                         uint16_t handle);
> @@ -116,17 +116,10 @@ bool gatt_db_attribute_get_service_handles(struct gatt_db_attribute *attrib,
>  bool gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib,
>                                                         uint32_t *permissions);
>
> -typedef void (*gatt_db_attribute_read_t) (struct gatt_db_attribute *attrib,
> -                                       int err, uint8_t *value, size_t length,
> -                                       void *user_data);
> -
>  bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
>                                 uint8_t opcode, bdaddr_t *bdaddr,
>                                 gatt_db_attribute_read_t func, void *user_data);
>
> -typedef void (*gatt_db_attribute_write_t) (struct gatt_db_attribute *attrib,
> -                                               int err, void *user_data);
> -
>  bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
>                                         const uint8_t *value, size_t len,
>                                         uint8_t opcode, bdaddr_t *bdaddr,
> --
> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
Arman

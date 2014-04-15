Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1397027234-12003-7-git-send-email-marcin.kraglak@tieto.com>
References: <1397027234-12003-1-git-send-email-marcin.kraglak@tieto.com>
	<1397027234-12003-7-git-send-email-marcin.kraglak@tieto.com>
Date: Tue, 15 Apr 2014 09:51:34 -0300
Message-ID: <CAKT1EBcWWVVjMOhv7oUZQ24SNkNjy4TJeHD7Q-AP3_E+TEtm5A@mail.gmail.com>
Subject: Re: [RFC 06/16] gatt: Add characteristic descriptor method
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Apr 9, 2014 at 4:07 AM, Marcin Kraglak <marcin.kraglak@tieto.com> wrote:
> It will add characteristic descriptor to service attribute's list.
> ---
>  src/shared/gatt-db.c | 29 +++++++++++++++++++++++++++++
>  src/shared/gatt-db.h |  7 +++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 294179f..26b36d9 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -285,3 +285,32 @@ uint16_t gatt_db_new_characteristic(struct gatt_db *db, uint16_t handle,
>
>         return update_attribute_handle(service, i);
>  }
> +
> +uint16_t gatt_db_new_char_descriptor(struct gatt_db *db, uint16_t handle,
> +                                               const bt_uuid_t *uuid,
> +                                               uint8_t permissions,
> +                                               gatt_db_read_t read_func,
> +                                               gatt_db_write_t write_func,
> +                                               void *user_data)
> +{
> +       struct gatt_db_service *service;
> +       int i;
> +
> +       service = queue_find(db->services, match_service_by_handle,
> +                                                       INT_TO_PTR(handle));
> +       if (!service)
> +               return 0;
> +
> +       i = get_attribute_index(service, 0);
> +       if (!i)
> +               return 0;

Descriptor belongs to characteristics. If service handle is more
suitable for this function, how are you associating characteristic and
descriptors?
Is there any restriction (order) to call this helper function?

> +
> +       service->attributes[i] = new_attribute(uuid, NULL, 0);
> +       if (!service->attributes[i])
> +               return 0;
> +
> +       set_attribute_data(service->attributes[i], read_func, write_func,
> +                                                       permissions, user_data);
> +
> +       return update_attribute_handle(service, i);
> +}
> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> index 8d9107a..1191614 100644
> --- a/src/shared/gatt-db.h
> +++ b/src/shared/gatt-db.h
> @@ -51,3 +51,10 @@ uint16_t gatt_db_new_characteristic(struct gatt_db *db, uint16_t handle,
>                                                 gatt_db_read_t read_func,
>                                                 gatt_db_write_t write_func,
>                                                 void *user_data);
> +
> +uint16_t gatt_db_new_char_descriptor(struct gatt_db *db, uint16_t handle,
> +                                               const bt_uuid_t *uuid,
> +                                               uint8_t permissions,
> +                                               gatt_db_read_t read_func,
> +                                               gatt_db_write_t write_func,
> +                                               void *user_data);
> --


Why permissions is required? My understanding is that in some cases
the upper layer can define extra "requirements".
Maybe it'd better to add "properties" later.

Claudio

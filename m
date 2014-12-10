Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418166520-32993-7-git-send-email-jamuraa@chromium.org>
References: <1418166520-32993-1-git-send-email-jamuraa@chromium.org>
	<1418166520-32993-7-git-send-email-jamuraa@chromium.org>
Date: Wed, 10 Dec 2014 10:03:16 +0200
Message-ID: <CABBYNZ+WrW0Wa5jOhnWAPjL1RdJV4VW4dA9fqzAGpNit2VsxaQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 6/8] shared/gatt-db: Add gatt_db_find_by_type_value
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Wed, Dec 10, 2014 at 1:08 AM, Michael Janssen <jamuraa@chromium.org> wrote:
> Added to support the GATT discovery of services by UUID.
> Currently only works for values which are stored within the attribute
> structure (not callback-based).
> ---
>  src/shared/gatt-db.c | 27 +++++++++++++++++++++++++++
>  src/shared/gatt-db.h |  7 +++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 98fb8a0..b261ca4 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -853,6 +853,8 @@ struct find_by_type_value_data {
>         bt_uuid_t uuid;
>         uint16_t start_handle;
>         uint16_t end_handle;
> +       const void *value;
> +       size_t value_len;
>  };
>
>  static void find_by_type(void *data, void *user_data)
> @@ -878,6 +880,12 @@ static void find_by_type(void *data, void *user_data)
>                 if (bt_uuid_cmp(&search_data->uuid, &attribute->uuid))
>                         continue;
>
> +               /* TODO: fix for read-callback based attributes */
> +               if (search_data->value && memcmp(attribute->value,
> +                                                       search_data->value,
> +                                                       search_data->value_len))
> +                       continue;
> +
>                 queue_push_tail(search_data->queue, attribute);
>         }
>  }
> @@ -897,6 +905,25 @@ void gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
>         queue_foreach(db->services, find_by_type, &data);
>  }
>
> +void gatt_db_find_by_type_value(struct gatt_db *db, uint16_t start_handle,
> +                                                       uint16_t end_handle,
> +                                                       const bt_uuid_t *type,
> +                                                       const void *value,
> +                                                       size_t value_len,
> +                                                       struct queue *queue)
> +{
> +       struct find_by_type_value_data data;
> +
> +       data.uuid = *type;
> +       data.start_handle = start_handle;
> +       data.end_handle = end_handle;
> +       data.queue = queue;
> +       data.value = value;
> +       data.value_len = value_len;
> +
> +       queue_foreach(db->services, find_by_type, &data);
> +}
> +
>  struct read_by_type_data {
>         struct queue *queue;
>         bt_uuid_t uuid;
> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> index e5fe6bb..22e60d5 100644
> --- a/src/shared/gatt-db.h
> +++ b/src/shared/gatt-db.h
> @@ -92,6 +92,13 @@ void gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
>                                                         const bt_uuid_t *type,
>                                                         struct queue *queue);
>
> +void gatt_db_find_by_type_value(struct gatt_db *db, uint16_t start_handle,
> +                                                       uint16_t end_handle,
> +                                                       const bt_uuid_t *type,
> +                                                       const void *value,
> +                                                       size_t value_len,
> +                                                       struct queue *queue);
> +

We actually have plans to replace this API that expose queues with
callback based thus avoid having to iterate twice.

>  void gatt_db_read_by_type(struct gatt_db *db, uint16_t start_handle,
>                                                         uint16_t end_handle,
>                                                         const bt_uuid_t type,
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

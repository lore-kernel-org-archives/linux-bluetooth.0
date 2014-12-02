Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1417478382-37027-1-git-send-email-jamuraa@chromium.org>
References: <1417478382-37027-1-git-send-email-jamuraa@chromium.org>
Date: Tue, 2 Dec 2014 15:56:49 +0200
Message-ID: <CABBYNZLxCheZsTXZ3GR5KSpdO3eLxjNzsftuOSXb6zjDUXtxow@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] shared/gatt-db: Use insert_service for add_service
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Tue, Dec 2, 2014 at 1:59 AM, Michael Janssen <jamuraa@chromium.org> wrote:
> gatt_db_add_service is the same as gatt_db_insert_service with little
> change except not specifying the handle.  Reuse the code.
> ---
>  src/shared/gatt-db.c | 38 +++++++++-----------------------------
>  1 file changed, 9 insertions(+), 29 deletions(-)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index b210376..2a35bae 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -258,35 +258,6 @@ static struct gatt_db_service *gatt_db_service_create(const bt_uuid_t *uuid,
>         return service;
>  }
>
> -struct gatt_db_attribute *gatt_db_add_service(struct gatt_db *db,
> -                                               const bt_uuid_t *uuid,
> -                                               bool primary,
> -                                               uint16_t num_handles)
> -{
> -       struct gatt_db_service *service;
> -
> -       if (!db || (num_handles + db->next_handle - 1) > UINT16_MAX)
> -               return NULL;
> -
> -       service = gatt_db_service_create(uuid, primary, num_handles);
> -       if (!service)
> -               return NULL;
> -
> -       if (!queue_push_tail(db->services, service)) {
> -               gatt_db_service_destroy(service);
> -               return NULL;
> -       }
> -
> -       /* TODO now we get next handle from database. We should first look
> -        * for 'holes' between existing services first, and assign next_handle
> -        * only if enough space was not found.
> -        */
> -       service->attributes[0]->handle = db->next_handle;
> -       db->next_handle += num_handles;
> -       service->num_handles = num_handles;
> -
> -       return service->attributes[0];
> -}
>
>  bool gatt_db_remove_service(struct gatt_db *db,
>                                         struct gatt_db_attribute *attrib)
> @@ -442,6 +413,15 @@ fail:
>         return NULL;
>  }
>
> +struct gatt_db_attribute *gatt_db_add_service(struct gatt_db *db,
> +                                               const bt_uuid_t *uuid,
> +                                               bool primary,
> +                                               uint16_t num_handles)
> +{
> +       return gatt_db_insert_service(db, db->next_handle, uuid, primary
> +                                                               num_handles);

This one did not compile initially since there is a missing ','
between primary and num_handles, I fixed that and applied both.


-- 
Luiz Augusto von Dentz

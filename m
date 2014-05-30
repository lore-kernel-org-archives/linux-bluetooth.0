Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1401429074-31535-2-git-send-email-marcin.kraglak@tieto.com>
References: <1401429074-31535-1-git-send-email-marcin.kraglak@tieto.com>
	<1401429074-31535-2-git-send-email-marcin.kraglak@tieto.com>
Date: Fri, 30 May 2014 11:32:34 +0300
Message-ID: <CABBYNZLhNAAP8+9Ngw_njve6WsV01yn+S=_yctobacW6ajsayg@mail.gmail.com>
Subject: Re: [PATCH 2/4] shared/gatt: Add function to check if handle was
 found in database
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Fri, May 30, 2014 at 8:51 AM, Marcin Kraglak
<marcin.kraglak@tieto.com> wrote:
> It will return true if attribute with given handle exists in db, otherwise
> false.
> ---
>  src/shared/gatt-db.c | 18 ++++++++++++++++++
>  src/shared/gatt-db.h |  1 +
>  2 files changed, 19 insertions(+)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 998e93e..de1de57 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -758,3 +758,21 @@ uint32_t gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle)
>
>         return attribute->permissions;
>  }
> +
> +bool gatt_db_has_attribute(struct gatt_db *db, uint16_t handle)
> +{
> +       struct gatt_db_attribute *attribute;
> +       struct gatt_db_service *service;
> +       uint16_t service_handle;
> +
> +       service = queue_find(db->services, find_service_for_handle,
> +                                                       INT_TO_PTR(handle));
> +       if (!service)
> +               return false;
> +
> +       service_handle = service->attributes[0]->handle;
> +
> +       attribute = service->attributes[handle - service_handle];
> +
> +       return attribute ? true : false;
> +}
> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> index f2f2f4d..ca36d32 100644
> --- a/src/shared/gatt-db.h
> +++ b/src/shared/gatt-db.h
> @@ -93,3 +93,4 @@ const bt_uuid_t *gatt_db_get_attribute_type(struct gatt_db *db,
>  uint16_t gatt_db_get_end_handle(struct gatt_db *db, uint16_t handle);
>
>  uint32_t gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle);
> +bool gatt_db_has_attribute(struct gatt_db *db, uint16_t handle);
> --
> 1.9.0

This kind of API design is inefficient since it normally gonna cause
double lookup and in any case gatt_db_get_attribute_permissions needs
a fix since right now it cannot really tell if an error happen.
Perhaps we could change the return to int and have another parameter
to hold the permissions value or we can create an API for attribute
themselves e.g. gatt_db_get_attribute + gatt_attribute_get_permission.


-- 
Luiz Augusto von Dentz

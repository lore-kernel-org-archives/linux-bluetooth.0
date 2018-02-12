Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180212104030.10653-1-zhukov@mercurydevelopment.com>
References: <20180212104030.10653-1-zhukov@mercurydevelopment.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 12 Feb 2018 09:47:33 -0200
Message-ID: <CABBYNZJsCg_c9zdKc_MG9Caf=r7rVz39pfv=hmkO1E96z_8JBA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/gatt-db: Fix declaration attributes permission
To: Konstantin Zhukov <zhukov@mercurydevelopment.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Konstantin,

On Mon, Feb 12, 2018 at 8:40 AM, Konstantin Zhukov
<zhukov@mercurydevelopment.com> wrote:
> According to Bluetooth Core specification v4.2 (Vol. 3, part G,
> section 3.1), service declararion attributes should have only READ
> permission. The same obligation has charateristic declaration and
> include service declaration attributes.
>
> Without this permission connected clients could corrupt GATT database
> by writing to declaration attributes. After thatm service discovery
> fails in other clients.
> ---
>  src/shared/gatt-db.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 2487584f3..814e79bed 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -115,6 +115,12 @@ struct gatt_db_service {
>         struct gatt_db_attribute **attributes;
>  };
>
> +static void set_attribute_data(struct gatt_db_attribute *attribute,
> +                                               gatt_db_read_t read_func,
> +                                               gatt_db_write_t write_func,
> +                                               uint32_t permissions,
> +                                               void *user_data);
> +
>  static void pending_read_result(struct pending_read *p, int err,
>                                         const uint8_t *data, size_t length)
>  {
> @@ -387,6 +393,8 @@ static struct gatt_db_service *gatt_db_service_create(const bt_uuid_t *uuid,
>                 return NULL;
>         }
>
> +       set_attribute_data(service->attributes[0], NULL, NULL, BT_ATT_PERM_READ, NULL);
> +
>         return service;
>  }
>
> @@ -718,6 +726,8 @@ service_insert_characteristic(struct gatt_db_service *service,
>         if (!service->attributes[i])
>                 return NULL;
>
> +       set_attribute_data(service->attributes[i], NULL, NULL, BT_ATT_PERM_READ, NULL);
> +
>         i++;
>
>         service->attributes[i] = new_attribute(service, handle, uuid, NULL, 0);
> @@ -929,7 +939,7 @@ service_insert_included(struct gatt_db_service *service, uint16_t handle,
>          *
>          * TODO handle permissions
>          */
> -       set_attribute_data(service->attributes[index], NULL, NULL, 0, NULL);
> +       set_attribute_data(service->attributes[index], NULL, NULL, BT_ATT_PERM_READ, NULL);
>
>         return attribute_update(service, index);
>  }
> --
> 2.14.1

Applied after changing it to not use a forward declaration, thanks.

-- 
Luiz Augusto von Dentz

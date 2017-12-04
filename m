Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171204121054.29186-1-luiz.dentz@gmail.com>
References: <20171204121054.29186-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 4 Dec 2017 19:48:14 +0200
Message-ID: <CABBYNZJUZvumCS2kvJ7SEVaFpCcnvT6OQRG0jQDq3ifGo1kyJg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] gatt: Make database_add_record detect the UUID
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Dec 4, 2017 at 2:10 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> gatt_db_attribute does carry the UUID so this make database_add_record
> add it directly instead of taking as parameter.
> ---
>  src/gatt-database.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 3e10c901c..fa94a83f8 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -707,15 +707,30 @@ static sdp_record_t *record_new(uuid_t *uuid, uint16_t start, uint16_t end)
>  }
>
>  static uint32_t database_add_record(struct btd_gatt_database *database,
> -                                       uint16_t uuid,
>                                         struct gatt_db_attribute *attr,
>                                         const char *name)
>  {
>         sdp_record_t *record;
>         uint16_t start, end;
>         uuid_t svc, gap_uuid;
> +       bt_uuid_t uuid;
> +
> +       gatt_db_attribute_get_service_uuid(attr, &uuid);
> +
> +       switch (uuid.type) {
> +       case BT_UUID16:
> +               sdp_uuid16_create(&svc, uuid.value.u16);
> +               break;
> +       case BT_UUID32:
> +               sdp_uuid32_create(&svc, uuid.value.u32);
> +               break;
> +       case BT_UUID128:
> +               sdp_uuid128_create(&svc, (void *) &uuid.value.u128);
> +               break;
> +       case BT_UUID_UNSPEC:
> +               return 0;
> +       }
>
> -       sdp_uuid16_create(&svc, uuid);
>         gatt_db_attribute_get_service_handles(attr, &start, &end);
>
>         record = record_new(&svc, start, end);
> @@ -747,7 +762,7 @@ static void populate_gap_service(struct btd_gatt_database *database)
>         /* Add the GAP service */
>         bt_uuid16_create(&uuid, UUID_GAP);
>         service = gatt_db_add_service(database->db, &uuid, true, 5);
> -       database->gap_handle = database_add_record(database, UUID_GAP, service,
> +       database->gap_handle = database_add_record(database, service,
>                                                 "Generic Access Profile");
>
>         /*
> @@ -902,8 +917,7 @@ static void populate_gatt_service(struct btd_gatt_database *database)
>         /* Add the GATT service */
>         bt_uuid16_create(&uuid, UUID_GATT);
>         service = gatt_db_add_service(database->db, &uuid, true, 4);
> -       database->gatt_handle = database_add_record(database, UUID_GATT,
> -                                               service,
> +       database->gatt_handle = database_add_record(database, service,
>                                                 "Generic Attribute Profile");
>
>         bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
> --
> 2.13.6

Applied.


-- 
Luiz Augusto von Dentz

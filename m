Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1445538593-5217-1-git-send-email-jpawlowski@google.com>
References: <1445538593-5217-1-git-send-email-jpawlowski@google.com>
Date: Fri, 23 Oct 2015 12:10:50 +0300
Message-ID: <CABBYNZL27qkS7z0LaUdXKcUdHh-Bk+YzxKjp+Eec6SXK2mkxTA@mail.gmail.com>
Subject: Re: [PATCH] profiles/gap: remove unnecessary code
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thu, Oct 22, 2015 at 9:29 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> There is no need to register for service_added and service_removed.
> device_remove will be always called before service_removed, so this
> code is not needed.
> ---
>  profiles/gap/gas.c | 42 ------------------------------------------
>  1 file changed, 42 deletions(-)
>
> diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
> index 819a967..877c4fd 100644
> --- a/profiles/gap/gas.c
> +++ b/profiles/gap/gas.c
> @@ -53,7 +53,6 @@
>  struct gas {
>         struct btd_device *device;
>         struct gatt_db *db;
> -       unsigned int db_id;
>         struct bt_gatt_client *client;
>         struct gatt_db_attribute *attr;
>  };
> @@ -62,7 +61,6 @@ static GSList *devices;
>
>  static void gas_free(struct gas *gas)
>  {
> -       gatt_db_unregister(gas->db, gas->db_id);
>         gatt_db_unref(gas->db);
>         bt_gatt_client_unref(gas->client);
>         btd_device_unref(gas->device);
> @@ -269,43 +267,6 @@ static void foreach_gap_service(struct gatt_db_attribute *attr, void *user_data)
>         handle_gap_service(gas);
>  }
>
> -static void service_added(struct gatt_db_attribute *attr, void *user_data)
> -{
> -       struct gas *gas = user_data;
> -       bt_uuid_t uuid, gap_uuid;
> -
> -       if (!bt_gatt_client_is_ready(gas->client))
> -               return;
> -
> -       gatt_db_attribute_get_service_uuid(attr, &uuid);
> -       bt_uuid16_create(&gap_uuid, GAP_UUID16);
> -
> -       if (bt_uuid_cmp(&uuid, &gap_uuid))
> -               return;
> -
> -       if (gas->attr) {
> -               error("More than one GAP service added to device");
> -               return;
> -       }
> -
> -       DBG("GAP service added");
> -
> -       gas->attr = attr;
> -       handle_gap_service(gas);
> -}
> -
> -static void service_removed(struct gatt_db_attribute *attr, void *user_data)
> -{
> -       struct gas *gas = user_data;
> -
> -       if (gas->attr != attr)
> -               return;
> -
> -       DBG("GAP service removed");
> -
> -       gas->attr = NULL;
> -}
> -
>  static int gap_driver_accept(struct btd_service *service)
>  {
>         struct btd_device *device = btd_service_get_device(service);
> @@ -329,14 +290,11 @@ static int gap_driver_accept(struct btd_service *service)
>
>         /* Clean-up any old client/db and acquire the new ones */
>         gas->attr = NULL;
> -       gatt_db_unregister(gas->db, gas->db_id);
>         gatt_db_unref(gas->db);
>         bt_gatt_client_unref(gas->client);
>
>         gas->db = gatt_db_ref(db);
>         gas->client = bt_gatt_client_ref(client);
> -       gas->db_id = gatt_db_register(db, service_added, service_removed, gas,
> -                                                                       NULL);
>
>         /* Handle the GAP services */
>         bt_uuid16_create(&gap_uuid, GAP_UUID16);
> --
> 2.5.0

Ive done this already, perhaps you forgot to pull?


-- 
Luiz Augusto von Dentz

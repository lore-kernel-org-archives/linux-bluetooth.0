Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1441715022-20327-2-git-send-email-luiz.dentz@gmail.com>
References: <1441715022-20327-1-git-send-email-luiz.dentz@gmail.com>
	<1441715022-20327-2-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 8 Sep 2015 10:40:19 -0700
Message-ID: <CAD0=r8yuseCAN7RvtRwUA4eaA3eKhNaOq+8NofV8M+Herbt-vw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/3] core/gatt: Fix not able to read/write on reconnections
From: Jakub Pawlowski <jpawlowski@google.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

This patch fixes all my issues with writing just after connecting.
Thanks alot!

On Tue, Sep 8, 2015 at 5:23 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Upon reconnecting the attributes may already be available from cache
> which mean the client would be able to issue commands while discovery
> is not complete thus btd_gatt_client_ready was not called yet.
>
> To fix now btd_gatt_client_ready is split into btd_gatt_client_connected
> which is called whenever connected leaving btd_gatt_client_ready to only
> deal with exporting services found during the discovery.
> ---
>  src/device.c      |  2 ++
>  src/gatt-client.c | 24 +++++++++++++++++-------
>  src/gatt-client.h |  1 +
>  3 files changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index dc362d9..2102f23 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4602,6 +4602,8 @@ static void gatt_client_init(struct btd_device *device)
>         }
>
>         device->gatt_cache_used = !gatt_db_isempty(device->db);
> +
> +       btd_gatt_client_connected(device->client_dbus);
>  }
>
>  static void gatt_server_init(struct btd_device *device, struct gatt_db *db)
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index d8a3429..225aa42 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -1825,20 +1825,14 @@ fail:
>
>  void btd_gatt_client_ready(struct btd_gatt_client *client)
>  {
> -       struct bt_gatt_client *gatt;
> -
>         if (!client)
>                 return;
>
> -       gatt = btd_device_get_gatt_client(client->device);
> -       if (!gatt) {
> +       if (!client->gatt) {
>                 error("GATT client not initialized");
>                 return;
>         }
>
> -       bt_gatt_client_unref(client->gatt);
> -       client->gatt = bt_gatt_client_ref(gatt);
> -
>         client->ready = true;
>
>         DBG("GATT client ready");
> @@ -1852,6 +1846,22 @@ void btd_gatt_client_ready(struct btd_gatt_client *client)
>         queue_foreach(client->all_notify_clients, register_notify, client);
>  }
>
> +void btd_gatt_client_connected(struct btd_gatt_client *client)
> +{
> +       struct bt_gatt_client *gatt;
> +
> +       gatt = btd_device_get_gatt_client(client->device);
> +       if (!gatt) {
> +               error("GATT client not initialized");
> +               return;
> +       }
> +
> +       DBG("Device connected.");
> +
> +       bt_gatt_client_unref(client->gatt);
> +       client->gatt = bt_gatt_client_ref(gatt);
> +}
> +
>  void btd_gatt_client_service_added(struct btd_gatt_client *client,
>                                         struct gatt_db_attribute *attrib)
>  {
> diff --git a/src/gatt-client.h b/src/gatt-client.h
> index a18db17..92a9255 100644
> --- a/src/gatt-client.h
> +++ b/src/gatt-client.h
> @@ -23,6 +23,7 @@ struct btd_gatt_client *btd_gatt_client_new(struct btd_device *device);
>  void btd_gatt_client_destroy(struct btd_gatt_client *client);
>
>  void btd_gatt_client_ready(struct btd_gatt_client *client);
> +void btd_gatt_client_connected(struct btd_gatt_client *client);
>  void btd_gatt_client_service_added(struct btd_gatt_client *client,
>                                         struct gatt_db_attribute *attrib);
>  void btd_gatt_client_service_removed(struct btd_gatt_client *client,
> --
> 2.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

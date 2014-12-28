Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1419024965-10375-18-git-send-email-armansito@chromium.org>
References: <1419024965-10375-1-git-send-email-armansito@chromium.org>
	<1419024965-10375-18-git-send-email-armansito@chromium.org>
Date: Sun, 28 Dec 2014 21:39:09 -0200
Message-ID: <CABBYNZ+=N6EQc1tBe39BLmPf_Vwd6eup+iy85-x5UpvsEX63bA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 17/17] core: gatt: Don't export claimed services
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Fri, Dec 19, 2014 at 7:36 PM, Arman Uguray <armansito@chromium.org> wrote:
> GattService1 objects for services which are claimed by an internal
> profile are no longer exported. This is to prevent conflicts that
> may arise between internal plugins and external applications that
> wish to access the same GATT service.
>
> This is at least until there is a better system for managing external
> claims on GATT services and all remote profiles have been switched to
> shared/gatt, which prevents some of the conflicts that may arise from
> writes to CCC descriptors.

I was thinking that we could use gatt_db_service_set_active if it
succeed on probing but for that to work we might have to add
gatt_db_service_get_active or make gatt_db_foreach_service ignore
services not active.

> ---
>  src/gatt-client.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index 16a3b3b..4f44516 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -1772,11 +1772,36 @@ static gboolean set_chrcs_ready(gpointer user_data)
>         return FALSE;
>  }
>
> +static bool is_service_claimed(struct btd_device *dev,
> +                                               struct gatt_db_attribute *attr)
> +{
> +       uint16_t start, end;
> +       bt_uuid_t uuid;
> +       char uuid_str[MAX_LEN_UUID_STR];
> +
> +       if (!gatt_db_attribute_get_service_data(attr, &start, &end, NULL,
> +                                                                       &uuid))
> +               return false;
> +
> +       bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
> +
> +       return !!btd_device_get_gatt_service(dev, uuid_str, start, end);
> +}
> +
>  static void export_service(struct gatt_db_attribute *attr, void *user_data)
>  {
>         struct btd_gatt_client *client = user_data;
>         struct service *service;
>
> +       /*
> +        * Check if a profile claimed this service and don't export it
> +        * otherwise.
> +        */
> +       if (is_service_claimed(client->device, attr)) {
> +               DBG("GATT service already claimed by an internal profile");
> +               return;
> +       }
> +
>         service = service_create(attr, client);
>         if (!service)
>                 return;
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

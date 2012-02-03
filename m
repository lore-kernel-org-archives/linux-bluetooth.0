Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328284418-4989-1-git-send-email-arik@wizery.com>
References: <1328284418-4989-1-git-send-email-arik@wizery.com>
Date: Fri, 3 Feb 2012 21:10:50 +0100
Message-ID: <CACLukzK=0he14fvLUoLLDfvOShGNRDhyEsWYywBHbRcBSaK5Jw@mail.gmail.com>
Subject: Re: [PATCH v2] proximity: make reporter work per-adapter
From: Santiago Carot <sancane@gmail.com>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org,
	anderson.lizardo@openbossa.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik, Anderson

2012/2/3 Arik Nemtsov <arik@wizery.com>:
> Register an adapter driver for reporter and add the adapter argument in
> appropriate places.
>
> Signed-off-by: Arik Nemtsov <arik@wizery.com>
> ---
> v1->2: minor rename of reporter driver, squashed a bug where
> the D-Bus connection was referenced only after the monitor driver
> was registered (Thanks Anderson)
>
>  proximity/manager.c  |   28 +++++++++++++++++++-----
>  proximity/reporter.c |   57 +++++++++++++++++++------------------------------
>  proximity/reporter.h |    4 +-
>  3 files changed, 46 insertions(+), 43 deletions(-)
>
> diff --git a/proximity/manager.c b/proximity/manager.c
> index a767554..336d8f7 100644
> --- a/proximity/manager.c
> +++ b/proximity/manager.c
> @@ -84,12 +84,18 @@ static void attio_device_remove(struct btd_device *device)
>  }
>
>  static struct btd_device_driver monitor_driver = {
> -       .name = "Proximity GATT Driver",
> +       .name = "Proximity GATT Monitor Driver",
>        .uuids = BTD_UUIDS(IMMEDIATE_ALERT_UUID, LINK_LOSS_UUID, TX_POWER_UUID),
>        .probe = attio_device_probe,
>        .remove = attio_device_remove,
>  };
>
> +static struct btd_adapter_driver reporter_server_driver = {
> +       .name = "Proximity GATT Reporter Driver",
> +       .probe = reporter_init,
> +       .remove = reporter_exit,
> +};
> +
>  static void load_config_file(GKeyFile *config)
>  {
>        char **list;
> @@ -118,19 +124,29 @@ int proximity_manager_init(DBusConnection *conn, GKeyFile *config)
>
>        load_config_file(config);
>
> -       /* TODO: Register Proximity Monitor/Reporter drivers */
> +       connection = dbus_connection_ref(conn);
> +
>        ret = btd_register_device_driver(&monitor_driver);
>        if (ret < 0)
> -               return ret;
> +               goto fail_monitor;
>
> -       connection = dbus_connection_ref(conn);
> +       ret = btd_register_adapter_driver(&reporter_server_driver);
> +       if (ret < 0)
> +               goto fail_reporter;
> +
> +       return 0;
>
> -       return reporter_init();
> +fail_reporter:
> +       btd_unregister_device_driver(&monitor_driver);
> +
> +fail_monitor:
> +       dbus_connection_unref(connection);
> +       return ret;
>  }
>
>  void proximity_manager_exit(void)
>  {
> -       reporter_exit();
>        btd_unregister_device_driver(&monitor_driver);
> +       btd_unregister_adapter_driver(&reporter_server_driver);
>        dbus_connection_unref(connection);
>  }
> diff --git a/proximity/reporter.c b/proximity/reporter.c
> index a139c7c..5107fd8 100644
> --- a/proximity/reporter.c
> +++ b/proximity/reporter.c
> @@ -52,15 +52,14 @@ enum {
>
>  static uint16_t tx_power_handle;
>
> -static void register_link_loss(void)
> +static void register_link_loss(struct btd_adapter *adapter)
>  {
>        uint16_t start_handle, h;
>        const int svc_size = 3;
>        uint8_t atval[256];
>        bt_uuid_t uuid;
>
> -       /* FIXME: Provide the adapter in next function */
> -       start_handle = attrib_db_find_avail(NULL, svc_size);
> +       start_handle = attrib_db_find_avail(adapter, svc_size);
>        if (start_handle == 0) {
>                error("Not enough free handles to register service");
>                return;
> @@ -73,35 +72,31 @@ static void register_link_loss(void)
>        /* Primary service definition */
>        bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
>        att_put_u16(LINK_LOSS_SVC_UUID, &atval[0]);
> -       /* FIXME: Provide the adapter in next function */
> -       attrib_db_add(NULL, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
> +       attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
>
>        /* Alert level characteristic */
>        bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
>        atval[0] = ATT_CHAR_PROPER_READ | ATT_CHAR_PROPER_WRITE;
>        att_put_u16(h + 1, &atval[1]);
>        att_put_u16(ALERT_LEVEL_CHR_UUID, &atval[3]);
> -       /* FIXME: Provide the adapter in next function */
> -       attrib_db_add(NULL, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
> +       attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
>
>        /* Alert level value */
>        bt_uuid16_create(&uuid, ALERT_LEVEL_CHR_UUID);
>        att_put_u8(NO_ALERT, &atval[0]);
> -       /* FIXME: Provide the adapter in next function */
> -       attrib_db_add(NULL, h++, &uuid, ATT_NONE, ATT_NONE, atval, 1);
> +       attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NONE, atval, 1);
>

Why don't you use the gatt-service API here?. I think it would be
better a patch in this way than this one.

Regards.

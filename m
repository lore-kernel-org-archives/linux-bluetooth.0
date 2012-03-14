Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331215032-27695-9-git-send-email-arik@wizery.com>
References: <1331215032-27695-1-git-send-email-arik@wizery.com>
	<1331215032-27695-9-git-send-email-arik@wizery.com>
Date: Wed, 14 Mar 2012 09:19:34 -0400
Message-ID: <CAJdJm_PKA2eCSHDin6WLj4xTCONuURYfMkyBAeu=T1Sd74vBwQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] proximity: reporter: implement D-Bus API
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Thu, Mar 8, 2012 at 9:57 AM, Arik Nemtsov <arik@wizery.com> wrote:
>  int reporter_init(struct btd_adapter *adapter)
>  {
> +       struct reporter_adapter *radapter;
> +       DBusConnection *conn;
> +
>        if (!main_opts.attrib_server) {
>                DBG("Attribute server is disabled");
>                return -1;
>        }
>
> -       connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
> -       if (connection == NULL)
> -               return -EIO;
> -       DBG("Proximity Reporter for adapter %p", adapter);
> +       conn = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
> +       if (!conn)
> +               return -1;
>
> -       register_link_loss(adapter, connection);
> +       radapter = g_new0(struct reporter_adapter, 1);
> +       radapter->adapter = adapter;
> +       radapter->conn = conn;
> +
> +       register_link_loss(adapter, radapter->conn);
>        register_tx_power(adapter);
> -       register_imm_alert(adapter, connection);
> +       register_imm_alert(adapter, radapter->conn);
> +
> +       /*
> +        * Register watches for getting device change events. We watch
> +        * for existing, new and removed devices.
> +        */
> +       radapter->watch_added = g_dbus_add_signal_watch(radapter->conn,
> +                                       BLUEZ_SERVICE, NULL, ADAPTER_INTERFACE,
> +                                       "DeviceAdded", handle_device_change,
> +                                       radapter, NULL);
> +
> +       radapter->watch_created = g_dbus_add_signal_watch(radapter->conn,
> +                                       BLUEZ_SERVICE, NULL, ADAPTER_INTERFACE,
> +                                       "DeviceCreated", handle_device_change,
> +                                       radapter, NULL);
> +
> +       radapter->watch_removed = g_dbus_add_signal_watch(radapter->conn,
> +                                       BLUEZ_SERVICE, NULL, ADAPTER_INTERFACE,
> +                                       "DeviceRemoved", handle_device_change,
> +                                       radapter, NULL);

Again, setting a watcher for BlueZ own signals is strange. Why can't
you use a device driver like other plugins?

> +
> +       reporter_adapters = g_slist_prepend(reporter_adapters, radapter);
> +       DBG("Proximity Reporter for adapter %p", adapter);
>
>        return 0;
>  }

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

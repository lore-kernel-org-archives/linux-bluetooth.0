Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1354020685-17028-1-git-send-email-luiz.dentz@gmail.com>
References: <1354020685-17028-1-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 29 Nov 2012 10:52:28 +0200
Message-ID: <CABBYNZL0pBd9FCVr1M3A1iEVde8QrW=hxLNCrOSYyTYEZgVGjw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/6] gdbus: Add g_dbus_add_properties_watch function
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas, Marcel,

On Tue, Nov 27, 2012 at 2:51 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Convenient function to create watches for D-Bus properties.
> ---
>  gdbus/gdbus.h |  5 +++++
>  gdbus/watch.c | 28 ++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
> index ba49621..8b6dfe5 100644
> --- a/gdbus/gdbus.h
> +++ b/gdbus/gdbus.h
> @@ -243,6 +243,11 @@ guint g_dbus_add_signal_watch(DBusConnection *connection,
>                                 const char *interface, const char *member,
>                                 GDBusSignalFunction function, void *user_data,
>                                 GDBusDestroyFunction destroy);
> +guint g_dbus_add_properties_watch(DBusConnection *connection,
> +                               const char *sender, const char *path,
> +                               const char *interface,
> +                               GDBusSignalFunction function, void *user_data,
> +                               GDBusDestroyFunction destroy);
>  gboolean g_dbus_remove_watch(DBusConnection *connection, guint tag);
>  void g_dbus_remove_all_watches(DBusConnection *connection);
>
> diff --git a/gdbus/watch.c b/gdbus/watch.c
> index 1cd1211..9e4f994 100644
> --- a/gdbus/watch.c
> +++ b/gdbus/watch.c
> @@ -752,6 +752,34 @@ guint g_dbus_add_signal_watch(DBusConnection *connection,
>         return cb->id;
>  }
>
> +guint g_dbus_add_properties_watch(DBusConnection *connection,
> +                               const char *sender, const char *path,
> +                               const char *interface,
> +                               GDBusSignalFunction function, void *user_data,
> +                               GDBusDestroyFunction destroy)
> +{
> +       struct filter_data *data;
> +       struct filter_callback *cb;
> +
> +       data = filter_data_get(connection, signal_filter, sender, path,
> +                               DBUS_INTERFACE_PROPERTIES, "PropertiesChanged",
> +                               interface);
> +       if (data == NULL)
> +               return 0;
> +
> +       cb = filter_data_add_callback(data, NULL, NULL, function, destroy,
> +                                       user_data);
> +       if (cb == NULL)
> +               return 0;
> +
> +       if (data->name != NULL && data->name_watch == 0)
> +               data->name_watch = g_dbus_add_service_watch(connection,
> +                                                       data->name, NULL,
> +                                                       NULL, NULL, NULL);
> +
> +       return cb->id;
> +}
> +
>  gboolean g_dbus_remove_watch(DBusConnection *connection, guint id)
>  {
>         struct filter_data *data;
> --
> 1.7.11.7

Anything regarding this function? The point here is to be able to
listen to properties specific to one interface which is not possible
with g_dbus_add_signal_watch.


--
Luiz Augusto von Dentz

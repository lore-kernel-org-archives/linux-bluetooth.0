Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAAbnaHZwB4uSujXOWLnXnK+imioZVB4-yxOMCXcMkcyM0hdyNQ@mail.gmail.com>
References: <CAAbnaHZwB4uSujXOWLnXnK+imioZVB4-yxOMCXcMkcyM0hdyNQ@mail.gmail.com>
Date: Fri, 20 Jul 2012 22:33:40 +0200
Message-ID: <CANq1E4QX5VBkUGz7J-UGZHG7OT3bkVzwa-qUnB1bgZ6rAi_fWg@mail.gmail.com>
Subject: Re: [RFC generichid 5/5]
From: David Herrmann <dh.herrmann@googlemail.com>
To: Nathaniel Haggard <natester@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On Fri, Jul 20, 2012 at 6:30 PM, Nathaniel Haggard <natester@gmail.com> wrote:
> Clean up newlines and adds the reconnect and disconnect device functions.

Please do not mix whitespace cleanups and code-changes. If you need
the cleanup, then do it as a separate patch. And then do only
cleanups. Anyway, why did you introduce these empty lines in the
previous patches?

>  input/generichid.c |   92 +++++++++++++++++++++++++++++++++++++++++-----------
>  1 files changed, 73 insertions(+), 19 deletions(-)
>
> diff --git a/input/generichid.c b/input/generichid.c
> index 42d6a29..7957774 100644
> --- a/input/generichid.c
> +++ b/input/generichid.c
> @@ -130,7 +130,6 @@ struct user_data {
>         func_ptr func;
>  };
>
> -
>  static void add_lang_attr(sdp_record_t *r)
>  {
>         sdp_lang_attr_t base_lang;
> @@ -145,7 +144,6 @@ static void add_lang_attr(sdp_record_t *r)
>         sdp_list_free(langs, 0);
>  }
>
> -
>  static int sdp_keyboard_service(struct adapter_data *adapt)
>  {
>         bdaddr_t src;
> @@ -347,7 +345,6 @@ static int sdp_keyboard_service(struct adapter_data *adapt)
>         return 0;
>  }
>
> -
>  static void initiate_keyboard(struct keyboard_state *keyboard)
>  {
>         keyboard->value[0] = 0xa1;
> @@ -459,8 +456,6 @@ static DBusMessage *send_report(GIOChannel *chan,
>         return NULL;
>  }
>
> -
> -
>  static DBusMessage *keyboard_event(GIOChannel *chan, DBusMessage *msg,
>                                         struct keyboard_state *keyboard,
>                                         unsigned char code,
> @@ -502,8 +497,6 @@ static DBusMessage *keyboard_event(GIOChannel
> *chan, DBusMessage *msg,
>         return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
>  }
>
> -
> -
>  static DBusMessage *send_event(DBusConnection *conn,
>                 DBusMessage *msg, void *data)
>  {
> @@ -573,7 +566,6 @@ static gboolean set_protocol_listener(GIOChannel
> *chan, GIOCondition condition,
>         return TRUE;
>  }
>
> -
>  static gboolean channel_listener(GIOChannel *chan, GIOCondition condition,
>                                         gpointer data)
>  {
> @@ -596,7 +588,6 @@ static gboolean channel_listener(GIOChannel *chan,
> GIOCondition condition,
>         return FALSE;
>  }
>
> -
>  static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
>                                         void *data)
>  {
> @@ -648,8 +639,6 @@ failed:
>         }
>  }
>
> -
> -
>  static void control_connect_cb(GIOChannel *chan, GError *conn_err,
>                                         void *data)
>  {
> @@ -691,16 +680,88 @@ failed:
>         dev->ctrl = NULL;
>  }
>
> -
>  static DBusMessage *reconnect_device(DBusConnection *conn, DBusMessage *msg,
>                                         gpointer data)
>  {
> +       GError *err = NULL;
> +       GIOChannel *io;
> +       bdaddr_t src;
> +       struct adapter_data *adapt = data;
> +       struct device_data *dev = adapt->dev;
> +       struct user_data *info;
> +
> +       if (adapt->pending)
> +               return btd_error_in_progress(msg);
> +
> +       if (dev->intr != NULL)
> +               return btd_error_already_connected(msg);
> +
> +       info = g_try_new(struct user_data, 1);
> +       if (info == NULL)
> +               return btd_error_failed(msg, strerror(-ENOMEM));
> +
> +       info->adapt = adapt;
> +       info->func = NULL;
> +
> +       adapter_get_address(adapt->adapter, &src);
> +
> +       io = bt_io_connect(BT_IO_L2CAP, control_connect_cb, info,
> +                               NULL, &err,
> +                               BT_IO_OPT_SOURCE_BDADDR, &src,
> +                               BT_IO_OPT_DEST_BDADDR, &(dev->dst),
> +                               BT_IO_OPT_PSM, L2CAP_PSM_HIDP_CTRL,
> +                               BT_IO_OPT_INVALID);
> +
> +       /* TODO: treat plug failed even with errors from cb */
> +       if (err != NULL)
> +               error("%s", err->message);
> +
> +       if (io == NULL) {
> +               if (info != NULL)
> +                       g_free(info);
> +
> +               return btd_error_failed(msg, "Failed to plug the device");
> +       }
> +
> +       dev->ctrl = io;
> +       return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
>  }
>
>
>  static DBusMessage *disconnect_device(DBusConnection *conn, DBusMessage *msg,
>                                         gpointer data)
>  {
> +       struct adapter_data *adapt = data;
> +       struct device_data *dev = adapt->dev;
> +
> +       if (dev->intr != NULL) {
> +               g_io_channel_shutdown(dev->intr, TRUE, NULL);
> +               g_io_channel_unref(dev->intr);
> +               dev->intr = NULL;
> +
> +               g_source_remove(dev->intr_watch);
> +       }
> +
> +       if (dev->ctrl != NULL) {
> +               g_io_channel_shutdown(dev->ctrl, TRUE, NULL);
> +               g_io_channel_unref(dev->ctrl);
> +               dev->ctrl = NULL;
> +       }
> +
> +       g_dbus_unregister_interface(conn, dev->input_path,
> +                                       GENERIC_INPUT_DEVICE);
> +
> +       if (dev->input_path != NULL) {
> +               g_free(dev->input_path);
> +               dev->input_path = NULL;
> +       }
> +
> +       g_dbus_emit_signal(connection, adapter_get_path(adapt->adapter),
> +                               GENERIC_HID_INTERFACE, "DeviceReleased",
> +                               DBUS_TYPE_INVALID);
> +
> +       return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
> +
>  }
>
>  static const GDBusSignalTable ghid_input_device_signals[] = {
> @@ -716,7 +777,6 @@ static const GDBusMethodTable
> ghid_input_device_methods[] = {
>         {}
>  };
>
> -
>  static void generic_input_device_path(char *path, struct btd_adapter *adapter)
>  {
>         char *adapt;
> @@ -826,20 +886,17 @@ static DBusMessage
> *connect_device(DBusConnection *conn, DBusMessage *msg,
>
>  }
>
> -
>  static const GDBusSignalTable ghid_adapter_signals[] = {
>         { GDBUS_SIGNAL("IncomingConnection", NULL) },
>         { GDBUS_SIGNAL("DeviceReleased", NULL) },
>         { }
>  };
>
> -
>  static const GDBusMethodTable ghid_adapter_methods[] = {
>         { GDBUS_METHOD("Connect", GDBUS_ARGS({"path", "s"}), NULL, connect_device) },
>         { }
>  };
>
> -
>  static void register_interface(const char *path, struct adapter_data *adapt)
>  {
>         if (g_dbus_register_interface(connection, path, GENERIC_HID_INTERFACE,
> @@ -854,7 +911,6 @@ static void register_interface(const char *path,
> struct adapter_data *adapt)
>
>  }
>
> -
>  static void unregister_interface(const char *path)
>  {
>         btd_debug("path %s", path);
> @@ -862,7 +918,6 @@ static void unregister_interface(const char *path)
>         g_dbus_unregister_interface(connection, path, GENERIC_HID_INTERFACE);
>  }
>
> -
>  static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
>  {
>         uint16_t psm;
> @@ -935,7 +990,6 @@ failed:
>         }
>  }
>
> -
>  static void confirm_event_cb(GIOChannel *chan, GError *err, gpointer data)
>  {
>         uint16_t psm;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

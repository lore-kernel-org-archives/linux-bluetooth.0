Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1419024965-10375-8-git-send-email-armansito@chromium.org>
References: <1419024965-10375-1-git-send-email-armansito@chromium.org>
	<1419024965-10375-8-git-send-email-armansito@chromium.org>
Date: Mon, 22 Dec 2014 10:26:27 -0800
Message-ID: <CAJLTA8jC0EyF0XmLsKXjG1XBt9QgDeoTuOwvPCf65nvU2CyGmg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 07/17] core: gatt: Implement GattCharacteristic1.StartNotify
From: Michael Janssen <jamuraa@google.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Fri, Dec 19, 2014 at 1:35 PM, Arman Uguray <armansito@chromium.org> wrote:
> This patch implements the StartNotify method of
> org.bluez.GattCharacteristic1. Each call to StartNotify assigns a
> session to the D-Bus sender which internally registers a unique
> notify handler with the bt_gatt_client. Each received notification
> or indication causes a PropertiesChanged signal to be emitted for the
> "Value" property.
>
> The notify handler gets automatically unregistered when sender
> disconnects from D-Bus.
> ---
>  src/gatt-client.c | 272 +++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 259 insertions(+), 13 deletions(-)
>
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index 9cbe32d..a29eea9 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -80,6 +80,9 @@ struct characteristic {
>         size_t value_len;
>
>         struct queue *descs;
> +
> +       bool notifying;
> +       struct queue *notify_clients;
>  };
>
>  struct descriptor {
> @@ -236,15 +239,20 @@ static bool resize_value_buffer(size_t new_len, uint8_t **value, size_t *len)
>  static void update_value_property(const uint8_t *value, size_t len,
>                                         uint8_t **cur_value, size_t *cur_len,
>                                         bool *value_known,
> -                                       const char *path, const char *iface)
> +                                       const char *path, const char *iface,
> +                                       bool notify_if_same)
>  {
>         /*
>          * If the value is the same, then only updated it if wasn't previously
>          * known.
>          */
>         if (*value_known && *cur_len == len &&
> -                       !memcmp(*cur_value, value, sizeof(uint8_t) * len))
> +                       !memcmp(*cur_value, value, sizeof(uint8_t) * len)) {
> +               if (notify_if_same)
> +                       goto notify;
> +
>                 return;
> +       }
>
>         if (resize_value_buffer(len, cur_value, cur_len)) {
>                 *value_known = true;
> @@ -261,6 +269,7 @@ static void update_value_property(const uint8_t *value, size_t len,
>                 *value_known = false;
>         }
>
> +notify:
>         g_dbus_emit_property_changed(btd_get_dbus_connection(), path, iface,
>                                                                 "Value");
>  }
> @@ -274,7 +283,9 @@ static void async_dbus_op_free(void *data)
>  {
>         struct async_dbus_op *op = data;
>
> -       dbus_message_unref(op->msg);
> +       if (op->msg)
> +               dbus_message_unref(op->msg);
> +
>         free(op);
>  }
>
> @@ -311,7 +322,7 @@ static void desc_read_long_cb(bool success, uint8_t att_ecode,
>
>         update_value_property(value, length, &desc->value, &desc->value_len,
>                                                 &desc->value_known, desc->path,
> -                                               GATT_DESCRIPTOR_IFACE);
> +                                               GATT_DESCRIPTOR_IFACE, false);
>
>         reply = g_dbus_create_reply(op->msg, DBUS_TYPE_INVALID);
>         if (!reply) {
> @@ -489,12 +500,8 @@ static gboolean characteristic_property_get_notifying(
>                                         const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data)
>  {
> -       dbus_bool_t notifying = FALSE;
> -
> -       /*
> -        * TODO: Return the correct value here once StartNotify and StopNotify
> -        * methods are implemented.
> -        */
> +       struct characteristic *chrc = data;
> +       dbus_bool_t notifying = chrc->notifying ? TRUE : FALSE;
>
>         dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &notifying);
>
> @@ -564,7 +571,8 @@ static void chrc_read_long_cb(bool success, uint8_t att_ecode,
>
>         update_value_property(value, length, &chrc->value, &chrc->value_len,
>                                                 &chrc->value_known, chrc->path,
> -                                               GATT_CHARACTERISTIC_IFACE);
> +                                               GATT_CHARACTERISTIC_IFACE,
> +                                               false);
>
>         reply = g_dbus_create_reply(op->msg, DBUS_TYPE_INVALID);
>         if (!reply) {
> @@ -614,11 +622,241 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
>         return btd_error_failed(msg, "Not implemented");
>  }
>
> +struct notify_client {
> +       struct characteristic *chrc;
> +       int ref_count;
> +       char *owner;
> +       guint watch;
> +       unsigned int notify_id;
> +};
> +
> +static void notify_client_free(struct notify_client *client)
> +{
> +       DBG("owner %s", client->owner);
> +
> +       g_dbus_remove_watch(btd_get_dbus_connection(), client->watch);
> +       free(client->owner);
> +       free(client);
> +}
> +
> +static void notify_client_unref(void *data)
> +{
> +       struct notify_client *client = data;
> +
> +       DBG("owner %s", client->owner);
> +
> +       if (__sync_sub_and_fetch(&client->ref_count, 1))
> +               return;
> +
> +       notify_client_free(client);
> +}

notify_client_free and notify_client_unref are both used in different
situations here.  It seems cleaner to do all management through
reference counting and you can inline notify_client_free into
notify_client_unref.

> +
> +static struct notify_client *notify_client_ref(struct notify_client *client)
> +{
> +       DBG("owner %s", client->owner);
> +
> +       __sync_fetch_and_add(&client->ref_count, 1);
> +
> +       return client;
> +}
> +
> +static bool match_notifying(const void *a, const void *b)
> +{
> +       const struct notify_client *client = a;
> +
> +       return !!client->notify_id;
> +}
> +
> +static void update_notifying(struct characteristic *chrc)
> +{
> +       if (!chrc->notifying)
> +               return;
> +
> +       if (queue_find(chrc->notify_clients, match_notifying, NULL))
> +               return;
> +
> +       chrc->notifying = false;
> +
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(), chrc->path,
> +                                               GATT_CHARACTERISTIC_IFACE,
> +                                               "Notifying");
> +}
> +
> +static void notify_client_disconnect(DBusConnection *conn, void *user_data)
> +{
> +       struct notify_client *client = user_data;
> +       struct characteristic *chrc = client->chrc;
> +       struct bt_gatt_client *gatt = chrc->service->client->gatt;
> +
> +       DBG("owner %s", client->owner);
> +
> +       queue_remove(chrc->notify_clients, client);
> +       bt_gatt_client_unregister_notify(gatt, client->notify_id);
> +
> +       update_notifying(chrc);
> +
> +       notify_client_unref(client);
> +}
> +
> +static struct notify_client *notify_client_create(struct characteristic *chrc,
> +                                                       const char *owner)
> +{
> +       struct notify_client *client;
> +
> +       client = new0(struct notify_client, 1);
> +       if (!client)
> +               return NULL;
> +
> +       client->chrc = chrc;
> +       client->owner = strdup(owner);
> +       if (!client->owner) {
> +               free(client);
> +               return NULL;
> +       }
> +
> +       client->watch = g_dbus_add_disconnect_watch(btd_get_dbus_connection(),
> +                                               owner, notify_client_disconnect,
> +                                               client, NULL);
> +       if (!client->watch) {
> +               free(client->owner);
> +               free(client);
> +               return NULL;
> +       }
> +
> +       return notify_client_ref(client);
> +}
> +
> +static bool match_notify_sender(const void *a, const void *b)
> +{
> +       const struct notify_client *client = a;
> +       const char *sender = b;
> +
> +       return strcmp(client->owner, sender) == 0;
> +}
> +
> +static void notify_cb(uint16_t value_handle, const uint8_t *value,
> +                                       uint16_t length, void *user_data)
> +{
> +       struct async_dbus_op *op = user_data;
> +       struct notify_client *client = op->data;
> +       struct characteristic *chrc = client->chrc;
> +
> +       /*
> +        * Even if the value didn't change, we want to send a PropertiesChanged
> +        * signal so that we propagate the notification/indication to
> +        * applications.
> +        */
> +       update_value_property(value, length, &chrc->value, &chrc->value_len,
> +                                               &chrc->value_known, chrc->path,
> +                                               GATT_CHARACTERISTIC_IFACE,
> +                                               true);
> +}
> +
> +static void register_notify_cb(unsigned int id, uint16_t att_ecode,
> +                                                               void *user_data)
> +{
> +       struct async_dbus_op *op = user_data;
> +       struct notify_client *client = op->data;
> +       struct characteristic *chrc = client->chrc;
> +       DBusMessage *reply;
> +
> +       /* Make sure that an interim disconnect did not remove the client */
> +       if (!queue_find(chrc->notify_clients, NULL, client)) {
> +               bt_gatt_client_unregister_notify(chrc->service->client->gatt,
> +                                                                       id);
> +               notify_client_unref(client);
> +
> +               reply = btd_error_failed(op->msg,
> +                                               "Characteristic not available");
> +               goto done;
> +       }
> +
> +       /*
> +        * Drop the reference count that we added when registering the callback.
> +        */
> +       notify_client_unref(client);
> +
> +       if (!id) {
> +               queue_remove(chrc->notify_clients, client);
> +               notify_client_free(client);
> +
> +               reply = create_gatt_dbus_error(op->msg, att_ecode);
> +
> +               goto done;
> +       }
> +
> +       client->notify_id = id;
> +
> +       if (!chrc->notifying) {
> +               chrc->notifying = true;
> +               g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                                       chrc->path, GATT_CHARACTERISTIC_IFACE,
> +                                       "Notifying");
> +       }
> +
> +       reply = g_dbus_create_reply(op->msg, DBUS_TYPE_INVALID);
> +
> +done:
> +       if (reply)
> +               g_dbus_send_message(btd_get_dbus_connection(), reply);
> +       else
> +               error("Failed to construct D-Bus message reply");
> +
> +       dbus_message_unref(op->msg);
> +       op->msg = NULL;
> +}
> +
>  static DBusMessage *characteristic_start_notify(DBusConnection *conn,
>                                         DBusMessage *msg, void *user_data)
>  {
> -       /* TODO: Implement */
> -       return btd_error_failed(msg, "Not implemented");
> +       struct characteristic *chrc = user_data;
> +       struct bt_gatt_client *gatt = chrc->service->client->gatt;
> +       const char *sender = dbus_message_get_sender(msg);
> +       struct async_dbus_op *op;
> +       struct notify_client *client;
> +
> +       if (!(chrc->props & BT_GATT_CHRC_PROP_NOTIFY ||
> +                               chrc->props & BT_GATT_CHRC_PROP_INDICATE))
> +               return btd_error_not_supported(msg);
> +
> +       /* Each client can only have one active notify session. */
> +       client = queue_find(chrc->notify_clients, match_notify_sender, sender);
> +       if (client)
> +               return client->notify_id ?
> +                               btd_error_failed(msg, "Already notifying") :
> +                               btd_error_in_progress(msg);
> +
> +       client = notify_client_create(chrc, sender);
> +       if (!client)
> +               return btd_error_failed(msg, "Failed allocate notify session");
> +
> +       op = new0(struct async_dbus_op, 1);
> +       if (!op) {
> +               notify_client_unref(client);
> +               return btd_error_failed(msg, "Failed to initialize request");
> +       }
> +
> +       /*
> +        * Add to the ref count so that a disconnect during register won't free
> +        * the client instance.
> +        */
> +       op->data = notify_client_ref(client);
> +       op->msg = dbus_message_ref(msg);
> +
> +       queue_push_tail(chrc->notify_clients, client);
> +
> +       if (bt_gatt_client_register_notify(gatt, chrc->value_handle,
> +                                               register_notify_cb, notify_cb,
> +                                               op, async_dbus_op_free))
> +               return NULL;
> +
> +       queue_remove(chrc->notify_clients, client);
> +       async_dbus_op_free(op);
> +
> +       /* Directly free the client */
> +       notify_client_free(client);
> +
> +       return btd_error_failed(msg, "Failed to register notify session");
>  }
>
>  static DBusMessage *characteristic_stop_notify(DBusConnection *conn,
> @@ -702,6 +940,13 @@ static struct characteristic *characteristic_create(
>                 return NULL;
>         }
>
> +       chrc->notify_clients = queue_new();
> +       if (!chrc->notify_clients) {
> +               queue_destroy(chrc->descs, NULL);
> +               free(chrc);
> +               return NULL;
> +       }
> +
>         chrc->service = service;
>
>         gatt_db_attribute_get_char_data(attr, &chrc->handle,
> @@ -735,6 +980,7 @@ static void unregister_characteristic(void *data)
>
>         DBG("Removing GATT characteristic: %s", chrc->path);
>
> +       queue_remove_all(chrc->notify_clients, NULL, NULL, notify_client_unref);
>         queue_remove_all(chrc->descs, NULL, NULL, unregister_descriptor);
>
>         g_dbus_unregister_interface(btd_get_dbus_connection(), chrc->path,
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Michael Janssen

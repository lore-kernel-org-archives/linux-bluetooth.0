Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1466679741-17053-1-git-send-email-luiz.dentz@gmail.com>
References: <1466679741-17053-1-git-send-email-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 27 Jun 2016 17:14:41 +0300
Message-ID: <CABBYNZJahNzdTzgGP4TmeoYWhTPD3EHMPoJRdpfiZASys0AvSg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] core/gatt-client: Allow clients to call
 ReadValue in parallel
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jun 23, 2016 at 2:02 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This queues ReadValue messages if the offset is the same so all the
> client interested in reading the attribute value are replied when the
> operation is completed.
> ---
>  src/gatt-client.c | 318 ++++++++++++++++++++++++++++--------------------------
>  1 file changed, 163 insertions(+), 155 deletions(-)
>
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index 6fc0d19..c2a888f 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -74,6 +74,17 @@ struct service {
>         struct queue *chrcs;
>  };
>
> +typedef bool (*async_dbus_op_complete_t)(void *data);
> +
> +struct async_dbus_op {
> +       int ref_count;
> +       unsigned int id;
> +       struct queue *msgs;
> +       void *data;
> +       uint16_t offset;
> +       async_dbus_op_complete_t complete;
> +};
> +
>  struct characteristic {
>         struct service *service;
>         struct gatt_db_attribute *attr;
> @@ -85,8 +96,8 @@ struct characteristic {
>         bt_uuid_t uuid;
>         char *path;
>
> -       unsigned int read_id;
> -       unsigned int write_id;
> +       struct async_dbus_op *read_op;
> +       struct async_dbus_op *write_op;
>
>         struct queue *descs;
>
> @@ -101,8 +112,8 @@ struct descriptor {
>         bt_uuid_t uuid;
>         char *path;
>
> -       unsigned int read_id;
> -       unsigned int write_id;
> +       struct async_dbus_op *read_op;
> +       struct async_dbus_op *write_op;
>  };
>
>  static bool uuid_cmp(const bt_uuid_t *uuid, uint16_t u16)
> @@ -205,22 +216,11 @@ static int parse_value_arg(DBusMessageIter *iter, uint8_t **value, int *len)
>         return 0;
>  }
>
> -typedef bool (*async_dbus_op_complete_t)(void *data);
> -
> -struct async_dbus_op {
> -       int ref_count;
> -       DBusMessage *msg;
> -       void *data;
> -       uint16_t offset;
> -       async_dbus_op_complete_t complete;
> -};
> -
>  static void async_dbus_op_free(void *data)
>  {
>         struct async_dbus_op *op = data;
>
> -       if (op->msg)
> -               dbus_message_unref(op->msg);
> +       queue_destroy(op->msgs, (void *)dbus_message_unref);
>
>         free(op);
>  }
> @@ -296,27 +296,44 @@ static void write_descriptor_cb(struct gatt_db_attribute *attr, int err,
>                                         GATT_DESCRIPTOR_IFACE, "Value");
>  }
>
> -static void read_op_cb(struct gatt_db_attribute *attrib, int err,
> -                               const uint8_t *value, size_t length,
> -                               void *user_data)
> +static void async_dbus_op_reply(struct async_dbus_op *op, int err,
> +                               const uint8_t *value, size_t length)
>  {
> -       struct async_dbus_op *op = user_data;
> +       const struct queue_entry *entry;
>         DBusMessage *reply;
>
> -       if (err) {
> -               error("Failed to read attribute");
> -               return;
> -       }
> +       op->id = 0;
>
> -       reply = g_dbus_create_reply(op->msg, DBUS_TYPE_INVALID);
> -       if (!reply) {
> -               error("Failed to allocate D-Bus message reply");
> -               return;
> +       for (entry = queue_get_entries(op->msgs); entry; entry = entry->next) {
> +               DBusMessage *msg = entry->data;
> +
> +               if (err) {
> +                       reply = err > 0 ? create_gatt_dbus_error(msg, err) :
> +                               btd_error_failed(msg, strerror(err));
> +                       goto send_reply;
> +               }
> +
> +               reply = g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
> +               if (!reply) {
> +                       error("Failed to allocate D-Bus message reply");
> +                       return;
> +               }
> +
> +               if (value)
> +                       message_append_byte_array(reply, value, length);
> +
> +send_reply:
> +               g_dbus_send_message(btd_get_dbus_connection(), reply);
>         }
> +}
>
> -       message_append_byte_array(reply, value, length);
> +static void read_op_cb(struct gatt_db_attribute *attrib, int err,
> +                               const uint8_t *value, size_t length,
> +                               void *user_data)
> +{
> +       struct async_dbus_op *op = user_data;
>
> -       g_dbus_send_message(btd_get_dbus_connection(), reply);
> +       async_dbus_op_reply(op, err, value, length);
>  }
>
>  static void desc_read_cb(bool success, uint8_t att_ecode,
> @@ -326,7 +343,6 @@ static void desc_read_cb(bool success, uint8_t att_ecode,
>         struct async_dbus_op *op = user_data;
>         struct descriptor *desc = op->data;
>         struct service *service = desc->chrc->service;
> -       DBusMessage *reply;
>
>         if (!success)
>                 goto fail;
> @@ -337,6 +353,7 @@ static void desc_read_cb(bool success, uint8_t att_ecode,
>         if (!gatt_db_attribute_write(desc->attr, op->offset, value, length, 0,
>                                         NULL, write_descriptor_cb, desc)) {
>                 error("Failed to store attribute");
> +               att_ecode = BT_ATT_ERROR_UNLIKELY;
>                 goto fail;
>         }
>
> @@ -347,32 +364,30 @@ static void desc_read_cb(bool success, uint8_t att_ecode,
>          */
>         if (length == bt_gatt_client_get_mtu(service->client->gatt) - 1) {
>                 op->offset += length;
> -               desc->read_id = bt_gatt_client_read_long_value(
> -                                                       service->client->gatt,
> +               op->id = bt_gatt_client_read_long_value(service->client->gatt,
>                                                         desc->handle,
>                                                         op->offset,
>                                                         desc_read_cb,
>                                                         async_dbus_op_ref(op),
>                                                         async_dbus_op_unref);
> -               if (desc->read_id)
> +               if (op->id)
>                         return;
>         }
>
>         /* Read the stored data from db */
>         if (!gatt_db_attribute_read(desc->attr, 0, 0, NULL, read_op_cb, op)) {
>                 error("Failed to read database");
> +               att_ecode = BT_ATT_ERROR_UNLIKELY;
>                 goto fail;
>         }
>
> -       desc->read_id = 0;
> +       desc->read_op = NULL;
>
>         return;
>
>  fail:
> -       reply = create_gatt_dbus_error(op->msg, att_ecode);
> -       desc->read_id = 0;
> -       g_dbus_send_message(btd_get_dbus_connection(), reply);
> -       return;
> +       async_dbus_op_reply(op, att_ecode, NULL, 0);
> +       desc->read_op = NULL;
>  }
>
>  static int parse_options(DBusMessageIter *iter, uint16_t *offset)
> @@ -408,19 +423,45 @@ static int parse_options(DBusMessageIter *iter, uint16_t *offset)
>         return 0;
>  }
>
> -static unsigned int read_value(struct bt_gatt_client *gatt, uint16_t handle,
> -                               bt_gatt_client_read_callback_t callback,
> -                               struct async_dbus_op *op)
> +static struct async_dbus_op *async_dbus_op_new(DBusMessage *msg, void *data)
> +{
> +       struct async_dbus_op *op;
> +
> +       op = new0(struct async_dbus_op, 1);
> +       op->msgs = queue_new();
> +       queue_push_tail(op->msgs, dbus_message_ref(msg));
> +       op->data = data;
> +
> +       return op;
> +}
> +
> +static struct async_dbus_op *read_value(struct bt_gatt_client *gatt,
> +                                       DBusMessage *msg, uint16_t handle,
> +                                       uint16_t offset,
> +                                       bt_gatt_client_read_callback_t callback,
> +                                       void *data)
>  {
> +       struct async_dbus_op *op;
> +
> +       op = async_dbus_op_new(msg, data);
> +       op->offset = offset;
> +
>         if (op->offset)
> -               return bt_gatt_client_read_long_value(gatt, handle, op->offset,
> +               op->id = bt_gatt_client_read_long_value(gatt, handle, offset,
>                                                         callback,
>                                                         async_dbus_op_ref(op),
>                                                         async_dbus_op_unref);
>         else
> -               return bt_gatt_client_read_value(gatt, handle, callback,
> +               op->id = bt_gatt_client_read_value(gatt, handle, callback,
>                                                         async_dbus_op_ref(op),
>                                                         async_dbus_op_unref);
> +
> +       if (op->id)
> +               return op;
> +
> +       async_dbus_op_free(op);
> +
> +       return NULL;
>  }
>
>  static DBusMessage *descriptor_read_value(DBusConnection *conn,
> @@ -429,63 +470,51 @@ static DBusMessage *descriptor_read_value(DBusConnection *conn,
>         struct descriptor *desc = user_data;
>         struct bt_gatt_client *gatt = desc->chrc->service->client->gatt;
>         DBusMessageIter iter;
> -       struct async_dbus_op *op;
>         uint16_t offset = 0;
>
>         if (!gatt)
>                 return btd_error_failed(msg, "Not connected");
>
> -       if (desc->read_id)
> -               return btd_error_in_progress(msg);
> -
>         dbus_message_iter_init(msg, &iter);
>
>         if (parse_options(&iter, &offset))
>                 return btd_error_invalid_args(msg);
>
> -       op = new0(struct async_dbus_op, 1);
> -       op->msg = dbus_message_ref(msg);
> -       op->data = desc;
> -       op->offset = offset;
> -
> -       desc->read_id = read_value(gatt, desc->handle, desc_read_cb, op);
> -       if (desc->read_id)
> +       if (desc->read_op) {
> +               if (desc->read_op->offset != offset)
> +                       return btd_error_in_progress(msg);
> +               queue_push_tail(desc->read_op->msgs, dbus_message_ref(msg));
>                 return NULL;
> +       }
>
> -       async_dbus_op_free(op);
> +       desc->read_op = read_value(gatt, msg, desc->handle, offset,
> +                                                       desc_read_cb, desc);
> +       if (!desc->read_op)
> +               return btd_error_failed(msg, "Failed to send read request");
>
> -       return btd_error_failed(msg, "Failed to send read request");
> +       return NULL;
>  }
>
>  static void write_result_cb(bool success, bool reliable_error,
>                                         uint8_t att_ecode, void *user_data)
>  {
>         struct async_dbus_op *op = user_data;
> -       DBusMessage *reply;
> +       int err = 0;
>
>         if (op->complete && !op->complete(op->data)) {
> -               reply = btd_error_failed(op->msg, "Operation failed");
> +               err = -EFAULT;
>                 goto done;
>         }
>
>         if (!success) {
>                 if (reliable_error)
> -                       reply = btd_error_failed(op->msg,
> -                                               "Reliable write failed");
> +                       err = -EFAULT;
>                 else
> -                       reply = create_gatt_dbus_error(op->msg, att_ecode);
> -
> -               goto done;
> -       }
> -
> -       reply = g_dbus_create_reply(op->msg, DBUS_TYPE_INVALID);
> -       if (!reply) {
> -               error("Failed to allocate D-Bus message reply");
> -               return;
> +                       err = att_ecode;
>         }
>
>  done:
> -       g_dbus_send_message(btd_get_dbus_connection(), reply);
> +       async_dbus_op_reply(op, err, NULL, 0);
>  }
>
>  static void write_cb(bool success, uint8_t att_ecode, void *user_data)
> @@ -493,7 +522,7 @@ static void write_cb(bool success, uint8_t att_ecode, void *user_data)
>         write_result_cb(success, false, att_ecode, user_data);
>  }
>
> -static unsigned int start_long_write(DBusMessage *msg, uint16_t handle,
> +static struct async_dbus_op *start_long_write(DBusMessage *msg, uint16_t handle,
>                                         struct bt_gatt_client *gatt,
>                                         bool reliable, const uint8_t *value,
>                                         size_t value_len, uint16_t offset,
> @@ -501,53 +530,52 @@ static unsigned int start_long_write(DBusMessage *msg, uint16_t handle,
>                                         async_dbus_op_complete_t complete)
>  {
>         struct async_dbus_op *op;
> -       unsigned int id;
>
> -       op = new0(struct async_dbus_op, 1);
> -       op->msg = dbus_message_ref(msg);
> -       op->data = data;
> +       op = async_dbus_op_new(msg, data);
>         op->complete = complete;
>         op->offset = offset;
>
> -       id = bt_gatt_client_write_long_value(gatt, reliable, handle, offset,
> +       op->id = bt_gatt_client_write_long_value(gatt, reliable, handle, offset,
>                                                         value, value_len,
>                                                         write_result_cb, op,
>                                                         async_dbus_op_free);
>
> -       if (!id)
> +       if (!op->id) {
>                 async_dbus_op_free(op);
> +               return NULL;
> +       }
>
> -       return id;
> +       return op;
>  }
>
> -static unsigned int start_write_request(DBusMessage *msg, uint16_t handle,
> +static struct async_dbus_op *start_write_request(DBusMessage *msg,
> +                                       uint16_t handle,
>                                         struct bt_gatt_client *gatt,
>                                         const uint8_t *value, size_t value_len,
>                                         void *data,
>                                         async_dbus_op_complete_t complete)
>  {
>         struct async_dbus_op *op;
> -       unsigned int id;
>
> -       op = new0(struct async_dbus_op, 1);
> -       op->msg = dbus_message_ref(msg);
> -       op->data = data;
> +       op = async_dbus_op_new(msg, data);
>         op->complete = complete;
>
> -       id = bt_gatt_client_write_value(gatt, handle, value, value_len,
> +       op->id = bt_gatt_client_write_value(gatt, handle, value, value_len,
>                                                         write_cb, op,
>                                                         async_dbus_op_free);
> -       if (!id)
> +       if (!op->id) {
>                 async_dbus_op_free(op);
> +               return NULL;
> +       }
>
> -       return id;
> +       return op;
>  }
>
>  static bool desc_write_complete(void *data)
>  {
>         struct descriptor *desc = data;
>
> -       desc->write_id = 0;
> +       desc->write_op = NULL;
>
>         /*
>          * The descriptor might have been unregistered during the read. Return
> @@ -569,7 +597,7 @@ static DBusMessage *descriptor_write_value(DBusConnection *conn,
>         if (!gatt)
>                 return btd_error_failed(msg, "Not connected");
>
> -       if (desc->write_id)
> +       if (desc->write_op)
>                 return btd_error_in_progress(msg);
>
>         dbus_message_iter_init(msg, &iter);
> @@ -593,17 +621,17 @@ static DBusMessage *descriptor_write_value(DBusConnection *conn,
>          * write.
>          */
>         if (value_len <= bt_gatt_client_get_mtu(gatt) - 3 && !offset)
> -               desc->write_id = start_write_request(msg, desc->handle,
> +               desc->write_op = start_write_request(msg, desc->handle,
>                                                         gatt, value,
>                                                         value_len, desc,
>                                                         desc_write_complete);
>         else
> -               desc->write_id = start_long_write(msg, desc->handle, gatt,
> +               desc->write_op = start_long_write(msg, desc->handle, gatt,
>                                                         false, value,
>                                                         value_len, offset, desc,
>                                                         desc_write_complete);
>
> -       if (!desc->write_id)
> +       if (!desc->write_op)
>                 return btd_error_failed(msg, "Failed to initiate write");
>
>         return NULL;
> @@ -681,11 +709,11 @@ static void unregister_descriptor(void *data)
>
>         DBG("Removing GATT descriptor: %s", desc->path);
>
> -       if (desc->read_id)
> -               bt_gatt_client_cancel(gatt, desc->read_id);
> +       if (desc->read_op)
> +               bt_gatt_client_cancel(gatt, desc->read_op->id);
>
> -       if (desc->write_id)
> -               bt_gatt_client_cancel(gatt, desc->write_id);
> +       if (desc->write_op)
> +               bt_gatt_client_cancel(gatt, desc->write_op->id);
>
>         desc->chrc = NULL;
>
> @@ -832,7 +860,6 @@ static void chrc_read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
>         struct async_dbus_op *op = user_data;
>         struct characteristic *chrc = op->data;
>         struct service *service = chrc->service;
> -       DBusMessage *reply;
>
>         if (!success)
>                 goto fail;
> @@ -843,6 +870,7 @@ static void chrc_read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
>         if (!gatt_db_attribute_write(chrc->attr, op->offset, value, length, 0,
>                                         NULL, write_characteristic_cb, chrc)) {
>                 error("Failed to store attribute");
> +               att_ecode = BT_ATT_ERROR_UNLIKELY;
>                 goto fail;
>         }
>
> @@ -853,31 +881,30 @@ static void chrc_read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
>          */
>         if (length == bt_gatt_client_get_mtu(service->client->gatt) - 1) {
>                 op->offset += length;
> -               chrc->read_id = bt_gatt_client_read_long_value(
> -                                                       service->client->gatt,
> +               op->id = bt_gatt_client_read_long_value(service->client->gatt,
>                                                         chrc->value_handle,
>                                                         op->offset,
>                                                         chrc_read_cb,
>                                                         async_dbus_op_ref(op),
>                                                         async_dbus_op_unref);
> -               if (chrc->read_id)
> +               if (op->id)
>                         return;
>         }
>
> -       chrc->read_id = 0;
> -
>         /* Read the stored data from db */
>         if (!gatt_db_attribute_read(chrc->attr, 0, 0, NULL, read_op_cb, op)) {
>                 error("Failed to read database");
> +               att_ecode = BT_ATT_ERROR_UNLIKELY;
>                 goto fail;
>         }
>
> +       chrc->read_op = NULL;
> +
>         return;
>
>  fail:
> -       reply = create_gatt_dbus_error(op->msg, att_ecode);
> -       chrc->read_id = 0;
> -       g_dbus_send_message(btd_get_dbus_connection(), reply);
> +       async_dbus_op_reply(op, att_ecode, NULL, 0);
> +       chrc->read_op = NULL;
>  }
>
>  static DBusMessage *characteristic_read_value(DBusConnection *conn,
> @@ -886,39 +913,36 @@ static DBusMessage *characteristic_read_value(DBusConnection *conn,
>         struct characteristic *chrc = user_data;
>         struct bt_gatt_client *gatt = chrc->service->client->gatt;
>         DBusMessageIter iter;
> -       struct async_dbus_op *op;
>         uint16_t offset = 0;
>
>         if (!gatt)
>                 return btd_error_failed(msg, "Not connected");
>
> -       if (chrc->read_id)
> -               return btd_error_in_progress(msg);
> -
>         dbus_message_iter_init(msg, &iter);
>
>         if (parse_options(&iter, &offset))
>                 return btd_error_invalid_args(msg);
>
> -       op = new0(struct async_dbus_op, 1);
> -       op->msg = dbus_message_ref(msg);
> -       op->data = chrc;
> -       op->offset = offset;
> -
> -       chrc->read_id = read_value(gatt, chrc->value_handle, chrc_read_cb, op);
> -       if (chrc->read_id)
> +       if (chrc->read_op) {
> +               if (chrc->read_op->offset != offset)
> +                       return btd_error_in_progress(msg);
> +               queue_push_tail(chrc->read_op->msgs, dbus_message_ref(msg));
>                 return NULL;
> +       }
>
> -       async_dbus_op_free(op);
> +       chrc->read_op = read_value(gatt, msg, chrc->value_handle, offset,
> +                                                       chrc_read_cb, chrc);
> +       if (!chrc->read_op)
> +               return btd_error_failed(msg, "Failed to send read request");
>
> -       return btd_error_failed(msg, "Failed to send read request");
> +       return NULL;
>  }
>
>  static bool chrc_write_complete(void *data)
>  {
>         struct characteristic *chrc = data;
>
> -       chrc->write_id = 0;
> +       chrc->write_op = NULL;
>
>         /*
>          * The characteristic might have been unregistered during the read.
> @@ -941,7 +965,7 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
>         if (!gatt)
>                 return btd_error_failed(msg, "Not connected");
>
> -       if (chrc->write_id)
> +       if (chrc->write_op)
>                 return btd_error_in_progress(msg);
>
>         dbus_message_iter_init(msg, &iter);
> @@ -965,10 +989,10 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
>          */
>         if ((chrc->ext_props & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE)) {
>                 supported = true;
> -               chrc->write_id = start_long_write(msg, chrc->value_handle, gatt,
> +               chrc->write_op = start_long_write(msg, chrc->value_handle, gatt,
>                                                 true, value, value_len, offset,
>                                                 chrc, chrc_write_complete);
> -               if (chrc->write_id)
> +               if (chrc->write_op)
>                         return NULL;
>         }
>
> @@ -981,17 +1005,17 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
>                         return btd_error_failed(msg, "No ATT transport");
>
>                 if (value_len <= mtu - 3 && !offset)
> -                       chrc->write_id = start_write_request(msg,
> +                       chrc->write_op = start_write_request(msg,
>                                                 chrc->value_handle,
>                                                 gatt, value, value_len,
>                                                 chrc, chrc_write_complete);
>                 else
> -                       chrc->write_id = start_long_write(msg,
> +                       chrc->write_op = start_long_write(msg,
>                                                 chrc->value_handle, gatt,
>                                                 false, value, value_len, offset,
>                                                 chrc, chrc_write_complete);
>
> -               if (chrc->write_id)
> +               if (chrc->write_op)
>                         return NULL;
>         }
>
> @@ -1140,26 +1164,17 @@ static void notify_cb(uint16_t value_handle, const uint8_t *value,
>                                                 write_characteristic_cb, chrc);
>  }
>
> -static DBusMessage *create_notify_reply(struct async_dbus_op *op,
> -                                               bool success, uint8_t att_ecode)
> +static void create_notify_reply(struct async_dbus_op *op, bool success,
> +                                                       uint8_t att_ecode)
>  {
> -       DBusMessage *reply = NULL;
> -
> -       if (!op->msg)
> -               return NULL;
> +       int err;
>
>         if (success)
> -               reply = g_dbus_create_reply(op->msg, DBUS_TYPE_INVALID);
> -       else if (att_ecode)
> -               reply = create_gatt_dbus_error(op->msg, att_ecode);
> +               err = 0;
>         else
> -               reply = btd_error_failed(op->msg,
> -                                               "Characteristic not available");
> +               err = att_ecode ? att_ecode : -ENOENT;
>
> -       if (!reply)
> -               error("Failed to construct D-Bus message reply");
> -
> -       return reply;
> +       async_dbus_op_reply(op, err, NULL, 0);
>  }
>
>  static void register_notify_cb(uint16_t att_ecode, void *user_data)
> @@ -1167,16 +1182,15 @@ static void register_notify_cb(uint16_t att_ecode, void *user_data)
>         struct async_dbus_op *op = user_data;
>         struct notify_client *client = op->data;
>         struct characteristic *chrc = client->chrc;
> -       DBusMessage *reply;
>
>         if (att_ecode) {
>                 queue_remove(chrc->notify_clients, client);
>                 queue_remove(chrc->service->client->all_notify_clients, client);
>                 notify_client_free(client);
>
> -               reply = create_notify_reply(op, false, att_ecode);
> +               create_notify_reply(op, false, att_ecode);
>
> -               goto done;
> +               return;
>         }
>
>         if (!chrc->notifying) {
> @@ -1186,11 +1200,7 @@ static void register_notify_cb(uint16_t att_ecode, void *user_data)
>                                         "Notifying");
>         }
>
> -       reply = create_notify_reply(op, true, 0);
> -
> -done:
> -       if (reply)
> -               g_dbus_send_message(btd_get_dbus_connection(), reply);
> +       create_notify_reply(op, true, 0);
>  }
>
>  static DBusMessage *characteristic_start_notify(DBusConnection *conn,
> @@ -1240,9 +1250,7 @@ static DBusMessage *characteristic_start_notify(DBusConnection *conn,
>                 goto fail;
>         }
>
> -       op = new0(struct async_dbus_op, 1);
> -       op->data = client;
> -       op->msg = dbus_message_ref(msg);
> +       op = async_dbus_op_new(msg, client);
>
>         client->notify_id = bt_gatt_client_register_notify(gatt,
>                                                 chrc->value_handle,
> @@ -1395,11 +1403,11 @@ static void unregister_characteristic(void *data)
>
>         DBG("Removing GATT characteristic: %s", chrc->path);
>
> -       if (chrc->read_id)
> -               bt_gatt_client_cancel(gatt, chrc->read_id);
> +       if (chrc->read_op)
> +               bt_gatt_client_cancel(gatt, chrc->read_op->id);
>
> -       if (chrc->write_id)
> -               bt_gatt_client_cancel(gatt, chrc->write_id);
> +       if (chrc->write_op)
> +               bt_gatt_client_cancel(gatt, chrc->write_op->id);
>
>         queue_remove_all(chrc->notify_clients, NULL, NULL, remove_client);
>         queue_remove_all(chrc->descs, NULL, NULL, unregister_descriptor);
> --
> 2.5.5

Applied.


-- 
Luiz Augusto von Dentz

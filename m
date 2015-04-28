Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1430231734-26699-4-git-send-email-luiz.dentz@gmail.com>
References: <1430231734-26699-1-git-send-email-luiz.dentz@gmail.com>
	<1430231734-26699-4-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 28 Apr 2015 14:28:58 -0700
Message-ID: <CAHrH25T1qZ1x1O2yKjmWNK7-xSXtw-sZAYHCcHEcJzEjkaGmtQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/4] core/gatt: Auto retry if read/write fails
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On Tue, Apr 28, 2015 at 7:35 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds auto retry logic to ReadValue and WriteValue when a security
> error happen, it will first attempt to elevate the security to match the
> requirement and then retry sending the same operation.
> ---
>  src/gatt-client.c | 182 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 176 insertions(+), 6 deletions(-)
>
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index 2e26ed7..7fd814c 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -223,6 +223,9 @@ static bool parse_value_arg(DBusMessage *msg, uint8_t **value,
>         return true;
>  }
>
> +struct async_dbus_op;
> +
> +typedef bool (*async_dbus_op_retry_t)(struct async_dbus_op *op, uint8_t ecode);
>  typedef bool (*async_dbus_op_complete_t)(void *data);
>
>  struct async_dbus_op {
> @@ -230,6 +233,7 @@ struct async_dbus_op {
>         DBusMessage *msg;
>         void *data;
>         uint16_t offset;
> +       async_dbus_op_retry_t retry;
>         async_dbus_op_complete_t complete;
>  };
>
> @@ -337,6 +341,23 @@ static void read_op_cb(struct gatt_db_attribute *attrib, int err,
>         g_dbus_send_message(btd_get_dbus_connection(), reply);
>  }
>
> +static bool check_security(struct bt_gatt_client *gatt, uint8_t ecode)
> +{
> +       int security;
> +
> +       security = bt_gatt_client_get_security(gatt);
> +       if (ecode == BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION &&
> +                                       security < BT_ATT_SECURITY_MEDIUM)
> +               security = BT_ATT_SECURITY_MEDIUM;
> +       else if (ecode == BT_ATT_ERROR_AUTHENTICATION &&
> +                                       security < BT_ATT_SECURITY_HIGH)
> +               security = BT_ATT_SECURITY_HIGH;
> +       else
> +               return false;
> +
> +       return bt_gatt_client_set_security(gatt, security);
> +}

This is mostly a nice to have but I wonder if we should try the same
thing from within shared/gatt-client as well in some cases, for
example when it fails to write to the CCC for a Service Changed
characteristic due to permissions. Just a thought.

> +
>  static void desc_read_cb(bool success, uint8_t att_ecode,
>                                         const uint8_t *value, uint16_t length,
>                                         void *user_data)
> @@ -346,8 +367,12 @@ static void desc_read_cb(bool success, uint8_t att_ecode,
>         struct service *service = desc->chrc->service;
>         DBusMessage *reply;
>
> -       if (!success)
> +       if (!success) {
> +               if (op->retry && op->retry(op, att_ecode))
> +                       return;
> +
>                 goto fail;
> +       }
>
>         if (!op->offset)
>                 gatt_db_attribute_reset(desc->attr);
> @@ -393,6 +418,28 @@ fail:
>         return;
>  }
>
> +static bool desc_read_retry(struct async_dbus_op *op, uint8_t ecode)
> +{
> +       struct descriptor *desc = op->data;
> +       struct bt_gatt_client *gatt = desc->chrc->service->client->gatt;
> +
> +       if (!check_security(gatt, ecode))
> +               return false;
> +
> +       desc->read_id = bt_gatt_client_read_value(gatt, desc->handle,
> +                                                       desc_read_cb,
> +                                                       async_dbus_op_ref(op),
> +                                                       async_dbus_op_unref);
> +       if (desc->read_id) {
> +               op->retry = NULL;
> +               return true;
> +       }
> +
> +       async_dbus_op_unref(op);
> +
> +       return false;
> +}
> +
>  static DBusMessage *descriptor_read_value(DBusConnection *conn,
>                                         DBusMessage *msg, void *user_data)
>  {
> @@ -412,6 +459,7 @@ static DBusMessage *descriptor_read_value(DBusConnection *conn,
>
>         op->msg = dbus_message_ref(msg);
>         op->data = desc;
> +       op->retry = desc_read_retry;
>
>         desc->read_id = bt_gatt_client_read_value(gatt, desc->handle,
>                                                         desc_read_cb,
> @@ -437,6 +485,9 @@ static void write_result_cb(bool success, bool reliable_error,
>         }
>
>         if (!success) {
> +               if (op->retry && op->retry(op, att_ecode))
> +                       return;
> +
>                 if (reliable_error)
>                         reply = btd_error_failed(op->msg,
>                                                 "Reliable write failed");
> @@ -466,6 +517,7 @@ static unsigned int start_long_write(DBusMessage *msg, uint16_t handle,
>                                         struct bt_gatt_client *gatt,
>                                         bool reliable, const uint8_t *value,
>                                         size_t value_len, void *data,
> +                                       async_dbus_op_retry_t retry,
>                                         async_dbus_op_complete_t complete)
>  {
>         struct async_dbus_op *op;
> @@ -493,7 +545,7 @@ static unsigned int start_long_write(DBusMessage *msg, uint16_t handle,
>  static unsigned int start_write_request(DBusMessage *msg, uint16_t handle,
>                                         struct bt_gatt_client *gatt,
>                                         const uint8_t *value, size_t value_len,
> -                                       void *data,
> +                                       void *data, async_dbus_op_retry_t retry,
>                                         async_dbus_op_complete_t complete)
>  {
>         struct async_dbus_op *op;
> @@ -529,6 +581,46 @@ static bool desc_write_complete(void *data)
>         return !!desc->chrc;
>  }
>
> +static bool desc_write_retry(struct async_dbus_op *op, uint8_t ecode)
> +{
> +       struct descriptor *desc = op->data;
> +       struct bt_gatt_client *gatt = desc->chrc->service->client->gatt;
> +       uint8_t *value = NULL;
> +       size_t value_len = 0;
> +
> +       if (!check_security(gatt, ecode))
> +               return false;
> +
> +       if (!parse_value_arg(op->msg, &value, &value_len))
> +               return false;
> +
> +       /*
> +        * Based on the value length and the MTU, either use a write or a long
> +        * write.
> +        */
> +       if (value_len <= (unsigned) bt_gatt_client_get_mtu(gatt) - 3)
> +               desc->write_id = bt_gatt_client_write_value(gatt, desc->handle,
> +                                                       value, value_len,
> +                                                       write_cb,
> +                                                       async_dbus_op_ref(op),
> +                                                       async_dbus_op_free);
> +       else
> +               desc->write_id = bt_gatt_client_write_long_value(gatt,
> +                                                       false, desc->handle,
> +                                                       0, value, value_len,
> +                                                       write_result_cb,
> +                                                       async_dbus_op_ref(op),
> +                                                       async_dbus_op_free);
> +       if (desc->write_id) {
> +               op->retry = NULL;
> +               return true;
> +       }
> +
> +       async_dbus_op_free(op);
> +
> +       return false;
> +}
> +
>  static DBusMessage *descriptor_write_value(DBusConnection *conn,
>                                         DBusMessage *msg, void *user_data)
>  {
> @@ -562,11 +654,13 @@ static DBusMessage *descriptor_write_value(DBusConnection *conn,
>                 desc->write_id = start_write_request(msg, desc->handle,
>                                                         gatt, value,
>                                                         value_len, desc,
> +                                                       desc_write_retry,
>                                                         desc_write_complete);
>         else
>                 desc->write_id = start_long_write(msg, desc->handle,
>                                                         gatt, false, value,
>                                                         value_len, desc,
> +                                                       desc_write_retry,
>                                                         desc_write_complete);
>
>         if (!desc->write_id)
> @@ -790,8 +884,12 @@ static void chrc_read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
>         struct service *service = chrc->service;
>         DBusMessage *reply;
>
> -       if (!success)
> +       if (!success) {
> +               if (op->retry && op->retry(op, att_ecode))
> +                       return;
> +
>                 goto fail;
> +       }
>
>         if (!op->offset)
>                 gatt_db_attribute_reset(chrc->attr);
> @@ -836,6 +934,29 @@ fail:
>         g_dbus_send_message(btd_get_dbus_connection(), reply);
>  }
>
> +static bool chrc_read_retry(struct async_dbus_op *op, uint8_t ecode)
> +{
> +       struct characteristic *chrc = op->data;
> +       struct bt_gatt_client *gatt = chrc->service->client->gatt;
> +
> +       if (!check_security(gatt, ecode))
> +               return false;
> +
> +       chrc->read_id = bt_gatt_client_read_value(gatt, chrc->value_handle,
> +                                                       chrc_read_cb,
> +                                                       async_dbus_op_ref(op),
> +                                                       async_dbus_op_unref);
> +       if (chrc->read_id) {
> +               /* Only retry once */
> +               op->retry = NULL;
> +               return true;
> +       }
> +
> +       async_dbus_op_free(op);
> +
> +       return false;
> +}
> +
>  static DBusMessage *characteristic_read_value(DBusConnection *conn,
>                                         DBusMessage *msg, void *user_data)
>  {
> @@ -855,6 +976,7 @@ static DBusMessage *characteristic_read_value(DBusConnection *conn,
>
>         op->msg = dbus_message_ref(msg);
>         op->data = chrc;
> +       op->retry = chrc_read_retry;
>
>         chrc->read_id = bt_gatt_client_read_value(gatt, chrc->value_handle,
>                                                         chrc_read_cb,
> @@ -881,6 +1003,51 @@ static bool chrc_write_complete(void *data)
>         return !!chrc->service;
>  }
>
> +static bool chrc_write_retry(struct async_dbus_op *op, uint8_t ecode)
> +{
> +       struct characteristic *chrc = op->data;
> +       struct bt_gatt_client *gatt = chrc->service->client->gatt;
> +       uint8_t *value = NULL;
> +       size_t value_len = 0;
> +       bool reliable;
> +
> +       if (!check_security(gatt, ecode))
> +               return false;
> +
> +       if (!parse_value_arg(op->msg, &value, &value_len))
> +               return false;
> +
> +       reliable = (chrc->ext_props & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE);
> +
> +       /*
> +        * Based on the value length and the MTU, either use a write or a long
> +        * write.
> +        */
> +       if (value_len <= (unsigned) bt_gatt_client_get_mtu(gatt) - 3 &&
> +                                                               !reliable)
> +               chrc->write_id = bt_gatt_client_write_value(gatt,
> +                                                       chrc->value_handle,
> +                                                       value, value_len,
> +                                                       write_cb,
> +                                                       async_dbus_op_ref(op),
> +                                                       async_dbus_op_free);
> +       else
> +               chrc->write_id = bt_gatt_client_write_long_value(gatt, reliable,
> +                                                       chrc->value_handle,
> +                                                       0, value, value_len,
> +                                                       write_result_cb,
> +                                                       async_dbus_op_ref(op),
> +                                                       async_dbus_op_free);
> +       if (chrc->write_id) {
> +               op->retry = NULL;
> +               return true;
> +       }
> +
> +       async_dbus_op_free(op);
> +
> +       return false;
> +}
> +
>  static DBusMessage *characteristic_write_value(DBusConnection *conn,
>                                         DBusMessage *msg, void *user_data)
>  {
> @@ -914,7 +1081,8 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
>                 supported = true;
>                 chrc->write_id = start_long_write(msg, chrc->value_handle, gatt,
>                                                 true, value, value_len,
> -                                               chrc, chrc_write_complete);
> +                                               chrc, chrc_write_retry,
> +                                               chrc_write_complete);
>                 if (chrc->write_id)
>                         return NULL;
>         }
> @@ -931,12 +1099,14 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
>                         chrc->write_id = start_write_request(msg,
>                                                 chrc->value_handle,
>                                                 gatt, value, value_len,
> -                                               chrc, chrc_write_complete);
> +                                               chrc, chrc_write_retry,
> +                                               chrc_write_complete);
>                 else
>                         chrc->write_id = start_long_write(msg,
>                                                 chrc->value_handle, gatt,
>                                                 false, value, value_len,
> -                                               chrc, chrc_write_complete);
> +                                               chrc, chrc_write_retry,
> +                                               chrc_write_complete);
>
>                 if (chrc->write_id)
>                         return NULL;
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Arman

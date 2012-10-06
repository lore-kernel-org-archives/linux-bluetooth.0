Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349531535-706-3-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
References: <1349531535-706-1-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
	<1349531535-706-3-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
Date: Sat, 6 Oct 2012 19:24:23 +0530
Message-ID: <CAEd0BX8+WV=qp2roYdtEuTBTOg3TyeGhW9co_UpHD=hfpCOhqg@mail.gmail.com>
Subject: Re: [PATCH 2/4] client: Add Message.SetProperty and
 Message.GetProperties implementation.
From: "Venkateswaran, Srinivasa Ragavan"
	<srinivasa.ragavan.venkateswaran@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Srinivasa Ragavan <srinivasa.ragavan.venkateswaran@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Oct 6, 2012 at 7:22 PM, Srinivasa Ragavan
<srinivasa.ragavan.venkateswaran@intel.com> wrote:
> ---
>  client/map.c |  190 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 190 insertions(+)
>
Argh, got flushed from my outbox, when I was sending a different
patch. This is already applied. Please ignore this patch.

-Srini.
> diff --git a/client/map.c b/client/map.c
> index e78cd68..fc2d874 100644
> --- a/client/map.c
> +++ b/client/map.c
> @@ -28,6 +28,7 @@
>  #include <string.h>
>  #include <stdio.h>
>  #include <glib.h>
> +#include <glib/gstdio.h>
>  #include <gdbus.h>
>
>  #include <gobex-apparam.h>
> @@ -78,6 +79,10 @@ static const char * const filter_list[] = {
>  #define FILTER_BIT_MAX 15
>  #define FILTER_ALL     0xFF
>
> +#define STATUS_READ 0
> +#define STATUS_DELETE 1
> +#define FILLER_BYTE 0x30
> +
>  struct map_data {
>         struct obc_session *session;
>         DBusMessage *msg;
> @@ -104,6 +109,7 @@ struct map_msg {
>         uint64_t size;
>         char *status;
>         uint8_t flags;
> +       DBusMessage *msg;
>  };
>
>  struct map_parser {
> @@ -412,6 +418,183 @@ fail:
>         return reply;
>  }
>
> +static void set_message_status_cb(struct obc_session *session,
> +                                               struct obc_transfer *transfer,
> +                                               GError *err, void *user_data)
> +{
> +       struct map_msg *msg = user_data;
> +       DBusMessage *reply;
> +
> +       if (err != NULL) {
> +               reply = g_dbus_create_error(msg->msg,
> +                                               ERROR_INTERFACE ".Failed",
> +                                               "%s", err->message);
> +               goto done;
> +       }
> +
> +       reply = dbus_message_new_method_return(msg->msg);
> +       if (reply == NULL) {
> +               reply = g_dbus_create_error(msg->msg,
> +                                               ERROR_INTERFACE ".Failed",
> +                                               "%s", err->message);
> +       }
> +
> +done:
> +       g_dbus_send_message(conn, reply);
> +       dbus_message_unref(msg->msg);
> +       msg->msg = NULL;
> +}
> +
> +static DBusMessage *map_msg_set_property(DBusConnection *connection,
> +                                               DBusMessage *message,
> +                                               void *user_data)
> +{
> +       struct map_msg *msg = user_data;
> +       struct obc_transfer *transfer;
> +       char *property;
> +       gboolean status;
> +       GError *err = NULL;
> +       DBusMessage *reply;
> +       GObexApparam *apparam;
> +       char contents[2];
> +       int op;
> +       DBusMessageIter args, variant;
> +
> +       dbus_message_iter_init(message, &args);
> +       if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_STRING)
> +               return g_dbus_create_error(message,
> +                               ERROR_INTERFACE ".InvalidArguments", NULL);
> +
> +       dbus_message_iter_get_basic(&args, &property);
> +       dbus_message_iter_next(&args);
> +       if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_VARIANT)
> +               return g_dbus_create_error(message,
> +                               ERROR_INTERFACE ".InvalidArguments", NULL);
> +
> +       dbus_message_iter_recurse(&args, &variant);
> +       if (dbus_message_iter_get_arg_type(&variant) != DBUS_TYPE_BOOLEAN)
> +               return g_dbus_create_error(message,
> +                               ERROR_INTERFACE ".InvalidArguments", NULL);
> +
> +       dbus_message_iter_get_basic(&variant, &status);
> +
> +       /* MAP supports modifying only these two properties. */
> +       if (property && strcasecmp(property, "Read") == 0) {
> +               op = STATUS_READ;
> +               if (status)
> +                       msg->flags |= MAP_MSG_FLAG_READ;
> +               else
> +                       msg->flags &= ~MAP_MSG_FLAG_READ;
> +       } else if (property && strcasecmp(property, "Deleted") == 0)
> +               op = STATUS_DELETE;
> +       else {
> +               return g_dbus_create_error(message,
> +                               ERROR_INTERFACE ".InvalidArguments", NULL);
> +       }
> +
> +       contents[0] = FILLER_BYTE;
> +       contents[1] = '\0';
> +
> +       transfer = obc_transfer_put("x-bt/messageStatus", msg->handle, NULL,
> +                                                       contents,
> +                                                       sizeof(contents), &err);
> +       if (transfer == NULL)
> +               goto fail;
> +
> +       apparam = g_obex_apparam_set_uint8(NULL, MAP_AP_STATUSINDICATOR,
> +                                                               op);
> +       apparam = g_obex_apparam_set_uint8(apparam, MAP_AP_STATUSVALUE,
> +                                                               status);
> +       obc_transfer_set_apparam(transfer, apparam);
> +
> +       if (!obc_session_queue(msg->data->session, transfer,
> +                           set_message_status_cb, msg, &err))
> +               goto fail;
> +
> +       msg->msg = dbus_message_ref(message);
> +       return NULL;
> +
> +fail:
> +       reply = g_dbus_create_error(message, ERROR_INTERFACE ".Failed", "%s",
> +                                                               err->message);
> +       g_error_free(err);
> +       return reply;
> +}
> +
> +static DBusMessage *map_msg_get_properties(DBusConnection *connection,
> +                                          DBusMessage *message,
> +                                          void *user_data)
> +{
> +       struct map_msg *msg = user_data;
> +       GError *err = NULL;
> +       DBusMessage *reply;
> +       DBusMessageIter iter, data_array;
> +       gboolean flag;
> +
> +       reply = dbus_message_new_method_return(message);
> +       if (reply == NULL) {
> +               reply = g_dbus_create_error(message,
> +                                               ERROR_INTERFACE ".Failed",
> +                                               NULL);
> +               goto done;
> +       }
> +
> +       dbus_message_iter_init_append(reply, &iter);
> +       dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +                                       DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
> +                                       DBUS_TYPE_STRING_AS_STRING
> +                                       DBUS_TYPE_VARIANT_AS_STRING
> +                                       DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
> +                                       &data_array);
> +
> +
> +       obex_dbus_dict_append(&data_array, "Subject",
> +                             DBUS_TYPE_STRING, &msg->subject);
> +       obex_dbus_dict_append(&data_array, "Timestamp",
> +                             DBUS_TYPE_STRING, &msg->timestamp);
> +       obex_dbus_dict_append(&data_array, "Sender",
> +                             DBUS_TYPE_STRING, &msg->sender);
> +       obex_dbus_dict_append(&data_array, "SenderAddress",
> +                             DBUS_TYPE_STRING, &msg->sender_address);
> +       obex_dbus_dict_append(&data_array, "ReplyTo",
> +                             DBUS_TYPE_STRING, &msg->replyto);
> +       obex_dbus_dict_append(&data_array, "Recipient",
> +                             DBUS_TYPE_STRING, &msg->recipient);
> +       obex_dbus_dict_append(&data_array, "RecipientAddress",
> +                             DBUS_TYPE_STRING, &msg->recipient_address);
> +       obex_dbus_dict_append(&data_array, "Type",
> +                             DBUS_TYPE_STRING, &msg->type);
> +       obex_dbus_dict_append(&data_array, "Status",
> +                             DBUS_TYPE_STRING, &msg->status);
> +       obex_dbus_dict_append(&data_array, "Size",
> +                             DBUS_TYPE_UINT64, &msg->size);
> +
> +       flag = (msg->flags & MAP_MSG_FLAG_PRIORITY) != 0;
> +       obex_dbus_dict_append(&data_array, "Priority",
> +                             DBUS_TYPE_BOOLEAN, &flag);
> +
> +       flag = (msg->flags & MAP_MSG_FLAG_READ) != 0;
> +       obex_dbus_dict_append(&data_array, "Read",
> +                             DBUS_TYPE_BOOLEAN, &flag);
> +
> +       flag = (msg->flags & MAP_MSG_FLAG_SENT) != 0;
> +       obex_dbus_dict_append(&data_array, "Sent",
> +                             DBUS_TYPE_BOOLEAN, &flag);
> +
> +       flag = (msg->flags & MAP_MSG_FLAG_PROTECTED) != 0;
> +       obex_dbus_dict_append(&data_array, "Protected",
> +                             DBUS_TYPE_BOOLEAN, &flag);
> +
> +       dbus_message_iter_close_container(&iter, &data_array);
> +
> +
> +done:
> +       if (err)
> +               g_error_free(err);
> +
> +       return reply;
> +}
> +
>  static const GDBusMethodTable map_msg_methods[] = {
>         { GDBUS_METHOD("Get",
>                         GDBUS_ARGS({ "targetfile", "s" },
> @@ -419,6 +602,13 @@ static const GDBusMethodTable map_msg_methods[] = {
>                         GDBUS_ARGS({ "transfer", "o" },
>                                                 { "properties", "a{sv}" }),
>                         map_msg_get) },
> +       { GDBUS_METHOD("GetProperties",
> +                       NULL,
> +                       GDBUS_ARGS({ "properties", "a{sv}" }),
> +                       map_msg_get_properties) },
> +       { GDBUS_ASYNC_METHOD("SetProperty",
> +                       GDBUS_ARGS({ "property", "sv" }), NULL,
> +                       map_msg_set_property) },
>         { }
>  };
>
> --
> 1.7.10.4
>

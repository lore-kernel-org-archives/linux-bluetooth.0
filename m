Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1362064124-29787-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1362064124-29787-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
	<1362064124-29787-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Fri, 1 Mar 2013 15:17:41 +0200
Message-ID: <CABBYNZJQCKST+4AA9vemQTeUN9M7W_4tWZ+QfsAWMaz6wtLWcQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] obexd: Move Message.Get parameter attachment into dictionary
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Thu, Feb 28, 2013 at 5:08 PM, Christian Fetzer
<christian.fetzer@oss.bmw-carit.de> wrote:
> From: Christian Fetzer <christian.fetzer@bmw-carit.de>
>
> This is a preparation for adding additional parameters to Message.Get.
> The parsing of the args dictionary is done in parse_get_options.
>
> The Attachment parameter has been moved into the args dictionary.
> The parameter is now optional defaulting to true.
> ---
>  doc/obex-api.txt   |  9 ++++++-
>  obexd/client/map.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 76 insertions(+), 12 deletions(-)
>
> diff --git a/doc/obex-api.txt b/doc/obex-api.txt
> index 759c4d8..0dd1261 100644
> --- a/doc/obex-api.txt
> +++ b/doc/obex-api.txt
> @@ -717,7 +717,7 @@ Service             org.bluez.obex
>  Interface      org.bluez.obex.Message1
>  Object path    [variable prefix]/{session0,session1,...}/{message0,...}
>
> -Methods                object, dict Get(string targetfile, boolean attachment)
> +Methods                object, dict Get(string targetfile, dict args)
>
>                         Download message and store it in the target file.
>
> @@ -731,6 +731,13 @@ Methods            object, dict Get(string targetfile, boolean attachment)
>                         The properties of this transfer are also returned along
>                         with the object path, to avoid a call to GetProperties.
>
> +                       Possible args:
> +
> +                               boolean Attachment
> +
> +                                       Request message attachment,
> +                                       defaults to True
> +
>                         Possible errors: org.bluez.obex.Error.InvalidArguments
>                                          org.bluez.obex.Error.Failed
>
> diff --git a/obexd/client/map.c b/obexd/client/map.c
> index 2b665ec..b7e6428 100644
> --- a/obexd/client/map.c
> +++ b/obexd/client/map.c
> @@ -385,34 +385,91 @@ static void map_msg_free(void *data)
>         g_free(msg);
>  }
>
> +static GObexApparam *parse_attachment(GObexApparam *apparam,
> +                                                       DBusMessageIter *iter)
> +{
> +       dbus_bool_t attachment;
> +
> +       if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
> +               return NULL;
> +
> +       dbus_message_iter_get_basic(iter, &attachment);
> +
> +       return g_obex_apparam_set_uint8(apparam, MAP_AP_ATTACHMENT,
> +                                               attachment ? TRUE : FALSE);
> +}
> +
> +static GObexApparam *parse_get_options(GObexApparam *apparam,
> +                                                       DBusMessageIter *iter)
> +{
> +       DBusMessageIter array;
> +
> +       DBG("");
> +
> +       if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
> +               return NULL;
> +
> +       dbus_message_iter_recurse(iter, &array);
> +
> +       while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_DICT_ENTRY) {
> +               const char *key;
> +               DBusMessageIter value, entry;
> +
> +               dbus_message_iter_recurse(&array, &entry);
> +               dbus_message_iter_get_basic(&entry, &key);
> +
> +               dbus_message_iter_next(&entry);
> +               dbus_message_iter_recurse(&entry, &value);
> +
> +               if (strcasecmp(key, "Attachment") == 0) {
> +                       if (parse_attachment(apparam, &value) == NULL)
> +                               return NULL;
> +               }
> +
> +               dbus_message_iter_next(&array);
> +       }
> +
> +       return apparam;
> +}
> +
>  static DBusMessage *map_msg_get(DBusConnection *connection,
>                                         DBusMessage *message, void *user_data)
>  {
>         struct map_msg *msg = user_data;
>         struct obc_transfer *transfer;
>         const char *target_file;
> -       gboolean attachment;
>         GError *err = NULL;
>         DBusMessage *reply;
>         GObexApparam *apparam;
> +       DBusMessageIter args;
> +
> +       dbus_message_iter_init(message, &args);
>
> -       if (dbus_message_get_args(message, NULL,
> -                               DBUS_TYPE_STRING, &target_file,
> -                               DBUS_TYPE_BOOLEAN, &attachment,
> -                               DBUS_TYPE_INVALID) == FALSE)
> +       if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_STRING)
>                 return g_dbus_create_error(message,
>                                 ERROR_INTERFACE ".InvalidArguments", NULL);
>
> -       transfer = obc_transfer_get("x-bt/message", msg->handle, target_file,
> -                                                                       &err);
> -       if (transfer == NULL)
> -               goto fail;
> +       dbus_message_iter_get_basic(&args, &target_file);
> +
> +       dbus_message_iter_next(&args);
>
>         apparam = g_obex_apparam_set_uint8(NULL, MAP_AP_ATTACHMENT,
> -                                                               attachment);
> +                                                               TRUE);
> +
>         apparam = g_obex_apparam_set_uint8(apparam, MAP_AP_CHARSET,
>                                                                 CHARSET_UTF8);
>
> +       if (parse_get_options(apparam, &args) == NULL) {
> +               g_obex_apparam_free(apparam);
> +               return g_dbus_create_error(message,
> +                               ERROR_INTERFACE ".InvalidArguments", NULL);
> +       }
> +
> +       transfer = obc_transfer_get("x-bt/message", msg->handle, target_file,
> +                                                                       &err);
> +       if (transfer == NULL)
> +               goto fail;
> +
>         obc_transfer_set_apparam(transfer, apparam);
>
>         if (!obc_session_queue(msg->data->session, transfer, NULL, NULL, &err))
> @@ -731,7 +788,7 @@ static void set_deleted(const GDBusPropertyTable *property,
>  static const GDBusMethodTable map_msg_methods[] = {
>         { GDBUS_METHOD("Get",
>                         GDBUS_ARGS({ "targetfile", "s" },
> -                                               { "attachment", "b" }),
> +                                               { "args", "a{sv}" }),
>                         GDBUS_ARGS({ "transfer", "o" },
>                                                 { "properties", "a{sv}" }),
>                         map_msg_get) },
> --
> 1.8.1.4

Im not against it, but we need to update the version number of the
interface if we break the API which these changes does.


-- 
Luiz Augusto von Dentz

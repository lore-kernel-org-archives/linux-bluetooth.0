Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349531535-706-1-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
References: <1349531535-706-1-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
Date: Tue, 9 Oct 2012 11:14:08 +0200
Message-ID: <CABBYNZ+xJuGLTmYdDCVXkxa4ut1XuF7OGdDUTCU5-acqkBE8yA@mail.gmail.com>
Subject: Re: [PATCH 1/3] client: Add implementation for UpdateInbox
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Srinivasa Ragavan <srinivasa.ragavan.venkateswaran@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Srinivasa,

On Sat, Oct 6, 2012 at 3:52 PM, Srinivasa Ragavan
<srinivasa.ragavan.venkateswaran@intel.com> wrote:
> ---
>  client/map.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/client/map.c b/client/map.c
> index 290eaae..c0a5bfc 100644
> --- a/client/map.c
> +++ b/client/map.c
> @@ -1242,6 +1242,60 @@ static DBusMessage *map_list_filter_fields(DBusConnection *connection,
>         return reply;
>  }
>
> +static void update_inbox_cb(struct obc_session *session,
> +                        struct obc_transfer *transfer,
> +                        GError *err, void *user_data)
> +{
> +       struct map_data *map = user_data;
> +       DBusMessage *reply;
> +
> +       if (err != NULL) {
> +               reply = g_dbus_create_error(map->msg,
> +                                               ERROR_INTERFACE ".Failed",
> +                                               "%s", err->message);
> +               goto done;
> +       }
> +
> +       reply = dbus_message_new_method_return(map->msg);
> +
> +done:
> +       g_dbus_send_message(conn, reply);
> +       dbus_message_unref(map->msg);
> +}
> +
> +static DBusMessage *map_update_inbox(DBusConnection *connection,
> +                                 DBusMessage *message, void *user_data)
> +{
> +       struct map_data *map = user_data;
> +       DBusMessage *reply;
> +       char contents[2];
> +       struct obc_transfer *transfer;
> +       GError *err = NULL;
> +
> +       contents[0] = FILLER_BYTE;
> +       contents[1] = '\0';
> +
> +       transfer = obc_transfer_put("x-bt/MAP-messageUpdate", NULL, NULL,
> +                                                       contents,
> +                                                       sizeof(contents), &err);
> +       if (transfer == NULL)
> +               goto fail;
> +
> +       if (!obc_session_queue(map->session, transfer,
> +                              update_inbox_cb, map, &err))
> +               goto fail;
> +
> +       map->msg = dbus_message_ref(message);
> +
> +       return NULL;
> +
> +fail:
> +       reply = g_dbus_create_error(message, ERROR_INTERFACE ".Failed", "%s",
> +                                                               err->message);
> +       g_error_free(err);
> +       return reply;
> +}
> +
>  static const GDBusMethodTable map_methods[] = {
>         { GDBUS_ASYNC_METHOD("SetFolder",
>                                 GDBUS_ARGS({ "name", "s" }), NULL,
> @@ -1258,6 +1312,10 @@ static const GDBusMethodTable map_methods[] = {
>                         NULL,
>                         GDBUS_ARGS({ "fields", "as" }),
>                         map_list_filter_fields) },
> +       { GDBUS_ASYNC_METHOD("UpdateInbox",
> +                       NULL,
> +                       NULL,
> +                       map_update_inbox) },
>         { }
>  };
>
> --
> 1.7.10.4

These patches are now upstream, Ive made some codestyle changes
because we don't use spaces to align on multilines but checkpatch
don't seem to catch those are they are no really mandatory on kernel.

-- 
Luiz Augusto von Dentz

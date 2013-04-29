Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1366318045-22261-1-git-send-email-luiz.dentz@gmail.com>
References: <1366318045-22261-1-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 29 Apr 2013 17:45:52 +0300
Message-ID: <CABBYNZKYwVpz6kAzJQ5D52ndVhb8M9P9YgECh69mQ7FPXhD0JA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gdbus: Fix calling GetManagedObjects twice in a row
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Apr 18, 2013 at 11:47 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Calling g_dbus_client_new followed by g_dbus_client_set_proxy_handlers
> cause two calls to GetManagedObjects in a row as GetNameOwner reply is
> asyncronously it triggers the second call because the handlers have
> been set by g_dbus_client_set_proxy_handlers.
> ---
>  gdbus/client.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/gdbus/client.c b/gdbus/client.c
> index c2d2346..55f1d89 100644
> --- a/gdbus/client.c
> +++ b/gdbus/client.c
> @@ -40,6 +40,7 @@ struct GDBusClient {
>         char *base_path;
>         GPtrArray *match_rules;
>         DBusPendingCall *pending_call;
> +       DBusPendingCall *get_objects_call;
>         GDBusWatchFunction connect_func;
>         void *connect_data;
>         GDBusWatchFunction disconn_func;
> @@ -992,6 +993,8 @@ static void get_managed_objects_reply(DBusPendingCall *call, void *user_data)
>         DBusMessage *reply = dbus_pending_call_steal_reply(call);
>         DBusError error;
>
> +       g_dbus_client_ref(client);
> +
>         dbus_error_init(&error);
>
>         if (dbus_set_error_from_message(&error, reply) == TRUE) {
> @@ -1004,19 +1007,24 @@ static void get_managed_objects_reply(DBusPendingCall *call, void *user_data)
>  done:
>         dbus_message_unref(reply);
>
> +       dbus_pending_call_unref(client->get_objects_call);
> +       client->get_objects_call = NULL;
> +
>         g_dbus_client_unref(client);
>  }
>
>  static void get_managed_objects(GDBusClient *client)
>  {
>         DBusMessage *msg;
> -       DBusPendingCall *call;
>
>         if (!client->proxy_added && !client->proxy_removed) {
>                 refresh_properties(client);
>                 return;
>         }
>
> +       if (client->get_objects_call != NULL)
> +               return;
> +
>         msg = dbus_message_new_method_call(client->service_name, "/",
>                                         DBUS_INTERFACE_DBUS ".ObjectManager",
>                                                         "GetManagedObjects");
> @@ -1026,16 +1034,14 @@ static void get_managed_objects(GDBusClient *client)
>         dbus_message_append_args(msg, DBUS_TYPE_INVALID);
>
>         if (dbus_connection_send_with_reply(client->dbus_conn, msg,
> -                                                       &call, -1) == FALSE) {
> +                               &client->get_objects_call, -1) == FALSE) {
>                 dbus_message_unref(msg);
>                 return;
>         }
>
> -       g_dbus_client_ref(client);
> -
> -       dbus_pending_call_set_notify(call, get_managed_objects_reply,
> -                                                       client, NULL);
> -       dbus_pending_call_unref(call);
> +       dbus_pending_call_set_notify(client->get_objects_call,
> +                                               get_managed_objects_reply,
> +                                               client, NULL);
>
>         dbus_message_unref(msg);
>  }
> @@ -1285,6 +1291,11 @@ void g_dbus_client_unref(GDBusClient *client)
>                 dbus_pending_call_unref(client->pending_call);
>         }
>
> +       if (client->get_objects_call != NULL) {
> +               dbus_pending_call_cancel(client->get_objects_call);
> +               dbus_pending_call_unref(client->get_objects_call);
> +       }
> +
>         for (i = 0; i < client->match_rules->len; i++) {
>                 modify_match(client->dbus_conn, "RemoveMatch",
>                                 g_ptr_array_index(client->match_rules, i));
> --
> 1.8.1.4

Anyone against pushing this one upstream? Otherwise I will be pushing
it latter today.


--
Luiz Augusto von Dentz

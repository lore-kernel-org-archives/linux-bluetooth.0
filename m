Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKYwVpz6kAzJQ5D52ndVhb8M9P9YgECh69mQ7FPXhD0JA@mail.gmail.com>
References: <1366318045-22261-1-git-send-email-luiz.dentz@gmail.com> <CABBYNZKYwVpz6kAzJQ5D52ndVhb8M9P9YgECh69mQ7FPXhD0JA@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 29 Apr 2013 13:39:55 -0300
Message-ID: <CAMOw1v4U+cFv=+J4CxuAOKFvBcfEUSTzJ2PV+mn4CCEjxDE99g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gdbus: Fix calling GetManagedObjects twice in a row
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Apr 29, 2013 at 11:45 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Thu, Apr 18, 2013 at 11:47 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> Calling g_dbus_client_new followed by g_dbus_client_set_proxy_handlers
>> cause two calls to GetManagedObjects in a row as GetNameOwner reply is
>> asyncronously it triggers the second call because the handlers have
>> been set by g_dbus_client_set_proxy_handlers.
>> ---
>>  gdbus/client.c | 25 ++++++++++++++++++-------
>>  1 file changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/gdbus/client.c b/gdbus/client.c
>> index c2d2346..55f1d89 100644
>> --- a/gdbus/client.c
>> +++ b/gdbus/client.c
>> @@ -40,6 +40,7 @@ struct GDBusClient {
>>         char *base_path;
>>         GPtrArray *match_rules;
>>         DBusPendingCall *pending_call;
>> +       DBusPendingCall *get_objects_call;
>>         GDBusWatchFunction connect_func;
>>         void *connect_data;
>>         GDBusWatchFunction disconn_func;
>> @@ -992,6 +993,8 @@ static void get_managed_objects_reply(DBusPendingCall *call, void *user_data)
>>         DBusMessage *reply = dbus_pending_call_steal_reply(call);
>>         DBusError error;
>>
>> +       g_dbus_client_ref(client);
>> +
>>         dbus_error_init(&error);
>>
>>         if (dbus_set_error_from_message(&error, reply) == TRUE) {
>> @@ -1004,19 +1007,24 @@ static void get_managed_objects_reply(DBusPendingCall *call, void *user_data)
>>  done:
>>         dbus_message_unref(reply);
>>
>> +       dbus_pending_call_unref(client->get_objects_call);
>> +       client->get_objects_call = NULL;
>> +
>>         g_dbus_client_unref(client);
>>  }
>>
>>  static void get_managed_objects(GDBusClient *client)
>>  {
>>         DBusMessage *msg;
>> -       DBusPendingCall *call;
>>
>>         if (!client->proxy_added && !client->proxy_removed) {
>>                 refresh_properties(client);
>>                 return;
>>         }
>>
>> +       if (client->get_objects_call != NULL)
>> +               return;
>> +
>>         msg = dbus_message_new_method_call(client->service_name, "/",
>>                                         DBUS_INTERFACE_DBUS ".ObjectManager",
>>                                                         "GetManagedObjects");
>> @@ -1026,16 +1034,14 @@ static void get_managed_objects(GDBusClient *client)
>>         dbus_message_append_args(msg, DBUS_TYPE_INVALID);
>>
>>         if (dbus_connection_send_with_reply(client->dbus_conn, msg,
>> -                                                       &call, -1) == FALSE) {
>> +                               &client->get_objects_call, -1) == FALSE) {
>>                 dbus_message_unref(msg);
>>                 return;
>>         }
>>
>> -       g_dbus_client_ref(client);
>> -
>> -       dbus_pending_call_set_notify(call, get_managed_objects_reply,
>> -                                                       client, NULL);
>> -       dbus_pending_call_unref(call);
>> +       dbus_pending_call_set_notify(client->get_objects_call,
>> +                                               get_managed_objects_reply,
>> +                                               client, NULL);

Why don't you let the unref here, so you don't need to do it in
g_dbus_client_unref() and get_managed_objects_reply(). This way the
only ref is owned by libdbus which will free it when it's done.

Lucas De Marchi

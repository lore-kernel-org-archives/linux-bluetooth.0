Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLJofos=6Q_ZpeGH72g3EcYC9645QCK=_=tADU3zG7abQ@mail.gmail.com>
References: <CAK8d-aLtkB1RKm+HP92x45D7csVpPNHj--4SsOPG3aAcx9sj0Q@mail.gmail.com>
 <1417622074-20023-1-git-send-email-stevenrwalter@gmail.com>
 <1417622074-20023-2-git-send-email-stevenrwalter@gmail.com> <CABBYNZLJofos=6Q_ZpeGH72g3EcYC9645QCK=_=tADU3zG7abQ@mail.gmail.com>
From: Steven Walter <stevenrwalter@gmail.com>
Date: Wed, 3 Dec 2014 12:28:55 -0500
Message-ID: <CAK8d-aJRBapUzKqBOG-S+UZxZ5P0ZGtDS_RdONpC7Y7HjyQc-Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/5] gdbus/client.c: don't assume the root object
 path is valid
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Arman Uguray <armansito@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz

On Wed, Dec 3, 2014 at 11:08 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Steven,
>
> On Wed, Dec 3, 2014 at 5:54 PM, Steven Walter <stevenrwalter@gmail.com> wrote:
>> We should look for objects at the path the client has registered, not
>> hard-coded at root.  In particular, python D-Bus objects will not
>> respond to requests directed at the root object path.
>> ---
>>  gdbus/client.c  | 2 +-
>>  src/gatt-dbus.c | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/gdbus/client.c b/gdbus/client.c
>> index eb68a0f..a270fc2 100644
>> --- a/gdbus/client.c
>> +++ b/gdbus/client.c
>> @@ -1115,7 +1115,7 @@ static void get_managed_objects(GDBusClient *client)
>>         if (client->get_objects_call != NULL)
>>                 return;
>>
>> -       msg = dbus_message_new_method_call(client->service_name, "/",
>> +       msg = dbus_message_new_method_call(client->service_name, client->base_path,
>>                                         DBUS_INTERFACE_DBUS ".ObjectManager",
>>                                                         "GetManagedObjects");
>>         if (msg == NULL)
>> diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
>> index a04c38f..e61af15 100644
>> --- a/src/gatt-dbus.c
>> +++ b/src/gatt-dbus.c
>> @@ -524,7 +524,7 @@ static struct external_service *external_service_new(DBusConnection *conn,
>>         GDBusClient *client;
>>         const char *sender = dbus_message_get_sender(msg);
>>
>> -       client = g_dbus_client_new(conn, sender, "/");
>> +       client = g_dbus_client_new(conn, sender, path);
>>         if (!client)
>>                 return NULL;
>>
>> --
>> 1.9.1
>
> I remember the spec had something regarding '/' must be present and
> the ObjectManager was only allowed on that because of that otherwise
> the clients have to know before hand what path are available which is
> the whole point of having ObjectManager to discover that.

I don't read that in the spec.  The specs says:

"The root of each sub-tree implements this interface so other
applications can get all objects, interfaces and properties in a
single method call."

Note "sub-tree", not "the root tree."  The spec is also careful to
talk about the ObjectManager's object path, not assuming that the path
will be '/'.

Regardless, we can always be less strict than the spec.  Since we have
an object path, why wouldn't we use it?
-- 
-Steven Walter <stevenrwalter@gmail.com>

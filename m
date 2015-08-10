Return-Path: <cyrus@holtmann.org>
From: Adam Moore <adam.moore@savantsystems.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Adam Moore <adam.moore@savantsystems.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] gatt-database: allow GattService anywhere in
 ObjectManager tree
Date: Mon, 10 Aug 2015 23:27:14 +0000
Message-ID: <D1EE7DB0.B607%adam.moore@savant.com>
References: <1438364565-24642-1-git-send-email-adam.moore@savantsystems.com>
 <CABBYNZLWpbr36dvPP-QsSTtMjW=zZqU7ZfK7KW8SohBeeTtvbg@mail.gmail.com>
In-Reply-To: <CABBYNZLWpbr36dvPP-QsSTtMjW=zZqU7ZfK7KW8SohBeeTtvbg@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



On 8/2/15, 2:04 AM, "Luiz Augusto von Dentz" <luiz.dentz@gmail.com> wrote:

>Hi Adam,
>
>On Fri, Jul 31, 2015 at 8:42 PM, Adam Moore
><adam.moore@savantsystems.com> wrote:
>> Relaxes the requirement that object provide ObjectManager AND
>> GattService interfaces.
>>
>> Maintains check that GattService and GattCharacteristics are
>> children of ObjectManager, but loses the check that
>> GattCharacteristics are children of GattService. Therefore,
>> meant as a temporary workaround.
>> ---
>>  src/gatt-database.c | 20 +++++++++++++++-----
>>  1 file changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/src/gatt-database.c b/src/gatt-database.c
>> index 69a814d..e82165c 100644
>> --- a/src/gatt-database.c
>> +++ b/src/gatt-database.c
>> @@ -85,6 +85,7 @@ struct external_service {
>>         bool failed;
>>         char *owner;
>>         char *path;     /* Path to GattService1 */
>> +       char *manager_path;     /* Path to ObjectManager */
>>         DBusMessage *reg;
>>         GDBusClient *client;
>>         GDBusProxy *proxy;
>> @@ -372,6 +373,7 @@ static void service_free(void *data)
>>
>>         g_free(service->owner);
>>         g_free(service->path);
>> +       g_free(service->manager_path);
>>
>>         free(service);
>>  }
>> @@ -1042,7 +1044,7 @@ static bool match_service(const void *a, const
>>void *b)
>>         const struct external_service *service = a;
>>         const struct svc_match_data *data = b;
>>
>> -       return g_strcmp0(service->path, data->path) == 0 &&
>> +       return g_strcmp0(service->manager_path, data->path) == 0 &&
>>                                 g_strcmp0(service->owner, data->sender)
>>== 0;
>>  }
>>
>> @@ -1321,7 +1323,7 @@ static void proxy_added_cb(GDBusProxy *proxy,
>>void *user_data)
>>         iface = g_dbus_proxy_get_interface(proxy);
>>         path = g_dbus_proxy_get_path(proxy);
>>
>> -       if (!g_str_has_prefix(path, service->path))
>> +       if (!g_str_has_prefix(path, service->manager_path))
>>                 return;
>>
>>         if (g_strcmp0(iface, GATT_SERVICE_IFACE) == 0) {
>> @@ -1332,12 +1334,20 @@ static void proxy_added_cb(GDBusProxy *proxy,
>>void *user_data)
>>                  * TODO: We may want to support adding included
>>services in a
>>                  * single hierarchy.
>>                  */
>> -               if (g_strcmp0(path, service->path) != 0) {
>> +               if (service->path != NULL) {
>>                         error("Multiple services added within
>>hierarchy");
>>                         service->failed = true;
>>                         return;
>>                 }
>>
>> +               // Set service path now that we've found a service
>> +               service->path = g_strdup(path);
>> +               if (!service->path) {
>> +                       error("Failed to allocate service path");
>> +                       service->failed = true;
>> +                       return;
>> +               }
>> +
>>                 /* Add 1 for the service declaration */
>>                 if (!incr_attr_count(service, 1)) {
>>                         error("Failed to increment attribute count");
>> @@ -2171,8 +2181,8 @@ static struct external_service
>>*service_create(DBusConnection *conn,
>>         if (!service->owner)
>>                 goto fail;
>>
>> -       service->path = g_strdup(path);
>> -       if (!service->path)
>> +       service->manager_path = g_strdup(path);
>> +       if (!service->manager_path)
>>                 goto fail;
>>
>>         service->chrcs = queue_new();
>> --
>> 2.4.6
>
>Well if we are doing to do that then perhaps we should list all the
>services under the path ObjectManager path not only one.

Hi Luiz,

You are right - though I still like the initial design of having one
service per ObjectManager, as it makes it easier to cleanup or restart (or
D-Bus export/unexport) an individual service at the ObjectManager API
level.

I only added the pointer to manager_path because it was better to test
that for that prefix than it was to not do any checking.  I couldn¹t do
the stronger test for the GattService path because there is no guaranteed
order to the proxy callbacks.

How strict do you think we need to be here in validating the parent/child
relationships in the object tree?

-Adam

>
>
>--
>Luiz Augusto von Dentz


Statement of Confidentiality

The contents of this e-mail message and any attachments are confidential and are intended solely for the addressee. The information may also be legally privileged. This transmission is sent in trust, and the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or at 508.683.2500 and delete this message and its attachments, if any.


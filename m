Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1342685013.24426.7.camel@aeonflux>
References: <1342668008-5522-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1342668008-5522-2-git-send-email-lucas.demarchi@profusion.mobi> <1342685013.24426.7.camel@aeonflux>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Thu, 19 Jul 2012 05:19:34 -0300
Message-ID: <CAMOw1v4M-grmnaAoDujhRYHWzf_j0t2T4Uo0hOhmzH3Li_pWcg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] gdbus: Add skeleton of DBus.Properties interface
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jul 19, 2012 at 5:03 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Lucas,
>
>> This interface is responsible for handling properties of all objects in
>> a given path. Right now it only registers itself, doing nothing useful.
>> A conversion to this new layout will be done by subsequent patches.
>>
>> org.freedesktop.org.DBus.Properties spec can be found at
>> http://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-properties
>> ---
>>  gdbus/object.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>
>> diff --git a/gdbus/object.c b/gdbus/object.c
>> index 900e7ab..72f77d4 100644
>> --- a/gdbus/object.c
>> +++ b/gdbus/object.c
>> @@ -491,6 +491,50 @@ static const GDBusMethodTable introspect_methods[] = {
>>       { }
>>  };
>>
>> +static DBusMessage *properties_get(DBusConnection *connection,
>> +                                     DBusMessage *message, void *user_data)
>> +{
>> +     return NULL;
>> +}
>> +
>> +static DBusMessage *properties_get_all(DBusConnection *connection,
>> +                                     DBusMessage *message, void *user_data)
>> +{
>> +     return NULL;
>> +}
>> +
>> +static DBusMessage *properties_set(DBusConnection *connection,
>> +                                     DBusMessage *message, void *user_data)
>> +{
>> +     return NULL;
>> +}
>> +
>> +static const GDBusMethodTable properties_methods[] = {
>> +     { GDBUS_METHOD("Get",
>> +                     GDBUS_ARGS({ "interface_name", "s" },
>> +                                             { "property_name", "s" }),
>
> this should be "interface" and "name". Why are we so verbose here?

I put the same name as in spec:
http://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-properties

>
>> +                     GDBUS_ARGS({ "value", "v" }),
>> +                     properties_get) },
>> +     { GDBUS_METHOD("Set", NULL,
>> +                     GDBUS_ARGS({ "interface_name", "s" },
>> +                                     { "property_name", "s" },
>> +                                     { "value", "v" }),
>> +                     properties_set) },
>> +     { GDBUS_METHOD("GetAll",
>> +                     GDBUS_ARGS({ "interface_name", "s" }),
>> +                     GDBUS_ARGS({ "props", "a{sv}" }),
>
> And this should be "properties". Here you are trying to be super short.

same here.


should I change or let as is?

Lucas De  Marchi

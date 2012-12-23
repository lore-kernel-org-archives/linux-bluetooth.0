Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1356279010.29264.25.camel@aeonflux>
References: <1356276298-13795-1-git-send-email-luiz.dentz@gmail.com>
	<1356276298-13795-4-git-send-email-luiz.dentz@gmail.com>
	<1356279010.29264.25.camel@aeonflux>
Date: Sun, 23 Dec 2012 18:31:49 +0200
Message-ID: <CABBYNZJ=cpoaSOk4fvk3Y7pp=vtYyN3Qqwacq6iG6UHBicM5-g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/6] gdbus: Call check_signals when sending signals
 with g_dbus_send_message
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Dec 23, 2012 at 6:10 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> If message passed to g_dbus_send_message is a signal verify if it is a
>> valid and there really exists an interface with respective signal name.
>> ---
>>  gdbus/object.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/gdbus/object.c b/gdbus/object.c
>> index 510763a..6951171 100644
>> --- a/gdbus/object.c
>> +++ b/gdbus/object.c
>> @@ -1475,6 +1475,15 @@ gboolean g_dbus_send_message(DBusConnection *connection, DBusMessage *message)
>>
>>       if (dbus_message_get_type(message) == DBUS_MESSAGE_TYPE_METHOD_CALL)
>>               dbus_message_set_no_reply(message, TRUE);
>> +     else {
>> +             const char *path = dbus_message_get_path(message);
>> +             const char *interface = dbus_message_get_interface(message);
>> +             const char *name = dbus_message_get_member(message);
>> +             const GDBusArgInfo *args;
>> +
>> +             if (!check_signal(connection, path, interface, name, &args))
>> +                     return FALSE;
>> +     }
>
> we have more than just method calls and signals. This could be also used
> used for sending async method returns.

I guess I should do else if and check for signal type then, or you
have a better idea?

--
Luiz Augusto von Dentz

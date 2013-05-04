Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <776BEEA5-8007-4BC5-90CC-7C00E9F61B95@holtmann.org>
References: <1367692601-3578-1-git-send-email-anderson.lizardo@openbossa.org>
	<776BEEA5-8007-4BC5-90CC-7C00E9F61B95@holtmann.org>
Date: Sat, 4 May 2013 15:18:15 -0400
Message-ID: <CAJdJm_On9SMVJzdZUOSoE5H8YS+OFz1ZMWDP9wj8aYC2AWgr4Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gdbus: Fix segfault when D-Bus daemon exits
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, May 4, 2013 at 3:08 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> -     dbus_pending_call_set_notify(call, modify_match_reply, NULL, NULL);
>> -     dbus_pending_call_unref(call);
>> +     if (call != NULL) {
>> +             dbus_pending_call_set_notify(call, modify_match_reply, NULL,
>> +                                                                     NULL);
>> +             dbus_pending_call_unref(call);
>> +     }
>
> If we really have to check then make it a case where we return FALSE and not a success case.
>
>         if (call == NULL) {
>                 dbus_message_unref(msg);
>                 return FALSE;
>
>         }
>
> I still maintain that this should not return NULL and TRUE at the same time. That is just plain stupid.

Unfortunately, it is exactly what D-Bus currently handles this
situation: http://dbus.freedesktop.org/doc/api/html/group__DBusConnection.html#gaa215df7ab7ca6dce7be153c6b9cc80ba

I will invert the logic here like you suggested.

>
> Have you actually seen it crashing with call == NULL?

Yes. After fixing the dbus_message_get_sender() returning NULL issue
above, I got several errors like:

bluetoothd[5712]: plugins/neard.c:neard_exit() Cleanup neard plugin
process 5712: arguments to dbus_pending_call_set_notify() were
incorrect, assertion "pending != NULL" failed in file
../../dbus/dbus-pending-call.c line 596.
This is normally a bug in some application using the D-Bus library.
process 5712: arguments to dbus_pending_call_unref() were incorrect,
assertion "pending != NULL" failed in file
../../dbus/dbus-pending-call.c line 572.
This is normally a bug in some application using the D-Bus library.
...

After some investigation, I found the reason for the NULL "call" on
the documentation.

>>       dbus_message_unref(msg);
>>
>> @@ -1119,6 +1122,8 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
>>               return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
>>
>>       sender = dbus_message_get_sender(message);
>> +     if (sender == NULL)
>> +             return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
>>
>>       if (g_str_equal(sender, DBUS_SERVICE_DBUS) == TRUE) {
>>               const char *interface, *member;
>
> These are two independent fixes. So make it two patches.

Ok, I'll split into two patches. It was the fix above that uncovered
the other "call == NULL" issue.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH BlueZ] gdbus: Fix segfault when D-Bus daemon exits
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJdJm_On9SMVJzdZUOSoE5H8YS+OFz1ZMWDP9wj8aYC2AWgr4Q@mail.gmail.com>
Date: Sat, 4 May 2013 12:26:55 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <76C68397-727A-41D0-98F0-EA2E6E196CF4@holtmann.org>
References: <1367692601-3578-1-git-send-email-anderson.lizardo@openbossa.org> <776BEEA5-8007-4BC5-90CC-7C00E9F61B95@holtmann.org> <CAJdJm_On9SMVJzdZUOSoE5H8YS+OFz1ZMWDP9wj8aYC2AWgr4Q@mail.gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

>>> -     dbus_pending_call_set_notify(call, modify_match_reply, NULL, NULL);
>>> -     dbus_pending_call_unref(call);
>>> +     if (call != NULL) {
>>> +             dbus_pending_call_set_notify(call, modify_match_reply, NULL,
>>> +                                                                     NULL);
>>> +             dbus_pending_call_unref(call);
>>> +     }
>> 
>> If we really have to check then make it a case where we return FALSE and not a success case.
>> 
>>        if (call == NULL) {
>>                dbus_message_unref(msg);
>>                return FALSE;
>> 
>>        }
>> 
>> I still maintain that this should not return NULL and TRUE at the same time. That is just plain stupid.
> 
> Unfortunately, it is exactly what D-Bus currently handles this
> situation: http://dbus.freedesktop.org/doc/api/html/group__DBusConnection.html#gaa215df7ab7ca6dce7be153c6b9cc80ba
> 
> I will invert the logic here like you suggested.
> 
>> 
>> Have you actually seen it crashing with call == NULL?
> 
> Yes. After fixing the dbus_message_get_sender() returning NULL issue
> above, I got several errors like:
> 
> bluetoothd[5712]: plugins/neard.c:neard_exit() Cleanup neard plugin
> process 5712: arguments to dbus_pending_call_set_notify() were
> incorrect, assertion "pending != NULL" failed in file
> ../../dbus/dbus-pending-call.c line 596.
> This is normally a bug in some application using the D-Bus library.
> process 5712: arguments to dbus_pending_call_unref() were incorrect,
> assertion "pending != NULL" failed in file
> ../../dbus/dbus-pending-call.c line 572.
> This is normally a bug in some application using the D-Bus library.
> ...
> 
> After some investigation, I found the reason for the NULL "call" on
> the documentation.

that is utterly stupidity in the D-Bus API. Either something succeeds or it fails. Not it half succeeds and we send the message, but hey, you have no chance of tracking it.

It is really time that libdbus gets replaced.

Regards

Marcel


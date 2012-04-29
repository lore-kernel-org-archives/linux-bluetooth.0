Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLOF5TTU+oey-bRY-z-orXWndfmKiN81QbkqFaHXboZ4Q@mail.gmail.com>
References: <1335561922-3518-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1335561922-3518-4-git-send-email-lucas.demarchi@profusion.mobi> <CABBYNZLOF5TTU+oey-bRY-z-orXWndfmKiN81QbkqFaHXboZ4Q@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Sun, 29 Apr 2012 18:38:01 -0300
Message-ID: <CAMOw1v6iqa74-r7-WzMj=jOOCS8rrHaFt+tfK1Rxx44WXZM1xQ@mail.gmail.com>
Subject: Re: [BlueZ RFC 3/5] gdbus: implement DBus.Properties.GetAll method
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Apr 29, 2012 at 8:22 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lucas,
>
> On Sat, Apr 28, 2012 at 12:25 AM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>> +               if (p->exists != NULL && !p->exists(p, iface->user_data))
>> +                       continue;
>> +
>> +               dbus_message_iter_open_container(&dict, DBUS_TYPE_DICT_ENTRY,
>> +                                                               NULL, &entry);
>> +               dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
>> +                                                               p->name);
>> +               dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
>> +                                                       p->type, &value);
>> +
>> +               if (!p->get(connection, message, p, &value, iface->user_data)) {
>> +                       dbus_message_iter_abandon_container(&entry, &value);
>> +                       dbus_message_iter_abandon_container(&dict, &entry);
>> +                       dbus_message_unref(reply);
>> +                       return NULL;
>> +               }
>
> I would do this a little different, make the callback return the value
> (void *) so you don't even need to create any container if it returns
> NULL, if the value is set then you create the container and use the
> registered type to add the value to the container, obviously this is
> limited to values that doesn't require another container but IMO that
> should not be the case of any of our properties.

Yeah, I thought about that. But as you said it's limited to the basic
types. See the example Henrique sent for "ao". And there's the more
difficult one: a property that is a dictionary.

To cover these more complicated cases, we would need to check if it's
a property with basic signature and act differently based on that.


Lucas De Marchi

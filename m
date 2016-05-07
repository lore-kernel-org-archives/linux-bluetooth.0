Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth\@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/4] doc/gatt-api: Add options dictionary to ReadValue/WriteValue
In-Reply-To: <CABBYNZ+g+aHGEe-NDVgtzsHQ0N+4YEgkF9MvoQX_hXSsmjgpdg@mail.gmail.com>
References: <1462561862-500-1-git-send-email-luiz.dentz@gmail.com> <87zis2espf.fsf@intel.com> <CABBYNZ+g+aHGEe-NDVgtzsHQ0N+4YEgkF9MvoQX_hXSsmjgpdg@mail.gmail.com>
Date: Sat, 07 May 2016 16:57:49 -0300
Message-ID: <87vb2pej42.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:

>>> +static int parse_options(DBusMessage *msg, uint16_t *offset)
>>> +{
>>> +     DBusMessageIter args, flags;
>>> +
>>> +     if (!dbus_message_iter_init(msg, &args))
>>> +             return -EINVAL;
>>> +
>>> +     if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_ARRAY)
>>> +             return -EINVAL;
>>> +
>>> +     dbus_message_iter_recurse(&args, &flags);
>>> +     if (dbus_message_iter_get_arg_type(&flags) != DBUS_TYPE_DICT_ENTRY)
>>> +             return -EINVAL;
>>> +
>>
>> I would think that from the documentation, "Possible options", that providing
>> the offset would be optional. I don't think much is gained making this mandatory.
>
> I guess you are referring to empty array, so yes we should probably
> drop the check for dict entry so it can be empty since it is optional.
>

I was thinking that a ReadValue() message without any arguments would
make sense to be valid. And one less thing to change in applications if
they don't need the offset.

>>> +     while (dbus_message_iter_get_arg_type(&flags) == DBUS_TYPE_DICT_ENTRY) {
>>> +             const char *key;
>>> +             DBusMessageIter value, entry;
>>> +             int var;
>>> +
>>> +             dbus_message_iter_recurse(&flags, &entry);
>>> +             dbus_message_iter_get_basic(&entry, &key);
>>> +
>>> +             dbus_message_iter_next(&entry);
>>> +             dbus_message_iter_recurse(&entry, &value);
>>> +
>>> +             var = dbus_message_iter_get_arg_type(&value);
>>> +             if (strcasecmp(key, "offset") == 0) {
>>> +                     if (var != DBUS_TYPE_UINT16)
>>> +                             return -EINVAL;
>>> +                     dbus_message_iter_get_basic(&value, offset);
>>> +             }
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>
>>
>> Cheers,
>> --
>> Vinicius
>
>
>
> --
> Luiz Augusto von Dentz


Cheers,
--
Vinicius

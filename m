Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87vb2pej42.fsf@intel.com>
References: <1462561862-500-1-git-send-email-luiz.dentz@gmail.com>
	<87zis2espf.fsf@intel.com>
	<CABBYNZ+g+aHGEe-NDVgtzsHQ0N+4YEgkF9MvoQX_hXSsmjgpdg@mail.gmail.com>
	<87vb2pej42.fsf@intel.com>
Date: Sun, 8 May 2016 16:54:58 +0300
Message-ID: <CABBYNZKMehTW-DvHp+Z79GVt-gJ4HT+Jvd8U0kHscygcr1PV7w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] doc/gatt-api: Add options dictionary to ReadValue/WriteValue
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Sat, May 7, 2016 at 10:57 PM, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
> Hi Luiz,
>
> Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:
>
>>>> +static int parse_options(DBusMessage *msg, uint16_t *offset)
>>>> +{
>>>> +     DBusMessageIter args, flags;
>>>> +
>>>> +     if (!dbus_message_iter_init(msg, &args))
>>>> +             return -EINVAL;
>>>> +
>>>> +     if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_ARRAY)
>>>> +             return -EINVAL;
>>>> +
>>>> +     dbus_message_iter_recurse(&args, &flags);
>>>> +     if (dbus_message_iter_get_arg_type(&flags) != DBUS_TYPE_DICT_ENTRY)
>>>> +             return -EINVAL;
>>>> +
>>>
>>> I would think that from the documentation, "Possible options", that providing
>>> the offset would be optional. I don't think much is gained making this mandatory.
>>
>> I guess you are referring to empty array, so yes we should probably
>> drop the check for dict entry so it can be empty since it is optional.
>>
>
> I was thinking that a ReadValue() message without any arguments would
> make sense to be valid. And one less thing to change in applications if
> they don't need the offset.

We can't do that because D-Bus doesn't support method overloading thus
the signature must be a{sv}, but it can be an empty container so we
would default to offset 0 as it is currently.


Luiz Augusto von Dentz

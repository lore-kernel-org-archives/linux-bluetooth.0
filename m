Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJPnLWtHbYRQp3twtd=kuuB6wMARU96QwDWncunJjHUBQ@mail.gmail.com>
References: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1312568132-21112-11-git-send-email-lucas.demarchi@profusion.mobi> <CABBYNZJPnLWtHbYRQp3twtd=kuuB6wMARU96QwDWncunJjHUBQ@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 8 Aug 2011 11:03:23 -0300
Message-ID: <CAMOw1v4=qQx_MCpwBxj1CjGQEDACR_+FDTvSe09uQnFWRk_0Ww@mail.gmail.com>
Subject: Re: [PATCH 11/23] avrcp: handle SetPlayerApplicationSettingValue pdu
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Aug 8, 2011 at 5:31 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lucas,
>
> On Fri, Aug 5, 2011 at 9:15 PM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>> +static void append_variant(DBusMessageIter *iter, int type, void *val)
>> +{
>> +       DBusMessageIter value;
>> +       char sig[2] = { type, '\0' };
>> +
>> +       dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT, sig, &value);
>> +
>> +       dbus_message_iter_append_basic(&value, type, val);
>> +
>> +       dbus_message_iter_close_container(iter, &value);
>> +}
>
> There should be possible to use dict_append_entry(src/dbus-common.h)
> here, isn't it?

No, because it's not a dict (see that dict_append_entry calls
dbus_message_iter_open_container() ).

I could create a method for this in dbus-common, so it'd be useful for
others. What do you think?


Lucas De Marchi

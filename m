Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJPnLWtHbYRQp3twtd=kuuB6wMARU96QwDWncunJjHUBQ@mail.gmail.com>
References: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1312568132-21112-11-git-send-email-lucas.demarchi@profusion.mobi> <CABBYNZJPnLWtHbYRQp3twtd=kuuB6wMARU96QwDWncunJjHUBQ@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 8 Aug 2011 15:58:15 -0300
Message-ID: <CAMOw1v5tORbGzZ+hVp1j98MbuMKhc89gjDE+AAc-s9+PSJtMBQ@mail.gmail.com>
Subject: Re: [PATCH 11/23] avrcp: handle SetPlayerApplicationSettingValue pdu
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

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
>
>> +static dbus_bool_t emit_setting_changed(DBusConnection *conn,
>> +                                               const char *path,
>> +                                               const char *interface,
>> +                                               const char *name,
>> +                                               int type, void *value)
>> +{
>> +       DBusMessage *signal;
>> +       DBusMessageIter iter;
>> +
>> +       signal = dbus_message_new_signal(path, interface, "SettingChanged");
>> +
>> +       if (!signal) {
>> +               error("Unable to allocate new %s.SettingChanged signal",
>> +                               interface);
>> +               return FALSE;
>> +       }
>> +
>> +       dbus_message_iter_init_append(signal, &iter);
>> +
>> +       dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &name);
>> +
>> +       append_variant(&iter, type, value);
>> +
>> +       return g_dbus_send_message(conn, signal);
>> +}
>> +
>
> I wonder if the settings cannot use PropertyChanged instead?

If I use PropertyChanged, I can use emit_property_changed(). Then I
don't need this method. I'll do it, thanks.


Lucas De Marchi

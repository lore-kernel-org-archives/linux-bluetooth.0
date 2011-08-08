Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1312568132-21112-11-git-send-email-lucas.demarchi@profusion.mobi>
References: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1312568132-21112-11-git-send-email-lucas.demarchi@profusion.mobi>
Date: Mon, 8 Aug 2011 11:31:30 +0300
Message-ID: <CABBYNZJPnLWtHbYRQp3twtd=kuuB6wMARU96QwDWncunJjHUBQ@mail.gmail.com>
Subject: Re: [PATCH 11/23] avrcp: handle SetPlayerApplicationSettingValue pdu
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Fri, Aug 5, 2011 at 9:15 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> +static void append_variant(DBusMessageIter *iter, int type, void *val)
> +{
> +       DBusMessageIter value;
> +       char sig[2] = { type, '\0' };
> +
> +       dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT, sig, &value);
> +
> +       dbus_message_iter_append_basic(&value, type, val);
> +
> +       dbus_message_iter_close_container(iter, &value);
> +}

There should be possible to use dict_append_entry(src/dbus-common.h)
here, isn't it?

> +static dbus_bool_t emit_setting_changed(DBusConnection *conn,
> +                                               const char *path,
> +                                               const char *interface,
> +                                               const char *name,
> +                                               int type, void *value)
> +{
> +       DBusMessage *signal;
> +       DBusMessageIter iter;
> +
> +       signal = dbus_message_new_signal(path, interface, "SettingChanged");
> +
> +       if (!signal) {
> +               error("Unable to allocate new %s.SettingChanged signal",
> +                               interface);
> +               return FALSE;
> +       }
> +
> +       dbus_message_iter_init_append(signal, &iter);
> +
> +       dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &name);
> +
> +       append_variant(&iter, type, value);
> +
> +       return g_dbus_send_message(conn, signal);
> +}
> +

I wonder if the settings cannot use PropertyChanged instead?

-- 
Luiz Augusto von Dentz

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1335561922-3518-4-git-send-email-lucas.demarchi@profusion.mobi>
References: <1335561922-3518-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1335561922-3518-4-git-send-email-lucas.demarchi@profusion.mobi>
Date: Sun, 29 Apr 2012 14:22:27 +0300
Message-ID: <CABBYNZLOF5TTU+oey-bRY-z-orXWndfmKiN81QbkqFaHXboZ4Q@mail.gmail.com>
Subject: Re: [BlueZ RFC 3/5] gdbus: implement DBus.Properties.GetAll method
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Sat, Apr 28, 2012 at 12:25 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> +               if (p->exists != NULL && !p->exists(p, iface->user_data))
> +                       continue;
> +
> +               dbus_message_iter_open_container(&dict, DBUS_TYPE_DICT_ENTRY,
> +                                                               NULL, &entry);
> +               dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
> +                                                               p->name);
> +               dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
> +                                                       p->type, &value);
> +
> +               if (!p->get(connection, message, p, &value, iface->user_data)) {
> +                       dbus_message_iter_abandon_container(&entry, &value);
> +                       dbus_message_iter_abandon_container(&dict, &entry);
> +                       dbus_message_unref(reply);
> +                       return NULL;
> +               }

I would do this a little different, make the callback return the value
(void *) so you don't even need to create any container if it returns
NULL, if the value is set then you create the container and use the
registered type to add the value to the container, obviously this is
limited to values that doesn't require another container but IMO that
should not be the case of any of our properties.


-- 
Luiz Augusto von Dentz

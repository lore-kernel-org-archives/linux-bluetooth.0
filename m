Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1354195173-12750-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1354195173-12750-1-git-send-email-lucas.demarchi@profusion.mobi>
Date: Thu, 29 Nov 2012 15:33:03 +0200
Message-ID: <CABBYNZJVfiD36XrnNyn-5i5MqcOi-LKJ3QMREC6E+XpC9+1CyQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] gdbus: Don't register DBus.Properties with no properties
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Nov 29, 2012 at 3:19 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> Delay registering DBus.Properties interface until the moment there are
> properties on that path. This is needed for objects that currently don't
> expose any property to not export the interface.
> ---
>  gdbus/object.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/gdbus/object.c b/gdbus/object.c
> index 3101ca6..47116bd 100644
> --- a/gdbus/object.c
> +++ b/gdbus/object.c
> @@ -1213,9 +1213,6 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
>                                         manager_methods, manager_signals,
>                                         NULL, data, NULL);
>
> -       add_interface(data, DBUS_INTERFACE_PROPERTIES, properties_methods,
> -                                       properties_signals, NULL, data, NULL);
> -
>         return data;
>  }
>
> @@ -1336,6 +1333,12 @@ gboolean g_dbus_register_interface(DBusConnection *connection,
>                 return FALSE;
>         }
>
> +       if (properties != NULL && !find_interface(data->interfaces,
> +                                               DBUS_INTERFACE_PROPERTIES))
> +               add_interface(data, DBUS_INTERFACE_PROPERTIES,
> +                               properties_methods, properties_signals, NULL,
> +                               data, NULL);
> +
>         add_interface(data, name, methods, signals, properties, user_data,
>                                                                 destroy);
>
> --
> 1.8.0.1

Ack


--
Luiz Augusto von Dentz

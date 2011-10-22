Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1319219908-2819-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1319219908-2819-1-git-send-email-lucas.demarchi@profusion.mobi>
Date: Sat, 22 Oct 2011 13:09:16 +0300
Message-ID: <CABBYNZKi0XO1XNehK0MtW=vBSRfF4oz9jfqwohEQzWe8ibbkLw@mail.gmail.com>
Subject: Re: [PATCH 1/5] Fix handling of dbus signals
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Fri, Oct 21, 2011 at 8:58 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> We're previously leaking a D-Bus message and always returning that
> the signal was not handled.
> ---
>  test/mpris-player.c |   16 +++++++++++-----
>  1 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/test/mpris-player.c b/test/mpris-player.c
> index 29bea46..4592e5d 100644
> --- a/test/mpris-player.c
> +++ b/test/mpris-player.c
> @@ -549,7 +549,7 @@ static DBusHandlerResult properties_changed(DBusConnection *conn,
>        if (!signal) {
>                fprintf(stderr, "Unable to allocate new PropertyChanged"
>                                                        " signal\n");
> -               goto done;
> +               goto err;
>        }
>
>        dbus_message_iter_init_append(signal, &entry);
> @@ -563,13 +563,19 @@ static DBusHandlerResult properties_changed(DBusConnection *conn,
>        dbus_message_iter_next(&iter);
>
>        if (parse_metadata(&iter, &metadata) < 0)
> -               goto done;
> +               goto err;
>
>        dbus_message_iter_close_container(&entry, &metadata);
>
>        dbus_connection_send(sys, signal, NULL);
> +       dbus_message_unref(signal);
> +       g_free(path);
>
> -done:
> +       return DBUS_HANDLER_RESULT_HANDLED;
> +
> +err:
> +       if (signal)
> +               dbus_message_unref(signal);
>        g_free(path);
>        return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
>  }
> @@ -607,7 +613,7 @@ static DBusHandlerResult session_filter(DBusConnection *conn,
>                add_player(conn, name, new);
>        }
>
> -       return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
> +       return DBUS_HANDLER_RESULT_HANDLED;
>  }
>
>  static DBusHandlerResult system_filter(DBusConnection *conn,
> @@ -633,7 +639,7 @@ static DBusHandlerResult system_filter(DBusConnection *conn,
>                __io_terminated = 1;
>        }
>
> -       return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
> +       return DBUS_HANDLER_RESULT_HANDLED;
>  }
>
>  static char *get_default_adapter(DBusConnection *conn)
> --
> 1.7.7
>
> --

Ack.


-- 
Luiz Augusto von Dentz

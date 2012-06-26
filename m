Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1340639082-10347-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <CABBYNZ+oS3tGhYVY01uE6gfuzmA94TqV3YybgHdG83pCMzW8vA@mail.gmail.com>
	<1340639082-10347-1-git-send-email-lucas.demarchi@profusion.mobi>
Date: Tue, 26 Jun 2012 10:45:39 +0300
Message-ID: <CABBYNZJk3d3CPLD8TVSnrve_yE9rbn1Ec9OdxPF2eXnGFz1EdA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] gdbus: Fix removal of filter after last filter_data
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Mon, Jun 25, 2012 at 6:44 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> If there's a signal watch that's also watching for name
> (data->name_watch) currently we are trying to remove the message_filter
> twice since we may have the following call chain:
>
> filter_data_remove_callback()
>  filter_data_free()
>    g_dbus_remove_watch()
>      filter_data_remove_callback()
>        filter_data_free()
>        dbus_connection_remove_filter()
>  dbus_connection_remove_filter()
>
> Because of this we can't currently watch for signals passing the bus
> name. After this patch we don't have this issue anymore.
>
> We fix it by removing the filter before calling filter_data_free() if we
> are the last filter_data and thus avoid calling
> dbus_connection_remove_filter() twice.
> ---
>  gdbus/watch.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/gdbus/watch.c b/gdbus/watch.c
> index 9a716b0..d749176 100644
> --- a/gdbus/watch.c
> +++ b/gdbus/watch.c
> @@ -376,15 +376,14 @@ static gboolean filter_data_remove_callback(struct filter_data *data,
>
>        connection = dbus_connection_ref(data->connection);
>        listeners = g_slist_remove(listeners, data);
> -       filter_data_free(data);
>
>        /* Remove filter if there are no listeners left for the connection */
> -       data = filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
> -                                       NULL);
> -       if (data == NULL)
> +       if (filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
> +                                                               NULL) == NULL)
>                dbus_connection_remove_filter(connection, message_filter,
>                                                NULL);
>
> +       filter_data_free(data);
>        dbus_connection_unref(connection);
>
>        return TRUE;
> @@ -537,15 +536,15 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
>        remove_match(data);
>
>        listeners = g_slist_remove(listeners, data);
> -       filter_data_free(data);
>
> -       /* Remove filter if there no listener left for the connection */
> -       data = filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
> -                                       NULL);
> -       if (data == NULL)
> +       /* Remove filter if there are no listeners left for the connection */
> +       if (filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
> +                                                               NULL) == NULL)
>                dbus_connection_remove_filter(connection, message_filter,
>                                                NULL);
>
> +       filter_data_free(data);
> +
>        return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
>  }
>
> --
> 1.7.11

Ack.

-- 
Luiz Augusto von Dentz

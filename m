Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1340460137-4279-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1340460137-4279-1-git-send-email-lucas.demarchi@profusion.mobi>
Date: Mon, 25 Jun 2012 11:51:02 +0300
Message-ID: <CABBYNZJ9UAFcQ5qBMduZkufap+zLc_C2iB2kxsHJ3Qx6HaPEjg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gdbus: Fix removal of filter after last filter_data
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Sat, Jun 23, 2012 at 5:02 PM, Lucas De Marchi
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
> We fix this by checking if we are the last filter_data before calling
> filter_data_free and thus not calling dbus_connection_remove_filter()
> twice.
> ---
>  gdbus/watch.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/gdbus/watch.c b/gdbus/watch.c
> index 9a716b0..6fed264 100644
> --- a/gdbus/watch.c
> +++ b/gdbus/watch.c
> @@ -350,6 +350,7 @@ static gboolean filter_data_remove_callback(struct filter_data *data,
>                                                struct filter_callback *cb)
>  {
>        DBusConnection *connection;
> +       struct filter_data *data_next;
>
>        data->callbacks = g_slist_remove(data->callbacks, cb);
>        data->processed = g_slist_remove(data->processed, cb);
> @@ -376,12 +377,17 @@ static gboolean filter_data_remove_callback(struct filter_data *data,
>
>        connection = dbus_connection_ref(data->connection);
>        listeners = g_slist_remove(listeners, data);
> +
> +       /*
> +        * filter_data_free() may remove the latest data - we need to check
> +        * before it runs if it's our duty to remove the filter
> +        */
> +       data_next = filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
> +                                                                       NULL);
>        filter_data_free(data);
>
>        /* Remove filter if there are no listeners left for the connection */
> -       data = filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
> -                                       NULL);
> -       if (data == NULL)
> +       if (data_next == NULL)
>                dbus_connection_remove_filter(connection, message_filter,
>                                                NULL);
>
> --
> 1.7.11

Hmm do you have checks enabled in libdbus? It seems this is cause by:

#ifndef DBUS_DISABLE_CHECKS
  if (filter == NULL)
    {
      _dbus_warn_check_failed ("Attempt to remove filter function %p
user data %p, but no such filter has been added\n",
                               function, user_data);
      return;
    }
#endif

Anyway I couldn't reproduce by changing ofono with stock libdbus from
FC 17, although I see the problem just by looking at the code, but
there other places where this need to be checked as well and the code
could be simplified:

diff --git a/gdbus/watch.c b/gdbus/watch.c
index 9a716b0..d749176 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -376,15 +376,14 @@ static gboolean
filter_data_remove_callback(struct filter_data *data,

 	connection = dbus_connection_ref(data->connection);
 	listeners = g_slist_remove(listeners, data);
-	filter_data_free(data);

 	/* Remove filter if there are no listeners left for the connection */
-	data = filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
-					NULL);
-	if (data == NULL)
+	if (filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
+								NULL) == NULL)
 		dbus_connection_remove_filter(connection, message_filter,
 						NULL);

+	filter_data_free(data);
 	dbus_connection_unref(connection);

 	return TRUE;
@@ -537,15 +536,15 @@ static DBusHandlerResult
message_filter(DBusConnection *connection,
 	remove_match(data);

 	listeners = g_slist_remove(listeners, data);
-	filter_data_free(data);

-	/* Remove filter if there no listener left for the connection */
-	data = filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
-					NULL);
-	if (data == NULL)
+	/* Remove filter if there are no listeners left for the connection */
+	if (filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
+								NULL) == NULL)
 		dbus_connection_remove_filter(connection, message_filter,
 						NULL);

+	filter_data_free(data);
+
 	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 }

-- 
Luiz Augusto von Dentz

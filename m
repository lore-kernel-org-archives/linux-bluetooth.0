Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1448975492.2240.83.camel@linux.intel.com>
References: <1448975492.2240.83.camel@linux.intel.com>
Date: Fri, 4 Dec 2015 14:31:12 +0200
Message-ID: <CACumGO+6VJQ-O3Y2npOcd41yQJa4c_f1C4193tvCMTj-OUY5gQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] gdbus: Fix Memory Leak
From: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
To: Patrik Flykt <Patrik.Flykt@linux.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"saurav.babu" <saurav.babu@samsung.com>,
	connman <connman@lists.01.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Dec 1, 2015 at 3:11 PM, Patrik Flykt
<Patrik.Flykt@linux.intel.com> wrote:
> From: Saurav Babu <saurav.babu@samsung.com>
>
> Members of data are allocated memory but not freed only data is freed
> ---
>
>         Hi,
>
> This patch came up on the ConnMan mailing list, applies to Bluez too.
>
>         Patrik
>
>
>  gdbus/watch.c | 50 +++++++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/gdbus/watch.c b/gdbus/watch.c
> index b60f650..447e486 100644
> --- a/gdbus/watch.c
> +++ b/gdbus/watch.c
> @@ -204,6 +204,30 @@ static gboolean remove_match(struct filter_data *data)
>         return TRUE;
>  }
>
> +static void filter_data_free(struct filter_data *data)
> +{
> +       GSList *l;
> +
> +       /* Remove filter if there are no listeners left for the connection */
> +       if (filter_data_find(data->connection) == NULL)
> +               dbus_connection_remove_filter(data->connection, message_filter,
> +                                                                       NULL);
> +
> +       for (l = data->callbacks; l != NULL; l = l->next)
> +               g_free(l->data);
> +
> +       g_slist_free(data->callbacks);
> +       g_dbus_remove_watch(data->connection, data->name_watch);
> +       g_free(data->name);
> +       g_free(data->owner);
> +       g_free(data->path);
> +       g_free(data->interface);
> +       g_free(data->member);
> +       g_free(data->argument);
> +       dbus_connection_unref(data->connection);
> +       g_free(data);
> +}
> +
>  static struct filter_data *filter_data_get(DBusConnection *connection,
>                                         DBusHandleMessageFunction filter,
>                                         const char *sender,
> @@ -248,7 +272,7 @@ proceed:
>         data->argument = g_strdup(argument);
>
>         if (!add_match(data, filter)) {
> -               g_free(data);
> +               filter_data_free(data);
>                 return NULL;
>         }
>
> @@ -277,30 +301,6 @@ static struct filter_callback *filter_data_find_callback(
>         return NULL;
>  }
>
> -static void filter_data_free(struct filter_data *data)
> -{
> -       GSList *l;
> -
> -       /* Remove filter if there are no listeners left for the connection */
> -       if (filter_data_find(data->connection) == NULL)
> -               dbus_connection_remove_filter(data->connection, message_filter,
> -                                                                       NULL);
> -
> -       for (l = data->callbacks; l != NULL; l = l->next)
> -               g_free(l->data);
> -
> -       g_slist_free(data->callbacks);
> -       g_dbus_remove_watch(data->connection, data->name_watch);
> -       g_free(data->name);
> -       g_free(data->owner);
> -       g_free(data->path);
> -       g_free(data->interface);
> -       g_free(data->member);
> -       g_free(data->argument);
> -       dbus_connection_unref(data->connection);
> -       g_free(data);
> -}
> -
>  static void filter_data_call_and_free(struct filter_data *data)
>  {
>         GSList *l;
> --
> 1.9.1

This has been applied to BlueZ.

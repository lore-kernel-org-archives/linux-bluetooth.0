Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170915083916.27456-1-luiz.dentz@gmail.com>
References: <20170915083916.27456-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 Sep 2017 12:23:20 +0300
Message-ID: <CABBYNZKdRqeeYNm54=Z-qgZi6o97FrovVs-YzwMiEr5nqjPYiQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] adapter: Fix not waiting for start discovery result
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Sep 15, 2017 at 11:39 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> We should not reply until the start discovery completes otherwise
> clients may attempt to stop the discovery before it even has started.
>
> On top of this it will now block clients so they so not be able to
> queue more requests.
> ---
>  src/adapter.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 64 insertions(+), 8 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index a571b1870..9a8b32066 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -160,6 +160,7 @@ struct discovery_filter {
>
>  struct watch_client {
>         struct btd_adapter *adapter;
> +       DBusMessage *msg;
>         char *owner;
>         guint watch;
>         struct discovery_filter *discovery_filter;
> @@ -1421,13 +1422,34 @@ static void start_discovery_complete(uint8_t status, uint16_t length,
>                                         const void *param, void *user_data)
>  {
>         struct btd_adapter *adapter = user_data;
> +       struct watch_client *client = adapter->discovery_list->data;
>         const struct mgmt_cp_start_discovery *rp = param;
> +       DBusMessage *reply;
>
>         DBG("status 0x%02x", status);
>
> +       /* Is there are no clients the discovery must have been stopped while
> +        * discovery command was pending.
> +        */
> +       if (!client) {
> +               struct mgmt_cp_stop_discovery cp;
> +
> +               if (status != MGMT_STATUS_SUCCESS)
> +                       return;
> +
> +               /* Stop discovering as there are no clients left */
> +               cp.type = rp->type;
> +               mgmt_send(adapter->mgmt, MGMT_OP_STOP_DISCOVERY,
> +                                       adapter->dev_id, sizeof(cp), &cp,
> +                                       NULL, NULL, NULL);
> +               return;
> +       }
> +
>         if (length < sizeof(*rp)) {
>                 btd_error(adapter->dev_id,
>                         "Wrong size of start discovery return parameters");
> +               if (client->msg)
> +                       goto fail;
>                 return;
>         }
>
> @@ -1440,6 +1462,14 @@ static void start_discovery_complete(uint8_t status, uint16_t length,
>                 else
>                         adapter->filtered_discovery = false;
>
> +               if (client->msg) {
> +                       reply = g_dbus_create_reply(client->msg,
> +                                                       DBUS_TYPE_INVALID);
> +                       g_dbus_send_message(dbus_conn, reply);
> +                       dbus_message_unref(client->msg);
> +                       client->msg = NULL;
> +               }
> +
>                 if (adapter->discovering)
>                         return;
>
> @@ -1449,6 +1479,15 @@ static void start_discovery_complete(uint8_t status, uint16_t length,
>                 return;
>         }
>
> +fail:
> +       /* Reply with an error if the first discovery has failed */
> +       if (client->msg) {
> +               reply = btd_error_busy(client->msg);
> +               g_dbus_send_message(dbus_conn, reply);
> +               g_dbus_remove_watch(dbus_conn, client->watch);
> +               return;
> +       }
> +
>         /*
>          * In case the restart of the discovery failed, then just trigger
>          * it for the next idle timeout again.
> @@ -1933,7 +1972,7 @@ static bool filters_equal(struct mgmt_cp_start_service_discovery *a,
>         return true;
>  }
>
> -static void update_discovery_filter(struct btd_adapter *adapter)
> +static int update_discovery_filter(struct btd_adapter *adapter)
>  {
>         struct mgmt_cp_start_service_discovery *sd_cp;
>
> @@ -1942,7 +1981,7 @@ static void update_discovery_filter(struct btd_adapter *adapter)
>         if (discovery_filter_to_mgmt_cp(adapter, &sd_cp)) {
>                 btd_error(adapter->dev_id,
>                                 "discovery_filter_to_mgmt_cp returned error");
> -               return;
> +               return -ENOMEM;
>         }
>
>         /*
> @@ -1953,13 +1992,15 @@ static void update_discovery_filter(struct btd_adapter *adapter)
>             adapter->discovering != 0) {
>                 DBG("filters were equal, deciding to not restart the scan.");
>                 g_free(sd_cp);
> -               return;
> +               return 0;
>         }
>
>         g_free(adapter->current_discovery_filter);
>         adapter->current_discovery_filter = sd_cp;
>
>         trigger_start_discovery(adapter, 0);
> +
> +       return -EINPROGRESS;
>  }
>
>  static void discovery_destroy(void *user_data)
> @@ -1980,6 +2021,9 @@ static void discovery_destroy(void *user_data)
>                 client->discovery_filter = NULL;
>         }
>
> +       if (client->msg)
> +               dbus_message_unref(client->msg);
> +
>         g_free(client->owner);
>         g_free(client);
>
> @@ -2087,6 +2131,7 @@ static DBusMessage *start_discovery(DBusConnection *conn,
>         const char *sender = dbus_message_get_sender(msg);
>         struct watch_client *client;
>         bool is_discovering;
> +       int err;
>
>         DBG("sender %s", sender);
>
> @@ -2107,12 +2152,14 @@ static DBusMessage *start_discovery(DBusConnection *conn,
>          * and trigger scan.
>          */
>         if (client) {
> +               if (client->msg)
> +                       return btd_error_busy(msg);
> +
>                 adapter->set_filter_list = g_slist_remove(
>                                              adapter->set_filter_list, client);
>                 adapter->discovery_list = g_slist_prepend(
>                                               adapter->discovery_list, client);
> -               update_discovery_filter(adapter);
> -               return dbus_message_new_method_return(msg);
> +               goto done;
>         }
>
>         client = g_new0(struct watch_client, 1);
> @@ -2126,14 +2173,23 @@ static DBusMessage *start_discovery(DBusConnection *conn,
>         adapter->discovery_list = g_slist_prepend(adapter->discovery_list,
>                                                                 client);
>
> +done:
>         /*
>          * Just trigger the discovery here. In case an already running
>          * discovery in idle phase exists, it will be restarted right
>          * away.
>          */
> -       update_discovery_filter(adapter);
> +       err = update_discovery_filter(adapter);
> +       if (!err)
> +               return dbus_message_new_method_return(msg);
>
> -       return dbus_message_new_method_return(msg);
> +       /* If the discovery has to be started wait it complete to reply */
> +       if (err == -EINPROGRESS) {
> +               client->msg = dbus_message_ref(msg);
> +               return NULL;
> +       }
> +
> +       return btd_error_failed(msg, strerror(-err));
>  }
>
>  static bool parse_uuids(DBusMessageIter *value, struct discovery_filter *filter)
> @@ -2984,7 +3040,7 @@ static DBusMessage *get_discovery_filters(DBusConnection *conn,
>  }
>
>  static const GDBusMethodTable adapter_methods[] = {
> -       { GDBUS_METHOD("StartDiscovery", NULL, NULL, start_discovery) },
> +       { GDBUS_ASYNC_METHOD("StartDiscovery", NULL, NULL, start_discovery) },
>         { GDBUS_METHOD("SetDiscoveryFilter",
>                                 GDBUS_ARGS({ "properties", "a{sv}" }), NULL,
>                                 set_discovery_filter) },
> --
> 2.13.5

Pushed.


-- 
Luiz Augusto von Dentz

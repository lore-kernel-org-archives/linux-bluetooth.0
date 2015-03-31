Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1427758340-14949-6-git-send-email-jpawlowski@google.com>
References: <1427758340-14949-1-git-send-email-jpawlowski@google.com>
	<1427758340-14949-6-git-send-email-jpawlowski@google.com>
Date: Mon, 30 Mar 2015 18:26:57 -0700
Message-ID: <CAHrH25QJyWLWWEzObuOVvGuUQpOoH+sxb+qCnt0E_-1OfiJjoQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] core: adapter: start proper discovery depending on
 filter type
From: Arman Uguray <armansito@chromium.org>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> On Mon, Mar 30, 2015 at 4:32 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> This patch implement starting and updating filtered discovery,
> depending on kind of filters used by each client. It also removes
> iddle timeout for filtered scans, to make sure that this kind of
> scan will run continuously.
> ---
>  src/adapter.c | 291 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 269 insertions(+), 22 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 166e74e..67db99c 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -93,6 +93,7 @@
>  #define SCAN_TYPE_LE ((1 << BDADDR_LE_PUBLIC) | (1 << BDADDR_LE_RANDOM))
>  #define SCAN_TYPE_DUAL (SCAN_TYPE_BREDR | SCAN_TYPE_LE)
>
> +#define        HCI_RSSI_INVALID        127
>  #define        DISTANCE_VAL_INVALID    0x7FFF
>  #define        PATHLOSS_MAX 137
>
> @@ -206,6 +207,9 @@ struct btd_adapter {
>         char *stored_alias;             /* stored adapter name alias */
>
>         bool discovering;               /* discovering property state */
> +       bool filtered_discovery;        /* we are doing filtered discovery */
> +       bool no_scan_restart_delay;     /* when this flag is set, restart scan
> +                                        * without delay */
>         uint8_t discovery_type;         /* current active discovery type */
>         uint8_t discovery_enable;       /* discovery enabled/disabled */
>         bool discovery_suspended;       /* discovery has been suspended */
> @@ -213,6 +217,9 @@ struct btd_adapter {
>         GSList *set_filter_list;        /* list of clients that specified
>                                          * filter, but don't scan yet
>                                          */
> +       /* current discovery filter, if any */
> +       struct mgmt_cp_start_service_discovery *current_discovery_filter;
> +
>         GSList *discovery_found;        /* list of found devices */
>         guint discovery_idle_timeout;   /* timeout between discovery runs */
>         guint passive_scan_timeout;     /* timeout between passive scans */
> @@ -1390,6 +1397,11 @@ static void start_discovery_complete(uint8_t status, uint16_t length,
>                 adapter->discovery_type = rp->type;
>                 adapter->discovery_enable = 0x01;
>
> +               if (adapter->current_discovery_filter)
> +                       adapter->filtered_discovery = true;
> +               else
> +                       adapter->filtered_discovery = false;
> +
>                 if (adapter->discovering)
>                         return;
>
> @@ -1409,21 +1421,32 @@ static void start_discovery_complete(uint8_t status, uint16_t length,
>  static gboolean start_discovery_timeout(gpointer user_data)
>  {
>         struct btd_adapter *adapter = user_data;
> -       struct mgmt_cp_start_discovery cp;
> +       struct mgmt_cp_start_service_discovery *sd_cp;
>         uint8_t new_type;
>
>         DBG("");
>
>         adapter->discovery_idle_timeout = 0;
>
> +       /* If we're doing filtered discovery, it must be quickly restarted */
> +       adapter->no_scan_restart_delay = !!adapter->current_discovery_filter;
> +
> +       DBG("adapter->current_discovery_filter == %d",
> +           !!adapter->current_discovery_filter);
> +
>         new_type = get_scan_type(adapter);
>
>         if (adapter->discovery_enable == 0x01) {
> +               struct mgmt_cp_stop_discovery cp;
> +
>                 /*
> -                * If there is an already running discovery and it has the
> -                * same type, then just keep it.
> +                * If we're asked to start regular discovery, and there is an
> +                *  already running regular discovery and it has the same type,

Remove extra space before 'already'.

> +                * then just keep it.
>                  */
> -               if (adapter->discovery_type == new_type) {
> +               if (!adapter->current_discovery_filter &&
> +                   !adapter->filtered_discovery &&
> +                   adapter->discovery_type == new_type) {
>                         if (adapter->discovering)
>                                 return FALSE;
>
> @@ -1438,20 +1461,43 @@ static gboolean start_discovery_timeout(gpointer user_data)
>                  * queue up a stop discovery command.
>                  *
>                  * This can happen if a passive scanning for Low Energy
> -                * devices is ongoing.
> +                * devices is ongoing, or scan type is changed between
> +                * regular and filtered, or filter was updated.
>                  */
>                 cp.type = adapter->discovery_type;
> -
>                 mgmt_send(adapter->mgmt, MGMT_OP_STOP_DISCOVERY,
>                                         adapter->dev_id, sizeof(cp), &cp,
>                                         NULL, NULL, NULL);
> +
> +               /* Don't even bother to try to quickly start discovery
> +                * just after stopping it, it would fail with status
> +                * MGMT_BUSY. Instead discovering_callback will take
> +                * care of that.
> +                */
> +               return FALSE;
> +
>         }
>
> -       cp.type = new_type;
> +       /* Regular discovery is required */
> +       if (!adapter->current_discovery_filter) {
> +               struct mgmt_cp_start_discovery cp;
>
> -       mgmt_send(adapter->mgmt, MGMT_OP_START_DISCOVERY,
> +               cp.type = new_type;
> +               mgmt_send(adapter->mgmt, MGMT_OP_START_DISCOVERY,
>                                 adapter->dev_id, sizeof(cp), &cp,
>                                 start_discovery_complete, adapter, NULL);
> +               return FALSE;
> +       }
> +
> +       /* Filtered discovery is required */
> +       sd_cp = adapter->current_discovery_filter;
> +
> +       DBG("sending MGMT_OP_START_SERVICE_DISCOVERY %d, %d, %d",
> +           sd_cp->rssi, sd_cp->type, sd_cp->uuid_count);
> +
> +       mgmt_send(adapter->mgmt, MGMT_OP_START_SERVICE_DISCOVERY,
> +                 adapter->dev_id, sizeof(*sd_cp) + sd_cp->uuid_count * 16,
> +                 sd_cp, start_discovery_complete, adapter, NULL);
>
>         return FALSE;
>  }
> @@ -1563,8 +1609,8 @@ static void discovering_callback(uint16_t index, uint16_t length,
>                 return;
>         }
>
> -       DBG("hci%u type %u discovering %u", adapter->dev_id,
> -                                       ev->type, ev->discovering);
> +       DBG("hci%u type %u discovering %u method %d", adapter->dev_id, ev->type,
> +                               ev->discovering, adapter->filtered_discovery);
>
>         if (adapter->discovery_enable == ev->discovering)
>                 return;
> @@ -1590,7 +1636,10 @@ static void discovering_callback(uint16_t index, uint16_t length,
>
>         switch (adapter->discovery_enable) {
>         case 0x00:
> -               trigger_start_discovery(adapter, IDLE_DISCOV_TIMEOUT);
> +               if (adapter->no_scan_restart_delay)
> +                       trigger_start_discovery(adapter, 0);
> +               else
> +                       trigger_start_discovery(adapter, IDLE_DISCOV_TIMEOUT);
>                 break;
>
>         case 0x01:
> @@ -1598,6 +1647,7 @@ static void discovering_callback(uint16_t index, uint16_t length,
>                         g_source_remove(adapter->discovery_idle_timeout);
>                         adapter->discovery_idle_timeout = 0;
>                 }
> +
>                 break;
>         }
>  }
> @@ -1612,7 +1662,8 @@ static void stop_discovery_complete(uint8_t status, uint16_t length,
>         if (status == MGMT_STATUS_SUCCESS) {
>                 adapter->discovery_type = 0x00;
>                 adapter->discovery_enable = 0x00;
> -
> +               adapter->filtered_discovery = false;
> +               adapter->no_scan_restart_delay = false;
>                 adapter->discovering = false;
>                 g_dbus_emit_property_changed(dbus_conn, adapter->path,
>                                         ADAPTER_INTERFACE, "Discovering");
> @@ -1663,6 +1714,193 @@ static gboolean remove_temp_devices(gpointer user_data)
>         return FALSE;
>  }
>
> +static gint g_strcmp(gconstpointer a, gconstpointer b)
> +{
> +       return strcmp(a, b);
> +}
> +
> +static void extract_unique_uuids(gpointer data, gpointer user_data)
> +{
> +       char *uuid_str = data;
> +       GSList **uuids = user_data;
> +
> +       if (!g_slist_find_custom(*uuids, uuid_str, g_strcmp))
> +               *uuids = g_slist_insert_sorted(*uuids, uuid_str, g_strcmp);
> +}
> +
> +/*
> + * This method merges all adapter filters into one that will be send to kernel.
> + * cp_ptr is set to null when regular non-filtered discovery is needed,
> + * otherwise it's pointing to filter. Returns 0 on succes, -1 on error
> + */
> +static int discovery_filter_to_mgmt_cp(struct btd_adapter *adapter,
> +                              struct mgmt_cp_start_service_discovery **cp_ptr)
> +{
> +       GSList *l, *uuids = NULL;
> +       struct mgmt_cp_start_service_discovery *cp;
> +       int rssi = DISTANCE_VAL_INVALID;
> +       int uuid_count;
> +       uint8_t discovery_type = 0;
> +       uint8_t (*current_uuid)[16];
> +       bool empty_uuid = false;
> +       bool has_regular_discovery = false;
> +       bool has_filtered_discovery = false;
> +
> +       DBG("");
> +
> +       for (l = adapter->discovery_list; l != NULL; l = g_slist_next(l)) {

It might be cleaner to put this loop into g_slist_foreach as well.
This way you would break this big function down into smaller helpers.

> +               struct watch_client *client = l->data;
> +               struct discovery_filter *item = client->discovery_filter;
> +
> +               if (!item) {
> +                       has_regular_discovery = true;
> +                       continue;
> +               }
> +
> +               has_filtered_discovery = true;
> +
> +               discovery_type |= item->type;
> +
> +               /*
> +                * Rule for merging rssi and pathloss into rssi field of kernel
> +                * filter is as follow:
> +                * - if there's any client without proximity filter, then do no
> +                *   proximity filtering,
> +                * - if all clients specified RSSI, then use lowest value,
> +                * - if any client specified pathloss, then kernel filter should
> +                *   do no proximity, as kernel can't compute pathloss. We'll do
> +                *   filtering on our own.
> +                */
> +               if (item->rssi == DISTANCE_VAL_INVALID)
> +                       rssi = HCI_RSSI_INVALID;
> +               else if (rssi != HCI_RSSI_INVALID && rssi >= item->rssi)
> +                       rssi = item->rssi;
> +               else if (item->pathloss != DISTANCE_VAL_INVALID)
> +                       rssi = HCI_RSSI_INVALID;
> +
> +               if (!g_slist_length(item->uuids))
> +                       empty_uuid = true;
> +
> +               g_slist_foreach(item->uuids, extract_unique_uuids, &uuids);
> +       }
> +
> +       /* If no proximity filtering is set, disable it */
> +       if (rssi == DISTANCE_VAL_INVALID)
> +               rssi = HCI_RSSI_INVALID;
> +
> +       /*
> +        * Empty_uuid variable determines wether there was any filter with no
> +        * uuids. In this case someone might be looking for all devices in
> +        * certain proximity, and we need to have empty uuids in kernel filter.
> +        */
> +       if (empty_uuid) {
> +               g_slist_free(uuids);
> +               uuids = NULL;
> +       }
> +
> +       if (has_regular_discovery) {
> +               /*
> +                * It there is both regular and filtered scan running, then
> +                * clear whole fitler to report all devices. If there are only
> +                * regular scans, run just regular scan.
> +                */
> +               if (has_filtered_discovery) {
> +                       discovery_type = get_scan_type(adapter);
> +                       rssi = HCI_RSSI_INVALID;
> +                       g_slist_free(uuids);
> +                       uuids = NULL;
> +               } else {
> +                       *cp_ptr = NULL;

Don't you need to free "uuids" here?

> +                       return 0;
> +               }
> +       }
> +
> +       uuid_count = g_slist_length(uuids);
> +
> +       cp = g_try_malloc(sizeof(cp) + 16*uuid_count);

sizeof(*cp) ?

> +       *cp_ptr = cp;
> +       if (!cp)
> +               return -1;

Shouldn't "uuids" be freed here?

> +
> +       cp->type = discovery_type;
> +       cp->rssi = rssi;
> +       cp->uuid_count = uuid_count;
> +
> +       current_uuid = cp->uuids;
> +
> +       for (l = uuids; l != NULL; l = g_slist_next(l)) {

Use a helper function here? Basically you want a
populate_mgmt_filter_uuids of sorts.

> +               bt_uuid_t uuid, u128;
> +               uint128_t uint128;
> +
> +               bt_string_to_uuid(&uuid, l->data);
> +               bt_uuid_to_uuid128(&uuid, &u128);
> +
> +               ntoh128((uint128_t *) u128.value.u128.data, &uint128);
> +               htob128(&uint128, (uint128_t *) current_uuid);
> +
> +               current_uuid++;
> +       }
> +
> +       g_slist_free(uuids);
> +       return 0;
> +}
> +
> +static bool filters_equal(struct mgmt_cp_start_service_discovery *a,
> +                  struct mgmt_cp_start_service_discovery *b) {
> +       if (!a && !b)
> +               return true;
> +
> +       if ((!a && b) || (a && !b))
> +               return false;
> +
> +       if (a->type != b->type)
> +               return false;
> +
> +       if (a->rssi != b->rssi)
> +               return false;
> +
> +       /*
> +        * When we create mgmt_cp_start_service_discovery structure inside
> +        * discovery_filter_to_mgmt_cp, we always keep uuids sorted, and
> +        * unique, so we're safe to compare uuid_count, and uuids like that.
> +        */
> +       if (a->uuid_count != b->uuid_count)
> +               return false;
> +
> +       if (memcmp(a->uuids, b->uuids, 16 * a->uuid_count) != 0)
> +               return false;
> +
> +       return true;
> +}
> +
> +static void update_discovery_filter(struct btd_adapter *adapter)
> +{
> +       struct mgmt_cp_start_service_discovery *sd_cp;
> +
> +       DBG("");
> +
> +       if (discovery_filter_to_mgmt_cp(adapter, &sd_cp)) {
> +               error("discovery_filter_to_mgmt_cp returned error");
> +               return;
> +       }
> +
> +       /*
> +        * If filters are equal, then don't update scan, except for when
> +        * starting discovery.
> +        */
> +       if (filters_equal(adapter->current_discovery_filter, sd_cp) &&
> +           adapter->discovering != 0) {
> +               DBG("filters were equal, deciding to not restart the scan.");
> +               g_free(sd_cp);
> +               return;
> +       }
> +
> +       g_free(adapter->current_discovery_filter);
> +       adapter->current_discovery_filter = sd_cp;
> +
> +       trigger_start_discovery(adapter, 0);
> +}
> +
>  static void discovery_destroy(void *user_data)
>  {
>         struct watch_client *client = user_data;
> @@ -1730,8 +1968,10 @@ static void discovery_disconnect(DBusConnection *conn, void *user_data)
>          * However in case this is the last client, the discovery in
>          * the kernel needs to be disabled.
>          */
> -       if (adapter->discovery_list)
> +       if (adapter->discovery_list) {
> +               update_discovery_filter(adapter);
>                 return;
> +       }
>
>         /*
>          * In the idle phase of a discovery, there is no need to stop it
> @@ -1753,7 +1993,8 @@ static void discovery_disconnect(DBusConnection *conn, void *user_data)
>                                 stop_discovery_complete, adapter, NULL);
>  }
>
> -/* returns true if client was already discovering, false otherwise. *client
> +/*
> + * Return true if client was already discovering, false otherwise. *client
>   * will point to discovering client, or client that have pre-set his filter.
>   */
>  static bool get_discovery_client(struct btd_adapter *adapter,
> @@ -1808,8 +2049,8 @@ static DBusMessage *start_discovery(DBusConnection *conn,
>                 adapter->set_filter_list = g_slist_remove(
>                                              adapter->set_filter_list, client);
>                 adapter->discovery_list = g_slist_prepend(
> -                                            adapter->discovery_list, client);
> -               trigger_start_discovery(adapter, 0);
> +                                             adapter->discovery_list, client);
> +               update_discovery_filter(adapter);
>                 return dbus_message_new_method_return(msg);
>         }
>
> @@ -1829,7 +2070,7 @@ static DBusMessage *start_discovery(DBusConnection *conn,
>          * discovery in idle phase exists, it will be restarted right
>          * away.
>          */
> -       trigger_start_discovery(adapter, 0);
> +       update_discovery_filter(adapter);
>
>         return dbus_message_new_method_return(msg);
>  }
> @@ -2035,6 +2276,9 @@ static DBusMessage *set_discovery_filter(DBusConnection *conn,
>                 free_discovery_filter(client->discovery_filter);
>                 client->discovery_filter = discovery_filter;
>
> +               if (is_discovering)
> +                       update_discovery_filter(adapter);
> +
>                 if (discovery_filter || is_discovering)
>                         return dbus_message_new_method_return(msg);
>
> @@ -2092,12 +2336,10 @@ static DBusMessage *stop_discovery(DBusConnection *conn,
>          */
>         g_dbus_remove_watch(dbus_conn, client->watch);
>
> -       /*
> -        * As long as other discovery clients are still active, just
> -        * return success.
> -        */
> -       if (adapter->discovery_list)
> +       if (adapter->discovery_list) {
> +               update_discovery_filter(adapter);
>                 return dbus_message_new_method_return(msg);
> +       }
>
>         /*
>          * In the idle phase of a discovery, there is no need to stop it
> @@ -5312,6 +5554,11 @@ static void adapter_stop(struct btd_adapter *adapter)
>                 g_dbus_remove_watch(dbus_conn, client->watch);
>         }
>
> +       adapter->filtered_discovery = false;
> +       adapter->no_scan_restart_delay = false;
> +       g_free(adapter->current_discovery_filter);
> +       adapter->current_discovery_filter = NULL;
> +
>         adapter->discovering = false;
>
>         while (adapter->connections) {
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Arman

Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Jan 2012 14:35:10 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Vishal Agarwal <vishal.agarwal@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org, naresh.gupta@stericsson.com
Subject: Re: [PATCH BlueZ v1 1/1] Add Support for BLE Services to Adapter
Message-ID: <20120120173510.GA15285@samus>
References: <1326949654-23244-1-git-send-email-vishal.agarwal@stericsson.com>
 <1326949654-23244-2-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326949654-23244-2-git-send-email-vishal.agarwal@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

On 10:37 Thu 19 Jan, Vishal Agarwal wrote:
> This patch adds support for adding primary service UUIDs
> to adapter's list. These uuids can then be sent to upper
> layers using the DBUS method of get_properties and signal
> adapter_emit_uuids_updated.

It would be nice if you added support for using this information in the
EIR and Advertising Data, in a later patch.

> ---
>  proximity/manager.c |   23 +++++++++++++++++++
>  src/adapter.c       |   61 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  src/adapter.h       |    2 +
>  3 files changed, 84 insertions(+), 2 deletions(-)
> 
> diff --git a/proximity/manager.c b/proximity/manager.c
> index a767554..ff5af6d 100644
> --- a/proximity/manager.c
> +++ b/proximity/manager.c
> @@ -83,6 +83,21 @@ static void attio_device_remove(struct btd_device *device)
>  	monitor_unregister(connection, device);
>  }
>  
> +static int proximity_adapter_probe(struct btd_adapter *adapter)
> +{
> +	add_primary(adapter, LINK_LOSS_SERVICE_ID);
> +	add_primary(adapter, IMMEDIATE_ALERT_SERVICE_ID);
> +	add_primary(adapter, TX_POWER_SERVICE_ID);
> +	return 0;
> +}
> +
> +static void proximity_adapter_remove(struct btd_adapter *adapter)
> +{
> +	remove_primary(adapter, LINK_LOSS_SERVICE_ID);
> +	remove_primary(adapter, IMMEDIATE_ALERT_SERVICE_ID);
> +	remove_primary(adapter, TX_POWER_SERVICE_ID);
> +}
> +
>  static struct btd_device_driver monitor_driver = {
>  	.name = "Proximity GATT Driver",
>  	.uuids = BTD_UUIDS(IMMEDIATE_ALERT_UUID, LINK_LOSS_UUID, TX_POWER_UUID),
> @@ -90,6 +105,12 @@ static struct btd_device_driver monitor_driver = {
>  	.remove = attio_device_remove,
>  };
>  
> +static struct btd_adapter_driver proximity_adapter = {
> +	.name = "Proximity",
> +	.probe = proximity_adapter_probe,
> +	.remove = proximity_adapter_remove,
> +};
> +
>  static void load_config_file(GKeyFile *config)
>  {
>  	char **list;
> @@ -118,6 +139,7 @@ int proximity_manager_init(DBusConnection *conn, GKeyFile *config)
>  
>  	load_config_file(config);
>  
> +	btd_register_adapter_driver(&proximity_adapter);
>  	/* TODO: Register Proximity Monitor/Reporter drivers */
>  	ret = btd_register_device_driver(&monitor_driver);
>  	if (ret < 0)
> @@ -132,5 +154,6 @@ void proximity_manager_exit(void)
>  {
>  	reporter_exit();
>  	btd_unregister_device_driver(&monitor_driver);
> +	btd_unregister_adapter_driver(&proximity_adapter);
>  	dbus_connection_unref(connection);
>  }

Everything above here should be a separate commit.

> diff --git a/src/adapter.c b/src/adapter.c
> index a75a0c4..c206a20 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -154,6 +154,7 @@ struct btd_adapter {
>  	GSList *pin_callbacks;
>  
>  	GSList *loaded_drivers;
> +	GSList *primaries;
>  };
>  
>  static void dev_info_free(void *data)
> @@ -879,11 +880,12 @@ static void adapter_emit_uuids_updated(struct btd_adapter *adapter)
>  	char **uuids;
>  	int i;
>  	sdp_list_t *list;
> +	GSList *primary_list;
>  
>  	if (!adapter->initialized)
>  		return;
>  
> -	uuids = g_new0(char *, sdp_list_len(adapter->services) + 1);
> +	uuids = g_new0(char *, sdp_list_len(adapter->services) + g_slist_length(adapter->primaries) + 1);
>  
>  	for (i = 0, list = adapter->services; list; list = list->next) {
>  		char *uuid;
> @@ -894,6 +896,15 @@ static void adapter_emit_uuids_updated(struct btd_adapter *adapter)
>  			uuids[i++] = uuid;
>  	}
>  
> +	for (primary_list = adapter->primaries; primary_list; primary_list = primary_list->next) {
> +		char *uuid;
> +		uuid_t *rec = primary_list->data;
> +
> +		uuid = bt_uuid2string(rec);
> +		if (uuid)
> +			uuids[i++] = uuid;
> +	}
> +
>  	emit_array_property_changed(connection, adapter->path,
>  			ADAPTER_INTERFACE, "UUIDs", DBUS_TYPE_STRING, &uuids, i);
>  
> @@ -986,6 +997,41 @@ void adapter_service_remove(struct btd_adapter *adapter, void *r)
>  	adapter_emit_uuids_updated(adapter);
>  }
>  
> +static void adapter_primary_insert(struct btd_adapter *adapter, void *u)
> +{

Why this function receives an void*? It would be much clearer and less
bug prone if it receives const bt_uuid_t* (please use bt_uuid_t, instead
of uuid_t) and you do the allocation inside the function.

And speaking of allocation, please use the glib helpers for allocation
instead of using malloc directly.

Another thing, as this is an internal function it may be called
something shorter.

> +	uuid_t *uuid = u;
> +	if (!g_slist_find_custom(adapter->primaries, uuid, (GCompareFunc) sdp_uuid_cmp))
> +		adapter->primaries = g_slist_append(adapter->primaries, uuid);
> +	else
> +		free(u);
> +}
> +
> +static void adapter_primary_remove(struct btd_adapter *adapter, void *u)
> +{
> +	uuid_t *uuid = u;
> +	GSList *list_pos;

Please call list_pos just "l", to make it more consistent with the rest
of the code.

> +
> +	list_pos = g_slist_find_custom(adapter->primaries, uuid, (GCompareFunc) sdp_uuid_cmp);
> +	if (!list_pos) {
> +		adapter->primaries = g_slist_remove(adapter->primaries, list_pos->data);
> +		free(list_pos->data);
> +	}
> +}
> +
> +void add_primary(struct btd_adapter *adapter, uint16_t val)

This is an exported function, please use a name that reduces the chances
of clashes: adapter_add_primary() or even adapter_add_primary_uuid(),
sounds better.

> +{
> +	uuid_t *primary = malloc(sizeof(uuid_t));
> +	sdp_uuid16_create(primary, val);
> +	adapter_primary_insert(adapter, primary);
> +}
> +
> +void remove_primary(struct btd_adapter *adapter, uint16_t val)
> +{

Same rationale as above.

> +	uuid_t primary;
> +	sdp_uuid16_create(&primary, val);
> +	adapter_primary_remove(adapter, &primary);
> +}
> +
>  static struct btd_device *adapter_create_device(DBusConnection *conn,
>  						struct btd_adapter *adapter,
>  						const char *address,
> @@ -1148,6 +1194,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
>  	int i;
>  	GSList *l;
>  	sdp_list_t *list;
> +	GSList *primary_list;
>  
>  	ba2str(&adapter->bdaddr, srcaddr);
>  
> @@ -1214,7 +1261,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
>  	g_free(devices);
>  
>  	/* UUIDs */
> -	uuids = g_new0(char *, sdp_list_len(adapter->services) + 1);
> +	uuids = g_new0(char *, sdp_list_len(adapter->services) + g_slist_length(adapter->primaries) + 1);
>  
>  	for (i = 0, list = adapter->services; list; list = list->next) {
>  		sdp_record_t *rec = list->data;
> @@ -1225,6 +1272,15 @@ static DBusMessage *get_properties(DBusConnection *conn,
>  			uuids[i++] = uuid;
>  	}
>  
> +	for (primary_list = adapter->primaries; primary_list; primary_list = primary_list->next) {
> +		char *uuid;
> +		uuid_t *rec = primary_list->data;
> +
> +		uuid = bt_uuid2string(rec);
> +		if (uuid)
> +			uuids[i++] = uuid;
> +	}
> +
>  	dict_append_array(&dict, "UUIDs", DBUS_TYPE_STRING, &uuids, i);
>  
>  	g_strfreev(uuids);
> @@ -2324,6 +2380,7 @@ static void adapter_free(gpointer user_data)
>  		off_timer_remove(adapter);
>  
>  	sdp_list_free(adapter->services, NULL);
> +	g_slist_free(adapter->primaries);
>  
>  	g_slist_free_full(adapter->found_devices, dev_info_free);
>  
> diff --git a/src/adapter.h b/src/adapter.h
> index c1f981a..c1228ae 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -123,6 +123,8 @@ int adapter_set_name(struct btd_adapter *adapter, const char *name);
>  void adapter_name_changed(struct btd_adapter *adapter, const char *name);
>  void adapter_service_insert(struct btd_adapter *adapter, void *rec);
>  void adapter_service_remove(struct btd_adapter *adapter, void *rec);
> +void add_primary(struct btd_adapter *adapter, uint16_t val);
> +void remove_primary(struct btd_adapter *adapter, uint16_t val);
>  void btd_adapter_class_changed(struct btd_adapter *adapter,
>  							uint32_t new_class);
>  void btd_adapter_pairable_changed(struct btd_adapter *adapter,
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
-- 
Vinicius

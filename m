Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 17 Jul 2017 16:07:23 +0200
From: Olivier MARTIN <olivier@labapart.com>
To: Jonah Petri <jonah@sense.com>
Cc: linux-bluetooth@vger.kernel.org,
        linux-bluetooth-owner@vger.kernel.org
Subject: Re: [PATCH] gatt-server: Implement NegotiatedMTU property on Device1
In-Reply-To: <CF389661-A1F2-4A25-96CD-0070FE33A1DE@sense.com>
References: <CF389661-A1F2-4A25-96CD-0070FE33A1DE@sense.com>
Message-ID: <e588afc974278375a48bf57177858b9a@labapart.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 14.07.2017 17:56, Jonah Petri wrote:
> It can be useful for programs using GATT to be aware of the maximum
> transmittable packet size, as negotiated by bluetoothd.  This change
> exposes the negotiated MTU over D-Bus, if such a negotiation has
> occurred.
> ---
>  client/main.c            |  1 +
>  doc/device-api.txt       |  5 +++++
>  src/device.c             | 31 +++++++++++++++++++++++++++++++
>  src/shared/gatt-server.c | 15 +++++++++++++++
>  src/shared/gatt-server.h |  3 +++
>  5 files changed, 55 insertions(+)
> 
> diff --git a/client/main.c b/client/main.c
> index 255cbd5..6435674 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -1372,6 +1372,7 @@ static void cmd_info(const char *arg)
>  	print_property(proxy, "ServiceData");
>  	print_property(proxy, "RSSI");
>  	print_property(proxy, "TxPower");
> +	print_property(proxy, "NegotiatedMTU");
>  }
> 
>  static void pair_reply(DBusMessage *message, void *user_data)
> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index 13b2881..908616b 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -234,3 +234,8 @@ Properties	string Address [readonly]
>  		array{byte} AdvertisingFlags [readonly, experimental]
> 
>  			The Advertising Data Flags of the remote device.
> +
> +		int16 NegotiatedMTU [readonly, optional, experimental]
> +
> +			The ATT MTU negotiated with the connected host.
> +			Available only once MTU negotiation is complete.
> diff --git a/src/device.c b/src/device.c
> index 8693eb8..1b171ee 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -930,6 +930,35 @@ static gboolean
> dev_property_exists_tx_power(const GDBusPropertyTable *property,
>  	return TRUE;
>  }
> 
> +static gboolean dev_property_get_negotiated_mtu(
> +					const GDBusPropertyTable * property,
> +					DBusMessageIter *iter, void *data)
> +{
> +	const struct btd_device *dev = data;
> +	dbus_int16_t val = 0;
> +	int err;
> +
> +	err = bt_gatt_server_get_negotiated_mtu(dev->server, &val);
> +	if (err != 0)
> +		return FALSE;
> +
> +	dbus_message_iter_append_basic(iter, DBUS_TYPE_INT16, &val);
> +
> +	return TRUE;
> +}
> +
> +static gboolean dev_property_exists_negotiated_mtu(
> +					const GDBusPropertyTable * property,
> +					void *data)
> +{
> +	const struct btd_device *dev = data;
> +	int err;
> +
> +	err = bt_gatt_server_get_negotiated_mtu(dev->server, NULL);
> +
> +	return err == 0;
> +}
> +
>  static gboolean
>  dev_property_get_svc_resolved(const GDBusPropertyTable *property,
>  					DBusMessageIter *iter, void *data)
> @@ -2561,6 +2590,8 @@ static const GDBusPropertyTable 
> device_properties[] = {
>  				NULL, dev_property_service_data_exist },
>  	{ "TxPower", "n", dev_property_get_tx_power, NULL,
>  					dev_property_exists_tx_power },
> +	{ "NegotiatedMTU", "n", dev_property_get_negotiated_mtu, NULL,
> +					dev_property_exists_negotiated_mtu },
>  	{ "ServicesResolved", "b", dev_property_get_svc_resolved, NULL, NULL 
> },
>  	{ "AdvertisingFlags", "ay", dev_property_get_flags, NULL,
>  					dev_property_flags_exist,
> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> index 79e01c8..2727f09 100644
> --- a/src/shared/gatt-server.c
> +++ b/src/shared/gatt-server.c
> @@ -89,6 +89,7 @@ struct bt_gatt_server {
>  	struct bt_att *att;
>  	int ref_count;
>  	uint16_t mtu;
> +	bool mtu_negotiated;
> 
>  	unsigned int mtu_id;
>  	unsigned int read_by_grp_type_id;
> @@ -1378,12 +1379,25 @@ static void exchange_mtu_cb(uint8_t opcode,
> const void *pdu,
> 
>  	/* Set MTU to be the minimum */
>  	server->mtu = final_mtu;
> +	server->mtu_negotiated = true;
>  	bt_att_set_mtu(server->att, final_mtu);
> 
>  	util_debug(server->debug_callback, server->debug_data,
>  			"MTU exchange complete, with MTU: %u", final_mtu);
>  }
> 
> +int bt_gatt_server_get_negotiated_mtu(const struct bt_gatt_server 
> *server,
> +				int16_t *mtu)
> +{
> +	if (!server || !server->mtu_negotiated)
> +		return -1;
> +
> +	if (mtu)
> +		*mtu = server->mtu;
> +
> +	return 0;
> +}
> +
>  static bool gatt_server_register_att_handlers(struct bt_gatt_server 
> *server)
>  {
>  	/* Exchange MTU */
> @@ -1493,6 +1507,7 @@ struct bt_gatt_server *bt_gatt_server_new(struct
> gatt_db *db,
>  	server->db = gatt_db_ref(db);
>  	server->att = bt_att_ref(att);
>  	server->mtu = MAX(mtu, BT_ATT_DEFAULT_LE_MTU);
> +	server->mtu_negotiated = false;
>  	server->max_prep_queue_len = DEFAULT_MAX_PREP_QUEUE_LEN;
>  	server->prep_queue = queue_new();
> 
> diff --git a/src/shared/gatt-server.h b/src/shared/gatt-server.h
> index 0e480e1..0b99da5 100644
> --- a/src/shared/gatt-server.h
> +++ b/src/shared/gatt-server.h
> @@ -31,6 +31,9 @@ struct bt_gatt_server *bt_gatt_server_new(struct 
> gatt_db *db,
>  struct bt_gatt_server *bt_gatt_server_ref(struct bt_gatt_server 
> *server);
>  void bt_gatt_server_unref(struct bt_gatt_server *server);
> 
> +int bt_gatt_server_get_negotiated_mtu(const struct bt_gatt_server 
> *server,
> +					int16_t *mtu);
> +
>  typedef void (*bt_gatt_server_destroy_func_t)(void *user_data);
>  typedef void (*bt_gatt_server_debug_func_t)(const char *str, void 
> *user_data);
>  typedef void (*bt_gatt_server_conf_func_t)(void *user_data);

When I started to do the same exercise last week, I exposed two 
different MTUs: GATT Server MTU (in GATT Manager DBUS API) and GATT 
Client MTU (in Device DBUS API) as I had the impression they were 
different.
Instead of only exposing the negociated MTU I also exposed the current 
MTU (ie: the value before being negociated). The idea was to send a DBUS 
Signal when a new MTU was negociated to tell DBus-based applications a 
new MTU has been negociated.

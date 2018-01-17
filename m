Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/3] tools/btpclient: Add start, stop advertising commands
Date: Wed, 17 Jan 2018 11:44:09 +0100
Message-Id: <20180117104411.13628-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds start and stop advertising commands for btp client.
---
 tools/btpclient.c | 659 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 658 insertions(+), 1 deletion(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 2040fbe32..286aa16aa 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -35,6 +35,19 @@
 #include "lib/bluetooth.h"
 #include "src/shared/btp.h"
 
+#define AD_PATH "/org/bluez/advertising"
+#define AD_IFACE "org.bluez.LEAdvertisement1"
+
+/* List of assigned numbers for advetising data and scan response */
+#define AD_TYPE_FLAGS				0x01
+#define AD_TYPE_INCOMPLETE_UUID16_SERVICE_LIST	0x02
+#define AD_TYPE_SHORT_NAME			0x08
+#define AD_TYPE_SERVICE_DATA_UUID16		0x16
+#define AD_TYPE_APPEARANCE			0x19
+#define AD_TYPE_MANUFACTURER_DATA		0xff
+
+static struct l_dbus *dbus;
+
 struct btp_adapter {
 	struct l_dbus_proxy *proxy;
 	struct l_dbus_proxy *ad_proxy;
@@ -54,6 +67,53 @@ static struct btp *btp;
 
 static bool gap_service_registered;
 
+struct ad_data {
+	uint8_t data[25];
+	uint8_t len;
+};
+
+struct service_data {
+	char *uuid;
+	struct ad_data data;
+};
+
+struct manufacturer_data {
+	uint16_t id;
+	struct ad_data data;
+};
+
+static struct ad {
+	bool registered;
+	char *type;
+	char *local_name;
+	uint16_t local_appearance;
+	uint16_t duration;
+	uint16_t timeout;
+	struct l_queue *uuids;
+	struct l_queue *services;
+	struct l_queue *manufacturers;
+	bool tx_power;
+	bool name;
+	bool appearance;
+} ad;
+
+static char *dupuuid2str(const uint8_t *uuid, uint8_t len)
+{
+	switch (len) {
+	case 16:
+		return l_strdup_printf("%hhx%hhx", uuid[0], uuid[1]);
+	case 128:
+		return l_strdup_printf("%hhx%hhx%hhx%hhx%hhx%hhx%hhx%hhx%hhx"
+					"%hhx%hhx%hhx%hhx%hhx%hhx%hhx", uuid[0],
+					uuid[1], uuid[2], uuid[3], uuid[4],
+					uuid[5], uuid[6], uuid[6], uuid[8],
+					uuid[7], uuid[10], uuid[11], uuid[12],
+					uuid[13], uuid[14], uuid[15]);
+	default:
+		return NULL;
+	}
+}
+
 static struct btp_adapter *find_adapter_by_proxy(struct l_dbus_proxy *proxy)
 {
 	const struct l_queue_entry *entry;
@@ -118,6 +178,8 @@ static void btp_gap_read_commands(uint8_t index, const void *param,
 	commands |= (1 << BTP_OP_GAP_SET_CONNECTABLE);
 	commands |= (1 << BTP_OP_GAP_SET_DISCOVERABLE);
 	commands |= (1 << BTP_OP_GAP_SET_BONDABLE);
+	commands |= (1 << BTP_OP_GAP_START_ADVERTISING);
+	commands |= (1 << BTP_OP_GAP_STOP_ADVERTISING);
 	commands |= (1 << BTP_OP_GAP_START_DISCOVERY);
 	commands |= (1 << BTP_OP_GAP_STOP_DISCOVERY);
 
@@ -229,6 +291,46 @@ static void remove_device_reply(struct l_dbus_proxy *proxy,
 	l_queue_remove(adapter->devices, device);
 }
 
+static void unreg_advertising_setup(struct l_dbus_message *message,
+								void *user_data)
+{
+	struct l_dbus_message_builder *builder;
+
+	builder = l_dbus_message_builder_new(message);
+	l_dbus_message_builder_append_basic(builder, 'o', AD_PATH);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+}
+
+static void unreg_advertising_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	const char *path = l_dbus_proxy_get_path(proxy);
+	struct btp_adapter *adapter = find_adapter_by_path(path);
+
+	if (!adapter)
+		return;
+
+	if (l_dbus_message_is_error(result)) {
+		const char *name;
+
+		l_dbus_message_get_error(result, &name, NULL);
+
+		l_error("Failed to stop advertising %s (%s)",
+					l_dbus_proxy_get_path(proxy), name);
+		return;
+	}
+
+	if (!l_dbus_object_remove_interface(dbus, AD_PATH, AD_IFACE))
+		l_info("Unable to remove ad instance");
+	if (!l_dbus_object_remove_interface(dbus, AD_PATH,
+						L_DBUS_INTERFACE_PROPERTIES))
+		l_info("Unable to remove propety instance");
+	if (!l_dbus_unregister_interface(dbus, AD_IFACE))
+		l_info("Unable to unregister ad interface");
+}
+
 static void btp_gap_reset(uint8_t index, const void *param, uint16_t length,
 								void *user_data)
 {
@@ -259,6 +361,16 @@ static void btp_gap_reset(uint8_t index, const void *param, uint16_t length,
 						NULL);
 	}
 
+	if (adapter->ad_proxy)
+		if (!l_dbus_proxy_method_call(adapter->ad_proxy,
+						"UnregisterAdvertisement",
+						unreg_advertising_setup,
+						unreg_advertising_reply,
+						NULL, NULL)) {
+			status = BTP_ERROR_FAIL;
+			goto failed;
+		}
+
 	/* TODO for we assume all went well */
 	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_RESET, index, 0, NULL);
 	return;
@@ -444,6 +556,539 @@ failed:
 	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
 }
 
+static void ad_cleanup_service(void *service)
+{
+	struct service_data *s = service;
+
+	l_free(s->uuid);
+	l_free(s);
+}
+
+static void ad_cleanup(void)
+{
+	l_free(ad.local_name);
+	l_queue_destroy(ad.uuids, l_free);
+	l_queue_destroy(ad.services, ad_cleanup_service);
+	l_queue_destroy(ad.manufacturers, l_free);
+
+	memset(&ad, 0, sizeof(ad));
+}
+
+static void ad_init(void)
+{
+	ad.uuids = l_queue_new();
+	ad.services = l_queue_new();
+	ad.manufacturers = l_queue_new();
+
+	ad.local_appearance = UINT16_MAX;
+}
+
+static struct l_dbus_message *ad_release_call(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct l_dbus_message *reply;
+
+	l_dbus_unregister_object(dbus, AD_PATH);
+	l_dbus_unregister_interface(dbus, AD_IFACE);
+
+	reply = l_dbus_message_new_method_return(message);
+	l_dbus_message_set_arguments(reply, "");
+
+	ad_cleanup();
+
+	return reply;
+}
+
+static bool ad_type_getter(struct l_dbus *dbus, struct l_dbus_message *message,
+				struct l_dbus_message_builder *builder,
+				void *user_data)
+{
+	l_dbus_message_builder_append_basic(builder, 's', ad.type);
+
+	return true;
+}
+
+static bool ad_serviceuuids_getter(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	const struct l_queue_entry *entry;
+
+	if (l_queue_isempty(ad.uuids))
+		return false;
+
+	l_dbus_message_builder_enter_array(builder, "s");
+
+	for (entry = l_queue_get_entries(ad.uuids); entry; entry = entry->next)
+		l_dbus_message_builder_append_basic(builder, 's', entry->data);
+
+	l_dbus_message_builder_leave_array(builder);
+
+	return true;
+}
+
+static bool ad_servicedata_getter(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	const struct l_queue_entry *entry;
+	size_t i;
+
+	if (l_queue_isempty(ad.services))
+		return false;
+
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+
+	for (entry = l_queue_get_entries(ad.services); entry;
+							entry = entry->next) {
+		struct service_data *sd = entry->data;
+
+		l_dbus_message_builder_enter_dict(builder, "sv");
+		l_dbus_message_builder_append_basic(builder, 's', sd->uuid);
+		l_dbus_message_builder_enter_variant(builder, "ay");
+		l_dbus_message_builder_enter_array(builder, "y");
+
+		for (i = 0; i < sd->data.len; i++)
+			l_dbus_message_builder_append_basic(builder, 'y',
+							&(sd->data.data[i]));
+
+		l_dbus_message_builder_leave_array(builder);
+		l_dbus_message_builder_leave_variant(builder);
+		l_dbus_message_builder_leave_dict(builder);
+	}
+	l_dbus_message_builder_leave_array(builder);
+
+	return true;
+}
+
+static bool ad_manufacturerdata_getter(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	const struct l_queue_entry *entry;
+	size_t i;
+
+	if (l_queue_isempty(ad.manufacturers))
+		return false;
+
+	l_dbus_message_builder_enter_array(builder, "{qv}");
+
+	for (entry = l_queue_get_entries(ad.manufacturers); entry;
+							entry = entry->next) {
+		struct manufacturer_data *md = entry->data;
+
+		l_dbus_message_builder_enter_dict(builder, "qv");
+		l_dbus_message_builder_append_basic(builder, 'q', &md->id);
+		l_dbus_message_builder_enter_variant(builder, "ay");
+		l_dbus_message_builder_enter_array(builder, "y");
+
+		for (i = 0; i < md->data.len; i++)
+			l_dbus_message_builder_append_basic(builder, 'y',
+							&(md->data.data[i]));
+
+		l_dbus_message_builder_leave_array(builder);
+		l_dbus_message_builder_leave_variant(builder);
+		l_dbus_message_builder_leave_dict(builder);
+	}
+	l_dbus_message_builder_leave_array(builder);
+
+	return true;
+}
+
+static bool ad_includes_getter(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	l_dbus_message_builder_enter_array(builder, "s");
+
+	if (!(ad.tx_power || ad.name || ad.appearance))
+		return false;
+
+	if (ad.tx_power) {
+		const char *str = "tx-power";
+
+		l_dbus_message_builder_append_basic(builder, 's', &str);
+	}
+
+	if (ad.name) {
+		const char *str = "local-name";
+
+		l_dbus_message_builder_append_basic(builder, 's', &str);
+	}
+
+	if (ad.appearance) {
+		const char *str = "appearance";
+
+		l_dbus_message_builder_append_basic(builder, 's', &str);
+	}
+
+	l_dbus_message_builder_leave_array(builder);
+
+	return true;
+}
+
+static bool ad_localname_getter(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	if (!ad.local_name)
+		return false;
+
+	l_dbus_message_builder_append_basic(builder, 's', ad.local_name);
+
+	return true;
+}
+
+static bool ad_appearance_getter(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	if (!ad.local_appearance)
+		return false;
+
+	l_dbus_message_builder_append_basic(builder, 'q', &ad.local_appearance);
+
+	return true;
+}
+
+static bool ad_duration_getter(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	if (!ad.duration)
+		return false;
+
+	l_dbus_message_builder_append_basic(builder, 'q', &ad.duration);
+
+	return true;
+}
+
+static bool ad_timeout_getter(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	if (!ad.timeout)
+		return false;
+
+	l_dbus_message_builder_append_basic(builder, 'q', &ad.timeout);
+
+	return true;
+}
+
+static void setup_ad_interface(struct l_dbus_interface *interface)
+{
+	l_dbus_interface_method(interface, "Release",
+						L_DBUS_METHOD_FLAG_NOREPLY,
+						ad_release_call, "", "");
+	l_dbus_interface_property(interface, "Type", 0, "s", ad_type_getter,
+									NULL);
+	l_dbus_interface_property(interface, "ServiceUUIDs", 0, "as",
+						ad_serviceuuids_getter, NULL);
+	l_dbus_interface_property(interface, "ServiceData", 0, "a{sv}",
+						ad_servicedata_getter, NULL);
+	l_dbus_interface_property(interface, "ManufacturerServiceData", 0,
+					"a{qv}", ad_manufacturerdata_getter,
+					NULL);
+	l_dbus_interface_property(interface, "Includes", 0, "as",
+						ad_includes_getter, NULL);
+	l_dbus_interface_property(interface, "LocalName", 0, "s",
+						ad_localname_getter, NULL);
+	l_dbus_interface_property(interface, "Appearance", 0, "q",
+						ad_appearance_getter, NULL);
+	l_dbus_interface_property(interface, "Duration", 0, "q",
+						ad_duration_getter, NULL);
+	l_dbus_interface_property(interface, "Timeout", 0, "q",
+						ad_timeout_getter, NULL);
+}
+
+static void start_advertising_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	const char *path = l_dbus_proxy_get_path(proxy);
+	struct btp_adapter *adapter = find_adapter_by_path(path);
+	uint32_t new_settings;
+
+	if (!adapter) {
+		btp_send_error(btp, BTP_GAP_SERVICE, BTP_INDEX_NON_CONTROLLER,
+								BTP_ERROR_FAIL);
+		return;
+	}
+
+	if (l_dbus_message_is_error(result)) {
+		const char *name, *desc;
+
+		l_dbus_message_get_error(result, &name, &desc);
+		l_error("Failed to start advertising (%s), %s", name, desc);
+
+		btp_send_error(btp, BTP_GAP_SERVICE, adapter->index,
+								BTP_ERROR_FAIL);
+		return;
+	}
+
+	new_settings = adapter->current_settings;
+	new_settings |= BTP_GAP_SETTING_ADVERTISING;
+	update_current_settings(adapter, new_settings);
+
+	ad.registered = true;
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_START_ADVERTISING,
+					adapter->index, sizeof(new_settings),
+					&new_settings);
+}
+
+static void create_advertising_data(uint8_t adv_data_len, const uint8_t *data)
+{
+	const uint8_t *ad_data;
+	uint8_t ad_type, ad_len;
+	uint8_t remaining_data_len = adv_data_len;
+
+	while (remaining_data_len) {
+		ad_type = data[adv_data_len - remaining_data_len];
+		ad_len = data[adv_data_len - remaining_data_len + 1];
+		ad_data = &data[adv_data_len - remaining_data_len + 2];
+
+		switch (ad_type) {
+		case AD_TYPE_INCOMPLETE_UUID16_SERVICE_LIST:
+		{
+			char *uuid = dupuuid2str(ad_data, 16);
+
+			l_queue_push_tail(ad.uuids, uuid);
+
+			break;
+		}
+		case AD_TYPE_SHORT_NAME:
+			ad.local_name = malloc(ad_len + 1);
+			memcpy(ad.local_name, ad_data, ad_len);
+			ad.local_name[ad_len] = '\0';
+
+			break;
+		case AD_TYPE_SERVICE_DATA_UUID16:
+		{
+			struct service_data *sd;
+
+			sd = l_new(struct service_data, 1);
+			sd->uuid = dupuuid2str(ad_data, 16);
+			sd->data.len = ad_len - 2;
+			memcpy(sd->data.data, ad_data + 2, sd->data.len);
+
+			l_queue_push_tail(ad.services, sd);
+
+			break;
+		}
+		case AD_TYPE_APPEARANCE:
+			memcpy(&ad.local_appearance, ad_data, ad_len);
+
+			break;
+		case AD_TYPE_MANUFACTURER_DATA:
+		{
+			struct manufacturer_data *md;
+
+			md = l_new(struct manufacturer_data, 1);
+			/* The first 2 octets contain the Company Identifier
+			 * Code followed by additional manufacturer specific
+			 * data.
+			 */
+			memcpy(&md->id, ad_data, 2);
+			md->data.len = ad_len - 2;
+			memcpy(md->data.data, ad_data + 2, md->data.len);
+
+			l_queue_push_tail(ad.manufacturers, md);
+
+			break;
+		}
+		default:
+			l_info("Unsupported advertising data type");
+
+			break;
+		}
+		/* Advertising entity data len + advertising entity header
+		 * (type, len)
+		 */
+		remaining_data_len -= ad_len + 2;
+	}
+}
+
+static void create_scan_response(uint8_t scan_rsp_len, const uint8_t *data)
+{
+	/* TODO */
+}
+
+static void start_advertising_setup(struct l_dbus_message *message,
+							void *user_data)
+{
+	struct l_dbus_message_builder *builder;
+
+	builder = l_dbus_message_builder_new(message);
+	l_dbus_message_builder_append_basic(builder, 'o', AD_PATH);
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_leave_dict(builder);
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+}
+
+static void btp_gap_start_advertising(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	const struct btp_gap_start_adv_cp *cp = param;
+	uint8_t status = BTP_ERROR_FAIL;
+	bool prop;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	/* Adapter needs to be powered to be able to remove devices */
+	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &prop) ||
+							!prop || ad.registered)
+		goto failed;
+
+	if (!l_dbus_register_interface(dbus, AD_IFACE, setup_ad_interface, NULL,
+								false)) {
+		l_info("Unable to register ad interface");
+		goto failed;
+	}
+
+	if (!l_dbus_object_add_interface(dbus, AD_PATH, AD_IFACE, NULL)) {
+		l_info("Unable to instantiate ad interface");
+
+		if (!l_dbus_unregister_interface(dbus, AD_IFACE))
+			l_info("Unable to unregister ad interface");
+
+		goto failed;
+	}
+
+	if (!l_dbus_object_add_interface(dbus, AD_PATH,
+						L_DBUS_INTERFACE_PROPERTIES,
+						NULL)) {
+		l_info("Unable to instantiate the properties interface");
+
+		if (!l_dbus_object_remove_interface(dbus, AD_PATH, AD_IFACE))
+			l_info("Unable to remove ad instance");
+		if (!l_dbus_unregister_interface(dbus, AD_IFACE))
+			l_info("Unable to unregister ad interface");
+
+		goto failed;
+	}
+
+	ad_init();
+
+	if (adapter->current_settings & BTP_GAP_SETTING_CONNECTABLE)
+		ad.type = "peripheral";
+	else
+		ad.type = "broadcast";
+
+	if (cp->adv_data_len > 0)
+		create_advertising_data(cp->adv_data_len, cp->data);
+	if (cp->scan_rsp_len > 0)
+		create_scan_response(cp->scan_rsp_len,
+						cp->data + cp->scan_rsp_len);
+
+	if (!l_dbus_proxy_method_call(adapter->ad_proxy,
+							"RegisterAdvertisement",
+							start_advertising_setup,
+							start_advertising_reply,
+							NULL, NULL)) {
+		if (!l_dbus_object_remove_interface(dbus, AD_PATH, AD_IFACE))
+			l_info("Unable to remove ad instance");
+		if (!l_dbus_unregister_interface(dbus, AD_IFACE))
+			l_info("Unable to unregister ad interface");
+
+		goto failed;
+	}
+
+	return;
+
+failed:
+	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
+}
+
+static void stop_advertising_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	const char *path = l_dbus_proxy_get_path(proxy);
+	struct btp_adapter *adapter = find_adapter_by_path(path);
+	uint32_t new_settings;
+
+	if (!adapter)
+		return;
+
+	if (l_dbus_message_is_error(result)) {
+		const char *name;
+
+		l_dbus_message_get_error(result, &name, NULL);
+
+		l_error("Failed to stop advertising %s (%s)",
+					l_dbus_proxy_get_path(proxy), name);
+		return;
+	}
+
+	if (!l_dbus_object_remove_interface(dbus, AD_PATH, AD_IFACE))
+		l_info("Unable to remove ad instance");
+	if (!l_dbus_object_remove_interface(dbus, AD_PATH,
+						L_DBUS_INTERFACE_PROPERTIES))
+		l_info("Unable to remove propety instance");
+	if (!l_dbus_unregister_interface(dbus, AD_IFACE))
+		l_info("Unable to unregister ad interface");
+
+	new_settings = adapter->current_settings;
+	new_settings &= ~BTP_GAP_SETTING_ADVERTISING;
+	update_current_settings(adapter, new_settings);
+
+	ad_cleanup();
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_STOP_ADVERTISING,
+					adapter->index, sizeof(new_settings),
+					&new_settings);
+}
+
+static void btp_gap_stop_advertising(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	uint8_t status = BTP_ERROR_FAIL;
+	bool prop;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &prop) ||
+							!prop || !ad.registered)
+		goto failed;
+
+	if (adapter->ad_proxy) {
+		if (!l_dbus_proxy_method_call(adapter->ad_proxy,
+						"UnregisterAdvertisement",
+						unreg_advertising_setup,
+						stop_advertising_reply,
+						NULL, NULL)) {
+			status = BTP_ERROR_FAIL;
+			goto failed;
+		}
+	}
+
+	return;
+
+failed:
+	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
+}
+
 static void start_discovery_reply(struct l_dbus_proxy *proxy,
 						struct l_dbus_message *result,
 						void *user_data)
@@ -723,6 +1368,12 @@ static void register_gap_service(void)
 	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_SET_BONDABLE,
 					btp_gap_set_bondable, NULL, NULL);
 
+	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_START_ADVERTISING,
+					btp_gap_start_advertising, NULL, NULL);
+
+	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_STOP_ADVERTISING,
+					btp_gap_stop_advertising, NULL, NULL);
+
 	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_START_DISCOVERY,
 					btp_gap_start_discovery, NULL, NULL);
 
@@ -1119,6 +1770,12 @@ static void client_ready(struct l_dbus_client *client, void *user_data)
 					BTP_INDEX_NON_CONTROLLER, 0, NULL);
 }
 
+static void ready_callback(void *user_data)
+{
+	if (!l_dbus_object_manager_enable(dbus))
+		l_info("Unable to register the ObjectManager");
+}
+
 static void usage(void)
 {
 	l_info("btpclient - Bluetooth tester");
@@ -1143,7 +1800,6 @@ int main(int argc, char *argv[])
 {
 	struct l_dbus_client *client;
 	struct l_signal *signal;
-	struct l_dbus *dbus;
 	sigset_t mask;
 	int opt;
 
@@ -1187,6 +1843,7 @@ int main(int argc, char *argv[])
 	signal = l_signal_create(&mask, signal_handler, NULL, NULL);
 
 	dbus = l_dbus_new_default(L_DBUS_SYSTEM_BUS);
+	l_dbus_set_ready_handler(dbus, ready_callback, NULL, NULL);
 	client = l_dbus_client_new(dbus, "org.bluez", "/org/bluez");
 
 	l_dbus_client_set_connect_handler(client, client_connected, NULL, NULL);
-- 
2.13.6


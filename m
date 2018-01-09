Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] tools/btpclient: Add start, stop advertising commands
Date: Tue,  9 Jan 2018 16:45:19 +0100
Message-Id: <20180109154521.30947-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds start and stop advertising commands for btp client.
---
 tools/btpclient.c | 661 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 660 insertions(+), 1 deletion(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 806403f6a..472e9e4c2 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -34,6 +34,19 @@
 
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
+struct l_dbus *dbus;
+
 struct btp_adapter {
 	struct l_dbus_proxy *proxy;
 	struct l_dbus_proxy *ad_proxy;
@@ -53,12 +66,64 @@ static struct btp *btp;
 
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
+	char **uuids;
+	size_t uuids_cnt;
+	struct service_data *services;
+	size_t services_data_len;
+	struct manufacturer_data *manufacturer;
+	size_t manufacturer_data_len;
+	bool tx_power;
+	bool name;
+	bool appearance;
+} ad = {
+	.local_appearance = UINT16_MAX,
+};
+
 static bool str2addr(const char *str, uint8_t *addr)
 {
 	return sscanf(str, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &addr[5], &addr[4],
 				&addr[3], &addr[2], &addr[1], &addr[0]) == 6;
 }
 
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
@@ -123,6 +188,8 @@ static void btp_gap_read_commands(uint8_t index, const void *param,
 	commands |= (1 << BTP_OP_GAP_SET_CONNECTABLE);
 	commands |= (1 << BTP_OP_GAP_SET_DISCOVERABLE);
 	commands |= (1 << BTP_OP_GAP_SET_BONDABLE);
+	commands |= (1 << BTP_OP_GAP_START_ADVERTISING);
+	commands |= (1 << BTP_OP_GAP_STOP_ADVERTISING);
 	commands |= (1 << BTP_OP_GAP_START_DISCOVERY);
 	commands |= (1 << BTP_OP_GAP_STOP_DISCOVERY);
 
@@ -234,6 +301,46 @@ static void remove_device_reply(struct l_dbus_proxy *proxy,
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
@@ -264,6 +371,16 @@ static void btp_gap_reset(uint8_t index, const void *param, uint16_t length,
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
@@ -449,6 +566,536 @@ failed:
 	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
 }
 
+static struct l_dbus_message *ad_release_call(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct l_dbus_message *reply;
+	uint8_t i;
+
+	l_dbus_unregister_object(dbus, AD_PATH);
+	l_dbus_unregister_interface(dbus, AD_IFACE);
+
+	reply = l_dbus_message_new_method_return(message);
+	l_dbus_message_set_arguments(reply, "");
+
+	for (i = 0; i < ad.uuids_cnt; i++)
+		l_free(ad.uuids[i]);
+	l_free(ad.uuids);
+	ad.uuids_cnt = 0;
+
+	l_free(ad.local_name);
+
+	for (i = 0; i < ad.services_data_len; i++)
+		l_free(ad.services[i].uuid);
+	l_free(ad.services);
+	ad.services_data_len = 0;
+
+	l_free(ad.manufacturer);
+	ad.manufacturer_data_len = 0;
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
+	size_t i;
+
+	if (!ad.uuids_cnt)
+		return false;
+
+	l_dbus_message_builder_enter_array(builder, "s");
+
+	for (i = 0; i < ad.uuids_cnt; i++)
+		l_dbus_message_builder_append_basic(builder, 's', ad.uuids[i]);
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
+	const uint8_t *array;
+	size_t i, j;
+
+	if (!ad.services_data_len)
+		return false;
+
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+
+	for (j = 0; j < ad.services_data_len; j++) {
+		array = ad.services[j].data.data;
+
+		l_dbus_message_builder_enter_dict(builder, "sv");
+		l_dbus_message_builder_append_basic(builder, 's',
+							ad.services[j].uuid);
+		l_dbus_message_builder_enter_variant(builder, "ay");
+		l_dbus_message_builder_enter_array(builder, "y");
+
+		for (i = 0; i < ad.services[j].data.len; i++)
+			l_dbus_message_builder_append_basic(builder, 'y',
+								&(array[i]));
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
+	const uint8_t *array;
+	size_t i, j;
+
+	if (!ad.manufacturer_data_len)
+		return false;
+
+	l_dbus_message_builder_enter_array(builder, "{qv}");
+
+	for (j = 0; j < ad.manufacturer_data_len; j++) {
+		array = ad.manufacturer[j].data.data;
+
+		l_dbus_message_builder_enter_dict(builder, "qv");
+		l_dbus_message_builder_append_basic(builder, 'q',
+							&ad.manufacturer[j].id);
+		l_dbus_message_builder_enter_variant(builder, "ay");
+		l_dbus_message_builder_enter_array(builder, "y");
+
+		for (i = 0; i < ad.manufacturer[j].data.len; i++)
+			l_dbus_message_builder_append_basic(builder, 'y',
+								&(array[i]));
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
+	l_dbus_interface_method(interface, "Release", 0, ad_release_call, "",
+									"");
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
+	return;
+}
+
+static void start_advertising_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	const char *path = l_dbus_proxy_get_path(proxy);
+	struct btp_adapter *adapter = find_adapter_by_path(path);
+	uint32_t settings;
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
+	settings = L_CPU_TO_LE32(adapter->current_settings);
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_START_ADVERTISING,
+				adapter->index, sizeof(settings), &settings);
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
+			ad.uuids_cnt += 1;
+			ad.uuids = realloc(ad.uuids,
+					ad.uuids_cnt * sizeof(ad.uuids));
+			ad.uuids[ad.uuids_cnt - 1] = dupuuid2str(ad_data, 16);
+
+			break;
+		case AD_TYPE_SHORT_NAME:
+			ad.local_name = malloc(ad_len + 1);
+			memcpy(ad.local_name, ad_data, ad_len);
+			ad.local_name[ad_len] = '\0';
+
+			break;
+		case AD_TYPE_SERVICE_DATA_UUID16:
+		{
+			uint8_t svc_id;
+
+			ad.services_data_len += 1;
+			svc_id = ad.services_data_len - 1;
+			ad.services = l_realloc(ad.services,
+						sizeof(struct service_data) *
+						ad.services_data_len);
+			/* The first 2 octets contain the 16 bit Service UUID
+			 * followed by additional service data
+			 */
+			ad.services[svc_id].uuid = dupuuid2str(ad_data, 16);
+			ad.services[svc_id].data.len = ad_len - 2;
+			memcpy(ad.services[svc_id].data.data, ad_data + 2,
+						ad.services[svc_id].data.len);
+
+			break;
+		}
+		case AD_TYPE_APPEARANCE:
+			memcpy(&ad.local_appearance, ad_data, ad_len);
+
+			break;
+		case AD_TYPE_MANUFACTURER_DATA:
+		{
+			uint8_t md_id;
+
+			ad.manufacturer_data_len += 1;
+			md_id = ad.manufacturer_data_len - 1;
+			ad.manufacturer = l_realloc(ad.manufacturer,
+					sizeof(struct manufacturer_data) *
+					ad.manufacturer_data_len);
+			/* The first 2 octets contain the Company Identifier
+			 * Code followed by additional manufacturer specific
+			 * data.
+			 */
+			memcpy(&ad.manufacturer[md_id].id, ad_data, 2);
+			ad.manufacturer[md_id].data.len = ad_len - 2;
+			memcpy(&ad.manufacturer[md_id].data.data, ad_data + 2,
+					ad.manufacturer[md_id].data.len);
+
+			break;
+		}
+		}
+		/* Advertising entity data len + advertising entity header
+		 * (type, len)
+		 */
+		remaining_data_len -= ad_len + 2;
+	}
+}
+
+struct start_advertising_data {
+	uint32_t settings;
+	struct btp_gap_start_adv_cp cp;
+};
+
+static void create_scan_response(uint8_t scan_rsp_len, const uint8_t *data)
+{
+	/* TODO */
+}
+
+static void start_advertising_setup(struct l_dbus_message *message,
+							void *user_data)
+{
+	const struct start_advertising_data *sad = user_data;
+	const struct btp_gap_start_adv_cp *cp = &sad->cp;
+	struct l_dbus_message_builder *builder;
+
+	if ((sad->settings >> BTP_GAP_SETTING_CONNECTABLE) & 1U)
+		ad.type = l_strdup("peripheral");
+	else
+		ad.type = l_strdup("broadcast");
+
+	if (cp->adv_data_len != 0)
+		create_advertising_data(cp->adv_data_len, cp->data);
+	if (cp->scan_rsp_len != 0)
+		create_scan_response(cp->scan_rsp_len,
+						cp->data + cp->scan_rsp_len);
+
+	free(user_data);
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
+	struct start_advertising_data *data;
+	uint8_t status = BTP_ERROR_FAIL;
+	bool prop;
+	void *buff;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	/* Adapter needs to be powered to be able to remove devices */
+	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &prop) ||
+									!prop)
+		goto failed;
+
+	if (!l_dbus_register_interface(dbus, AD_IFACE, setup_ad_interface, NULL,
+									false)) {
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
+	buff = l_malloc(sizeof(struct start_advertising_data) +
+					cp->adv_data_len + cp->scan_rsp_len);
+	data = buff;
+	data->settings = adapter->current_settings;
+	data->cp.adv_data_len = cp->adv_data_len;
+	data->cp.scan_rsp_len = cp->scan_rsp_len;
+	memcpy(data->cp.data, cp->data, cp->adv_data_len + cp->scan_rsp_len);
+
+	if (!l_dbus_proxy_method_call(adapter->ad_proxy,
+							"RegisterAdvertisement",
+							start_advertising_setup,
+							start_advertising_reply,
+							data, NULL)) {
+		if (!l_dbus_object_remove_interface(dbus, AD_PATH, AD_IFACE))
+			l_info("Unable to remove ad instance");
+		if (!l_dbus_unregister_interface(dbus, AD_IFACE))
+			l_info("Unable to unregister ad interface");
+
+		free(buff);
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
+	uint32_t settings;
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
+	settings = L_CPU_TO_LE32(adapter->current_settings);
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_STOP_ADVERTISING,
+				adapter->index, sizeof(settings), &settings);
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
+									!prop)
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
+failed:
+	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
+}
+
 static void start_discovery_reply(struct l_dbus_proxy *proxy,
 						struct l_dbus_message *result,
 						void *user_data)
@@ -728,6 +1375,12 @@ static void register_gap_service(void)
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
 
@@ -1124,6 +1777,12 @@ static void client_ready(struct l_dbus_client *client, void *user_data)
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
@@ -1148,7 +1807,6 @@ int main(int argc, char *argv[])
 {
 	struct l_dbus_client *client;
 	struct l_signal *signal;
-	struct l_dbus *dbus;
 	sigset_t mask;
 	int opt;
 
@@ -1192,6 +1850,7 @@ int main(int argc, char *argv[])
 	signal = l_signal_create(&mask, signal_handler, NULL, NULL);
 
 	dbus = l_dbus_new_default(L_DBUS_SYSTEM_BUS);
+	l_dbus_set_ready_handler(dbus, ready_callback, NULL, NULL);
 	client = l_dbus_client_new(dbus, "org.bluez", "/org/bluez");
 
 	l_dbus_client_set_connect_handler(client, client_connected, NULL, NULL);
-- 
2.13.6


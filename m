Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/5] tools/btpclient: Add set io capabilities command
Date: Fri, 26 Jan 2018 11:54:02 +0100
Message-Id: <20180126105402.31682-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for set io capabilities command.
---
 tools/btpclient.c | 570 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 567 insertions(+), 3 deletions(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index bdc404dd9..22142aecb 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -36,7 +36,9 @@
 #include "src/shared/btp.h"
 
 #define AD_PATH "/org/bluez/advertising"
+#define AG_PATH "/org/bluez/agent"
 #define AD_IFACE "org.bluez.LEAdvertisement1"
+#define AG_IFACE "org.bluez.Agent1"
 
 /* List of assigned numbers for advetising data and scan response */
 #define AD_TYPE_FLAGS				0x01
@@ -46,6 +48,8 @@
 #define AD_TYPE_APPEARANCE			0x19
 #define AD_TYPE_MANUFACTURER_DATA		0xff
 
+static void register_gap_service(void);
+
 static struct l_dbus *dbus;
 
 struct btp_adapter {
@@ -98,6 +102,12 @@ static struct ad {
 	bool appearance;
 } ad;
 
+static struct btp_agent {
+	bool registered;
+	struct l_dbus_proxy *proxy;
+	struct l_dbus_message *pending_req;
+} ag;
+
 static char *dupuuid2str(const uint8_t *uuid, uint8_t len)
 {
 	switch (len) {
@@ -199,6 +209,31 @@ static struct btp_device *find_device_by_address(struct btp_adapter *adapter,
 	return NULL;
 }
 
+static bool match_device_paths(const void *device, const void *path)
+{
+	const struct btp_device *dev = device;
+
+	return !strcmp(l_dbus_proxy_get_path(dev->proxy), path);
+}
+
+static struct btp_device *find_device_by_path(const char *path)
+{
+	const struct l_queue_entry *entry;
+	struct btp_device *device;
+
+	for (entry = l_queue_get_entries(adapters); entry;
+							entry = entry->next) {
+		struct btp_adapter *adapter = entry->data;
+
+		device = l_queue_find(adapter->devices, match_device_paths,
+									path);
+		if (device)
+			return device;
+	}
+
+	return NULL;
+}
+
 static bool match_adapter_dev_proxy(const void *device, const void *proxy)
 {
 	const struct btp_device *d = device;
@@ -270,6 +305,7 @@ static void btp_gap_read_commands(uint8_t index, const void *param,
 	commands |= (1 << BTP_OP_GAP_STOP_DISCOVERY);
 	commands |= (1 << BTP_OP_GAP_CONNECT);
 	commands |= (1 << BTP_OP_GAP_DISCONNECT);
+	commands |= (1 << BTP_OP_GAP_SET_IO_CAPA);
 
 	commands = L_CPU_TO_LE16(commands);
 
@@ -439,6 +475,43 @@ static void unreg_advertising_reply(struct l_dbus_proxy *proxy,
 	ad_cleanup();
 }
 
+static void unreg_agent_setup(struct l_dbus_message *message, void *user_data)
+{
+	struct l_dbus_message_builder *builder;
+
+	builder = l_dbus_message_builder_new(message);
+
+	l_dbus_message_builder_append_basic(builder, 'o', AG_PATH);
+
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+}
+
+static void reset_unreg_agent_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	if (l_dbus_message_is_error(result)) {
+		const char *name;
+
+		l_dbus_message_get_error(result, &name, NULL);
+
+		l_error("Failed to unregister agent %s (%s)",
+					l_dbus_proxy_get_path(proxy), name);
+		return;
+	}
+
+	if (!l_dbus_object_remove_interface(dbus, AG_PATH,
+						L_DBUS_INTERFACE_PROPERTIES))
+		l_info("Unable to remove propety instance");
+	if (!l_dbus_object_remove_interface(dbus, AG_PATH, AG_IFACE))
+		l_info("Unable to remove agent instance");
+	if (!l_dbus_unregister_interface(dbus, AG_IFACE))
+		l_info("Unable to unregister agent interface");
+
+	ag.registered = false;
+}
+
 static void btp_gap_reset(uint8_t index, const void *param, uint16_t length,
 								void *user_data)
 {
@@ -479,6 +552,15 @@ static void btp_gap_reset(uint8_t index, const void *param, uint16_t length,
 			goto failed;
 		}
 
+	if (ag.proxy && ag.registered)
+		if (!l_dbus_proxy_method_call(ag.proxy, "UnregisterAgent",
+						unreg_agent_setup,
+						reset_unreg_agent_reply,
+						NULL, NULL)) {
+			status = BTP_ERROR_FAIL;
+			goto failed;
+		}
+
 	adapter->current_settings = adapter->default_settings;
 
 	/* TODO for we assume all went well */
@@ -1518,6 +1600,476 @@ failed:
 	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
 }
 
+static struct l_dbus_message *ag_release_call(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct l_dbus_message *reply;
+
+	reply = l_dbus_message_new_method_return(message);
+	l_dbus_message_set_arguments(reply, "");
+
+	return reply;
+}
+
+static struct l_dbus_message *ag_request_passkey_call(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct btp_gap_passkey_req_ev ev;
+	struct btp_device *device;
+	struct btp_adapter *adapter;
+	const char *path, *str_addr, *str_addr_type;
+
+	l_dbus_message_get_arguments(message, "o", &path);
+
+	device = find_device_by_path(path);
+
+	if (!l_dbus_proxy_get_property(device->proxy, "Address", "s", &str_addr)
+		|| !l_dbus_proxy_get_property(device->proxy, "AddressType", "s",
+		&str_addr_type)) {
+		l_info("Cannot get device properties");
+
+		return NULL;
+	}
+
+	ev.address_type = strcmp(str_addr_type, "public") ?
+							BTP_GAP_ADDR_RANDOM :
+							BTP_GAP_ADDR_PUBLIC;
+	if (!str2ba(str_addr, &ev.address))
+		return NULL;
+
+	adapter = find_adapter_by_device(device);
+
+	ag.pending_req = l_dbus_message_ref(message);
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_PASSKEY_REQUEST,
+					adapter->index, sizeof(ev), &ev);
+
+	return NULL;
+}
+
+static struct l_dbus_message *ag_display_passkey_call(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct l_dbus_message *reply;
+
+	reply = l_dbus_message_new_method_return(message);
+	l_dbus_message_set_arguments(reply, "");
+
+	return reply;
+}
+
+static struct l_dbus_message *ag_request_confirmation_call(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct l_dbus_message *reply;
+
+	reply = l_dbus_message_new_method_return(message);
+	l_dbus_message_set_arguments(reply, "");
+
+	return reply;
+}
+
+static struct l_dbus_message *ag_request_authorization_call(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct l_dbus_message *reply;
+
+	reply = l_dbus_message_new_method_return(message);
+	l_dbus_message_set_arguments(reply, "");
+
+	return reply;
+}
+
+static struct l_dbus_message *ag_authorize_service_call(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct l_dbus_message *reply;
+
+	reply = l_dbus_message_new_method_return(message);
+	l_dbus_message_set_arguments(reply, "");
+
+	return reply;
+}
+
+static struct l_dbus_message *ag_cancel_call(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct l_dbus_message *reply;
+
+	reply = l_dbus_message_new_method_return(message);
+	l_dbus_message_set_arguments(reply, "");
+
+	return reply;
+}
+
+static void setup_ag_interface(struct l_dbus_interface *iface)
+{
+	l_dbus_interface_method(iface, "Release", 0, ag_release_call, "", "");
+	l_dbus_interface_method(iface, "RequestPasskey", 0,
+					ag_request_passkey_call, "u", "o",
+					"passkey", "device");
+	l_dbus_interface_method(iface, "DisplayPasskey", 0,
+					ag_display_passkey_call, "", "ouq",
+					"device", "passkey", "entered");
+	l_dbus_interface_method(iface, "RequestConfirmation", 0,
+					ag_request_confirmation_call, "", "ou",
+					"device", "passkey");
+	l_dbus_interface_method(iface, "RequestAuthorization", 0,
+					ag_request_authorization_call, "", "o",
+					"device");
+	l_dbus_interface_method(iface, "AuthorizeService", 0,
+					ag_authorize_service_call, "", "os",
+					"device", "uuid");
+	l_dbus_interface_method(iface, "Cancel", 0, ag_cancel_call, "", "");
+}
+
+struct set_io_capabilities_data {
+	uint8_t capa;
+	struct btp_adapter *adapter;
+};
+
+static void set_io_capabilities_setup(struct l_dbus_message *message,
+								void *user_data)
+{
+	struct set_io_capabilities_data *sicd = user_data;
+	struct l_dbus_message_builder *builder;
+	char *capa_str;
+
+	builder = l_dbus_message_builder_new(message);
+
+	l_dbus_message_builder_append_basic(builder, 'o', AG_PATH);
+
+	switch (sicd->capa) {
+	case BTP_GAP_IOCAPA_DISPLAY_ONLY:
+		capa_str = "DisplayOnly";
+		break;
+	case BTP_GAP_IOCAPA_DISPLAY_YESNO:
+		capa_str = "DisplayYesNo";
+		break;
+	case BTP_GAP_IOCAPA_KEYBOARD_ONLY:
+		capa_str = "KeyboardOnly";
+		break;
+	case BTP_GAP_IOCAPA_KEYBOARD_DISPLAY:
+		capa_str = "KeyboardDisplay";
+		break;
+	case BTP_GAP_IOCAPA_NO_INPUT_NO_OUTPUT:
+	default:
+		capa_str = "NoInputNoOutput";
+		break;
+	}
+
+	l_dbus_message_builder_append_basic(builder, 's', capa_str);
+
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+}
+
+static void reg_def_req_default_agent_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	if (l_dbus_message_is_error(result)) {
+		const char *name, *desc;
+
+		if (!l_dbus_object_remove_interface(dbus, AG_PATH, AG_IFACE))
+			l_info("Unable to remove agent instance");
+		if (!l_dbus_unregister_interface(dbus, AG_IFACE))
+			l_info("Unable to unregister agent interface");
+
+		l_dbus_message_get_error(result, &name, &desc);
+		l_error("Failed to request default agent (%s), %s", name, desc);
+
+		btp_send_error(btp, BTP_CORE_SERVICE, BTP_INDEX_NON_CONTROLLER,
+								BTP_ERROR_FAIL);
+		return;
+	}
+
+	register_gap_service();
+	gap_service_registered = true;
+
+	ag.registered = true;
+
+	btp_send(btp, BTP_CORE_SERVICE, BTP_OP_CORE_REGISTER,
+					BTP_INDEX_NON_CONTROLLER, 0, NULL);
+}
+
+static void set_io_req_default_agent_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	struct btp_adapter *adapter = user_data;
+
+	if (!adapter) {
+		btp_send_error(btp, BTP_GAP_SERVICE, BTP_INDEX_NON_CONTROLLER,
+								BTP_ERROR_FAIL);
+		goto failed;
+	}
+
+	if (l_dbus_message_is_error(result)) {
+		const char *name, *desc;
+
+		l_dbus_message_get_error(result, &name, &desc);
+		l_error("Failed to set io capabilities (%s), %s", name, desc);
+
+		btp_send_error(btp, BTP_GAP_SERVICE, adapter->index,
+								BTP_ERROR_FAIL);
+		goto failed;
+	}
+
+	ag.registered = true;
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_SET_IO_CAPA,
+						adapter->index, 0, NULL);
+
+	return;
+
+failed:
+	if (!l_dbus_object_remove_interface(dbus, AG_PATH, AG_IFACE))
+		l_info("Unable to remove agent instance");
+	if (!l_dbus_unregister_interface(dbus, AG_IFACE))
+		l_info("Unable to unregister agent interface");
+}
+
+static void request_default_agent_setup(struct l_dbus_message *message,
+								void *user_data)
+{
+	struct l_dbus_message_builder *builder;
+
+	builder = l_dbus_message_builder_new(message);
+
+	l_dbus_message_builder_append_basic(builder, 'o', AG_PATH);
+
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+}
+
+static void set_io_capabilities_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	struct set_io_capabilities_data *sicd = user_data;
+
+	if (!sicd->adapter) {
+		btp_send_error(btp, BTP_GAP_SERVICE, BTP_INDEX_NON_CONTROLLER,
+								BTP_ERROR_FAIL);
+		goto failed;
+	}
+
+	if (l_dbus_message_is_error(result)) {
+		const char *name, *desc;
+
+		l_dbus_message_get_error(result, &name, &desc);
+		l_error("Failed to set io capabilities (%s), %s", name, desc);
+
+		btp_send_error(btp, BTP_GAP_SERVICE, sicd->adapter->index,
+								BTP_ERROR_FAIL);
+		goto failed;
+	}
+
+	if (l_dbus_proxy_method_call(ag.proxy, "RequestDefaultAgent",
+						request_default_agent_setup,
+						set_io_req_default_agent_reply,
+						sicd->adapter, NULL))
+		return;
+
+failed:
+	if (!l_dbus_object_remove_interface(dbus, AG_PATH, AG_IFACE))
+		l_info("Unable to remove agent instance");
+	if (!l_dbus_unregister_interface(dbus, AG_IFACE))
+		l_info("Unable to unregister agent interface");
+}
+
+static void register_default_agent_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	const char *name, *desc;
+
+	if (l_dbus_message_is_error(result)) {
+		if (!l_dbus_object_remove_interface(dbus, AG_PATH, AG_IFACE))
+			l_info("Unable to remove agent instance");
+		if (!l_dbus_unregister_interface(dbus, AG_IFACE))
+			l_info("Unable to unregister agent interface");
+
+		l_dbus_message_get_error(result, &name, &desc);
+		l_error("Failed to register default agent (%s), %s", name,
+									desc);
+		return;
+	}
+
+	if (!l_dbus_proxy_method_call(ag.proxy, "RequestDefaultAgent",
+						request_default_agent_setup,
+						reg_def_req_default_agent_reply,
+						NULL, NULL)) {
+		if (!l_dbus_object_remove_interface(dbus, AG_PATH, AG_IFACE))
+			l_info("Unable to remove agent instance");
+		if (!l_dbus_unregister_interface(dbus, AG_IFACE))
+			l_info("Unable to unregister agent interface");
+	}
+}
+
+static void set_io_capabilities_destroy(void *user_data)
+{
+	l_free(user_data);
+}
+
+static bool register_default_agent(struct btp_adapter *adapter, uint8_t capa,
+				l_dbus_client_proxy_result_func_t set_io_cb)
+{
+	struct set_io_capabilities_data *data;
+
+	if (!l_dbus_register_interface(dbus, AG_IFACE, setup_ag_interface, NULL,
+								false)) {
+		l_info("Unable to register agent interface");
+		return false;
+	}
+
+	if (!l_dbus_object_add_interface(dbus, AG_PATH, AG_IFACE, NULL)) {
+		l_info("Unable to instantiate agent interface");
+
+		if (!l_dbus_unregister_interface(dbus, AG_IFACE))
+			l_info("Unable to unregister agent interface");
+
+		return false;
+	}
+
+	if (!l_dbus_object_add_interface(dbus, AG_PATH,
+						L_DBUS_INTERFACE_PROPERTIES,
+						NULL)) {
+		l_info("Unable to instantiate the ag properties interface");
+
+		if (!l_dbus_object_remove_interface(dbus, AG_PATH, AG_IFACE))
+			l_info("Unable to remove agent instance");
+		if (!l_dbus_unregister_interface(dbus, AG_IFACE))
+			l_info("Unable to unregister agent interface");
+
+		return false;
+	}
+
+	data = l_new(struct set_io_capabilities_data, 1);
+	data->adapter = adapter;
+	data->capa = capa;
+
+	if (!l_dbus_proxy_method_call(ag.proxy, "RegisterAgent",
+					set_io_capabilities_setup, set_io_cb,
+					data, set_io_capabilities_destroy)) {
+		if (!l_dbus_object_remove_interface(dbus, AG_PATH, AG_IFACE))
+			l_info("Unable to remove agent instance");
+		if (!l_dbus_unregister_interface(dbus, AG_IFACE))
+			l_info("Unable to unregister agent interface");
+
+		return false;
+	}
+
+	return true;
+}
+
+struct rereg_unreg_agent_data {
+	struct btp_adapter *adapter;
+	l_dbus_client_proxy_result_func_t cb;
+	uint8_t capa;
+};
+
+static void rereg_unreg_agent_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	struct rereg_unreg_agent_data *ruad = user_data;
+
+	if (l_dbus_message_is_error(result)) {
+		const char *name;
+
+		l_dbus_message_get_error(result, &name, NULL);
+
+		l_error("Failed to unregister agent %s (%s)",
+					l_dbus_proxy_get_path(proxy), name);
+		return;
+	}
+
+	if (!l_dbus_object_remove_interface(dbus, AG_PATH,
+						L_DBUS_INTERFACE_PROPERTIES))
+		l_info("Unable to remove propety instance");
+	if (!l_dbus_object_remove_interface(dbus, AG_PATH, AG_IFACE))
+		l_info("Unable to remove agent instance");
+	if (!l_dbus_unregister_interface(dbus, AG_IFACE))
+		l_info("Unable to unregister agent interface");
+
+	ag.registered = false;
+
+	if (!register_default_agent(ruad->adapter, ruad->capa, ruad->cb))
+		btp_send_error(btp, BTP_GAP_SERVICE, ruad->adapter->index,
+								BTP_ERROR_FAIL);
+}
+
+static void rereg_unreg_agent_destroy(void *rereg_unreg_agent_data)
+{
+	l_free(rereg_unreg_agent_data);
+}
+
+static void btp_gap_set_io_capabilities(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	const struct btp_gap_set_io_capa_cp *cp = param;
+	uint8_t status = BTP_ERROR_FAIL;
+	struct rereg_unreg_agent_data *data;
+	bool prop;
+
+	switch (cp->capa) {
+	case BTP_GAP_IOCAPA_DISPLAY_ONLY:
+	case BTP_GAP_IOCAPA_DISPLAY_YESNO:
+	case BTP_GAP_IOCAPA_KEYBOARD_ONLY:
+	case BTP_GAP_IOCAPA_NO_INPUT_NO_OUTPUT:
+	case BTP_GAP_IOCAPA_KEYBOARD_DISPLAY:
+		break;
+	default:
+		l_error("Wrong iocapa given!");
+
+		goto failed;
+	}
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	/* Adapter needs to be powered to be able to set io cap */
+	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &prop) ||
+									!prop)
+		goto failed;
+
+	if (ag.registered) {
+		data = l_new(struct rereg_unreg_agent_data, 1);
+		data->adapter = adapter;
+		data->capa = cp->capa;
+		data->cb = set_io_capabilities_reply;
+
+		if (!l_dbus_proxy_method_call(ag.proxy, "UnregisterAgent",
+						unreg_agent_setup,
+						rereg_unreg_agent_reply, data,
+						rereg_unreg_agent_destroy))
+			goto failed;
+
+		return;
+	}
+
+	if (!register_default_agent(adapter, cp->capa,
+						set_io_capabilities_reply))
+		goto failed;
+
+	return;
+
+failed:
+	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
+}
+
 static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 {
 	struct btp_device_found_ev ev;
@@ -1639,6 +2191,9 @@ static void register_gap_service(void)
 
 	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_DISCONNECT,
 						btp_gap_disconnect, NULL, NULL);
+
+	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_SET_IO_CAPA,
+				btp_gap_set_io_capabilities, NULL, NULL);
 }
 
 static void btp_core_read_commands(uint8_t index, const void *param,
@@ -1698,9 +2253,12 @@ static void btp_core_register(uint8_t index, const void *param,
 		if (gap_service_registered)
 			goto failed;
 
-		register_gap_service();
-		gap_service_registered = true;
-		break;
+		if (!register_default_agent(NULL,
+					BTP_GAP_IOCAPA_NO_INPUT_NO_OUTPUT,
+					register_default_agent_reply))
+			goto failed;
+
+		return;
 	case BTP_GATT_SERVICE:
 	case BTP_L2CAP_SERVICE:
 	case BTP_MESH_NODE_SERVICE:
@@ -1896,6 +2454,12 @@ static void proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 
 		return;
 	}
+
+	if (!strcmp(interface, "org.bluez.AgentManager1")) {
+		ag.proxy = proxy;
+
+		return;
+	}
 }
 
 static bool device_match_by_proxy(const void *a, const void *b)
-- 
2.13.6


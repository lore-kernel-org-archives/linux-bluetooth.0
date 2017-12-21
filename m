Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] tools/btpclient: Add start, stop discovery commands
Date: Thu, 21 Dec 2017 17:47:19 +0100
Message-Id: <20171221164720.20925-5-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20171221164720.20925-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20171221164720.20925-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds start and stop discovery command for btp client.
---
 tools/btpclient.c | 220 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 220 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index c0ad03b68..f4b930a51 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -122,6 +122,8 @@ static void btp_gap_read_commands(uint8_t index, const void *param,
 	commands |= (1 << BTP_OP_GAP_SET_POWERED);
 	commands |= (1 << BTP_OP_GAP_SET_DISCOVERABLE);
 	commands |= (1 << BTP_OP_GAP_SET_BONDABLE);
+	commands |= (1 << BTP_OP_GAP_START_DISCOVERY);
+	commands |= (1 << BTP_OP_GAP_STOP_DISCOVERY);
 
 	commands = L_CPU_TO_LE16(commands);
 
@@ -399,6 +401,218 @@ failed:
 	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
 }
 
+static void start_discovery_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_proxy(proxy);
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
+		l_error("Failed to start discovery (%s), %s", name, desc);
+
+		btp_send_error(btp, BTP_GAP_SERVICE, adapter->index,
+								BTP_ERROR_FAIL);
+		return;
+	}
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_START_DISCOVERY,
+						adapter->index, 0, NULL);
+}
+
+static void set_start_discovery_filter_setup(struct l_dbus_message *message,
+							void *user_data)
+{
+	uint8_t flags = L_PTR_TO_UINT(user_data);
+	struct l_dbus_message_builder *builder;
+
+	builder = l_dbus_message_builder_new(message);
+
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+	l_dbus_message_builder_enter_dict(builder, "sv");
+
+	/* Be in observer mode or in general mode (default in Bluez) */
+	if (flags & BTP_GAP_DISCOVERY_FLAG_OBSERVATION) {
+		l_dbus_message_builder_append_basic(builder, 's', "Transport");
+		l_dbus_message_builder_enter_variant(builder, "s");
+
+		if (flags & (BTP_GAP_DISCOVERY_FLAG_LE |
+						BTP_GAP_DISCOVERY_FLAG_BREDR))
+			l_dbus_message_builder_append_basic(builder, 's',
+									"auto");
+		else if (flags & BTP_GAP_DISCOVERY_FLAG_LE)
+			l_dbus_message_builder_append_basic(builder, 's', "le");
+		else if (flags & BTP_GAP_DISCOVERY_FLAG_BREDR)
+			l_dbus_message_builder_append_basic(builder, 's',
+								"bredr");
+
+		l_dbus_message_builder_leave_variant(builder);
+	}
+
+	l_dbus_message_builder_leave_dict(builder);
+	l_dbus_message_builder_leave_array(builder);
+
+	/* TODO add passive, limited discovery */
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+}
+
+static void set_start_discovery_filter_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_proxy(proxy);
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
+		l_error("Failed to set discovery filter (%s), %s", name, desc);
+
+		btp_send_error(btp, BTP_GAP_SERVICE, adapter->index,
+								BTP_ERROR_FAIL);
+		return;
+	}
+
+	l_dbus_proxy_method_call(adapter->proxy, "StartDiscovery", NULL,
+					start_discovery_reply, NULL, NULL);
+}
+
+static void btp_gap_start_discovery(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	const struct btp_gap_start_discovery_cp *cp = param;
+	bool prop;
+
+	if (!adapter) {
+		btp_send_error(btp, BTP_GAP_SERVICE, index,
+						BTP_ERROR_INVALID_INDEX);
+		return;
+	}
+
+	/* Adapter needs to be powered to start discovery */
+	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &prop) ||
+									!prop) {
+		btp_send_error(btp, BTP_GAP_SERVICE, index, BTP_ERROR_FAIL);
+		return;
+	}
+
+	l_dbus_proxy_method_call(adapter->proxy, "SetDiscoveryFilter",
+					set_start_discovery_filter_setup,
+					set_start_discovery_filter_reply,
+					L_UINT_TO_PTR(cp->flags), NULL);
+}
+
+static void set_stop_discovery_filter_setup(struct l_dbus_message *message,
+							void *user_data)
+{
+	struct l_dbus_message_builder *builder;
+
+	builder = l_dbus_message_builder_new(message);
+
+	/* Clear discovery filter setup */
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_leave_dict(builder);
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+}
+
+static void set_stop_discovery_filter_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_proxy(proxy);
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
+		l_error("Failed to set discovery filter (%s), %s", name, desc);
+
+		btp_send_error(btp, BTP_GAP_SERVICE, adapter->index,
+								BTP_ERROR_FAIL);
+		return;
+	}
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_STOP_DISCOVERY,
+						adapter->index, 0, NULL);
+}
+
+static void stop_discovery_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_proxy(proxy);
+
+	if (!adapter) {
+		btp_send_error(btp, BTP_GAP_SERVICE, BTP_INDEX_NON_CONTROLLER,
+								BTP_ERROR_FAIL);
+		return;
+	}
+
+	if (l_dbus_message_is_error(result)) {
+		const char *name;
+
+		l_dbus_message_get_error(result, &name, NULL);
+		l_error("Failed to stop discovery (%s)", name);
+
+		btp_send_error(btp, BTP_GAP_SERVICE, adapter->index,
+								BTP_ERROR_FAIL);
+		return;
+	}
+
+	l_dbus_proxy_method_call(adapter->proxy, "SetDiscoveryFilter",
+						set_stop_discovery_filter_setup,
+						set_stop_discovery_filter_reply,
+						NULL, NULL);
+}
+
+static void btp_gap_stop_discovery(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	bool prop;
+
+	if (!adapter) {
+		btp_send_error(btp, BTP_GAP_SERVICE, index,
+						BTP_ERROR_INVALID_INDEX);
+		return;
+	}
+
+	/* Adapter needs to be powered to be able to remove devices */
+	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &prop) ||
+									!prop) {
+		btp_send_error(btp, BTP_GAP_SERVICE, index, BTP_ERROR_FAIL);
+		return;
+	}
+
+	l_dbus_proxy_method_call(adapter->proxy, "StopDiscovery", NULL,
+					stop_discovery_reply, NULL, NULL);
+}
+
 static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 {
 	struct btp_device_found_ev ev;
@@ -453,6 +667,12 @@ static void register_gap_service(void)
 
 	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_SET_BONDABLE,
 					btp_gap_set_bondable, NULL, NULL);
+
+	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_START_DISCOVERY,
+					btp_gap_start_discovery, NULL, NULL);
+
+	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_STOP_DISCOVERY,
+					btp_gap_stop_discovery, NULL, NULL);
 }
 
 static void btp_core_read_commands(uint8_t index, const void *param,
-- 
2.13.6


Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] tools/btpclient: Add pair, unpair commands
Date: Thu, 25 Jan 2018 16:53:31 +0100
Message-Id: <20180125155333.12734-3-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180125155333.12734-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180125155333.12734-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds pair and unpair commands for btp client.
---
 tools/btpclient.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 7340a8812..95d369b51 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -306,6 +306,8 @@ static void btp_gap_read_commands(uint8_t index, const void *param,
 	commands |= (1 << BTP_OP_GAP_CONNECT);
 	commands |= (1 << BTP_OP_GAP_DISCONNECT);
 	commands |= (1 << BTP_OP_GAP_SET_IO_CAPA);
+	commands |= (1 << BTP_OP_GAP_PAIR);
+	commands |= (1 << BTP_OP_GAP_UNPAIR);
 
 	commands = L_CPU_TO_LE16(commands);
 
@@ -2058,6 +2060,143 @@ failed:
 	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
 }
 
+static void pair_reply(struct l_dbus_proxy *proxy,
+				struct l_dbus_message *result, void *user_data)
+{
+	uint8_t adapter_index = L_PTR_TO_UINT(user_data);
+	struct btp_adapter *adapter = find_adapter_by_index(adapter_index);
+
+	if (!adapter)
+		return;
+
+	if (l_dbus_message_is_error(result)) {
+		const char *name, *desc;
+
+		l_dbus_message_get_error(result, &name, &desc);
+		l_error("Failed to pair (%s), %s", name, desc);
+
+		return;
+	}
+}
+
+static void btp_gap_pair(uint8_t index, const void *param, uint16_t length,
+								void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	const struct btp_gap_pair_cp *cp = param;
+	uint8_t status = BTP_ERROR_FAIL;
+	struct btp_device *device;
+	bool prop;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	/* Adapter needs to be powered to be able to pair */
+	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &prop) ||
+									!prop)
+		goto failed;
+
+	device = find_device_by_address(adapter, &cp->address,
+							cp->address_type);
+
+	if (!device)
+		goto failed;
+
+	/* This command is asynchronous, send reply immediatelly to not block
+	 * pairing process eg. passkey request.
+	 */
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_PAIR, adapter->index, 0,
+									NULL);
+
+	l_dbus_proxy_method_call(device->proxy, "Pair", NULL, pair_reply,
+					L_UINT_TO_PTR(adapter->index), NULL);
+
+	return;
+
+failed:
+	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
+}
+
+static void unpair_reply(struct l_dbus_proxy *proxy,
+				struct l_dbus_message *result, void *user_data)
+{
+	struct btp_device *device = user_data;
+	struct btp_adapter *adapter = find_adapter_by_device(device);
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
+		l_error("Failed to unpair (%s), %s", name, desc);
+
+		btp_send_error(btp, BTP_GAP_SERVICE, adapter->index,
+								BTP_ERROR_FAIL);
+		return;
+	}
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_UNPAIR, adapter->index, 0,
+									NULL);
+}
+
+static void unpair_setup(struct l_dbus_message *message, void *user_data)
+{
+	struct btp_device *device = user_data;
+	const char *path = l_dbus_proxy_get_path(device->proxy);
+	struct l_dbus_message_builder *builder;
+
+	builder = l_dbus_message_builder_new(message);
+
+	l_dbus_message_builder_append_basic(builder, 'o', path);
+
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+}
+
+static void btp_gap_unpair(uint8_t index, const void *param, uint16_t length,
+								void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	const struct btp_gap_pair_cp *cp = param;
+	uint8_t status = BTP_ERROR_FAIL;
+	struct btp_device *device;
+	bool prop;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	/* Adapter needs to be powered to be able to unpair */
+	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &prop) ||
+									!prop)
+		goto failed;
+
+	device = find_device_by_address(adapter, &cp->address,
+							cp->address_type);
+
+	if (!device)
+		goto failed;
+
+	/* There is no direct unpair method, removing device will clear pairing
+	 * information.
+	 */
+	l_dbus_proxy_method_call(adapter->proxy, "RemoveDevice", unpair_setup,
+						unpair_reply, device, NULL);
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
@@ -2182,6 +2321,12 @@ static void register_gap_service(void)
 
 	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_SET_IO_CAPA,
 				btp_gap_set_io_capabilities, NULL, NULL);
+
+	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_PAIR, btp_gap_pair, NULL,
+									NULL);
+
+	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_UNPAIR, btp_gap_unpair,
+								NULL, NULL);
 }
 
 static void btp_core_read_commands(uint8_t index, const void *param,
-- 
2.13.6


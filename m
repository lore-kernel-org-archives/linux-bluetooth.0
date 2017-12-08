Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH V2 10/10] tools/btpclient: Add support for reseting adapter
Date: Fri,  8 Dec 2017 16:49:25 +0100
Message-Id: <20171208154925.11775-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For now this means only removing all bonded devices.
---
 tools/btpclient.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 89b2d2801..6ffbc8698 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -189,6 +189,77 @@ failed:
 	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
 }
 
+static void remove_device_setup(struct l_dbus_message *message,
+							void *user_data)
+{
+	struct btp_device *device = user_data;
+
+	l_dbus_message_set_arguments(message, "o",
+					l_dbus_proxy_get_path(device->proxy));
+}
+
+static void remove_device_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	struct btp_device *device = user_data;
+	struct btp_adapter *adapter = find_adapter_by_proxy(proxy);
+
+	if (!adapter)
+		return;
+
+	if (l_dbus_message_is_error(result)) {
+		const char *name;
+
+		l_dbus_message_get_error(result, &name, NULL);
+
+		l_error("Failed to remove device %s (%s)",
+					l_dbus_proxy_get_path(device->proxy),
+					name);
+		return;
+	}
+
+	l_queue_remove(adapter->devices, device);
+}
+
+static void btp_gap_reset(uint8_t index, const void *param, uint16_t length,
+								void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	const struct l_queue_entry *entry;
+	uint8_t status;
+	bool prop;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	/* Adapter needs to be powered to be able to remove devices */
+	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &prop) ||
+									!prop) {
+		status = BTP_ERROR_FAIL;
+		goto failed;
+	}
+
+	for (entry = l_queue_get_entries(adapter->devices); entry;
+							entry = entry->next) {
+		struct btp_device *device = entry->data;
+
+		l_dbus_proxy_method_call(adapter->proxy, "RemoveDevice",
+						remove_device_setup,
+						remove_device_reply, device,
+						NULL);
+	}
+
+	/* TODO for we assume all went well */
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_RESET, index, 0, NULL);
+	return;
+
+failed:
+	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
+}
+
 struct set_setting_data {
 	struct btp_adapter *adapter;
 	uint8_t opcode;
@@ -331,6 +402,9 @@ static void register_gap_service(void)
 	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_READ_COTROLLER_INFO,
 						btp_gap_read_info, NULL, NULL);
 
+	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_RESET,
+						btp_gap_reset, NULL, NULL);
+
 	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_SET_POWERED,
 					btp_gap_set_powered, NULL, NULL);
 
-- 
2.14.3


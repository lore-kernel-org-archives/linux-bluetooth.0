Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] tools/btpclient: Add connect, disconnect commands
Date: Tue,  9 Jan 2018 16:45:20 +0100
Message-Id: <20180109154521.30947-2-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180109154521.30947-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180109154521.30947-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds start and stop connect, disconnect commands for btp
client.
---
 tools/btpclient.c | 175 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 472e9e4c2..053ae07a2 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -107,6 +107,13 @@ static bool str2addr(const char *str, uint8_t *addr)
 				&addr[3], &addr[2], &addr[1], &addr[0]) == 6;
 }
 
+static bool addr2str(const uint8_t *addr, char *str)
+{
+	return sprintf(str, "%02hhX:%02hhX:%02hhX:%02hhX:%02hhX:%02hhX",
+			addr[0], addr[1], addr[2], addr[3], addr[4], addr[5])
+			== 17;
+}
+
 static char *dupuuid2str(const uint8_t *uuid, uint8_t len)
 {
 	switch (len) {
@@ -124,6 +131,17 @@ static char *dupuuid2str(const uint8_t *uuid, uint8_t len)
 	}
 }
 
+static bool match_dev_addr_type(const char *addr_type_str, uint8_t addr_type)
+{
+	if (((addr_type == BTP_GAP_ADDR_PUBLIC) &&
+					(strcmp(addr_type_str, "public"))) ||
+					((addr_type == BTP_GAP_ADDR_RANDOM) &&
+					strcmp(addr_type_str, "random")))
+		return false;
+
+	return true;
+}
+
 static struct btp_adapter *find_adapter_by_proxy(struct l_dbus_proxy *proxy)
 {
 	const struct l_queue_entry *entry;
@@ -169,6 +187,34 @@ static struct btp_adapter *find_adapter_by_path(const char *path)
 	return NULL;
 }
 
+static struct btp_device *find_device_by_address(struct btp_adapter *adapter,
+							const uint8_t *addr,
+							uint8_t addr_type)
+{
+	const struct l_queue_entry *entry;
+	const char *str;
+	char addr_str[18];
+
+	if (!addr2str(addr, addr_str))
+		return NULL;
+
+	for (entry = l_queue_get_entries(adapter->devices); entry;
+							entry = entry->next) {
+		struct btp_device *device = entry->data;
+
+		l_dbus_proxy_get_property(device->proxy, "Address", "s", &str);
+		if (strcmp(str, addr_str))
+			continue;
+
+		l_dbus_proxy_get_property(device->proxy, "AddressType", "s",
+									&str);
+		if (match_dev_addr_type(str, addr_type))
+			return device;
+	}
+
+	return NULL;
+}
+
 static void btp_gap_read_commands(uint8_t index, const void *param,
 					uint16_t length, void *user_data)
 {
@@ -192,6 +238,8 @@ static void btp_gap_read_commands(uint8_t index, const void *param,
 	commands |= (1 << BTP_OP_GAP_STOP_ADVERTISING);
 	commands |= (1 << BTP_OP_GAP_START_DISCOVERY);
 	commands |= (1 << BTP_OP_GAP_STOP_DISCOVERY);
+	commands |= (1 << BTP_OP_GAP_CONNECT);
+	commands |= (1 << BTP_OP_GAP_DISCONNECT);
 
 	commands = L_CPU_TO_LE16(commands);
 
@@ -1314,6 +1362,127 @@ static void btp_gap_stop_discovery(uint8_t index, const void *param,
 					stop_discovery_reply, NULL, NULL);
 }
 
+static void connect_reply(struct l_dbus_proxy *proxy,
+				struct l_dbus_message *result, void *user_data)
+{
+	uint8_t adapter_index = L_PTR_TO_UINT(user_data);
+	struct btp_adapter *adapter = find_adapter_by_index(adapter_index);
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
+		l_error("Failed to connect (%s), %s", name, desc);
+
+		btp_send_error(btp, BTP_GAP_SERVICE, adapter_index,
+								BTP_ERROR_FAIL);
+		return;
+	}
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_CONNECT, adapter_index, 0,
+									NULL);
+}
+
+static void btp_gap_connect(uint8_t index, const void *param, uint16_t length,
+								void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	const struct btp_gap_connect_cp *cp = param;
+	struct btp_device *device;
+	bool prop;
+	uint8_t status = BTP_ERROR_FAIL;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	/* Adapter needs to be powered to be able to connect */
+	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &prop) ||
+									!prop)
+		goto failed;
+
+	device = find_device_by_address(adapter, cp->address, cp->address_type);
+
+	if (!device)
+		goto failed;
+
+	l_dbus_proxy_method_call(device->proxy, "Connect", NULL, connect_reply,
+					L_UINT_TO_PTR(adapter->index), NULL);
+
+	return;
+
+failed:
+	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
+}
+
+static void disconnect_reply(struct l_dbus_proxy *proxy,
+				struct l_dbus_message *result, void *user_data)
+{
+	uint8_t adapter_index = L_PTR_TO_UINT(user_data);
+	struct btp_adapter *adapter = find_adapter_by_index(adapter_index);
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
+		l_error("Failed to disconnect (%s), %s", name, desc);
+
+		btp_send_error(btp, BTP_GAP_SERVICE, adapter_index,
+								BTP_ERROR_FAIL);
+		return;
+	}
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_DISCONNECT, adapter_index, 0,
+									NULL);
+}
+
+static void btp_gap_disconnect(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	const struct btp_gap_disconnect_cp *cp = param;
+	uint8_t status = BTP_ERROR_FAIL;
+	struct btp_device *device;
+	bool prop;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	/* Adapter needs to be powered to be able to connect */
+	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &prop) ||
+									!prop)
+		goto failed;
+
+	device = find_device_by_address(adapter, cp->address, cp->address_type);
+
+	if (!device)
+		goto failed;
+
+	l_dbus_proxy_method_call(device->proxy, "Disconnect", NULL,
+					disconnect_reply,
+					L_UINT_TO_PTR(adapter->index), NULL);
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
@@ -1386,6 +1555,12 @@ static void register_gap_service(void)
 
 	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_STOP_DISCOVERY,
 					btp_gap_stop_discovery, NULL, NULL);
+
+	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_CONNECT, btp_gap_connect,
+								NULL, NULL);
+
+	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_CONNECT,
+						btp_gap_disconnect, NULL, NULL);
 }
 
 static void btp_core_read_commands(uint8_t index, const void *param,
-- 
2.13.6


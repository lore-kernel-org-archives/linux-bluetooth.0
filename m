Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH V2 05/10] tools/btpclient: Add initial support for read controller info command
Date: Fri,  8 Dec 2017 15:03:44 +0100
Message-Id: <20171208140348.30342-6-szymon.janc@codecoup.pl>
In-Reply-To: <20171208140348.30342-1-szymon.janc@codecoup.pl>
References: <20171208140348.30342-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btpclient.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 17a9c8a23..d4b4601bd 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -37,6 +37,8 @@
 struct btp_adapter {
 	struct l_dbus_proxy *proxy;
 	uint8_t index;
+	uint32_t supported_settings;
+	uint32_t current_settings;
 };
 
 struct btp_device {
@@ -50,6 +52,21 @@ static struct btp *btp;
 
 static bool gap_service_registered;
 
+static struct btp_adapter *find_adapter_by_index(uint8_t index)
+{
+	const struct l_queue_entry *entry;
+
+	for (entry = l_queue_get_entries(adapters); entry;
+							entry = entry->next) {
+		struct btp_adapter *adapter = entry->data;
+
+		if (adapter->index == index)
+			return adapter;
+	}
+
+	return NULL;
+}
+
 static void btp_gap_read_commands(uint8_t index, const void *param,
 					uint16_t length, void *user_data)
 {
@@ -63,6 +80,7 @@ static void btp_gap_read_commands(uint8_t index, const void *param,
 
 	commands |= (1 << BTP_OP_GAP_READ_SUPPORTED_COMMANDS);
 	commands |= (1 << BTP_OP_GAP_READ_CONTROLLER_INDEX_LIST);
+	commands |= (1 << BTP_OP_GAP_READ_COTROLLER_INFO);
 
 	commands = L_CPU_TO_LE16(commands);
 
@@ -101,6 +119,46 @@ static void btp_gap_read_controller_index(uint8_t index, const void *param,
 			BTP_INDEX_NON_CONTROLLER, sizeof(*rp) + cnt, rp);
 }
 
+static void btp_gap_read_info(uint8_t index, const void *param, uint16_t length,
+								void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	struct btp_gap_read_info_rp rp;
+	const char *str;
+	uint8_t status = BTP_ERROR_FAIL;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	memset(&rp, 0, sizeof(rp));
+
+	if (!l_dbus_proxy_get_property(adapter->proxy, "Address", "s", &str))
+		goto failed;
+
+	if (sscanf(str,"%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
+			&rp.address[5], &rp.address[4], &rp.address[3],
+			&rp.address[2], &rp.address[1], &rp.address[0]) != 6)
+		goto failed;
+
+	if (!l_dbus_proxy_get_property(adapter->proxy, "Name", "s", &str)) {
+		goto failed;
+	}
+
+	strncpy((char *) rp.name, str, sizeof(rp.name));
+	strncpy((char *) rp.short_name, str, sizeof(rp.short_name));
+	rp.supported_settings = L_CPU_TO_LE32(adapter->supported_settings);
+	rp.current_settings = L_CPU_TO_LE32(adapter->current_settings);
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_READ_COTROLLER_INFO, index,
+							sizeof(rp), &rp);
+
+	return;
+failed:
+	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
+}
+
 static void register_gap_service(void)
 {
 	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_READ_SUPPORTED_COMMANDS,
@@ -109,6 +167,9 @@ static void register_gap_service(void)
 	btp_register(btp, BTP_GAP_SERVICE,
 				BTP_OP_GAP_READ_CONTROLLER_INDEX_LIST,
 				btp_gap_read_controller_index, NULL, NULL);
+
+	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_READ_COTROLLER_INFO,
+						btp_gap_read_info, NULL, NULL);
 }
 
 static void btp_core_read_commands(uint8_t index, const void *param,
-- 
2.14.3


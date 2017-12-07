Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 6/9] tools/btpclient: Add initial support for read controller info command
Date: Thu,  7 Dec 2017 15:21:40 +0100
Message-Id: <20171207142143.27324-7-szymon.janc@codecoup.pl>
In-Reply-To: <20171207142143.27324-1-szymon.janc@codecoup.pl>
References: <20171207142143.27324-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btpclient.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index e63159824..7db65b8b4 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -38,6 +38,8 @@
 struct btp_adapter {
 	struct l_dbus_proxy *proxy;
 	unsigned int index;
+	uint32_t supported_settings;
+	uint32_t current_settings;
 };
 
 struct btp_device {
@@ -51,6 +53,21 @@ static struct btp *btp;
 
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
 static void btp_gap_read_commands(uint16_t index, const void *param,
 					uint16_t length, void *user_data)
 {
@@ -64,6 +81,7 @@ static void btp_gap_read_commands(uint16_t index, const void *param,
 
 	commands |= (1 << BTP_OP_GAP_READ_SUPPORTED_COMMANDS);
 	commands |= (1 << BTP_OP_GAP_READ_CONTROLLER_INDEX_LIST);
+	commands |= (1 << BTP_OP_GAP_READ_COTROLLER_INFO);
 
 	commands = L_CPU_TO_LE16(commands);
 
@@ -102,6 +120,46 @@ static void btp_gap_read_controller_index(uint16_t index, const void *param,
 			BTP_INDEX_NON_CONTROLLER, sizeof(*rp) + cnt, rp);
 }
 
+static void btp_gap_read_info(uint16_t index, const void *param,
+					uint16_t length, void *user_data)
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
@@ -110,6 +168,9 @@ static void register_gap_service(void)
 	btp_register(btp, BTP_GAP_SERVICE,
 				BTP_OP_GAP_READ_CONTROLLER_INDEX_LIST,
 				btp_gap_read_controller_index, NULL, NULL);
+
+	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_READ_COTROLLER_INFO,
+						btp_gap_read_info, NULL, NULL);
 }
 
 static void btp_core_read_commands(uint16_t index, const void *param,
-- 
2.14.3


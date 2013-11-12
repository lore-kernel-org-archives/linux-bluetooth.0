Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 3/8] android: Don't use static pointer for storing adapter_ready callback
Date: Tue, 12 Nov 2013 23:48:15 +0000
Message-Id: <1384300100-8941-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384300100-8941-1-git-send-email-szymon.janc@tieto.com>
References: <1384300100-8941-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to keep ready callback for daemon lifetime as it is
not used after reporting adapter being ready. Use mgmt library feature
for passing user data so that static pointer is not needed.
---
 android/adapter.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 1d628c8..001059a 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -65,8 +65,6 @@ static int notification_sk = -1;
 /* This list contains addresses which are asked for records */
 static GSList *browse_reqs;
 
-static bt_adapter_ready adapter_ready = NULL;
-
 static struct mgmt *mgmt_if = NULL;
 
 static struct {
@@ -940,6 +938,7 @@ static void register_mgmt_handlers(void)
 static void load_link_keys_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
+	bt_adapter_ready cb = user_data;
 	int err;
 
 	if (status) {
@@ -951,14 +950,14 @@ static void load_link_keys_complete(uint8_t status, uint16_t length,
 
 	DBG("status %u", status);
 
-	adapter_ready(0);
+	cb(0);
 	return;
 
 failed:
-	adapter_ready(err);
+	cb(err);
 }
 
-static void load_link_keys(GSList *keys)
+static void load_link_keys(GSList *keys, bt_adapter_ready cb)
 {
 	struct mgmt_cp_load_link_keys *cp;
 	struct mgmt_link_key_info *key;
@@ -984,13 +983,13 @@ static void load_link_keys(GSList *keys)
 		memcpy(key, keys->data, sizeof(*key));
 
 	id = mgmt_send(mgmt_if, MGMT_OP_LOAD_LINK_KEYS, adapter.index,
-			cp_size, cp, load_link_keys_complete, NULL, NULL);
+			cp_size, cp, load_link_keys_complete, cb, NULL);
 
 	g_free(cp);
 
 	if (id == 0) {
 		error("Failed to load link keys");
-		adapter_ready(-EIO);
+		cb(-EIO);
 	}
 }
 
@@ -1280,6 +1279,7 @@ static void read_info_complete(uint8_t status, uint16_t length, const void *para
 							void *user_data)
 {
 	const struct mgmt_rp_read_info *rp = param;
+	bt_adapter_ready cb = user_data;
 	uint32_t missing_settings, supported_settings;
 	int err;
 
@@ -1320,7 +1320,7 @@ static void read_info_complete(uint8_t status, uint16_t length, const void *para
 
 	clear_uuids();
 
-	load_link_keys(NULL);
+	load_link_keys(NULL, cb);
 
 	set_io_capability();
 	set_device_id();
@@ -1336,12 +1336,14 @@ static void read_info_complete(uint8_t status, uint16_t length, const void *para
 	return;
 
 failed:
-	adapter_ready(err);
+	cb(err);
 }
 
 static void mgmt_index_added_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
+	bt_adapter_ready cb = user_data;
+
 	DBG("index %u", index);
 
 	if (adapter.index != MGMT_INDEX_NONE) {
@@ -1355,8 +1357,8 @@ static void mgmt_index_added_event(uint16_t index, uint16_t length,
 	}
 
 	if (mgmt_send(mgmt_if, MGMT_OP_READ_INFO, index, 0, NULL,
-				read_info_complete, NULL, NULL) == 0) {
-		adapter_ready(-EIO);
+				read_info_complete, cb, NULL) == 0) {
+		cb(-EIO);
 		return;
 	}
 }
@@ -1377,6 +1379,7 @@ static void read_index_list_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	const struct mgmt_rp_read_index_list *rp = param;
+	bt_adapter_ready cb = user_data;
 	uint16_t num;
 	int i;
 
@@ -1412,7 +1415,7 @@ static void read_index_list_complete(uint8_t status, uint16_t length,
 			continue;
 
 		if (mgmt_send(mgmt_if, MGMT_OP_READ_INFO, index, 0, NULL,
-					read_info_complete, NULL, NULL) == 0)
+					read_info_complete, cb, NULL) == 0)
 			goto failed;
 
 		adapter.index = index;
@@ -1422,7 +1425,7 @@ static void read_index_list_complete(uint8_t status, uint16_t length,
 	return;
 
 failed:
-	adapter_ready(-EIO);
+	cb(-EIO);
 }
 
 static void read_version_complete(uint8_t status, uint16_t length,
@@ -1430,6 +1433,7 @@ static void read_version_complete(uint8_t status, uint16_t length,
 {
 	const struct mgmt_rp_read_version *rp = param;
 	uint8_t mgmt_version, mgmt_revision;
+	bt_adapter_ready cb = user_data;
 
 	DBG("");
 
@@ -1456,18 +1460,18 @@ static void read_version_complete(uint8_t status, uint16_t length,
 	}
 
 	mgmt_register(mgmt_if, MGMT_EV_INDEX_ADDED, MGMT_INDEX_NONE,
-					mgmt_index_added_event, NULL, NULL);
+					mgmt_index_added_event, cb, NULL);
 	mgmt_register(mgmt_if, MGMT_EV_INDEX_REMOVED, MGMT_INDEX_NONE,
 					mgmt_index_removed_event, NULL, NULL);
 
 	if (mgmt_send(mgmt_if, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0,
-			NULL, read_index_list_complete, NULL, NULL) > 0)
+				NULL, read_index_list_complete, cb, NULL) > 0)
 		return;
 
 	error("Failed to read controller index list");
 
 failed:
-	adapter_ready(-EIO);
+	cb(-EIO);
 }
 
 bool bt_adapter_start(int index, bt_adapter_ready cb)
@@ -1481,7 +1485,7 @@ bool bt_adapter_start(int index, bt_adapter_ready cb)
 	}
 
 	if (mgmt_send(mgmt_if, MGMT_OP_READ_VERSION, MGMT_INDEX_NONE, 0, NULL,
-				read_version_complete, NULL, NULL) == 0) {
+				read_version_complete, cb, NULL) == 0) {
 		error("Error sending READ_VERSION mgmt command");
 
 		mgmt_unref(mgmt_if);
@@ -1493,8 +1497,6 @@ bool bt_adapter_start(int index, bt_adapter_ready cb)
 	if (index >= 0)
 		option_index = index;
 
-	adapter_ready = cb;
-
 	return true;
 }
 
-- 
1.8.4.3


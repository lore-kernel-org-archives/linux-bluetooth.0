Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 13/16] android: Implement read_info_complete callback
Date: Fri, 27 Sep 2013 17:12:38 +0300
Message-Id: <1380291161-10232-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Handle read info complete callback from mgmt interface.
---
 android/main.c |  112 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 101 insertions(+), 11 deletions(-)

diff --git a/android/main.c b/android/main.c
index 649867d..658cdd2 100644
--- a/android/main.c
+++ b/android/main.c
@@ -51,6 +51,7 @@
 #include "hcid.h"
 #include "sdpd.h"
 #include "main.h"
+#include "bt_adapter.h"
 
 #include "lib/bluetooth.h"
 #include "lib/mgmt.h"
@@ -155,34 +156,123 @@ static GOptionEntry options[] = {
 	{ NULL }
 };
 
-static void read_info_complete(uint8_t status, uint16_t length,
+static void load_link_keys_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
-	/* TODO: Store Controller information */
-
-	/**
-	 * Register all event notification handlers for controller.
-	 *
-	 * The handlers are registered after a succcesful read of the
-	 * controller info. From now on they can track updates and
-	 * notifications.
-	 */
+	DBG("status %u", status);
+}
+
+static void load_link_keys(struct bt_adapter *adapter, GSList *keys)
+{
+	struct mgmt_cp_load_link_keys *cp;
+	uint16_t key_len = g_slist_length(keys);
+	struct mgmt_link_key_info *key;
+	uint16_t len;
+
+	DBG("");
+
+	len = sizeof(*cp) + key_len * sizeof(*key);
+	cp = malloc(len);
+	if (cp == NULL) {
+		error("%s: Not enough memory for link keys loading", __func__);
+		return;
+	}
+
+	cp->debug_keys = 0;
+	cp->key_count = htobs(key_len);
+
+	mgmt_send(adapter->mgmt, MGMT_OP_LOAD_LINK_KEYS, adapter->dev_id, len,
+				cp, load_link_keys_complete, adapter, NULL);
+
+	free(cp);
 }
 
+static void read_info_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_rp_read_info *rp = param;
+	struct bt_adapter *adapter = user_data;
+
+	DBG("");
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		error("Failed to read info for index %u: %s (0x%02x)",
+			adapter->dev_id, mgmt_errstr(status), status);
+		goto failed;
+	}
+
+	if (length < sizeof(*rp)) {
+		error("Too small read info complete response");
+		goto failed;
+	}
+
+	if (bacmp(&rp->bdaddr, BDADDR_ANY) == 0) {
+		error("No Bluetooth address for index %u", adapter->dev_id);
+		goto failed;
+	}
+
+	/* Store adapter information */
+	bacpy(&adapter->bdaddr, &rp->bdaddr);
+	adapter->dev_class = rp->dev_class[0] | (rp->dev_class[1] << 8) |
+						(rp->dev_class[2] << 16);
+	adapter->name = g_strdup((const char *) rp->name);
+	adapter->short_name = g_strdup((const char *) rp->short_name);
+
+	adapter->supported_settings = btohs(rp->supported_settings);
+	adapter->current_settings = btohs(rp->current_settings);
+
+	/* TODO: Register all event notification handlers */
+
+	if (adapter->current_settings & MGMT_SETTING_POWERED)
+		adapter_start(adapter);
+
+	/* dummy link keys loading */
+	load_link_keys(adapter, NULL);
+
+	return;
+
+failed:
+	adapter_list = g_list_remove(adapter_list, adapter);
+
+	bt_adapter_unref(adapter);
+}
 
 static void mgmt_index_added_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
+	struct bt_adapter *adapter;
+
 	info("%s: index %u", __func__, index);
 
+	adapter = bt_adapter_lookup(index);
+	if (adapter) {
+		warn("Ignoring %s for an already existing adapter", __func__);
+		return;
+	}
+
+	adapter = bt_adapter_new(index, mgmt_if);
+	if (adapter == NULL) {
+		error("Unable to create new adapter for index %u", index);
+		return;
+	}
+
+	adapter_list = g_list_append(adapter_list, adapter);
+
+	/* TODO: Add complex logic here */
+	if (index == 0)
+		default_adapter = adapter;
+
 	DBG("sending read info command for index %u", index);
 
 	if (mgmt_send(mgmt_if, MGMT_OP_READ_INFO, index, 0, NULL,
-					read_info_complete, NULL, NULL) > 0)
+					read_info_complete, adapter, NULL) > 0)
 		return;
 
 	error("Failed to read adapter info for index %u", index);
 
+	adapter_list = g_list_remove(adapter_list, adapter);
+
+	bt_adapter_unref(adapter);
 }
 
 static void mgmt_index_removed_event(uint16_t index, uint16_t length,
-- 
1.7.10.4


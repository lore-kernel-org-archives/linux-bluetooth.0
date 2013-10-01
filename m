Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 11/14] android: Implement read_info_complete callback
Date: Tue,  1 Oct 2013 18:03:16 +0300
Message-Id: <1380639799-25790-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1380639799-25790-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380639799-25790-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Handle read info complete callback from mgmt interface.
---
 android/main.c |  100 +++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 88 insertions(+), 12 deletions(-)

diff --git a/android/main.c b/android/main.c
index 36f9c1a..29389d5 100644
--- a/android/main.c
+++ b/android/main.c
@@ -54,6 +54,7 @@
 #include "hcid.h"
 #include "sdpd.h"
 #include "main.h"
+#include "bt_adapter.h"
 
 #include "lib/bluetooth.h"
 #include "lib/mgmt.h"
@@ -160,34 +161,109 @@ static GOptionEntry options[] = {
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
+
+	DBG("");
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		error("Failed to read info for index %u: %s (0x%02x)",
+			default_adapter->dev_id, mgmt_errstr(status), status);
+		goto failed;
+	}
+
+	if (length < sizeof(*rp)) {
+		error("Too small read info complete response");
+		goto failed;
+	}
+
+	if (bacmp(&rp->bdaddr, BDADDR_ANY) == 0) {
+		error("No Bluetooth address for index %u",
+						default_adapter->dev_id);
+		goto failed;
+	}
+
+	/* Store adapter information */
+	bacpy(&default_adapter->bdaddr, &rp->bdaddr);
+	default_adapter->dev_class = rp->dev_class[0] |
+						(rp->dev_class[1] << 8) |
+						(rp->dev_class[2] << 16);
+	default_adapter->name = g_strdup((const char *) rp->name);
+	default_adapter->short_name = g_strdup((const char *) rp->short_name);
+
+	default_adapter->supported_settings = btohs(rp->supported_settings);
+	default_adapter->current_settings = btohs(rp->current_settings);
+
+	/* TODO: Register all event notification handlers */
+
+	if (default_adapter->current_settings & MGMT_SETTING_POWERED)
+		adapter_start(default_adapter);
+
+	/* dummy link keys loading */
+	load_link_keys(default_adapter, NULL);
+
+	return;
+
+failed:
+	default_adapter = NULL;
+}
 
 static void mgmt_index_added_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
 	info("%s: index %u", __func__, index);
 
+	if (default_adapter == NULL) {
+		DBG("skip event for index %d", index);
+		return;
+	}
+
+	default_adapter = bt_adapter_new(index, mgmt_if);
+	if (default_adapter == NULL) {
+		error("Unable to create new adapter for index %u", index);
+		return;
+	}
+
 	DBG("sending read info command for index %u", index);
 
 	if (mgmt_send(mgmt_if, MGMT_OP_READ_INFO, index, 0, NULL,
-					read_info_complete, NULL, NULL) > 0)
+				read_info_complete, NULL, NULL) > 0)
 		return;
 
 	error("Failed to read adapter info for index %u", index);
-
 }
 
 static void mgmt_index_removed_event(uint16_t index, uint16_t length,
-- 
1.7.10.4


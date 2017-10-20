Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gatt: Clear subscriptions for device not paired
Date: Fri, 20 Oct 2017 15:21:14 +0300
Message-Id: <20171020122114.11887-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the device is no longer valid or is not considered bonded anymore
clear its CCC states before removing otherwise application may continue
to notify when there are no devices listening.
---
 src/gatt-database.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 47304704a..d6d1e4d13 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -891,6 +891,23 @@ static void conf_cb(void *user_data)
 	}
 }
 
+static void clear_ccc_state(void *data, void *user_data)
+{
+	struct ccc_state *ccc = data;
+	struct btd_gatt_database *db = user_data;
+	struct ccc_cb_data *ccc_cb;
+
+	if (!ccc->value[0])
+		return;
+
+	ccc_cb = queue_find(db->ccc_callbacks, ccc_cb_match_handle,
+						UINT_TO_PTR(ccc->handle));
+	if (!ccc_cb)
+		return;
+
+	ccc_cb->callback(NULL, 0, ccc_cb->user_data);
+}
+
 static void send_notification_to_device(void *data, void *user_data)
 {
 	struct device_state *device_state = data;
@@ -940,8 +957,11 @@ static void send_notification_to_device(void *data, void *user_data)
 
 remove:
 	/* Remove device state if device no longer exists or is not paired */
-	if (queue_remove(notify->database->device_states, device_state))
+	if (queue_remove(notify->database->device_states, device_state)) {
+		queue_foreach(device_state->ccc_states, clear_ccc_state,
+						notify->database);
 		device_state_free(device_state);
+	}
 }
 
 static void send_notification_to_devices(struct btd_gatt_database *database,
-- 
2.13.6


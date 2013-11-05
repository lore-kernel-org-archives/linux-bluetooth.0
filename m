Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/daemon: Send update name notification on mgmt evt
Date: Tue,  5 Nov 2013 10:53:41 +0200
Message-Id: <1383641621-25933-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Wehen receiving mgmt event local_name_changed we shall send notification
to the HAL that local name is changed.
---
 android/adapter.c |   46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 383cf07..b6f6096 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -66,6 +66,28 @@ struct bt_adapter {
 static struct bt_adapter *adapter;
 static GSList *found_devices = NULL;
 
+static void adapter_name_changed(const uint8_t *name)
+{
+	struct hal_ev_adapter_props_changed *ev;
+	size_t len = strlen((const char *) name);
+	uint8_t buf[sizeof(*ev) + sizeof(struct hal_property) + len];
+
+	memset(buf, 0, sizeof(buf));
+	ev = (void *) buf;
+
+	ev->num_props = 1;
+	ev->status = HAL_STATUS_SUCCESS;
+	ev->props[0].type = HAL_PROP_ADAPTER_NAME;
+	/* Android expects value without NULL terminator */
+	ev->props[0].len = len;
+	memcpy(ev->props->val, name, len);
+
+	DBG("Adapter name changed to: %s", name);
+
+	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
+			HAL_EV_ADAPTER_PROPS_CHANGED, sizeof(buf), ev, -1);
+}
+
 static void mgmt_local_name_changed_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -84,7 +106,7 @@ static void mgmt_local_name_changed_event(uint16_t index, uint16_t length,
 	g_free(adapter->name);
 	adapter->name = g_strdup((const char *) rp->name);
 
-	/* TODO Update services if needed */
+	adapter_name_changed(rp->name);
 }
 
 static void powered_changed(void)
@@ -142,28 +164,6 @@ static void scan_mode_changed(void)
 	g_free(ev);
 }
 
-static void adapter_name_changed(const uint8_t *name)
-{
-	struct hal_ev_adapter_props_changed *ev;
-	size_t len = strlen((const char *) name);
-	uint8_t buf[sizeof(*ev) + sizeof(struct hal_property) + len];
-
-	memset(buf, 0, sizeof(buf));
-	ev = (void *) buf;
-
-	ev->num_props = 1;
-	ev->status = HAL_STATUS_SUCCESS;
-	ev->props[0].type = HAL_PROP_ADAPTER_NAME;
-	/* Android expects value without NULL terminator */
-	ev->props[0].len = len;
-	memcpy(ev->props->val, name, len);
-
-	DBG("Adapter name changed to: %s", name);
-
-	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_EV_ADAPTER_PROPS_CHANGED, sizeof(buf), ev, -1);
-}
-
 static void settings_changed(uint32_t settings)
 {
 	uint32_t changed_mask;
-- 
1.7.10.4


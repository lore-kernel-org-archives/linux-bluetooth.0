Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCHv3] android: Implement class of device property callback
Date: Wed, 6 Nov 2013 11:59:22 +0100
Message-ID: <1383735562-21777-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will send adapter property with class of device
to notification socket.
---
 android/adapter.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 0f24cac..cf5edcd 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -189,6 +189,28 @@ static void scan_mode_changed(void)
 	g_free(ev);
 }
 
+static void adapter_class_changed(void)
+{
+	struct hal_ev_adapter_props_changed *ev;
+	int len;
+
+	len = sizeof(*ev) + sizeof(struct hal_property) + sizeof(uint32_t);
+
+	ev = g_malloc(len);
+
+	ev->num_props = 1;
+	ev->status = HAL_STATUS_SUCCESS;
+
+	ev->props[0].type = HAL_PROP_ADAPTER_CLASS;
+	ev->props[0].len = sizeof(uint32_t);
+	memcpy(ev->props->val, &adapter->dev_class, sizeof(uint32_t));
+
+	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_EV_ADAPTER_PROPS_CHANGED, len, ev, -1);
+
+	g_free(ev);
+}
+
 static void settings_changed(uint32_t settings)
 {
 	uint32_t changed_mask;
@@ -257,7 +279,7 @@ static void mgmt_dev_class_changed_event(uint16_t index, uint16_t length,
 
 	adapter->dev_class = dev_class;
 
-	/* TODO: Inform prop change: Class */
+	adapter_class_changed();
 
 	/* TODO: Gatt attrib set*/
 }
@@ -1219,11 +1241,11 @@ static bool get_uuids(void)
 
 static bool get_class(void)
 {
-	DBG("Not implemented");
+	DBG("");
 
-	/* TODO: Add implementation */
+	adapter_class_changed();
 
-	return false;
+	return true;
 }
 
 static bool get_type(void)
-- 
1.8.4.1


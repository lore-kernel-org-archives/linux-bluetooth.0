Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCHv2 5/6] android: Implement class of device property callback
Date: Tue, 5 Nov 2013 14:21:39 +0100
Message-ID: <1383657700-22313-6-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1383657700-22313-1-git-send-email-marcin.kraglak@tieto.com>
References: <1383657700-22313-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will send adapter property with class of device
to notification socket.

---
 android/adapter.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 70b9265..89db078 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -212,6 +212,30 @@ static void scan_mode_changed(void)
 	g_free(ev);
 }
 
+static void send_adapter_class(void)
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
+	DBG("Adapter class %u", adapter->dev_class);
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
@@ -280,7 +304,7 @@ static void mgmt_dev_class_changed_event(uint16_t index, uint16_t length,
 
 	adapter->dev_class = dev_class;
 
-	/* TODO: Inform prop change: Class */
+	send_adapter_class();
 
 	/* TODO: Gatt attrib set*/
 }
@@ -1278,11 +1302,11 @@ static bool get_uuids(void)
 
 static bool get_class(void)
 {
-	DBG("Not implemented");
+	DBG("");
 
-	/* TODO: Add implementation */
+	send_adapter_class();
 
-	return false;
+	return true;
 }
 
 static bool get_type(void)
-- 
1.8.4.1


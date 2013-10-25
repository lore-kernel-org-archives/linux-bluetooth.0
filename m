Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 6/6] android: Add support for notifying HAL about scan mode change
Date: Fri, 25 Oct 2013 17:15:03 +0200
Message-ID: <1382714103-27689-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382714103-27689-1-git-send-email-szymon.janc@tieto.com>
References: <1382714103-27689-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If connectable or discoverable setting changes property change is send
to HAL.
---
 android/adapter.c | 54 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index eebe45e..a6e5129 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -86,19 +86,52 @@ static void settings_changed_powered(void)
 			HAL_EV_ADAPTER_STATE_CHANGED, sizeof(ev), &ev, -1);
 }
 
-static void settings_changed_connectable(void)
+static uint8_t settings2scan_mode(void)
 {
-	/* TODO */
+	bool connectable, discoverable;
+
+	connectable = adapter->current_settings & MGMT_SETTING_CONNECTABLE;
+	discoverable = adapter->current_settings & MGMT_SETTING_DISCOVERABLE;
+
+	if (connectable && discoverable)
+		return HAL_ADAPTER_SCAN_MODE_CONN_DISC;
+
+	if (connectable)
+		return HAL_ADAPTER_SCAN_MODE_CONN;
+
+	return HAL_ADAPTER_SCAN_MODE_NONE;
 }
 
-static void settings_changed_discoverable(void)
+static void settings_changed_scan_mode(void)
 {
-	/* TODO */
+	struct hal_ev_adapter_props_changed *ev;
+	uint8_t *mode;
+	int len;
+	len = sizeof(*ev) + sizeof(struct hal_property) + 1;
+
+	ev = g_malloc(len);
+
+	ev->num_props = 1;
+	ev->status = HAL_STATUS_SUCCESS;
+
+	ev->props[0].type = HAL_PROP_ADAPTER_SCAN_MODE;
+	ev->props[0].len = 1;
+
+	mode = ev->props[0].val;
+	*mode = settings2scan_mode();
+
+	DBG("mode %u", *mode);
+
+	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_EV_ADAPTER_PROPS_CHANGED, len, ev, -1);
+
+	g_free(ev);
 }
 
 static void settings_changed(uint32_t settings)
 {
 	uint32_t changed_mask;
+	uint32_t scan_mode_mask;
 
 	changed_mask = adapter->current_settings ^ settings;
 
@@ -109,17 +142,10 @@ static void settings_changed(uint32_t settings)
 	if (changed_mask & MGMT_SETTING_POWERED)
 		settings_changed_powered();
 
-	if (changed_mask & MGMT_SETTING_CONNECTABLE) {
-		DBG("Connectable");
-
-		settings_changed_connectable();
-	}
+	scan_mode_mask = MGMT_SETTING_CONNECTABLE | MGMT_SETTING_DISCOVERABLE;
 
-	if (changed_mask & MGMT_SETTING_DISCOVERABLE) {
-		DBG("Discoverable");
-
-		settings_changed_discoverable();
-	}
+	if (changed_mask & scan_mode_mask)
+		settings_changed_scan_mode();
 }
 
 static void new_settings_callback(uint16_t index, uint16_t length,
-- 
1.8.4.1


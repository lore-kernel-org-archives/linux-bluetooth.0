Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/11] adapter: Remove scan_mode member
Date: Mon, 17 Dec 2012 15:44:55 +0100
Message-ID: <1355755498-2700-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355755498-2700-1-git-send-email-szymon.janc@tieto.com>
References: <1355755498-2700-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is not needed anymore as boolean flags can be used instead.
---
 src/adapter.c | 68 +++++++++++++++--------------------------------------------
 1 file changed, 17 insertions(+), 51 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2af0d4f..e97e9bb 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -130,8 +130,6 @@ struct btd_adapter {
 	uint32_t discov_timeout;	/* discoverable time(sec) */
 	guint pairable_timeout_id;	/* pairable timeout id */
 	uint32_t pairable_timeout;	/* pairable time(sec) */
-	uint8_t scan_mode;		/* scan mode: SCAN_DISABLED, SCAN_PAGE,
-					 * SCAN_INQUIRY */
 	uint8_t mode;			/* off, connectable, discoverable,
 					 * limited */
 	uint8_t global_mode;		/* last valid global mode */
@@ -1778,16 +1776,6 @@ void btd_adapter_start(struct btd_adapter *adapter)
 	adapter->off_requested = FALSE;
 	adapter->powered = TRUE;
 
-	if (adapter->scan_mode & SCAN_INQUIRY) {
-		adapter->mode = MODE_DISCOVERABLE;
-		adapter->discoverable = TRUE;
-	} else {
-		adapter->mode = MODE_CONNECTABLE;
-		adapter->discoverable = FALSE;
-	}
-
-	adapter->connectable = true;
-
 	g_dbus_emit_property_changed(btd_get_dbus_connection(), adapter->path,
 						ADAPTER_INTERFACE, "Powered");
 
@@ -1934,7 +1922,7 @@ int btd_adapter_stop(struct btd_adapter *adapter)
 	if (adapter->connectable && adapter->pairable == TRUE)
 		emit_pairable = true;
 
-	adapter->scan_mode = SCAN_DISABLED;
+	adapter->discoverable = FALSE;
 	adapter->connectable = false;
 
 	adapter->mode = MODE_OFF;
@@ -3155,56 +3143,34 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 
 static uint8_t create_mode(bool connectable, bool discoverable)
 {
-	uint8_t mode = 0;
-
-	if (connectable)
-		mode |= SCAN_PAGE;
+	if (connectable && discoverable)
+		return MODE_DISCOVERABLE;
 
-	if (discoverable)
-		mode |= SCAN_INQUIRY;
+	if (connectable && !discoverable)
+		return MODE_CONNECTABLE;
 
-	return mode;
+	return MODE_OFF;
 }
 
 void adapter_mode_changed(struct btd_adapter *adapter, bool connectable,
 							bool discoverable)
 {
-	bool emit_pairable = false;
-	uint8_t scan_mode;
-
-	scan_mode = create_mode(connectable, discoverable);
+	bool emit_pairable;
 
-	DBG("old 0x%02x new 0x%02x", adapter->scan_mode, scan_mode);
+	DBG("connectable %u (old %u) discoverable %u (old %u)",
+					connectable, adapter->connectable,
+					discoverable, adapter->discoverable);
 
-	if (adapter->scan_mode == scan_mode)
+	if (connectable == adapter->connectable &&
+			discoverable == adapter->discoverable)
 		return;
 
-	switch (scan_mode) {
-	case SCAN_DISABLED:
-		adapter->mode = MODE_OFF;
-		adapter->connectable = false;
-		adapter->discoverable = FALSE;
-		break;
-	case SCAN_PAGE:
-		adapter->mode = MODE_CONNECTABLE;
-		adapter->discoverable = FALSE;
-		adapter->connectable = true;
-		break;
-	case (SCAN_PAGE | SCAN_INQUIRY):
-		adapter->mode = MODE_DISCOVERABLE;
-		adapter->discoverable = TRUE;
-		adapter->connectable = true;
-		break;
-	default:
-		/* ignore, reserved */
-		return;
-	}
-
-	/* If page scanning gets toggled emit the Pairable property */
-	if ((adapter->scan_mode & SCAN_PAGE) != (scan_mode & SCAN_PAGE))
-		emit_pairable = true;
+	/* If connectable gets toggled emit the Pairable property */
+	emit_pairable = adapter->connectable != connectable;
 
-	adapter->scan_mode = scan_mode;
+	adapter->connectable = connectable;
+	adapter->discoverable = discoverable;
+	adapter->mode = create_mode(connectable, discoverable);
 
 	if (emit_pairable)
 		g_dbus_emit_property_changed(btd_get_dbus_connection(),
-- 
1.8.0


Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 06/11] adapter: Add connectable member to btd_adapter
Date: Mon, 17 Dec 2012 15:44:53 +0100
Message-ID: <1355755498-2700-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355755498-2700-1-git-send-email-szymon.janc@tieto.com>
References: <1355755498-2700-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will be used to track if adapter is in connectable state.
---
 src/adapter.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 915d897..473c9cf 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -153,6 +153,7 @@ struct btd_adapter {
 	guint auto_timeout_id;		/* Automatic connections timeout */
 	sdp_list_t *services;		/* Services associated to adapter */
 
+	bool connectable;		/* connectable state */
 	gboolean discoverable;		/* discoverable state */
 	gboolean pairable;		/* pairable state */
 	gboolean initialized;
@@ -415,7 +416,7 @@ static void set_pairable(struct btd_adapter *adapter, gboolean pairable,
 {
 	int err;
 
-	if (adapter->scan_mode == SCAN_DISABLED)
+	if (!adapter->connectable)
 		return g_dbus_pending_property_error(id,
 						ERROR_INTERFACE ".NotReady",
 						"Resource Not Ready");
@@ -1785,6 +1786,8 @@ void btd_adapter_start(struct btd_adapter *adapter)
 		adapter->discoverable = FALSE;
 	}
 
+	adapter->connectable = true;
+
 	g_dbus_emit_property_changed(btd_get_dbus_connection(), adapter->path,
 						ADAPTER_INTERFACE, "Powered");
 
@@ -1928,10 +1931,12 @@ int btd_adapter_stop(struct btd_adapter *adapter)
 	if (adapter->scan_mode == (SCAN_PAGE | SCAN_INQUIRY))
 		emit_discoverable = true;
 
-	if ((adapter->scan_mode & SCAN_PAGE) && adapter->pairable == TRUE)
+	if (adapter->connectable && adapter->pairable == TRUE)
 		emit_pairable = true;
 
 	adapter->scan_mode = SCAN_DISABLED;
+	adapter->connectable = false;
+
 	adapter->mode = MODE_OFF;
 	adapter->off_requested = FALSE;
 
@@ -3177,14 +3182,17 @@ void adapter_mode_changed(struct btd_adapter *adapter, bool connectable,
 	switch (scan_mode) {
 	case SCAN_DISABLED:
 		adapter->mode = MODE_OFF;
+		adapter->connectable = false;
 		break;
 	case SCAN_PAGE:
 		adapter->mode = MODE_CONNECTABLE;
 		adapter->discoverable = FALSE;
+		adapter->connectable = true;
 		break;
 	case (SCAN_PAGE | SCAN_INQUIRY):
 		adapter->mode = MODE_DISCOVERABLE;
 		adapter->discoverable = TRUE;
+		adapter->connectable = true;
 		break;
 	default:
 		/* ignore, reserved */
-- 
1.8.0


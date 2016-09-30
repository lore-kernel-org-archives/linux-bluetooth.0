Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: jiangbo.wu@intel.com
To: martin.xu@intel.com, johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Jiangbo Wu <jiangbo.wu@intel.com>
Subject: [PATCH] src/device: Free bonding while failed to pair device
Date: Fri, 30 Sep 2016 23:39:18 +0800
Message-Id: <1475249958-9934-1-git-send-email-jiangbo.wu@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jiangbo Wu <jiangbo.wu@intel.com>

---
 src/device.c | 62 +++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/src/device.c b/src/device.c
index 25d2e22..fb6104f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2314,6 +2314,35 @@ static void create_bond_req_exit(DBusConnection *conn, void *user_data)
 	}
 }
 
+static void bonding_request_free(struct bonding_req *bonding)
+{
+	if (!bonding)
+		return;
+
+	if (bonding->listener_id)
+		g_dbus_remove_watch(dbus_conn, bonding->listener_id);
+
+	if (bonding->msg)
+		dbus_message_unref(bonding->msg);
+
+	if (bonding->cb_iter)
+		g_free(bonding->cb_iter);
+
+	if (bonding->agent) {
+		agent_cancel(bonding->agent);
+		agent_unref(bonding->agent);
+		bonding->agent = NULL;
+	}
+
+	if (bonding->retry_timer)
+		g_source_remove(bonding->retry_timer);
+
+	if (bonding->device)
+		bonding->device->bonding = NULL;
+
+	g_free(bonding);
+}
+
 static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -2384,8 +2413,10 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 							BDADDR_BREDR, io_cap);
 	}
 
-	if (err < 0)
+	if (err < 0) {
+		bonding_request_free(device->bonding);
 		return btd_error_failed(msg, strerror(-err));
+	}
 
 	return NULL;
 }
@@ -2426,35 +2457,6 @@ static DBusMessage *new_authentication_return(DBusMessage *msg, uint8_t status)
 	}
 }
 
-static void bonding_request_free(struct bonding_req *bonding)
-{
-	if (!bonding)
-		return;
-
-	if (bonding->listener_id)
-		g_dbus_remove_watch(dbus_conn, bonding->listener_id);
-
-	if (bonding->msg)
-		dbus_message_unref(bonding->msg);
-
-	if (bonding->cb_iter)
-		g_free(bonding->cb_iter);
-
-	if (bonding->agent) {
-		agent_cancel(bonding->agent);
-		agent_unref(bonding->agent);
-		bonding->agent = NULL;
-	}
-
-	if (bonding->retry_timer)
-		g_source_remove(bonding->retry_timer);
-
-	if (bonding->device)
-		bonding->device->bonding = NULL;
-
-	g_free(bonding);
-}
-
 static void device_cancel_bonding(struct btd_device *device, uint8_t status)
 {
 	struct bonding_req *bonding = device->bonding;
-- 
1.9.1


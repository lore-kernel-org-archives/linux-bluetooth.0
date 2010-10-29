Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix issue when setting limited discoverable mode
Date: Fri, 29 Oct 2010 15:58:03 +0300
Message-Id: <1288357083-24664-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

When setting limited discoverable mode it will always switch to
discoverable on adapter_mode_changed which doesn't match the pending mode
requested.

To fix this MODE_LIMITED was removed since it didn't represent a real
scan mode but a discoverable mode so that limited discoverable and
general discoverable are now both represented by MODE_DISCOVERABLE.

Also limited bits are now set at same point the timeout start and removed
when mode change to something different then discoverable or when
discoverable timeout is removed permanently (set to 0).
---
 src/adapter.c |   76 +++++++++++++++++++++++++-------------------------------
 src/hcid.h    |    1 -
 2 files changed, 34 insertions(+), 43 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 1b03ef1..32c74d1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -410,7 +410,6 @@ static const char *mode2str(uint8_t mode)
 	case MODE_CONNECTABLE:
 		return "connectable";
 	case MODE_DISCOVERABLE:
-	case MODE_LIMITED:
 		return "discoverable";
 	default:
 		return "unknown";
@@ -425,8 +424,6 @@ static uint8_t get_mode(const bdaddr_t *bdaddr, const char *mode)
 		return MODE_CONNECTABLE;
 	else if (strcasecmp("discoverable", mode) == 0)
 		return MODE_DISCOVERABLE;
-	else if (strcasecmp("limited", mode) == 0)
-		return MODE_LIMITED;
 	else if (strcasecmp("on", mode) == 0) {
 		char onmode[14], srcaddr[18];
 
@@ -439,12 +436,33 @@ static uint8_t get_mode(const bdaddr_t *bdaddr, const char *mode)
 		return MODE_UNKNOWN;
 }
 
+static void adapter_set_limited_discoverable(struct btd_adapter *adapter,
+							gboolean limited)
+{
+	DBG("%s", limited ? "TRUE" : "FALSE");
+
+	/* Check if limited bit needs to be set/reset */
+	if (limited)
+		adapter->wanted_cod |= LIMITED_BIT;
+	else
+		adapter->wanted_cod &= ~LIMITED_BIT;
+
+	/* If we dont need the toggling, save an unnecessary CoD write */
+	if (adapter->pending_cod ||
+			adapter->wanted_cod == adapter->current_cod)
+		return;
+
+	if (adapter_ops->set_limited_discoverable(adapter->dev_id,
+					adapter->wanted_cod, limited) == 0)
+		adapter->pending_cod = adapter->wanted_cod;
+}
+
 static void adapter_remove_discov_timeout(struct btd_adapter *adapter)
 {
 	if (!adapter)
 		return;
 
-	if(adapter->discov_timeout_id == 0)
+	if (adapter->discov_timeout_id == 0)
 		return;
 
 	g_source_remove(adapter->discov_timeout_id);
@@ -470,33 +488,23 @@ static void adapter_set_discov_timeout(struct btd_adapter *adapter,
 		adapter->discov_timeout_id = 0;
 	}
 
-	if (interval == 0)
+	if (interval == 0) {
+		adapter_set_limited_discoverable(adapter, FALSE);
 		return;
+	}
+
+	/* Set limited discoverable if pairable and interval between 0 to 60
+	   sec */
+	if (adapter->pairable && interval <= 60)
+		adapter_set_limited_discoverable(adapter, TRUE);
+	else
+		adapter_set_limited_discoverable(adapter, FALSE);
 
 	adapter->discov_timeout_id = g_timeout_add_seconds(interval,
 							discov_timeout_handler,
 							adapter);
 }
 
-static void adapter_set_limited_discoverable(struct btd_adapter *adapter,
-							gboolean limited)
-{
-	/* Check if limited bit needs to be set/reset */
-	if (limited)
-		adapter->wanted_cod |= LIMITED_BIT;
-	else
-		adapter->wanted_cod &= ~LIMITED_BIT;
-
-	/* If we dont need the toggling, save an unnecessary CoD write */
-	if (adapter->pending_cod ||
-			adapter->wanted_cod == adapter->current_cod)
-		return;
-
-	if (adapter_ops->set_limited_discoverable(adapter->dev_id,
-					adapter->wanted_cod, limited) == 0)
-		adapter->pending_cod = adapter->wanted_cod;
-}
-
 static struct session_req *session_ref(struct session_req *req)
 {
 	req->refcount++;
@@ -551,9 +559,6 @@ static int adapter_set_mode(struct btd_adapter *adapter, uint8_t mode)
 	if (adapter->discov_timeout)
 		adapter_set_discov_timeout(adapter, adapter->discov_timeout);
 
-	if (mode != MODE_LIMITED && adapter->mode == MODE_LIMITED)
-		adapter_set_limited_discoverable(adapter, FALSE);
-
 	return 0;
 }
 
@@ -629,11 +634,6 @@ static DBusMessage *set_discoverable(DBusConnection *conn, DBusMessage *msg,
 
 	mode = discoverable ? MODE_DISCOVERABLE : MODE_CONNECTABLE;
 
-	if (mode == MODE_DISCOVERABLE && adapter->pairable &&
-					adapter->discov_timeout > 0 &&
-					adapter->discov_timeout <= 60)
-		mode = MODE_LIMITED;
-
 	if (mode == adapter->mode)
 		return dbus_message_new_method_return(msg);
 
@@ -673,7 +673,6 @@ static DBusMessage *set_pairable(DBusConnection *conn, DBusMessage *msg,
 				gboolean pairable, void *data)
 {
 	struct btd_adapter *adapter = data;
-	uint8_t mode;
 	int err;
 
 	if (adapter->scan_mode == SCAN_DISABLED)
@@ -685,11 +684,7 @@ static DBusMessage *set_pairable(DBusConnection *conn, DBusMessage *msg,
 	if (!(adapter->scan_mode & SCAN_INQUIRY))
 		goto store;
 
-	mode = (pairable && adapter->discov_timeout > 0 &&
-				adapter->discov_timeout <= 60) ?
-					MODE_LIMITED : MODE_DISCOVERABLE;
-
-	err = set_mode(adapter, mode, NULL);
+	err = set_mode(adapter, MODE_DISCOVERABLE, NULL);
 	if (err < 0 && msg)
 		return failed_strerror(msg, -err);
 
@@ -3255,10 +3250,7 @@ void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode)
 					ADAPTER_INTERFACE, "Pairable",
 					DBUS_TYPE_BOOLEAN, &pairable);
 
-	if (discoverable && adapter->pairable && adapter->discov_timeout > 0 &&
-						adapter->discov_timeout <= 60)
-		adapter_set_limited_discoverable(adapter, TRUE);
-	else if (!discoverable)
+	if (!discoverable)
 		adapter_set_limited_discoverable(adapter, FALSE);
 
 	emit_property_changed(connection, path,
diff --git a/src/hcid.h b/src/hcid.h
index 040411b..c73fe80 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -39,7 +39,6 @@
 #define MODE_OFF		0x00
 #define MODE_CONNECTABLE	0x01
 #define MODE_DISCOVERABLE	0x02
-#define MODE_LIMITED		0x03
 #define MODE_UNKNOWN		0xff
 
 struct main_opts {
-- 
1.7.1


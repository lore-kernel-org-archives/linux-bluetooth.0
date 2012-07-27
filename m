Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 11/14] core: Queue discovery if scanning is active
Date: Fri, 27 Jul 2012 19:29:55 -0300
Message-Id: <1343428198-23621-12-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1343428198-23621-1-git-send-email-jprvita@openbossa.org>
References: <1343428198-23621-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch manages BR/EDR inquiry and BLE scanning discovery sessions.
A scanning session is added in the discovery session list when there is
a bonded device which requires re-connection.

bluetoothd decides if interleaved or scanning needs to be executed based
on the queued discovery sessions. Interleaved discovery has higher
priority, scanning only is executed when there is only a scanning
session active.
---
 src/adapter.c |   68 +++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 21 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3bc2d0e..f27af24 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -132,6 +132,7 @@ struct btd_adapter {
 	GSList *devices;		/* Devices structure pointers */
 	GSList *mode_sessions;		/* Request Mode sessions */
 	GSList *disc_sessions;		/* Discovery sessions */
+	struct session_req *scanning_session;
 	GSList *connect_list;		/* Devices to connect when found */
 	GSList *connecting_list;	/* Pending connects */
 	guint discov_id;		/* Discovery timer */
@@ -220,18 +221,19 @@ static struct session_req *create_session(struct btd_adapter *adapter,
 					DBusConnection *conn, DBusMessage *msg,
 					uint8_t mode, GDBusWatchFunction cb)
 {
-	const char *sender = dbus_message_get_sender(msg);
+	const char *sender;
 	struct session_req *req;
 
 	req = g_new0(struct session_req, 1);
 	req->adapter = adapter;
-	req->conn = dbus_connection_ref(conn);
-	req->msg = dbus_message_ref(msg);
 	req->mode = mode;
 
-	if (cb == NULL)
+	if (conn == NULL || cb == NULL || msg == NULL)
 		return session_ref(req);
 
+	req->conn = dbus_connection_ref(conn);
+	req->msg = dbus_message_ref(msg);
+	sender = dbus_message_get_sender(msg);
 	req->owner = g_strdup(sender);
 	req->id = g_dbus_add_disconnect_watch(conn, sender, cb, req, NULL);
 
@@ -443,7 +445,9 @@ static struct session_req *find_session(GSList *list, const char *sender)
 	for (; list; list = list->next) {
 		struct session_req *req = list->data;
 
-		if (g_str_equal(req->owner, sender))
+		/* req->owner may be NULL if the session has been added by the
+		 * daemon itself, so we use g_strcmp0 instead of g_str_equal */
+		if (g_strcmp0(req->owner, sender) == 0)
 			return req;
 	}
 
@@ -518,7 +522,7 @@ static void session_remove(struct session_req *req)
 	struct btd_adapter *adapter = req->adapter;
 
 	/* Ignore set_mode session */
-	if (req->owner == NULL)
+	if (req->owner == NULL && adapter->pending_mode)
 		return;
 
 	DBG("%s session %p with %s deactivated",
@@ -1002,7 +1006,12 @@ static gboolean discovery_cb(gpointer user_data)
 	struct btd_adapter *adapter = user_data;
 
 	adapter->discov_id = 0;
-	mgmt_start_discovery(adapter->dev_id);
+
+	if (adapter->scanning_session &&
+			(g_slist_length(adapter->disc_sessions) == 1))
+		mgmt_start_scanning(adapter->dev_id);
+	else
+		mgmt_start_discovery(adapter->dev_id);
 
 	return FALSE;
 }
@@ -2172,6 +2181,7 @@ const char *btd_adapter_get_name(struct btd_adapter *adapter)
 void adapter_connect_list_add(struct btd_adapter *adapter,
 					struct btd_device *device)
 {
+	struct session_req *req;
 	bdaddr_t bdaddr;
 
 	device_get_address(device, &bdaddr, NULL);
@@ -2186,10 +2196,21 @@ void adapter_connect_list_add(struct btd_adapter *adapter,
 	DBG("%s added to %s's connect_list", device_get_path(device),
 								adapter->name);
 
-	if (adapter->disc_sessions)
+	if (!adapter->up)
 		return;
 
-	mgmt_start_scanning(adapter->dev_id);
+	if (adapter->off_requested)
+		return;
+
+	if (adapter->scanning_session)
+		return;
+
+	if (adapter->disc_sessions == NULL)
+		adapter->discov_id = g_idle_add(discovery_cb, adapter);
+
+	req = create_session(adapter, NULL, NULL, 0, NULL);
+	adapter->disc_sessions = g_slist_append(adapter->disc_sessions, req);
+	adapter->scanning_session = req;
 }
 
 void adapter_connect_list_remove(struct btd_adapter *adapter,
@@ -2202,6 +2223,7 @@ void adapter_connect_list_remove(struct btd_adapter *adapter,
 
 void btd_adapter_start(struct btd_adapter *adapter)
 {
+	struct session_req *req;
 	char address[18];
 	gboolean powered;
 
@@ -2228,8 +2250,15 @@ void btd_adapter_start(struct btd_adapter *adapter)
 
 	info("Adapter %s has been enabled", adapter->path);
 
-	if (g_slist_length(adapter->connect_list))
-		mgmt_start_scanning(adapter->dev_id);
+	if (g_slist_length(adapter->connect_list) == 0 ||
+					adapter->disc_sessions)
+		return;
+
+	req = create_session(adapter, NULL, NULL, 0, NULL);
+	adapter->disc_sessions = g_slist_append(adapter->disc_sessions, req);
+	adapter->scanning_session = req;
+
+	adapter->discov_id = g_idle_add(discovery_cb, adapter);
 }
 
 static void reply_pending_requests(struct btd_adapter *adapter)
@@ -2563,6 +2592,11 @@ void adapter_set_discovering(struct btd_adapter *adapter,
 
 	connect_list_size = g_slist_length(adapter->connect_list);
 
+	if (connect_list_size == 0 && adapter->scanning_session) {
+		session_unref(adapter->scanning_session);
+		adapter->scanning_session = NULL;
+	}
+
 	if (adapter_has_discov_sessions(adapter)) {
 		adapter->discov_id = g_idle_add(discovery_cb, adapter);
 
@@ -2571,14 +2605,6 @@ void adapter_set_discovering(struct btd_adapter *adapter,
 				g_slist_length(adapter->disc_sessions));
 		return;
 	}
-
-	if (connect_list_size) {
-		mgmt_start_scanning(adapter->dev_id);
-
-		DBG("hci%u restarting scanning connect_list size %u",
-				adapter->dev_id, connect_list_size);
-		return;
-	}
 }
 
 static void suspend_discovery(struct btd_adapter *adapter)
@@ -2877,7 +2903,6 @@ static gboolean clean_connecting_state(GIOChannel *io, GIOCondition cond, gpoint
 	struct btd_device *device = user_data;
 	struct btd_adapter *adapter = device_get_adapter(device);
 
-	adapter_connect_list_remove(adapter, device);
 	adapter->connecting_list = g_slist_remove(adapter->connecting_list,
 								device);
 
@@ -2885,7 +2910,7 @@ static gboolean clean_connecting_state(GIOChannel *io, GIOCondition cond, gpoint
 
 	if (!g_slist_length(adapter->connecting_list) &&
 					g_slist_length(adapter->connect_list))
-		mgmt_start_scanning(adapter->dev_id);
+		adapter->discov_id = g_idle_add(discovery_cb, adapter);
 
 	btd_device_unref(device);
 
@@ -3009,6 +3034,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 			goto done;
 
 		device = l->data;
+		adapter_connect_list_remove(adapter, device);
 		l = g_slist_find(adapter->connecting_list, device);
 		if (l)
 			goto done;
-- 
1.7.10.4


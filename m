Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v9 4/8] core: Start LE scanning when a device requests
Date: Tue,  2 Oct 2012 14:22:54 -0300
Message-Id: <1349198578-2818-4-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1349198578-2818-1-git-send-email-jprvita@openbossa.org>
References: <1349198578-2818-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch enables the LE scanning when a device requires connection and
there isn't discovery sessions, triggering the General Connection
Establishment Procedure.
---
 src/adapter.c | 70 ++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 17 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index d7f8c14..07b915e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -133,6 +133,7 @@ struct btd_adapter {
 	GSList *devices;		/* Devices structure pointers */
 	GSList *mode_sessions;		/* Request Mode sessions */
 	GSList *disc_sessions;		/* Discovery sessions */
+	struct session_req *scanning_session;
 	GSList *connect_list;		/* Devices to connect when found */
 	guint discov_id;		/* Discovery timer */
 	gboolean discovering;		/* Discovery active */
@@ -224,17 +225,22 @@ static struct session_req *create_session(struct btd_adapter *adapter,
 					DBusMessage *msg, uint8_t mode,
 					GDBusWatchFunction cb)
 {
-	const char *sender = dbus_message_get_sender(msg);
+	const char *sender;
 	struct session_req *req;
 
 	req = g_new0(struct session_req, 1);
 	req->adapter = adapter;
-	req->msg = dbus_message_ref(msg);
 	req->mode = mode;
 
-	if (cb == NULL)
+	if (msg == NULL)
+		return session_ref(req);
+
+	req->msg = dbus_message_ref(msg);
+
+	if(cb == NULL)
 		return session_ref(req);
 
+	sender = dbus_message_get_sender(msg);
 	req->owner = g_strdup(sender);
 	req->id = g_dbus_add_disconnect_watch(btd_get_dbus_connection(),
 							sender, cb, req, NULL);
@@ -445,7 +451,9 @@ static struct session_req *find_session(GSList *list, const char *sender)
 	for (; list; list = list->next) {
 		struct session_req *req = list->data;
 
-		if (g_str_equal(req->owner, sender))
+		/* req->owner may be NULL if the session has been added by the
+		 * daemon itself, so we use g_strcmp0 instead of g_str_equal */
+		if (g_strcmp0(req->owner, sender) == 0)
 			return req;
 	}
 
@@ -520,7 +528,7 @@ static void session_remove(struct session_req *req)
 	struct btd_adapter *adapter = req->adapter;
 
 	/* Ignore set_mode session */
-	if (req->owner == NULL)
+	if (req->owner == NULL && adapter->pending_mode)
 		return;
 
 	DBG("%s session %p with %s deactivated",
@@ -1028,7 +1036,12 @@ static gboolean discovery_cb(gpointer user_data)
 	struct btd_adapter *adapter = user_data;
 
 	adapter->discov_id = 0;
-	mgmt_start_discovery(adapter->dev_id);
+
+	if (adapter->scanning_session &&
+			(g_slist_length(adapter->disc_sessions) == 1))
+		mgmt_start_le_scanning(adapter->dev_id);
+	else
+		mgmt_start_discovery(adapter->dev_id);
 
 	return FALSE;
 }
@@ -2249,6 +2262,8 @@ const char *btd_adapter_get_name(struct btd_adapter *adapter)
 void adapter_connect_list_add(struct btd_adapter *adapter,
 					struct btd_device *device)
 {
+	struct session_req *req;
+
 	if (g_slist_find(adapter->connect_list, device)) {
 		DBG("ignoring already added device %s",
 						device_get_path(device));
@@ -2259,6 +2274,22 @@ void adapter_connect_list_add(struct btd_adapter *adapter,
 						btd_device_ref(device));
 	DBG("%s added to %s's connect_list", device_get_path(device),
 								adapter->name);
+
+	if (!adapter->up)
+		return;
+
+	if (adapter->off_requested)
+		return;
+
+	if (adapter->scanning_session)
+		return;
+
+	if (adapter->disc_sessions == NULL)
+		adapter->discov_id = g_idle_add(discovery_cb, adapter);
+
+	req = create_session(adapter, NULL, 0, NULL);
+	adapter->disc_sessions = g_slist_append(adapter->disc_sessions, req);
+	adapter->scanning_session = req;
 }
 
 void adapter_connect_list_remove(struct btd_adapter *adapter,
@@ -2278,6 +2309,7 @@ void adapter_connect_list_remove(struct btd_adapter *adapter,
 
 void btd_adapter_start(struct btd_adapter *adapter)
 {
+	struct session_req *req;
 	char address[18];
 	gboolean powered;
 
@@ -2304,8 +2336,15 @@ void btd_adapter_start(struct btd_adapter *adapter)
 
 	info("Adapter %s has been enabled", adapter->path);
 
-	if (g_slist_length(adapter->connect_list) > 0)
-		mgmt_start_le_scanning(adapter->dev_id);
+	if (g_slist_length(adapter->connect_list) == 0 ||
+					adapter->disc_sessions != NULL)
+		return;
+
+	req = create_session(adapter, NULL, 0, NULL);
+	adapter->disc_sessions = g_slist_append(adapter->disc_sessions, req);
+	adapter->scanning_session = req;
+
+	adapter->discov_id = g_idle_add(discovery_cb, adapter);
 }
 
 static void reply_pending_requests(struct btd_adapter *adapter)
@@ -2652,6 +2691,11 @@ void adapter_set_discovering(struct btd_adapter *adapter,
 
 	connect_list_len = g_slist_length(adapter->connect_list);
 
+	if (connect_list_len == 0 && adapter->scanning_session) {
+		session_unref(adapter->scanning_session);
+		adapter->scanning_session = NULL;
+	}
+
 	if (adapter_has_discov_sessions(adapter)) {
 		adapter->discov_id = g_idle_add(discovery_cb, adapter);
 
@@ -2660,14 +2704,6 @@ void adapter_set_discovering(struct btd_adapter *adapter,
 				g_slist_length(adapter->disc_sessions));
 		return;
 	}
-
-	if (connect_list_len > 0) {
-		mgmt_start_le_scanning(adapter->dev_id);
-
-		DBG("hci%u restarting scanning connect_list_len %u",
-				adapter->dev_id, connect_list_len);
-		return;
-	}
 }
 
 static void suspend_discovery(struct btd_adapter *adapter)
@@ -2982,7 +3018,7 @@ static gboolean clean_connecting_state(GIOChannel *io, GIOCondition cond,
 
 	if (adapter->waiting_to_connect == 0 &&
 				g_slist_length(adapter->connect_list) > 0)
-		mgmt_start_le_scanning(adapter->dev_id);
+		adapter->discov_id = g_idle_add(discovery_cb, adapter);
 
 	btd_device_unref(device);
 
-- 
1.7.11.4


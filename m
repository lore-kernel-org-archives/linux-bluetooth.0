Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ] core: fix stop scanning after GCEP
Date: Tue,  9 Oct 2012 14:38:27 -0300
Message-Id: <1349804307-20318-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The session type identification on struct session req (commit 328661a0)
broke the stop condition of the LE Genereal Connection Establishment
Procedure. This commit creates new identificators for discovery sessions
and makes their naming a bit more clear.
---
 src/adapter.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b6c1213..ad8ee06 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -87,8 +87,10 @@
 static GSList *adapter_drivers = NULL;
 
 enum session_req_type {
-	SESSION_REQ_TYPE_GLOBAL = 0,
-	SESSION_REQ_TYPE_SESSION,
+	SESSION_TYPE_MODE_GLOBAL = 0,
+	SESSION_TYPE_MODE_SESSION,
+	SESSION_TYPE_DISC_INTERLEAVED,
+	SESSION_TYPE_DISC_LE_SCAN
 };
 
 struct session_req {
@@ -345,7 +347,7 @@ static void set_session_pending_mode(struct btd_adapter *adapter,
 		session_ref(req);
 	} else
 		adapter->pending_mode = create_session(adapter, msg, new_mode,
-					SESSION_REQ_TYPE_SESSION, NULL);
+					SESSION_TYPE_MODE_SESSION, NULL);
 }
 
 static void set_discoverable(struct btd_adapter *adapter,
@@ -369,7 +371,7 @@ static void set_discoverable(struct btd_adapter *adapter,
 						strerror(-err));
 
 	adapter->pending_mode = create_session(adapter, NULL, mode,
-						SESSION_REQ_TYPE_GLOBAL, NULL);
+					SESSION_TYPE_MODE_GLOBAL, NULL);
 	adapter->pending_mode->prop_id = id;
 }
 
@@ -400,7 +402,7 @@ static void set_powered(struct btd_adapter *adapter, gboolean powered,
 						strerror(-err));
 
 	adapter->pending_mode = create_session(adapter, NULL, mode,
-						SESSION_REQ_TYPE_GLOBAL, NULL);
+					SESSION_TYPE_MODE_GLOBAL, NULL);
 	adapter->pending_mode->prop_id = id;
 }
 
@@ -560,7 +562,7 @@ static void session_remove(struct session_req *req)
 	struct btd_adapter *adapter = req->adapter;
 
 	/* Ignore global requests */
-	if (req->type == SESSION_REQ_TYPE_GLOBAL)
+	if (req->type == SESSION_TYPE_MODE_GLOBAL)
 		return;
 
 	DBG("%s session %p with %s deactivated",
@@ -1072,7 +1074,7 @@ static DBusMessage *adapter_start_discovery(DBusConnection *conn,
 		return btd_error_failed(msg, strerror(-err));
 
 done:
-	req = create_session(adapter, msg, 0, SESSION_REQ_TYPE_GLOBAL,
+	req = create_session(adapter, msg, 0, SESSION_TYPE_DISC_INTERLEAVED,
 							session_owner_exit);
 
 	adapter->disc_sessions = g_slist_append(adapter->disc_sessions, req);
@@ -1385,7 +1387,7 @@ static DBusMessage *request_session(DBusConnection *conn,
 		return dbus_message_new_method_return(msg);
 	} else {
 		req = create_session(adapter, msg, new_mode,
-				SESSION_REQ_TYPE_SESSION, session_owner_exit);
+				SESSION_TYPE_MODE_SESSION, session_owner_exit);
 		adapter->mode_sessions = g_slist_append(adapter->mode_sessions,
 							req);
 	}
@@ -2381,7 +2383,8 @@ void adapter_connect_list_add(struct btd_adapter *adapter,
 	if (adapter->disc_sessions == NULL)
 		adapter->discov_id = g_idle_add(discovery_cb, adapter);
 
-	req = create_session(adapter, NULL, 0, SESSION_REQ_TYPE_GLOBAL, NULL);
+	req = create_session(adapter, NULL, 0, SESSION_TYPE_DISC_LE_SCAN,
+									NULL);
 	adapter->disc_sessions = g_slist_append(adapter->disc_sessions, req);
 	adapter->scanning_session = req;
 }
@@ -2431,7 +2434,8 @@ void btd_adapter_start(struct btd_adapter *adapter)
 					adapter->disc_sessions != NULL)
 		return;
 
-	req = create_session(adapter, NULL, 0, SESSION_REQ_TYPE_GLOBAL, NULL);
+	req = create_session(adapter, NULL, 0, SESSION_TYPE_DISC_LE_SCAN,
+									NULL);
 	adapter->disc_sessions = g_slist_append(adapter->disc_sessions, req);
 	adapter->scanning_session = req;
 
@@ -2509,7 +2513,7 @@ static void set_mode_complete(struct btd_adapter *adapter)
 
 	err = (pending->mode != adapter->mode) ? -EINVAL : 0;
 
-	if (pending->type == SESSION_REQ_TYPE_GLOBAL) {
+	if (pending->type == SESSION_TYPE_MODE_GLOBAL) {
 		if (err < 0)
 			g_dbus_pending_property_error(conn, pending->prop_id,
 						ERROR_INTERFACE ".Failed",
-- 
1.7.11.4


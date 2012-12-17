Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] core: Remove mode session code
Date: Mon, 17 Dec 2012 17:45:54 +0200
Message-Id: <1355759155-27921-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355759155-27921-1-git-send-email-luiz.dentz@gmail.com>
References: <1355759155-27921-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Mode session no longer are needed since RequestSession is gone
---
 src/adapter.c | 210 +++++-----------------------------------------------------
 1 file changed, 15 insertions(+), 195 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2d81f66..b15c8b7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -89,8 +89,6 @@ static const char *base_path = "/org/bluez";
 static GSList *adapter_drivers = NULL;
 
 enum session_req_type {
-	SESSION_TYPE_MODE_GLOBAL = 0,
-	SESSION_TYPE_MODE_SESSION,
 	SESSION_TYPE_DISC_INTERLEAVED,
 	SESSION_TYPE_DISC_LE_SCAN
 };
@@ -99,10 +97,8 @@ struct session_req {
 	struct btd_adapter	*adapter;
 	enum session_req_type	type;
 	DBusMessage		*msg;		/* Unreplied message ref */
-	GDBusPendingPropertySet prop_id;	/* Pending Properties.Set() */
 	char			*owner;		/* Bus name of the owner */
 	guint			id;		/* Listener id */
-	uint8_t			mode;		/* Requested mode */
 	int			refcount;	/* Session refcount */
 	gboolean		got_reply;	/* Agent reply received */
 };
@@ -135,16 +131,12 @@ struct btd_adapter {
 	uint32_t discov_timeout;	/* discoverable time(sec) */
 	guint pairable_timeout_id;	/* pairable timeout id */
 	uint32_t pairable_timeout;	/* pairable time(sec) */
-	uint8_t mode;			/* off, connectable, discoverable,
-					 * limited */
-	uint8_t global_mode;		/* last valid global mode */
 	struct session_req *pending_mode;
 	guint auth_idle_id;		/* Pending authorization dequeue */
 	GQueue *auths;			/* Ongoing and pending auths */
 	GSList *connections;		/* Connected devices */
 	GSList *devices;		/* Devices structure pointers */
 	guint	remove_temp;		/* Remove devices timer */
-	GSList *mode_sessions;		/* Request Mode sessions */
 	GSList *disc_sessions;		/* Discovery sessions */
 	struct session_req *scanning_session;
 	GSList *connect_list;		/* Devices to connect when found */
@@ -181,20 +173,6 @@ int btd_adapter_set_class(struct btd_adapter *adapter, uint8_t major,
 	return mgmt_set_dev_class(adapter->dev_id, major, minor);
 }
 
-static const char *mode2str(uint8_t mode)
-{
-	switch(mode) {
-	case MODE_OFF:
-		return "off";
-	case MODE_CONNECTABLE:
-		return "connectable";
-	case MODE_DISCOVERABLE:
-		return "discoverable";
-	default:
-		return "unknown";
-	}
-}
-
 static uint8_t get_mode(const char *mode)
 {
 	if (strcasecmp("off", mode) == 0)
@@ -288,16 +266,15 @@ static struct session_req *session_ref(struct session_req *req)
 }
 
 static struct session_req *create_session(struct btd_adapter *adapter,
-					DBusMessage *msg, uint8_t mode,
-					enum session_req_type type,
-					GDBusWatchFunction cb)
+						DBusMessage *msg,
+						enum session_req_type type,
+						GDBusWatchFunction cb)
 {
 	const char *sender;
 	struct session_req *req;
 
 	req = g_new0(struct session_req, 1);
 	req->adapter = adapter;
-	req->mode = mode;
 	req->type = type;
 
 	if (msg == NULL)
@@ -313,56 +290,11 @@ static struct session_req *create_session(struct btd_adapter *adapter,
 	req->id = g_dbus_add_disconnect_watch(btd_get_dbus_connection(),
 							sender, cb, req, NULL);
 
-	info("%s session %p with %s activated",
-		req->mode ? "Mode" : "Discovery", req, sender);
+	info("session %p with %s activated", req, sender);
 
 	return session_ref(req);
 }
 
-static int set_mode(struct btd_adapter *adapter, uint8_t new_mode)
-{
-	int err;
-
-	if (adapter->pending_mode != NULL)
-		return -EALREADY;
-
-	if (!adapter->powered && new_mode != MODE_OFF) {
-		err = mgmt_set_powered(adapter->dev_id, TRUE);
-		if (err < 0)
-			return err;
-
-		goto done;
-	}
-
-	if (adapter->powered && new_mode == MODE_OFF) {
-		err = mgmt_set_powered(adapter->dev_id, FALSE);
-		if (err < 0)
-			return err;
-
-		adapter->off_requested = TRUE;
-
-		goto done;
-	}
-
-	if (new_mode == adapter->mode)
-		return 0;
-
-	if (new_mode == MODE_CONNECTABLE)
-		err = mgmt_set_discoverable(adapter->dev_id, FALSE, 0);
-	else
-		err = mgmt_set_discoverable(adapter->dev_id, TRUE,
-						adapter->discov_timeout);
-	if (err < 0)
-		return err;
-
-done:
-	store_adapter_info(adapter);
-
-	DBG("%s", mode2str(new_mode));
-
-	return 0;
-}
-
 static void set_discoverable(struct btd_adapter *adapter,
 			gboolean discoverable, GDBusPendingPropertySet id)
 {
@@ -386,6 +318,8 @@ static void set_powered(struct btd_adapter *adapter, gboolean powered,
 
 	if (powered == FALSE)
 		adapter->off_requested = TRUE;
+
+	g_dbus_pending_property_success(id);
 }
 
 static void set_pairable(struct btd_adapter *adapter, gboolean pairable,
@@ -453,23 +387,6 @@ static struct session_req *find_session(GSList *list, const char *sender)
 	return NULL;
 }
 
-static uint8_t get_needed_mode(struct btd_adapter *adapter, uint8_t mode)
-{
-	GSList *l;
-
-	if (adapter->global_mode > mode)
-		mode = adapter->global_mode;
-
-	for (l = adapter->mode_sessions; l; l = l->next) {
-		struct session_req *req = l->data;
-
-		if (req->mode > mode)
-			mode = req->mode;
-	}
-
-	return mode;
-}
-
 static void send_devices_found(struct btd_adapter *adapter)
 {
 	struct discovery *discovery = adapter->discovery;
@@ -565,38 +482,16 @@ static void session_remove(struct session_req *req)
 {
 	struct btd_adapter *adapter = req->adapter;
 
-	/* Ignore global requests */
-	if (req->type == SESSION_TYPE_MODE_GLOBAL)
-		return;
-
-	DBG("%s session %p with %s deactivated",
-		req->mode ? "Mode" : "Discovery", req, req->owner);
-
-	if (req->mode) {
-		uint8_t mode;
+	DBG("session %p with %s deactivated", req, req->owner);
 
-		adapter->mode_sessions = g_slist_remove(adapter->mode_sessions,
-							req);
+	adapter->disc_sessions = g_slist_remove(adapter->disc_sessions, req);
 
-		mode = get_needed_mode(adapter, adapter->global_mode);
-
-		if (mode == adapter->mode)
-			return;
-
-		DBG("Switching to '%s' mode", mode2str(mode));
-
-		set_mode(adapter, mode);
-	} else {
-		adapter->disc_sessions = g_slist_remove(adapter->disc_sessions,
-							req);
-
-		if (adapter->disc_sessions)
-			return;
+	if (adapter->disc_sessions)
+		return;
 
-		DBG("Stopping discovery");
+	DBG("Stopping discovery");
 
-		stop_discovery(adapter);
-	}
+	stop_discovery(adapter);
 }
 
 static void session_free(void *data)
@@ -1000,7 +895,7 @@ static DBusMessage *adapter_start_discovery(DBusConnection *conn,
 		return btd_error_failed(msg, strerror(-err));
 
 done:
-	req = create_session(adapter, msg, 0, SESSION_TYPE_DISC_INTERLEAVED,
+	req = create_session(adapter, msg, SESSION_TYPE_DISC_INTERLEAVED,
 							session_owner_exit);
 
 	adapter->disc_sessions = g_slist_append(adapter->disc_sessions, req);
@@ -1701,8 +1596,7 @@ void adapter_connect_list_add(struct btd_adapter *adapter,
 	if (adapter->disc_sessions == NULL)
 		adapter->discov_id = g_idle_add(discovery_cb, adapter);
 
-	req = create_session(adapter, NULL, 0, SESSION_TYPE_DISC_LE_SCAN,
-									NULL);
+	req = create_session(adapter, NULL, SESSION_TYPE_DISC_LE_SCAN, NULL);
 	adapter->disc_sessions = g_slist_append(adapter->disc_sessions, req);
 	adapter->scanning_session = req;
 }
@@ -1738,8 +1632,7 @@ void btd_adapter_start(struct btd_adapter *adapter)
 					adapter->disc_sessions != NULL)
 		return;
 
-	req = create_session(adapter, NULL, 0, SESSION_TYPE_DISC_LE_SCAN,
-									NULL);
+	req = create_session(adapter, NULL, SESSION_TYPE_DISC_LE_SCAN, NULL);
 	adapter->disc_sessions = g_slist_append(adapter->disc_sessions, req);
 	adapter->scanning_session = req;
 
@@ -1792,57 +1685,6 @@ static void unload_drivers(struct btd_adapter *adapter)
 	adapter->profiles = NULL;
 }
 
-static void set_mode_complete(struct btd_adapter *adapter)
-{
-	DBusConnection *conn = btd_get_dbus_connection();
-	struct session_req *pending;
-	int err;
-
-	DBG("%s", mode2str(adapter->mode));
-
-	if (adapter->mode == MODE_OFF) {
-		g_slist_free_full(adapter->mode_sessions, session_free);
-		adapter->mode_sessions = NULL;
-	}
-
-	if (adapter->pending_mode == NULL)
-		return;
-
-	pending = adapter->pending_mode;
-	adapter->pending_mode = NULL;
-
-	err = (pending->mode != adapter->mode) ? -EINVAL : 0;
-
-	if (pending->type == SESSION_TYPE_MODE_GLOBAL) {
-		if (err < 0)
-			g_dbus_pending_property_error(pending->prop_id,
-						ERROR_INTERFACE ".Failed",
-						strerror(-err));
-		else {
-			adapter->global_mode = adapter->mode;
-			g_dbus_pending_property_success(pending->prop_id);
-		}
-	} else if (pending->msg != NULL) {
-		DBusMessage *msg = pending->msg;
-		DBusMessage *reply;
-
-		if (err < 0)
-			reply = btd_error_failed(msg, strerror(-err));
-		else
-			reply = g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
-
-		g_dbus_send_message(conn, reply);
-	}
-
-	if (err != 0)
-		error("unable to set mode: %s", mode2str(pending->mode));
-
-	if (adapter->mode != MODE_DISCOVERABLE || adapter->discov_timeout == 0)
-		store_adapter_info(adapter);
-
-	session_unref(pending);
-}
-
 int btd_adapter_stop(struct btd_adapter *adapter)
 {
 	DBusConnection *conn = btd_get_dbus_connection();
@@ -1878,7 +1720,6 @@ int btd_adapter_stop(struct btd_adapter *adapter)
 	adapter->discoverable = FALSE;
 	adapter->connectable = false;
 
-	adapter->mode = MODE_OFF;
 	adapter->off_requested = FALSE;
 
 	if (emit_discoverable)
@@ -1897,8 +1738,6 @@ int btd_adapter_stop(struct btd_adapter *adapter)
 
 	info("Adapter %s has been disabled", adapter->path);
 
-	set_mode_complete(adapter);
-
 	return 0;
 }
 
@@ -2710,8 +2549,6 @@ static void load_config(struct btd_adapter *adapter)
 		gerr = NULL;
 	}
 
-	adapter->mode = MODE_OFF;
-
 	mgmt_set_connectable(adapter->dev_id, TRUE);
 	mgmt_set_discoverable(adapter->dev_id, adapter->discoverable,
 				adapter->discov_timeout);
@@ -3089,17 +2926,6 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 	}
 }
 
-static uint8_t create_mode(bool connectable, bool discoverable)
-{
-	if (connectable && discoverable)
-		return MODE_DISCOVERABLE;
-
-	if (connectable && !discoverable)
-		return MODE_CONNECTABLE;
-
-	return MODE_OFF;
-}
-
 void adapter_mode_changed(struct btd_adapter *adapter, bool connectable,
 							bool discoverable)
 {
@@ -3118,7 +2944,6 @@ void adapter_mode_changed(struct btd_adapter *adapter, bool connectable,
 
 	adapter->connectable = connectable;
 	adapter->discoverable = discoverable;
-	adapter->mode = create_mode(connectable, discoverable);
 
 	if (emit_pairable)
 		g_dbus_emit_property_changed(btd_get_dbus_connection(),
@@ -3126,8 +2951,6 @@ void adapter_mode_changed(struct btd_adapter *adapter, bool connectable,
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(), adapter->path,
 					ADAPTER_INTERFACE, "Discoverable");
-
-	set_mode_complete(adapter);
 }
 
 struct agent *adapter_get_agent(struct btd_adapter *adapter)
@@ -3385,9 +3208,6 @@ int btd_adapter_restore_powered(struct btd_adapter *adapter)
 	if (adapter->powered)
 		return 0;
 
-	if (adapter->mode == MODE_OFF)
-		return 0;
-
 	return mgmt_set_powered(adapter->dev_id, TRUE);
 }
 
-- 
1.7.11.7


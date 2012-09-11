Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v0 3/4] adapter: Queue parallel authorization requests
Date: Tue, 11 Sep 2012 15:55:29 +0200
Message-Id: <1347371730-14933-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1347371730-14933-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1347371730-14933-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Remote device could try to connect several profiles in parallel, or
several devices could be trying to connect services. Instead of
returning EBUSY, this patch adds a queue to each adapter such that the
authorization requests will be queued and processed sequentially.
---
 src/adapter.c |  150 ++++++++++++++++++++++++++++++--------------------------
 1 files changed, 80 insertions(+), 70 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index de5d1c9..14fe02a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -103,8 +103,10 @@ struct service_auth {
 	int id;
 	service_auth_cb cb;
 	void *user_data;
+	const char *uuid;
 	struct btd_device *device;
 	struct btd_adapter *adapter;
+	struct agent *agent;		/* NULL for queued auths */
 };
 
 struct btd_adapter {
@@ -131,8 +133,8 @@ struct btd_adapter {
 	GSList *found_devices;
 	GSList *oor_devices;		/* out of range device list */
 	struct agent *agent;		/* For the new API */
-	guint auth_idle_id;		/* Ongoing authorization (trusted) */
-	struct service_auth *auth;	/* Ongoing authorization */
+	guint auth_idle_id;		/* Pending authorization dequeue */
+	GQueue *auths;			/* Ongoing and pending auths */
 	GSList *connections;		/* Connected devices */
 	GSList *devices;		/* Devices structure pointers */
 	GSList *mode_sessions;		/* Request Mode sessions */
@@ -160,6 +162,8 @@ struct btd_adapter {
 	GSList *profiles;
 };
 
+static gboolean process_auth_queue(gpointer user_data);
+
 static void dev_info_free(void *data)
 {
 	struct remote_dev_info *dev = data;
@@ -971,16 +975,34 @@ static struct btd_device *adapter_create_device(DBusConnection *conn,
 	return device;
 }
 
+static void service_auth_cancel(struct service_auth *auth)
+{
+	DBusError derr;
+
+	dbus_error_init(&derr);
+	dbus_set_error_const(&derr, "org.bluez.Error.Canceled", NULL);
+
+	auth->cb(&derr, auth->user_data);
+
+	dbus_error_free(&derr);
+
+	if (auth->agent != NULL)
+		agent_cancel(auth->agent);
+
+	service_auth_free(auth);
+}
+
 void adapter_remove_device(DBusConnection *conn, struct btd_adapter *adapter,
 						struct btd_device *device,
 						gboolean remove_storage)
 {
 	const gchar *dev_path = device_get_path(device);
-	struct agent *agent;
 
 	adapter->devices = g_slist_remove(adapter->devices, device);
 	adapter->connections = g_slist_remove(adapter->connections, device);
 
+	g_queue_foreach(adapter->auths, (GFunc) service_auth_cancel, NULL);
+
 	adapter_update_devices(adapter);
 
 	g_dbus_emit_signal(conn, adapter->path,
@@ -988,13 +1010,6 @@ void adapter_remove_device(DBusConnection *conn, struct btd_adapter *adapter,
 			DBUS_TYPE_OBJECT_PATH, &dev_path,
 			DBUS_TYPE_INVALID);
 
-	agent = device_get_agent(device);
-
-	if (agent && adapter->auth && adapter->auth->device == device) {
-		adapter->auth = NULL;
-		agent_cancel(agent);
-	}
-
 	device_remove(device, remove_storage);
 }
 
@@ -2426,8 +2441,8 @@ static void adapter_free(gpointer user_data)
 	if (adapter->auth_idle_id)
 		g_source_remove(adapter->auth_idle_id);
 
-	if (adapter->auth)
-		service_auth_free(adapter->auth);
+	g_queue_foreach(adapter->auths, (GFunc) service_auth_free, NULL);
+	g_queue_free(adapter->auths);
 
 	if (adapter->off_timer)
 		off_timer_remove(adapter);
@@ -2525,6 +2540,7 @@ struct btd_adapter *adapter_create(DBusConnection *conn, int id)
 	}
 
 	adapter->dev_id = id;
+	adapter->auths = g_queue_new();
 
 	snprintf(path, sizeof(path), "%s/hci%d", base_path, id);
 	adapter->path = g_strdup(path);
@@ -3173,24 +3189,60 @@ static void agent_auth_cb(struct agent *agent, DBusError *derr,
 							void *user_data)
 {
 	struct btd_adapter *adapter = user_data;
-	struct service_auth *auth = adapter->auth;
+	struct service_auth *auth = adapter->auths->head->data;
 
-	adapter->auth = NULL;
+	g_queue_pop_head(adapter->auths);
 
 	auth->cb(derr, auth->user_data);
 
 	service_auth_free(auth);
+
+	adapter->auth_idle_id = g_idle_add(process_auth_queue, adapter);
 }
 
-static gboolean auth_idle_cb(gpointer user_data)
+static gboolean process_auth_queue(gpointer user_data)
 {
 	struct btd_adapter *adapter = user_data;
-	struct service_auth *auth = adapter->auth;
+	DBusError err;
 
-	adapter->auth = NULL;
 	adapter->auth_idle_id = 0;
 
-	auth->cb(NULL, auth->user_data);
+	dbus_error_init(&err);
+	dbus_set_error_const(&err, "org.bluez.Error.Rejected", NULL);
+
+	while (!g_queue_is_empty(adapter->auths)) {
+		struct service_auth *auth = adapter->auths->head->data;
+		struct btd_device *device = auth->device;
+		const gchar *dev_path;
+
+		if (device_is_trusted(device) == TRUE) {
+			auth->cb(NULL, auth->user_data);
+			goto next;
+		}
+
+		auth->agent = device_get_agent(device);
+		if (auth->agent == NULL) {
+			warn("Can't find device agent");
+			auth->cb(&err, auth->user_data);
+			goto next;
+		}
+
+		dev_path = device_get_path(device);
+
+		if (agent_authorize(auth->agent, dev_path, auth->uuid,
+					agent_auth_cb, adapter, NULL) < 0) {
+			auth->cb(&err, auth->user_data);
+			goto next;
+		}
+
+		break;
+
+next:
+		service_auth_free(auth);
+		g_queue_pop_head(adapter->auths);
+	}
+
+	dbus_error_free(&err);
 
 	return FALSE;
 }
@@ -3201,10 +3253,7 @@ static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
 {
 	struct service_auth *auth;
 	struct btd_device *device;
-	struct agent *agent;
 	char address[18];
-	const gchar *dev_path;
-	int err;
 
 	ba2str(dst, address);
 	device = adapter_find_device(adapter, address);
@@ -3215,46 +3264,29 @@ static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
 	if (!g_slist_find(adapter->connections, device))
 		error("Authorization request for non-connected device!?");
 
-	if (adapter->auth)
-		return -EBUSY;
-
 	auth = g_try_new0(struct service_auth, 1);
 	if (!auth)
 		return -ENOMEM;
 
 	auth->cb = cb;
 	auth->user_data = user_data;
+	auth->uuid = uuid;
 	auth->device = device;
 	auth->adapter = adapter;
 	auth->id = service_auth_id++;
 
 	g_hash_table_insert(service_auths, GUINT_TO_POINTER(auth->id), auth);
 
-	if (device_is_trusted(device) == TRUE) {
-		adapter->auth_idle_id = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE,
-							auth_idle_cb, adapter,
-							NULL);
-		goto done;
-	}
+	g_queue_push_tail(adapter->auths, auth);
 
-	agent = device_get_agent(device);
-	if (!agent) {
-		warn("Can't find device agent");
-		service_auth_free(auth);
-		return -EPERM;
-	}
+	if (adapter->auths->length != 1)
+		return auth->id;
 
-	dev_path = device_get_path(device);
+	if (adapter->auth_idle_id != 0)
+		return auth->id;
 
-	err = agent_authorize(agent, dev_path, uuid, agent_auth_cb, adapter,
-									NULL);
-	if (err < 0) {
-		service_auth_free(auth);
-		return err;
-	}
+	adapter->auth_idle_id = g_idle_add(process_auth_queue, adapter);
 
-done:
-	adapter->auth = auth;
 	return auth->id;
 }
 
@@ -3289,9 +3321,6 @@ int btd_request_authorization(const bdaddr_t *src, const bdaddr_t *dst,
 int btd_cancel_authorization(int auth_id)
 {
 	struct service_auth *auth;
-	struct btd_adapter *adapter;
-	struct agent *agent;
-	int err;
 
 	if (!service_auths)
 		return -EPERM;
@@ -3300,30 +3329,11 @@ int btd_cancel_authorization(int auth_id)
 	if (!auth)
 		return -EPERM;
 
-	adapter = auth->adapter;
-
-	if (adapter->auth_idle_id) {
-		g_source_remove(adapter->auth_idle_id);
-		adapter->auth_idle_id = 0;
-		adapter->auth = NULL;
-		return 0;
-	}
-
-	/*
-	 * FIXME: Cancel fails if authorization is requested to adapter's
-	 * agent and in the meanwhile CreatePairedDevice is called.
-	 */
-
-	agent = device_get_agent(auth->device);
-	if (!agent)
-		return -EPERM;
-
-	err = agent_cancel(agent);
+	g_queue_remove(auth->adapter->auths, auth);
 
-	if (err == 0)
-		adapter->auth = NULL;
+	service_auth_cancel(auth);
 
-	return err;
+	return 0;
 }
 
 static gchar *adapter_any_path = NULL;
-- 
1.7.7.6


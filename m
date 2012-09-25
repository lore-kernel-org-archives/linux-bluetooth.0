Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 5/6] adapter: Queue parallel authorization requests
Date: Tue, 25 Sep 2012 16:55:45 +0200
Message-Id: <1348584946-13895-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1348584946-13895-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1348584946-13895-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Remote device could try to connect several profiles in parallel, or
several devices could be trying to connect services. Instead of
returning EBUSY, this patch adds a queue to each adapter such that the
authorization requests will be queued and processed sequentially.
---
 src/adapter.c | 181 +++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 103 insertions(+), 78 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5f1a722..83746c7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -101,8 +101,10 @@ struct service_auth {
 	int id;
 	service_auth_cb cb;
 	void *user_data;
+	const char *uuid;
 	struct btd_device *device;
 	struct btd_adapter *adapter;
+	struct agent *agent;		/* NULL for queued auths */
 };
 
 struct btd_adapter {
@@ -129,8 +131,8 @@ struct btd_adapter {
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
@@ -158,6 +160,8 @@ struct btd_adapter {
 	GSList *profiles;
 };
 
+static gboolean process_auth_queue(gpointer user_data);
+
 static void dev_info_free(void *data)
 {
 	struct remote_dev_info *dev = data;
@@ -951,16 +955,49 @@ static struct btd_device *adapter_create_device(struct btd_adapter *adapter,
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
+	g_free(auth);
+}
+
 void adapter_remove_device(struct btd_adapter *adapter,
 						struct btd_device *device,
 						gboolean remove_storage)
 {
 	const gchar *dev_path = device_get_path(device);
-	struct agent *agent;
+	GList *l;
 
 	adapter->devices = g_slist_remove(adapter->devices, device);
 	adapter->connections = g_slist_remove(adapter->connections, device);
 
+	l = adapter->auths->head;
+	while (l != NULL) {
+		struct service_auth *auth = l->data;
+		GList *next = g_list_next(l);
+
+		if (auth->device != device) {
+			l = next;
+			continue;
+		}
+
+		g_queue_delete_link(adapter->auths, l);
+		l = next;
+
+		service_auth_cancel(auth);
+	}
+
 	adapter_update_devices(adapter);
 
 	g_dbus_emit_signal(btd_get_dbus_connection(), adapter->path,
@@ -968,14 +1005,6 @@ void adapter_remove_device(struct btd_adapter *adapter,
 			DBUS_TYPE_OBJECT_PATH, &dev_path,
 			DBUS_TYPE_INVALID);
 
-	agent = device_get_agent(device);
-
-	if (agent && adapter->auth && adapter->auth->device == device) {
-		g_free(adapter->auth);
-		adapter->auth = NULL;
-		agent_cancel(agent);
-	}
-
 	device_remove(device, remove_storage);
 }
 
@@ -2414,8 +2443,7 @@ static void adapter_free(gpointer user_data)
 	if (adapter->auth_idle_id)
 		g_source_remove(adapter->auth_idle_id);
 
-	if (adapter->auth)
-		g_free(adapter->auth);
+	g_queue_free_full(adapter->auths, g_free);
 
 	if (adapter->off_timer)
 		off_timer_remove(adapter);
@@ -2509,6 +2537,7 @@ struct btd_adapter *adapter_create(int id)
 	}
 
 	adapter->dev_id = id;
+	adapter->auths = g_queue_new();
 
 	snprintf(path, sizeof(path), "%s/hci%d", base_path, id);
 	adapter->path = g_strdup(path);
@@ -3152,26 +3181,60 @@ static void agent_auth_cb(struct agent *agent, DBusError *derr,
 							void *user_data)
 {
 	struct btd_adapter *adapter = user_data;
-	struct service_auth *auth = adapter->auth;
+	struct service_auth *auth = adapter->auths->head->data;
 
-	adapter->auth = NULL;
+	g_queue_pop_head(adapter->auths);
 
 	auth->cb(derr, auth->user_data);
 
 	g_free(auth);
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
 
-	g_free(auth);
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
+		g_free(auth);
+		g_queue_pop_head(adapter->auths);
+	}
+
+	dbus_error_free(&err);
 
 	return FALSE;
 }
@@ -3182,10 +3245,7 @@ static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
 {
 	struct service_auth *auth;
 	struct btd_device *device;
-	struct agent *agent;
 	char address[18];
-	const gchar *dev_path;
-	int err;
 
 	ba2str(dst, address);
 	device = adapter_find_device(adapter, address);
@@ -3196,42 +3256,27 @@ static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
 	if (!g_slist_find(adapter->connections, device))
 		error("Authorization request for non-connected device!?");
 
-	if (adapter->auth != NULL)
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
 
-	if (device_is_trusted(device) == TRUE) {
-		adapter->auth_idle_id = g_idle_add(auth_idle_cb, adapter);
-		goto done;
-	}
+	g_queue_push_tail(adapter->auths, auth);
 
-	agent = device_get_agent(device);
-	if (!agent) {
-		warn("Can't find device agent");
-		g_free(auth);
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
-		g_free(auth);
-		return err;
-	}
+	adapter->auth_idle_id = g_idle_add(process_auth_queue, adapter);
 
-done:
-	adapter->auth = auth;
 	return auth->id;
 }
 
@@ -3263,18 +3308,20 @@ int btd_request_authorization(const bdaddr_t *src, const bdaddr_t *dst,
 	return -EPERM;
 }
 
-static struct btd_adapter *find_authorization(int id)
+static struct service_auth *find_authorization(int id)
 {
 	GSList *l;
+	GList *l2;
 
 	for (l = manager_get_adapters(); l != NULL; l = g_slist_next(l)) {
 		struct btd_adapter *adapter = l->data;
 
-		if (adapter->auth == NULL)
-			continue;
+		for (l2 = adapter->auths->head; l2 != NULL; l2 = l2->next) {
+			struct service_auth *auth = l2->data;
 
-		if (adapter->auth->id == id)
-			return adapter;
+			if (auth->id == id)
+				return auth;
+		}
 	}
 
 	return NULL;
@@ -3282,39 +3329,17 @@ static struct btd_adapter *find_authorization(int id)
 
 int btd_cancel_authorization(int id)
 {
-	struct btd_adapter *adapter;
-	struct agent *agent;
-	int err;
-
-	adapter = find_authorization(id);
-	if (adapter == NULL)
-		return -EPERM;
-
-	if (adapter->auth_idle_id) {
-		g_source_remove(adapter->auth_idle_id);
-		adapter->auth_idle_id = 0;
-		g_free(adapter->auth);
-		adapter->auth = NULL;
-		return 0;
-	}
-
-	/*
-	 * FIXME: Cancel fails if authorization is requested to adapter's
-	 * agent and in the meanwhile CreatePairedDevice is called.
-	 */
+	struct service_auth *auth;
 
-	agent = device_get_agent(adapter->auth->device);
-	if (!agent)
+	auth = find_authorization(id);
+	if (auth == NULL)
 		return -EPERM;
 
-	err = agent_cancel(agent);
+	g_queue_remove(auth->adapter->auths, auth);
 
-	if (err == 0) {
-		g_free(adapter->auth);
-		adapter->auth = NULL;
-	}
+	service_auth_cancel(auth);
 
-	return err;
+	return 0;
 }
 
 static gchar *adapter_any_path = NULL;
-- 
1.7.11.4


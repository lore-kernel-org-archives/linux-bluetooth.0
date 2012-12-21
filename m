Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 14/25] observer: Add watchers and filters for observers
Date: Fri, 21 Dec 2012 16:26:41 -0400
Message-Id: <1356121612-15172-15-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
References: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The adapter will keep a list of observers listening for advertising.
The new observer is added on the list when it is registered.

When an observer is registered, the filter must be stored to be used
after receiving a new advertising. The observer will only receive the
data from advertising if the filter matches.
---
 src/adapter.c |  187 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 179 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 60dd54c..316acb9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -85,6 +85,11 @@
 #define REMOVE_TEMP_TIMEOUT (3 * 60)
 
 static const char *base_path = "/org/bluez";
+
+/* Filter Types (for Observer) */
+#define FILTER_SERVICE_UUID	0x01
+#define FILTER_COMPANY_IC	0x02
+
 static GSList *adapter_drivers = NULL;
 
 enum session_req_type {
@@ -116,6 +121,16 @@ struct discovery {
 	GSList *found;
 };
 
+struct observer_watcher {
+	struct btd_adapter *adapter;
+	guint id;			/* Listener id */
+	uint8_t filter_type;		/* Filer type: Service or Manufacturer
+					 * data */
+	void *filter_data;		/* Value of filter */
+	char *sender;			/* DBus sender */
+	char *path;			/* DBus path */
+};
+
 struct btd_adapter {
 	uint16_t dev_id;
 	gboolean powered;
@@ -136,6 +151,7 @@ struct btd_adapter {
 	GSList *disc_sessions;		/* Discovery sessions */
 	struct session_req *scanning_session;
 	GSList *connect_list;		/* Devices to connect when found */
+	GSList *observers;		/* Observer watchers */
 	guint discov_id;		/* Discovery timer */
 	struct discovery *discovery;	/* Discovery active */
 	gboolean connecting;		/* Connect active */
@@ -1154,10 +1170,85 @@ static DBusMessage *remove_device(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+static void destroy_observer(gpointer user_data)
+{
+	struct observer_watcher *obs = user_data;
+
+	btd_adapter_unref(obs->adapter);
+
+	g_dbus_remove_watch(btd_get_dbus_connection(), obs->id);
+
+	g_free(obs->path);
+	g_free(obs->sender);
+	g_free(obs);
+}
+
+static gint cmp_observer(gconstpointer a, gconstpointer b)
+{
+	const struct observer_watcher *obs = a;
+	const struct observer_watcher *match = b;
+	int ret;
+
+	ret = g_strcmp0(obs->sender, match->sender);
+	if (ret != 0)
+		return ret;
+
+	ret = g_strcmp0(obs->path, match->path);
+	if (ret != 0)
+		return ret;
+
+	return obs->filter_type - match->filter_type;
+}
+
+static struct observer_watcher *find_observer(GSList *list, const char *sender,
+					const char *path, uint8_t filter)
+{
+	struct observer_watcher *match;
+	GSList *l;
+
+	match = g_new0(struct observer_watcher, 1);
+	match->sender = g_strdup(sender);
+	match->path = g_strdup(path);
+	match->filter_type = filter;
+
+	l = g_slist_find_custom(list, match, cmp_observer);
+	g_free(match->sender);
+	g_free(match->path);
+	g_free(match);
+
+	return l ? l->data : NULL;
+}
+
+static void observer_exit(DBusConnection *conn, void *user_data)
+{
+	struct observer_watcher *obs = user_data;
+	struct btd_adapter *adapter = obs->adapter;
+
+	if (obs->filter_type == FILTER_SERVICE_UUID)
+		DBG("Service Data Observer watcher %s disconnected", obs->path);
+	else
+		DBG("Manufacturer Data Observer watcher %s disconnected",
+								obs->path);
+
+	adapter->observers = g_slist_remove(adapter->observers, obs);
+
+	if (adapter->observers == NULL) {
+		int err;
+
+		err = mgmt_set_observer(adapter->dev_id, FALSE);
+		if (err < 0)
+			error("Failed to set Observer: %s (%d)",
+							strerror(-err), -err);
+	}
+
+	destroy_observer(obs);
+}
+
 static DBusMessage *register_service_observer(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	struct btd_adapter *adapter = data;
+	struct observer_watcher *obs;
 	const char *path, *sender = dbus_message_get_sender(msg);
 	unsigned int uuid;
 	int err;
@@ -1167,8 +1258,26 @@ static DBusMessage *register_service_observer(DBusConnection *conn,
 					DBUS_TYPE_INVALID) == FALSE)
 		return btd_error_invalid_args(msg);
 
+	obs = find_observer(adapter->observers, sender, path,
+							FILTER_SERVICE_UUID);
+	if (obs)
+		return btd_error_already_exists(msg);
+
+	obs = g_new0(struct observer_watcher, 1);
+	obs->filter_type = FILTER_SERVICE_UUID;
+	obs->filter_data = GUINT_TO_POINTER(uuid);
+	obs->sender = g_strdup(sender);
+	obs->path = g_strdup(path);
+	obs->adapter = btd_adapter_ref(adapter);
+	obs->id = g_dbus_add_disconnect_watch(conn, sender, observer_exit,
+								obs, NULL);
+
+	adapter->observers = g_slist_prepend(adapter->observers, obs);
+
 	err = mgmt_set_observer(adapter->dev_id, TRUE);
 	if (err < 0) {
+		adapter->observers = g_slist_remove(adapter->observers, obs);
+		destroy_observer(obs);
 		error("Failed to set Observer: %s (%d)", strerror(-err), -err);
 
 		return btd_error_failed(msg, strerror(-err));
@@ -1185,15 +1294,28 @@ static DBusMessage *unregister_service_observer(DBusConnection *conn,
 {
 	const char *path, *sender = dbus_message_get_sender(msg);
 	struct btd_adapter *adapter = data;
-	int err;
+	struct observer_watcher *obs;
 
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
 						DBUS_TYPE_INVALID) == FALSE)
 		return btd_error_invalid_args(msg);
 
-	err = mgmt_set_observer(adapter->dev_id, FALSE);
-	if (err < 0)
-		return btd_error_failed(msg, strerror(-err));
+	obs = find_observer(adapter->observers, sender, path,
+							FILTER_SERVICE_UUID);
+	if (obs == NULL)
+		return btd_error_does_not_exist(msg);
+
+	adapter->observers = g_slist_remove(adapter->observers, obs);
+	g_dbus_remove_watch(btd_get_dbus_connection(), obs->id);
+	destroy_observer(obs);
+
+	if (adapter->observers == NULL) {
+		int err;
+
+		err = mgmt_set_observer(adapter->dev_id, FALSE);
+		if (err < 0)
+			return btd_error_failed(msg, strerror(-err));
+	}
 
 	DBG("Service Data Observer unregistered for hci%d at %s:%s",
 						adapter->dev_id, sender, path);
@@ -1205,6 +1327,7 @@ static DBusMessage *register_manuf_observer(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	struct btd_adapter *adapter = data;
+	struct observer_watcher *obs;
 	const char *path, *sender = dbus_message_get_sender(msg);
 	unsigned int company_id;
 	int err;
@@ -1214,8 +1337,26 @@ static DBusMessage *register_manuf_observer(DBusConnection *conn,
 					DBUS_TYPE_INVALID) == FALSE)
 		return btd_error_invalid_args(msg);
 
+	obs = find_observer(adapter->observers, sender, path,
+							FILTER_COMPANY_IC);
+	if (obs)
+		return btd_error_already_exists(msg);
+
+	obs = g_new0(struct observer_watcher, 1);
+	obs->filter_type = FILTER_COMPANY_IC;
+	obs->filter_data = GUINT_TO_POINTER(company_id);
+	obs->sender = g_strdup(sender);
+	obs->path = g_strdup(path);
+	obs->adapter = btd_adapter_ref(adapter);
+	obs->id = g_dbus_add_disconnect_watch(conn, sender, observer_exit,
+								obs, NULL);
+
+	adapter->observers = g_slist_prepend(adapter->observers, obs);
+
 	err = mgmt_set_observer(adapter->dev_id, TRUE);
 	if (err < 0) {
+		adapter->observers = g_slist_remove(adapter->observers, obs);
+		destroy_observer(obs);
 		error("Failed to set Observer: %s (%d)", strerror(-err), -err);
 
 		return btd_error_failed(msg, strerror(-err));
@@ -1232,15 +1373,28 @@ static DBusMessage *unregister_manuf_observer(DBusConnection *conn,
 {
 	const char *path, *sender = dbus_message_get_sender(msg);
 	struct btd_adapter *adapter = data;
-	int err;
+	struct observer_watcher *obs;
 
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
 						DBUS_TYPE_INVALID) == FALSE)
 		return btd_error_invalid_args(msg);
 
-	err = mgmt_set_observer(adapter->dev_id, FALSE);
-	if (err < 0)
-		return btd_error_failed(msg, strerror(-err));
+	obs = find_observer(adapter->observers, sender, path,
+							FILTER_COMPANY_IC);
+	if (obs == NULL)
+		return btd_error_does_not_exist(msg);
+
+	adapter->observers = g_slist_remove(adapter->observers, obs);
+	g_dbus_remove_watch(btd_get_dbus_connection(), obs->id);
+	destroy_observer(obs);
+
+	if (adapter->observers == NULL) {
+		int err;
+
+		err = mgmt_set_observer(adapter->dev_id, FALSE);
+		if (err < 0)
+			return btd_error_failed(msg, strerror(-err));
+	}
 
 	DBG("Manuf. Specific Data Observer unregistered for hci%d at %s:%s",
 						adapter->dev_id, sender, path);
@@ -2830,6 +2984,21 @@ struct btd_adapter *adapter_create(int id)
 	return btd_adapter_ref(adapter);
 }
 
+static void release_all_obs(struct btd_adapter *adapter)
+{
+	int err;
+
+	if (!adapter->observers)
+		return;
+
+	err = mgmt_set_observer(adapter->dev_id, FALSE);
+	if (err < 0)
+		error("Failed to set Observer: %s (%d)",
+						strerror(-err), -err);
+
+	g_slist_free_full(adapter->observers, destroy_observer);
+}
+
 void adapter_remove(struct btd_adapter *adapter)
 {
 	GSList *l;
@@ -2852,6 +3021,8 @@ void adapter_remove(struct btd_adapter *adapter)
 
 	g_slist_free(adapter->pin_callbacks);
 
+	release_all_obs(adapter);
+
 	if (adapter->powered)
 		mgmt_set_powered(adapter->dev_id, FALSE);
 }
-- 
1.7.9.5


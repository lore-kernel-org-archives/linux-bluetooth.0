Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 20/33] observer: Add watchers and filters for observers
Date: Mon, 27 Aug 2012 13:03:12 -0400
Message-Id: <1346087005-24693-21-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The adapter will keep a list of observers to listening for advertising.
The new observer is added on the list when it is registered.

When an observer is registered, the filter must be stored to be used
after receiving a new advertising. The observer only will received the
data from advertising if the filter matches.
---
 src/adapter.c |  179 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 171 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b2c052f..3b8cbcd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -82,6 +82,10 @@
 
 #define OFF_TIMER 3
 
+/* Filter Types (for Observer) */
+#define FILTER_SERVICE_UUID	0x01
+#define FILTER_COMPANY_IC	0x02
+
 static DBusConnection *connection = NULL;
 static GSList *adapter_drivers = NULL;
 
@@ -103,6 +107,16 @@ struct service_auth {
 	struct btd_adapter *adapter;
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
 	gboolean up;
@@ -132,6 +146,7 @@ struct btd_adapter {
 	GSList *devices;		/* Devices structure pointers */
 	GSList *mode_sessions;		/* Request Mode sessions */
 	GSList *disc_sessions;		/* Discovery sessions */
+	GSList *observers;		/* Observer watchers */
 	guint discov_id;		/* Discovery timer */
 	gboolean discovering;		/* Discovery active */
 	gboolean discov_suspended;	/* Discovery suspended */
@@ -1617,10 +1632,85 @@ static DBusMessage *unregister_agent(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+static void destroy_observer(gpointer user_data)
+{
+	struct observer_watcher *obs = user_data;
+
+	btd_adapter_unref(obs->adapter);
+
+	g_dbus_remove_watch(connection, obs->id);
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
+	return (l ? l->data : NULL);
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
@@ -1630,8 +1720,26 @@ static DBusMessage *register_service_observer(DBusConnection *conn,
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
@@ -1648,15 +1756,28 @@ static DBusMessage *unregister_service_observer(DBusConnection *conn,
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
+	g_dbus_remove_watch(connection, obs->id);
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
@@ -1668,6 +1789,7 @@ static DBusMessage *register_manufobserver(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	struct btd_adapter *adapter = data;
+	struct observer_watcher *obs;
 	const char *path, *sender = dbus_message_get_sender(msg);
 	unsigned int company_id;
 	int err;
@@ -1677,8 +1799,26 @@ static DBusMessage *register_manufobserver(DBusConnection *conn,
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
@@ -1695,15 +1835,28 @@ static DBusMessage *unregister_manufobserver(DBusConnection *conn,
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
+	g_dbus_remove_watch(connection, obs->id);
+	destroy_observer(obs);
+
+	if (adapter->observers == NULL) {
+		int err;
+
+		err = mgmt_set_observer(adapter->dev_id, FALSE);
+		if (err < 0)
+			return btd_error_failed(msg, strerror(-err));
+	}
 
 	DBG("Manufacturer Specific Data Observer unregistered for hci%d at "
 					"%s:%s", adapter->dev_id, sender, path);
@@ -2470,6 +2623,16 @@ static void adapter_free(gpointer user_data)
 
 	g_slist_free(adapter->oor_devices);
 
+	if (adapter->observers) {
+		int err;
+
+		err = mgmt_set_observer(adapter->dev_id, FALSE);
+		if (err < 0)
+			error("Failed to set Observer: %s (%d)",
+							strerror(-err), -err);
+		g_slist_free_full(adapter->observers, destroy_observer);
+	}
+
 	g_free(adapter->path);
 	g_free(adapter->name);
 	g_free(adapter);
-- 
1.7.9.5


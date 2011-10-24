Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 3/8] Implement D-Bus register watcher function
Date: Mon, 24 Oct 2011 19:04:03 +0200
Message-Id: <1319475848-4171-4-git-send-email-sancane@gmail.com>
In-Reply-To: <1319475848-4171-3-git-send-email-sancane@gmail.com>
References: <1319475848-4171-1-git-send-email-sancane@gmail.com>
 <1319475848-4171-2-git-send-email-sancane@gmail.com>
 <1319475848-4171-3-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   96 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 9c9a861..155b84a 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -50,6 +50,7 @@ struct thermometer {
 	guint			attioid;	/* Att watcher id */
 	guint			attindid;	/* Att incications id */
 	GSList			*chars;		/* Characteristics */
+	GSList			*fwatchers;     /* Final measurements */
 	gboolean		intermediate;
 	guint8			type;
 	guint16			interval;
@@ -71,8 +72,27 @@ struct descriptor {
 	bt_uuid_t		uuid;
 };
 
+struct watcher {
+	struct thermometer	*t;
+	guint			id;
+	gchar			*srv;
+	gchar			*path;
+};
+
 static GSList *thermometers = NULL;
 
+static void destroy_watcher(gpointer user_data)
+{
+	struct watcher *watcher = user_data;
+
+	if (watcher->id > 0)
+		g_dbus_remove_watch(watcher->t->conn, watcher->id);
+
+	g_free(watcher->path);
+	g_free(watcher->srv);
+	g_free(watcher);
+}
+
 static void destroy_char(gpointer user_data)
 {
 	struct characteristic *c = user_data;
@@ -97,6 +117,9 @@ static void destroy_thermometer(gpointer user_data)
 	if (t->chars != NULL)
 		g_slist_free_full(t->chars, destroy_char);
 
+	if (t->fwatchers != NULL)
+		g_slist_free_full(t->fwatchers, destroy_watcher);
+
 	dbus_connection_unref(t->conn);
 	btd_device_unref(t->dev);
 	g_free(t->svc_range);
@@ -114,6 +137,19 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
+static gint cmp_watcher(gconstpointer a, gconstpointer b)
+{
+	const struct watcher *watcher = a;
+	const struct watcher *match = b;
+	int ret;
+
+	ret = g_strcmp0(watcher->srv, match->srv);
+	if (ret != 0)
+		return ret;
+
+	return g_strcmp0(watcher->path, match->path);
+}
+
 static void change_property(struct thermometer *t, const gchar *name,
 							gpointer value) {
 	if (g_strcmp0(name, "Intermediate") == 0) {
@@ -410,12 +446,66 @@ static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 						"Function not implemented.");
 }
 
+static void enable_final_measurement(struct thermometer *t)
+{
+	/* TODO: enable final measurements */
+}
+
+static void watcher_exit(DBusConnection *conn, void *user_data)
+{
+	/* TODO: Watcher disconnected */
+}
+
+static struct watcher *find_watcher(struct thermometer *t, const gchar *sender,
+							const gchar *path)
+{
+	struct watcher *match;
+	GSList *l;
+
+	match = g_new0(struct watcher, 1);
+	match->srv = g_strdup(sender);
+	match->path = g_strdup(path);
+
+	l = g_slist_find_custom(t->fwatchers, match, cmp_watcher);
+	destroy_watcher(match);
+
+	if (l != NULL)
+		return l->data;
+
+	return NULL;
+}
+
 static DBusMessage *register_watcher(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
-	/* TODO: */
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".ThermometerError",
-						"Function not implemented.");
+	const gchar *sender = dbus_message_get_sender(msg);
+	struct thermometer *t = data;
+	struct watcher *watcher;
+	gchar *path;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+							DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	watcher = find_watcher(t, sender, path);
+	if (watcher != NULL)
+		return btd_error_already_exists(msg);
+
+	DBG("Thermometer watcher %s registered", path);
+
+	watcher = g_new0(struct watcher, 1);
+	watcher->srv = g_strdup(sender);
+	watcher->path = g_strdup(path);
+	watcher->t = t;
+	watcher->id = g_dbus_add_disconnect_watch(conn, sender, watcher_exit,
+						watcher, destroy_watcher);
+
+	if (g_slist_length(t->fwatchers) == 0)
+		enable_final_measurement(t);
+
+	t->fwatchers = g_slist_prepend(t->fwatchers, watcher);
+
+	return dbus_message_new_method_return(msg);
 }
 
 static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
-- 
1.7.6.1


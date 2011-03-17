Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 15/15] GATT server: add disconnect watch
Date: Wed, 16 Mar 2011 21:00:39 -0400
Message-Id: <1300323639-13296-16-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The disconnect watch is used to delete attributes added by a client. The
added attributes are only useful while the D-Bus client which added them
is alive, otherwise read/write callbacks, notifications and indications
will not work.
---
 plugins/gatt-profile.c |   64 +++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/plugins/gatt-profile.c b/plugins/gatt-profile.c
index 521befe..600efa1 100644
--- a/plugins/gatt-profile.c
+++ b/plugins/gatt-profile.c
@@ -44,6 +44,11 @@
 static DBusConnection *connection = NULL;
 static const char *any_path = NULL;
 
+struct client_data {
+	GSList *attrs; /* All attributes registered by this client */
+	guint listener_id;
+};
+
 struct gatt_descriptor {
 	uint16_t type;
 	union {
@@ -568,6 +573,7 @@ static void register_services(gpointer data, gpointer user_data)
 static void free_services(gpointer data, gpointer user_data)
 {
 	struct gatt_service *svc = data;
+	GSList **attrs = user_data;
 	GSList *cl;
 
 	for (cl = svc->chars; cl; cl = cl->next) {
@@ -593,6 +599,9 @@ static void free_services(gpointer data, gpointer user_data)
 	g_free(svc->id);
 	g_slist_free(svc->includes);
 
+	if (attrs)
+		*attrs = g_slist_concat(*attrs, svc->attrs);
+
 	g_free(svc);
 }
 
@@ -639,7 +648,8 @@ static void update_includes(gpointer data, gpointer user_data)
 	}
 }
 
-static int add_xml_profile(DBusConnection *conn, const char *profile)
+static int add_xml_profile(DBusConnection *conn, const char *profile,
+								GSList **attrs)
 {
 	GMarkupParser parser = { element_start, element_end, NULL, NULL, NULL };
 	GMarkupParseContext *ctx;
@@ -656,7 +666,7 @@ static int add_xml_profile(DBusConnection *conn, const char *profile)
 	g_slist_foreach(services, resolve_includes, services);
 	g_slist_foreach(services, register_services, NULL);
 	g_slist_foreach(services, update_includes, NULL);
-	g_slist_foreach(services, free_services, NULL);
+	g_slist_foreach(services, free_services, attrs);
 	g_slist_free(services);
 
 	g_markup_parse_context_free(ctx);
@@ -664,23 +674,59 @@ static int add_xml_profile(DBusConnection *conn, const char *profile)
 	return ret;
 }
 
+static void exit_callback(DBusConnection *conn, void *user_data)
+{
+	struct client_data *client = user_data;
+	GSList *l;
+
+	DBG("client=%p", client);
+
+	for (l = client->attrs; l; l = l->next) {
+		struct attribute *a = l->data;
+
+		attrib_db_del(a->handle);
+	}
+
+	g_slist_free(client->attrs);
+	client->attrs = NULL;
+}
+
 static DBusMessage *add_profile(DBusConnection *conn, DBusMessage *msg,
 								void *user_data)
 {
-	const char *profile;
+	struct client_data *client = user_data;
+	const char *sender, *profile;
 	int err;
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &profile,
 							DBUS_TYPE_INVALID))
 		return NULL;
 
-	err = add_xml_profile(conn, profile);
+	err = add_xml_profile(conn, profile, &client->attrs);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
+	sender = dbus_message_get_sender(msg);
+	client->listener_id = g_dbus_add_disconnect_watch(conn, sender,
+					exit_callback, client, NULL);
+
+	DBG("listener_id %d", client->listener_id);
+
 	return dbus_message_new_method_return(msg);
 }
 
+static void destroy_interface(void *user_data)
+{
+	struct client_data *client = user_data;
+
+	DBG("client=%p", client);
+
+	g_dbus_remove_watch(connection, client->listener_id);
+	exit_callback(connection, client);
+
+	g_free(client);
+}
+
 static GDBusMethodTable gatt_profile_methods[] = {
 	{ "AddProfile", "s", "", add_profile },
 	{ }
@@ -688,13 +734,19 @@ static GDBusMethodTable gatt_profile_methods[] = {
 
 static int register_interface(const char *path, struct btd_adapter *adapter)
 {
+	struct client_data *client;
+
 	DBG("path %s", path);
 
+	client = g_new0(struct client_data, 1);
+
 	if (!g_dbus_register_interface(connection, path, GATT_PROFILE_INTERFACE,
-					gatt_profile_methods, NULL, NULL, NULL,
-					NULL)) {
+					gatt_profile_methods, NULL, NULL,
+					client, destroy_interface)) {
 		error("D-Bus failed to register %s interface",
 							GATT_PROFILE_INTERFACE);
+		g_free(client);
+
 		return -EIO;
 	}
 
-- 
1.7.0.4


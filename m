Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 4/4] core/gatt: Add UnregisterService and track sender
Date: Wed,  4 Mar 2015 13:57:51 -0800
Message-Id: <1425506271-20775-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1425506271-20775-1-git-send-email-armansito@chromium.org>
References: <1425506271-20775-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the GattManager1.UnregisterService method. The
API implementation is slightly changed so that external services are
tracked on a per path + sender basis and not just based on the object
path.
---
 src/gatt-database.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index c7b2223..d4dd661 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -978,12 +978,18 @@ static void gatt_db_service_removed(struct gatt_db_attribute *attrib,
 								ccc_cb_free);
 }
 
-static bool match_service_path(const void *a, const void *b)
+struct svc_match_data {
+	const char *path;
+	const char *sender;
+};
+
+static bool match_service(const void *a, const void *b)
 {
 	const struct external_service *service = a;
-	const char *path = b;
+	const struct svc_match_data *data = b;
 
-	return g_strcmp0(service->path, path) == 0;
+	return g_strcmp0(service->path, data->path) == 0 &&
+				g_strcmp0(service->owner, data->sender) == 0;
 }
 
 static gboolean service_free_idle_cb(void *data)
@@ -2064,9 +2070,11 @@ static DBusMessage *manager_register_service(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
 	struct btd_gatt_database *database = user_data;
+	const char *sender = dbus_message_get_sender(msg);
 	DBusMessageIter args;
 	const char *path;
 	struct external_service *service;
+	struct svc_match_data match_data;
 
 	if (!dbus_message_iter_init(msg, &args))
 		return btd_error_invalid_args(msg);
@@ -2076,7 +2084,10 @@ static DBusMessage *manager_register_service(DBusConnection *conn,
 
 	dbus_message_iter_get_basic(&args, &path);
 
-	if (queue_find(database->services, match_service_path, path))
+	match_data.path = path;
+	match_data.sender = sender;
+
+	if (queue_find(database->services, match_service, &match_data))
 		return btd_error_already_exists(msg);
 
 	dbus_message_iter_next(&args);
@@ -2098,10 +2109,32 @@ static DBusMessage *manager_register_service(DBusConnection *conn,
 static DBusMessage *manager_unregister_service(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
-	DBG("UnregisterService");
+	struct btd_gatt_database *database = user_data;
+	const char *sender = dbus_message_get_sender(msg);
+	const char *path;
+	DBusMessageIter args;
+	struct external_service *service;
+	struct svc_match_data match_data;
 
-	/* TODO */
-	return NULL;
+	if (!dbus_message_iter_init(msg, &args))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&args, &path);
+
+	match_data.path = path;
+	match_data.sender = sender;
+
+	service = queue_remove_if(database->services, match_service,
+								&match_data);
+	if (!service)
+		return btd_error_does_not_exist(msg);
+
+	service_free(service);
+
+	return dbus_message_new_method_return(msg);
 }
 
 static const GDBusMethodTable manager_methods[] = {
-- 
2.2.0.rc0.207.ga3a616c


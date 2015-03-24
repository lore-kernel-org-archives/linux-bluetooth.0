Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] core/gatt: Add implementation of UnregisterProfile
Date: Tue, 24 Mar 2015 11:37:52 +0200
Message-Id: <1427189873-29770-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1427189873-29770-1-git-send-email-luiz.dentz@gmail.com>
References: <1427189873-29770-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds initial implementation of GattProfile.UnregisterProfile.
---
 src/gatt-database.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index e701439..9e9a368 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2322,6 +2322,37 @@ static DBusMessage *manager_register_profile(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *manager_unregister_profile(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct btd_gatt_database *database = user_data;
+	const char *sender = dbus_message_get_sender(msg);
+	const char *path;
+	DBusMessageIter args;
+	struct external_profile *profile;
+	struct svc_match_data match_data;
+
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
+	profile = queue_remove_if(database->profiles, match_profile,
+								&match_data);
+	if (!profile)
+		return btd_error_does_not_exist(msg);
+
+	profile_free(profile);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static const GDBusMethodTable manager_methods[] = {
 	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("RegisterService",
 			GDBUS_ARGS({ "service", "o" }, { "options", "a{sv}" }),
@@ -2333,6 +2364,9 @@ static const GDBusMethodTable manager_methods[] = {
 			GDBUS_ARGS({ "profile", "o" }, { "UUIDs", "as" },
 			{ "options", "a{sv}" }), NULL,
 			manager_register_profile) },
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("UnregisterProfile",
+					GDBUS_ARGS({ "profile", "o" }),
+					NULL, manager_unregister_profile) },
 	{ }
 };
 
-- 
2.1.0


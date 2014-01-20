Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org,
	Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [PATCH BlueZ v1 07/18] gatt: Implement UnregisterService
Date: Mon, 20 Jan 2014 15:04:52 -0300
Message-Id: <1390241103-808-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1390241103-808-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1389285503-19348-1-git-send-email-claudio.takahasi@openbossa.org>
 <1390241103-808-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alvaro Silva <alvaro.silva@openbossa.org>

This patch implements UnregisterService method of ServiceManager1.
External applications may call this method to unregister a given
service without leaving the system bus.
---
 src/gatt-dbus.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index fc41d00..1f789b0 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -243,6 +243,31 @@ static DBusMessage *register_service(DBusConnection *conn,
 static DBusMessage *unregister_service(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
+	struct external_app *eapp = user_data;
+	DBusMessageIter iter;
+	const char *path;
+	GSList *list;
+
+	DBG("Unregistering GATT Service");
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_OBJECT_PATH)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &path);
+
+	list = g_slist_find_custom(external_apps, path, external_app_path_cmp);
+	if (list == NULL)
+		return btd_error_does_not_exist(msg);
+
+	eapp = list->data;
+	if (g_strcmp0(dbus_message_get_sender(msg), eapp->owner) != 0)
+		return btd_error_does_not_exist(msg);
+
+	g_dbus_remove_watch(conn, eapp->watch);
+
 	return dbus_message_new_method_return(msg);
 }
 
-- 
1.8.3.1


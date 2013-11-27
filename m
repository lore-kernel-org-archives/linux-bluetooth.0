Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [RFC BlueZ v0 07/17] gatt: Implement UnregisterService
Date: Wed, 27 Nov 2013 17:50:47 -0300
Message-Id: <1385585457-26951-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1385585457-26951-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1385585457-26951-1-git-send-email-claudio.takahasi@openbossa.org>
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
index a53eed2..a7424d5 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -243,6 +243,31 @@ invalid:
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
+	if (dbus_message_iter_init(msg, &iter) == false)
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


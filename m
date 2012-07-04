Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v3 04/22] manager: remove deprecated ListAdapters() method
Date: Wed,  4 Jul 2012 14:31:45 +0200
Message-Id: <1341405105-5760-1-git-send-email-gustavo@padovan.org>
In-Reply-To: <1341389867-30749-5-git-send-email-gustavo@padovan.org>
References: <1341389867-30749-5-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 src/manager.c         |   33 ---------------------------------
 test/list-devices     |    3 +--
 test/test-health      |    2 +-
 test/test-health-sink |    3 +--
 4 files changed, 3 insertions(+), 38 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index 1637657..4a39461 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -130,36 +130,6 @@ done:
 	return reply;
 }
 
-static DBusMessage *list_adapters(DBusConnection *conn,
-					DBusMessage *msg, void *data)
-{
-	DBusMessageIter iter;
-	DBusMessageIter array_iter;
-	DBusMessage *reply;
-	GSList *l;
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	dbus_message_iter_init_append(reply, &iter);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-				DBUS_TYPE_OBJECT_PATH_AS_STRING, &array_iter);
-
-	for (l = adapters; l; l = l->next) {
-		struct btd_adapter *adapter = l->data;
-		const gchar *path = adapter_get_path(adapter);
-
-		dbus_message_iter_append_basic(&array_iter,
-					DBUS_TYPE_OBJECT_PATH, &path);
-	}
-
-	dbus_message_iter_close_container(&iter, &array_iter);
-
-	return reply;
-}
-
 static DBusMessage *get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -207,9 +177,6 @@ static const GDBusMethodTable manager_methods[] = {
 			GDBUS_ARGS({ "pattern", "s" }),
 			GDBUS_ARGS({ "adapter", "o" }),
 			find_adapter) },
-	{ GDBUS_DEPRECATED_METHOD("ListAdapters",
-			NULL, GDBUS_ARGS({ "adapters", "ao" }),
-			list_adapters) },
 	{ }
 };
 
diff --git a/test/list-devices b/test/list-devices
index 7ef6511..1683142 100755
--- a/test/list-devices
+++ b/test/list-devices
@@ -29,8 +29,7 @@ def extract_uuids(uuid_list):
 		list = list + val + " "
 	return list
 
-adapter_list = manager.ListAdapters()
-
+adapter_list = manager.GetProperties()["Adapters"]
 for i in adapter_list:
 	adapter = dbus.Interface(bus.get_object("org.bluez", i),
 							"org.bluez.Adapter")
diff --git a/test/test-health b/test/test-health
index 307e880..a7df679 100755
--- a/test/test-health
+++ b/test/test-health
@@ -134,7 +134,7 @@ if not con:
 manager = dbus.Interface(bus.get_object("org.bluez", "/"),
 						"org.bluez.Manager")
 
-adapters = manager.ListAdapters()
+adapters = manager.GetProperties()["Adapters"]
 
 i = 1
 for ad in adapters:
diff --git a/test/test-health-sink b/test/test-health-sink
index 7ee5e1a..333b2fb 100755
--- a/test/test-health-sink
+++ b/test/test-health-sink
@@ -24,8 +24,7 @@ print(app_path)
 manager = dbus.Interface(bus.get_object("org.bluez", "/"),
 						"org.bluez.Manager")
 
-adapters = manager.ListAdapters()
-
+adapters = manager.GetProperties()["Adapters"]
 i = 1
 for ad in adapters:
 	print("%d. %s" % (i, ad))
-- 
1.7.10.2


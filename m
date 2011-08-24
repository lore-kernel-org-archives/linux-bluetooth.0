Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 1/4] Remove forward declaration
Date: Wed, 24 Aug 2011 16:09:47 -0300
Message-Id: <1314212990-13090-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   35 ++++++++++++++++-------------------
 1 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 7ee970c..5878a76 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -151,9 +151,6 @@ struct btd_adapter {
 	GSList *loaded_drivers;
 };
 
-static void adapter_set_pairable_timeout(struct btd_adapter *adapter,
-					guint interval);
-
 static int found_device_cmp(const struct remote_dev_info *d1,
 			const struct remote_dev_info *d2)
 {
@@ -522,22 +519,6 @@ static DBusMessage *set_powered(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
-void btd_adapter_pairable_changed(struct btd_adapter *adapter,
-							gboolean pairable)
-{
-	adapter->pairable = pairable;
-
-	write_device_pairable(&adapter->bdaddr, pairable);
-
-	emit_property_changed(connection, adapter->path,
-				ADAPTER_INTERFACE, "Pairable",
-				DBUS_TYPE_BOOLEAN, &pairable);
-
-	if (pairable && adapter->pairable_timeout)
-		adapter_set_pairable_timeout(adapter,
-						adapter->pairable_timeout);
-}
-
 static DBusMessage *set_pairable(DBusConnection *conn, DBusMessage *msg,
 				gboolean pairable, void *data)
 {
@@ -587,6 +568,22 @@ static void adapter_set_pairable_timeout(struct btd_adapter *adapter,
 						adapter);
 }
 
+void btd_adapter_pairable_changed(struct btd_adapter *adapter,
+							gboolean pairable)
+{
+	adapter->pairable = pairable;
+
+	write_device_pairable(&adapter->bdaddr, pairable);
+
+	emit_property_changed(connection, adapter->path,
+				ADAPTER_INTERFACE, "Pairable",
+				DBUS_TYPE_BOOLEAN, &pairable);
+
+	if (pairable && adapter->pairable_timeout)
+		adapter_set_pairable_timeout(adapter,
+						adapter->pairable_timeout);
+}
+
 static struct session_req *find_session(GSList *list, const char *sender)
 {
 	for (; list; list = list->next) {
-- 
1.7.6


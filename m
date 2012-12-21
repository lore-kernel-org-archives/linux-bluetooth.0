Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 12/25] observer: Add Register/UnregisterServiceObserver() D-Bus method
Date: Fri, 21 Dec 2012 16:26:39 -0400
Message-Id: <1356121612-15172-13-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
References: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

An observer for Service Data must be registered using
RegisterServiceObserver() D-Bus method so it can receive any advertising
which matches with the filter used. Use UnregisterServiceObserver()
D-Bus method for unregistering an observer and stop sending broadcasts
to the agent.
---
 src/adapter.c |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 34dad6e..a5c23da 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1157,12 +1157,47 @@ static DBusMessage *remove_device(DBusConnection *conn, DBusMessage *msg,
 static DBusMessage *register_service_observer(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
+	struct btd_adapter *adapter = data;
+	const char *path, *sender = dbus_message_get_sender(msg);
+	unsigned int uuid;
+	int err;
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_UINT16, &uuid,
+					DBUS_TYPE_INVALID) == FALSE)
+		return btd_error_invalid_args(msg);
+
+	err = mgmt_set_observer(adapter->dev_id, TRUE);
+	if (err < 0) {
+		error("Failed to set Observer: %s (%d)", strerror(-err), -err);
+
+		return btd_error_failed(msg, strerror(-err));
+	}
+
+	DBG("Service Data Observer registered for hci%d at %s:%s",
+						adapter->dev_id, sender, path);
+
 	return dbus_message_new_method_return(msg);
 }
 
 static DBusMessage *unregister_service_observer(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
+	const char *path, *sender = dbus_message_get_sender(msg);
+	struct btd_adapter *adapter = data;
+	int err;
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+						DBUS_TYPE_INVALID) == FALSE)
+		return btd_error_invalid_args(msg);
+
+	err = mgmt_set_observer(adapter->dev_id, FALSE);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	DBG("Service Data Observer unregistered for hci%d at %s:%s",
+						adapter->dev_id, sender, path);
+
 	return dbus_message_new_method_return(msg);
 }
 
-- 
1.7.9.5


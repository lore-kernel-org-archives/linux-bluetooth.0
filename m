Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC BlueZ 27/33] broadcaster: Add SetServiceData() D-Bus method
Date: Mon, 27 Aug 2012 13:03:19 -0400
Message-Id: <1346087005-24693-28-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

Receive the service UUID with advertising data will be set in device.
---
 src/adapter.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 61abb34..118e633 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1872,6 +1872,23 @@ static DBusMessage *unregister_manufobserver(DBusConnection *conn,
 static DBusMessage *set_service_data(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
+	struct btd_adapter *adapter = data;
+	const char *sender;
+	uint16_t uuid;
+	uint8_t *sdata;
+	int ssize;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT16, &uuid,
+						DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE,
+						&sdata, &ssize,
+						DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	sender = dbus_message_get_sender(msg);
+
+	DBG("Service Data Broadcaster registered for hci%d at %s",
+						adapter->dev_id, sender);
+
 	return dbus_message_new_method_return(msg);
 }
 
-- 
1.7.9.5


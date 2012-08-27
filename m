Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 18/33] observer: Add RegisterManufacturerObserver() D-Bus method
Date: Mon, 27 Aug 2012 13:03:10 -0400
Message-Id: <1346087005-24693-19-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

An observer for Manufacturer Specific Data must be registered using
RegisterManufacturerObserver() D-Bus method so it can receive any
advertising which matches with the filter used.
---
 src/adapter.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index b437cf6..e5237b5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1667,6 +1667,26 @@ static DBusMessage *unregister_service_observer(DBusConnection *conn,
 static DBusMessage *register_manufobserver(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
+	struct btd_adapter *adapter = data;
+	const char *path, *sender = dbus_message_get_sender(msg);
+	unsigned int company_id;
+	int err;
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_UINT16, &company_id,
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
+	DBG("Manufacturer Specific Data Observer registered for hci%d at %s:%s",
+						adapter->dev_id, sender, path);
+
 	return dbus_message_new_method_return(msg);
 }
 
-- 
1.7.9.5


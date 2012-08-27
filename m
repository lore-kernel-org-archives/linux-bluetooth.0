Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 19/33] observer: Add UnregisterManufacturerObserver() D-Bus method
Date: Mon, 27 Aug 2012 13:03:11 -0400
Message-Id: <1346087005-24693-20-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Unregister an observer for Manufacturer Specific Data and avoid to send
broadcaster to this agent.
---
 src/adapter.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index e5237b5..b2c052f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1693,6 +1693,21 @@ static DBusMessage *register_manufobserver(DBusConnection *conn,
 static DBusMessage *unregister_manufobserver(DBusConnection *conn,
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
+	DBG("Manufacturer Specific Data Observer unregistered for hci%d at "
+					"%s:%s", adapter->dev_id, sender, path);
+
 	return dbus_message_new_method_return(msg);
 }
 
-- 
1.7.9.5


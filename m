Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 28/33] broadcaster: Add SetManufacturerData() D-Bus method
Date: Mon, 27 Aug 2012 13:03:20 -0400
Message-Id: <1346087005-24693-29-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Receive the Company Identifier Code with advertising data will be set in
device.
---
 src/adapter.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 118e633..94c813c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1895,6 +1895,23 @@ static DBusMessage *set_service_data(DBusConnection *conn,
 static DBusMessage *set_manufacturer_data(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
+	struct btd_adapter *adapter = data;
+	const char *sender;
+	uint16_t company_id;
+	uint8_t *mdata;
+	int msize;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT16, &company_id,
+						DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE,
+						&mdata, &msize,
+						DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	sender = dbus_message_get_sender(msg);
+
+	DBG("Manufacturer Specific Data Broadcaster registered for hci%d at %s",
+						adapter->dev_id, sender);
+
 	return dbus_message_new_method_return(msg);
 }
 
-- 
1.7.9.5


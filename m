Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/10] gatt: Add implementation of NotifyLocked
Date: Mon,  3 Jul 2017 15:11:46 +0300
Message-Id: <20170703121148.24299-9-luiz.dentz@gmail.com>
In-Reply-To: <20170703121148.24299-1-luiz.dentz@gmail.com>
References: <20170703121148.24299-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This property indicate if any client has acquire notify thus locking the
access to StartNotify.
---
 src/gatt-client.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 6bff87b..85d71e2 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -837,6 +837,18 @@ characteristic_get_write_locked(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean
+characteristic_get_notify_locked(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct characteristic *chrc = data;
+	dbus_bool_t locked = chrc->notify_io ? TRUE : FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &locked);
+
+	return TRUE;
+}
+
 static void write_characteristic_cb(struct gatt_db_attribute *attr, int err,
 								void *user_data)
 {
@@ -1063,6 +1075,10 @@ static void characteristic_destroy_pipe(struct characteristic *chrc,
 	} else if (chrc->notify_io) {
 		pipe_io_destroy(chrc->notify_io);
 		chrc->notify_io = NULL;
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						chrc->path,
+						GATT_CHARACTERISTIC_IFACE,
+						"NotifyLocked");
 	}
 }
 
@@ -1124,8 +1140,13 @@ static DBusMessage *characteristic_create_pipe(struct characteristic *chrc,
 						chrc->path,
 						GATT_CHARACTERISTIC_IFACE,
 						"WriteLocked");
-	} else
+	} else {
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						chrc->path,
+						GATT_CHARACTERISTIC_IFACE,
+						"NotifyLocked");
 		chrc->notify_io->io = io;
+	}
 
 	DBG("%s: sender %s io %p", dbus_message_get_member(msg),
 					dbus_message_get_sender(msg), io);
@@ -1564,6 +1585,8 @@ static const GDBusPropertyTable characteristic_properties[] = {
 	{ "Flags", "as", characteristic_get_flags, NULL, NULL },
 	{ "WriteLocked", "b", characteristic_get_write_locked, NULL, NULL,
 				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "NotifyLocked", "b", characteristic_get_notify_locked, NULL, NULL,
+				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
-- 
2.9.4


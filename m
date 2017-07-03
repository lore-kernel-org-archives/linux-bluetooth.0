Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/10] gatt: Add implementation of WriteLocked
Date: Mon,  3 Jul 2017 15:11:42 +0300
Message-Id: <20170703121148.24299-5-luiz.dentz@gmail.com>
In-Reply-To: <20170703121148.24299-1-luiz.dentz@gmail.com>
References: <20170703121148.24299-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This property indicate if any client has acquire write thus locking the
access to WriteValue.
---
 src/gatt-client.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index b66ee4e..12bdbdc 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -818,6 +818,18 @@ static gboolean characteristic_get_flags(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean
+characteristic_get_write_locked(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct characteristic *chrc = data;
+	dbus_bool_t locked = chrc->write_io ? TRUE : FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &locked);
+
+	return TRUE;
+}
+
 static void write_characteristic_cb(struct gatt_db_attribute *attr, int err,
 								void *user_data)
 {
@@ -1025,6 +1037,10 @@ static void characteristic_destroy_pipe(struct characteristic *chrc,
 	if (io == chrc->write_io) {
 		io_destroy(chrc->write_io);
 		chrc->write_io = NULL;
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						chrc->path,
+						GATT_CHARACTERISTIC_IFACE,
+						"WriteLocked");
 	}
 }
 
@@ -1080,8 +1096,13 @@ static DBusMessage *characteristic_create_pipe(struct characteristic *chrc,
 
 	close(pipefd[dir]);
 
-	if (dir)
+	if (dir) {
 		chrc->write_io = io;
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						chrc->path,
+						GATT_CHARACTERISTIC_IFACE,
+						"WriteLocked");
+	}
 
 	DBG("%s: sender %s io %p", dbus_message_get_member(msg),
 					dbus_message_get_sender(msg), io);
@@ -1406,6 +1427,8 @@ static const GDBusPropertyTable characteristic_properties[] = {
 	{ "Notifying", "b", characteristic_get_notifying, NULL,
 					characteristic_notifying_exists },
 	{ "Flags", "as", characteristic_get_flags, NULL, NULL },
+	{ "WriteLocked", "b", characteristic_get_write_locked, NULL, NULL,
+				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
-- 
2.9.4


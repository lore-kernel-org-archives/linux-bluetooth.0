Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 04/10] gatt: Add implementation of WriteAcquired
Date: Tue,  4 Jul 2017 18:09:31 +0300
Message-Id: <20170704150937.11701-5-luiz.dentz@gmail.com>
In-Reply-To: <20170704150937.11701-1-luiz.dentz@gmail.com>
References: <20170704150937.11701-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This property indicate if any client has acquire write thus locking the
access to WriteValue.
---
 src/gatt-client.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 9a660df..9ab5f96 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -818,6 +818,27 @@ static gboolean characteristic_get_flags(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean
+characteristic_get_write_acquired(const GDBusPropertyTable *property,
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
+static gboolean
+characteristic_write_acquired_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct characteristic *chrc = data;
+
+	return (chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP);
+}
+
 static void write_characteristic_cb(struct gatt_db_attribute *attr, int err,
 								void *user_data)
 {
@@ -1025,6 +1046,10 @@ static void characteristic_destroy_pipe(struct characteristic *chrc,
 	if (io == chrc->write_io) {
 		io_destroy(chrc->write_io);
 		chrc->write_io = NULL;
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						chrc->path,
+						GATT_CHARACTERISTIC_IFACE,
+						"WriteAcquired");
 	}
 }
 
@@ -1080,8 +1105,13 @@ static DBusMessage *characteristic_create_pipe(struct characteristic *chrc,
 
 	close(pipefd[dir]);
 
-	if (dir)
+	if (dir) {
 		chrc->write_io = io;
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						chrc->path,
+						GATT_CHARACTERISTIC_IFACE,
+						"WriteAcquired");
+	}
 
 	DBG("%s: sender %s io %p", dbus_message_get_member(msg),
 					dbus_message_get_sender(msg), io);
@@ -1406,6 +1436,9 @@ static const GDBusPropertyTable characteristic_properties[] = {
 	{ "Notifying", "b", characteristic_get_notifying, NULL,
 					characteristic_notifying_exists },
 	{ "Flags", "as", characteristic_get_flags, NULL, NULL },
+	{ "WriteAcquired", "b", characteristic_get_write_acquired, NULL,
+				characteristic_write_acquired_exists,
+				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
-- 
2.9.4


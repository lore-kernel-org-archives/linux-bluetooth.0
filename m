Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 08/10] gatt: Add implementation of NotifyAcquired
Date: Tue,  4 Jul 2017 18:09:35 +0300
Message-Id: <20170704150937.11701-9-luiz.dentz@gmail.com>
In-Reply-To: <20170704150937.11701-1-luiz.dentz@gmail.com>
References: <20170704150937.11701-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This property indicate if any client has acquire notify thus locking the
access to StartNotify.
---
 src/gatt-client.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 571d310..8f3e60c 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -846,6 +846,27 @@ characteristic_write_acquired_exists(const GDBusPropertyTable *property,
 	return (chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP);
 }
 
+static gboolean
+characteristic_get_notify_acquired(const GDBusPropertyTable *property,
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
+static gboolean
+characteristic_notify_acquired_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct characteristic *chrc = data;
+
+	return (chrc->props & BT_GATT_CHRC_PROP_NOTIFY);
+}
+
 static void write_characteristic_cb(struct gatt_db_attribute *attr, int err,
 								void *user_data)
 {
@@ -1072,6 +1093,10 @@ static void characteristic_destroy_pipe(struct characteristic *chrc,
 	} else if (chrc->notify_io) {
 		pipe_io_destroy(chrc->notify_io);
 		chrc->notify_io = NULL;
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						chrc->path,
+						GATT_CHARACTERISTIC_IFACE,
+						"NotifyAcquired");
 	}
 }
 
@@ -1133,8 +1158,13 @@ static DBusMessage *characteristic_create_pipe(struct characteristic *chrc,
 						chrc->path,
 						GATT_CHARACTERISTIC_IFACE,
 						"WriteAcquired");
-	} else
+	} else {
 		chrc->notify_io->io = io;
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						chrc->path,
+						GATT_CHARACTERISTIC_IFACE,
+						"NotifyAcquired");
+	}
 
 	DBG("%s: sender %s io %p", dbus_message_get_member(msg),
 					dbus_message_get_sender(msg), io);
@@ -1574,6 +1604,9 @@ static const GDBusPropertyTable characteristic_properties[] = {
 	{ "WriteAcquired", "b", characteristic_get_write_acquired, NULL,
 				characteristic_write_acquired_exists,
 				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "NotifyAcquired", "b", characteristic_get_notify_acquired, NULL,
+				characteristic_notify_acquired_exists,
+				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
-- 
2.9.4


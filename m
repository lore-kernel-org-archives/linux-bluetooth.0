Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [RFC 08/18] cyclingspeed: Add support to enable measurement notifications
Date: Thu, 25 Oct 2012 16:43:38 +0200
Message-ID: <1351176228-5789-9-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/cyclingspeed/cyclingspeed.c | 72 +++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 0b3742a..53fbb02 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -184,6 +184,17 @@ static void destroy_csc(gpointer user_data)
 	g_free(csc);
 }
 
+static void char_write_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	char *msg = user_data;
+
+	if (status != 0)
+		error("%s failed", msg);
+
+	g_free(msg);
+}
+
 static void read_feature_cb(guint8 status, const guint8 *pdu,
 						guint16 len, gpointer user_data)
 {
@@ -269,9 +280,25 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu,
 		if (uuid != GATT_CLIENT_CHARAC_CFG_UUID)
 			continue;
 
-		if (g_strcmp0(ch->uuid, CSC_MEASUREMENT_UUID) == 0)
+		if (g_strcmp0(ch->uuid, CSC_MEASUREMENT_UUID) == 0) {
+			char *msg;
+			uint8_t attr_val[2];
+
 			ch->csc->measurement_ccc_handle = handle;
 
+			if (g_slist_length(ch->csc->cadapter->watchers) == 0) {
+				att_put_u16(0x0000, attr_val);
+				msg = g_strdup("Disable measurement");
+			} else {
+				att_put_u16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT,
+								attr_val);
+				msg = g_strdup("Enable measurement");
+			}
+
+			gatt_write_char(ch->csc->attrib, handle, attr_val,
+					sizeof(attr_val), char_write_cb, msg);
+		}
+
 		/* We only want CCC, can break here */
 		break;
 	}
@@ -343,6 +370,40 @@ static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 							read_feature_cb, csc);
 }
 
+static void enable_measurement(gpointer data, gpointer user_data)
+{
+	struct csc *csc = data;
+	uint16_t handle = csc->measurement_ccc_handle;
+	uint8_t value[2];
+	char *msg;
+
+	if (csc->attrib == NULL || !handle)
+		return;
+
+	att_put_u16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
+	msg = g_strdup("Enable measurement");
+
+	gatt_write_char(csc->attrib, handle, value, sizeof(value),
+							char_write_cb, msg);
+}
+
+static void disable_measurement(gpointer data, gpointer user_data)
+{
+	struct csc *csc = data;
+	uint16_t handle = csc->measurement_ccc_handle;
+	uint8_t value[2];
+	char *msg;
+
+	if (csc->attrib == NULL || !handle)
+		return;
+
+	att_put_u16(0x0000, value);
+	msg = g_strdup("Disable measurement");
+
+	gatt_write_char(csc->attrib, handle, value, sizeof(value),
+							char_write_cb, msg);
+}
+
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct csc *csc = user_data;
@@ -375,6 +436,9 @@ static void watcher_exit_cb(DBusConnection *conn, void *user_data)
 
 	cadapter->watchers = g_slist_remove(cadapter->watchers, watcher);
 	g_dbus_remove_watch(conn, watcher->id);
+
+	if (g_slist_length(cadapter->watchers) == 0)
+		g_slist_foreach(cadapter->devices, disable_measurement, 0);
 }
 
 static DBusMessage *register_watcher(DBusConnection *conn, DBusMessage *msg,
@@ -400,6 +464,9 @@ static DBusMessage *register_watcher(DBusConnection *conn, DBusMessage *msg,
 	watcher->srv = g_strdup(sender);
 	watcher->path = g_strdup(path);
 
+	if (g_slist_length(cadapter->watchers) == 0)
+		g_slist_foreach(cadapter->devices, enable_measurement, 0);
+
 	cadapter->watchers = g_slist_prepend(cadapter->watchers, watcher);
 
 	DBG("cycling watcher [%s] registered", path);
@@ -426,6 +493,9 @@ static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
 	cadapter->watchers = g_slist_remove(cadapter->watchers, watcher);
 	g_dbus_remove_watch(conn, watcher->id);
 
+	if (g_slist_length(cadapter->watchers) == 0)
+		g_slist_foreach(cadapter->devices, disable_measurement, 0);
+
 	DBG("cycling watcher [%s] unregistered", path);
 
 	return dbus_message_new_method_return(msg);
-- 
1.8.0


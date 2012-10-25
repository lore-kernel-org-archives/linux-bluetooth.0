Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [RFC 09/18] cyclingspeed: Process measurement notifications
Date: Thu, 25 Oct 2012 16:43:39 +0200
Message-ID: <1351176228-5789-10-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/cyclingspeed/cyclingspeed.c | 139 ++++++++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 1 deletion(-)

diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 53fbb02..f7ffd2e 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -42,6 +42,14 @@
 #include "cyclingspeed.h"
 
 #define CYCLINGSPEED_MANAGER_INTERFACE	"org.bluez.CyclingSpeedManager"
+#define CYCLINGSPEED_WATCHER_INTERFACE	"org.bluez.CyclingSpeedWatcher"
+
+#define WHEEL_REV_SUPPORT		0x01
+#define CRANK_REV_SUPPORT		0x02
+#define MULTI_SENSOR_LOC_SUPPORT	0x04
+
+#define WHEEL_REV_PRESENT	0x01
+#define CRANK_REV_PRESENT	0x02
 
 struct csc_adapter {
 	struct btd_adapter	*adapter;
@@ -55,6 +63,8 @@ struct csc {
 
 	GAttrib			*attrib;
 	guint			attioid;
+	/* attio id for measurement characteristics value notifications */
+	guint			attio_measurement_id;
 
 	struct att_range	*svc_range;
 
@@ -73,6 +83,18 @@ struct watcher {
 	char			*path;
 };
 
+struct measurement {
+	struct csc	*csc;
+
+	bool		has_wheel_rev;
+	uint32_t	wheel_rev;
+	uint16_t	last_wheel_time;
+
+	bool		has_crank_rev;
+	uint16_t	crank_rev;
+	uint16_t	last_crank_time;
+};
+
 struct characteristic {
 	struct csc	*csc;
 	char		uuid[MAX_LEN_UUID_STR + 1];
@@ -176,8 +198,10 @@ static void destroy_csc(gpointer user_data)
 	if (csc->attioid > 0)
 		btd_device_remove_attio_callback(csc->dev, csc->attioid);
 
-	if (csc->attrib != NULL)
+	if (csc->attrib != NULL) {
+		g_attrib_unregister(csc->attrib, csc->attio_measurement_id);
 		g_attrib_unref(csc->attrib);
+	}
 
 	btd_device_unref(csc->dev);
 	g_free(csc->svc_range);
@@ -334,6 +358,109 @@ static void discover_desc(struct csc *csc, struct gatt_char *c,
 	gatt_find_info(csc->attrib, start, end, discover_desc_cb, ch);
 }
 
+static void update_watcher(gpointer data, gpointer user_data)
+{
+	struct watcher *w = data;
+	struct measurement *m = user_data;
+	struct csc *csc = m->csc;
+	const gchar *path = device_get_path(csc->dev);
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	DBusMessage *msg;
+
+	msg = dbus_message_new_method_call(w->srv, w->path,
+			CYCLINGSPEED_WATCHER_INTERFACE, "MeasurementReceived");
+	if (msg == NULL)
+		return;
+
+	dbus_message_iter_init_append(msg, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH , &path);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	if (m->has_wheel_rev) {
+		dict_append_entry(&dict, "WheelRevolutions",
+					DBUS_TYPE_UINT32, &m->wheel_rev);
+		dict_append_entry(&dict, "LastWheelEventTime",
+					DBUS_TYPE_UINT16, &m->last_wheel_time);
+	}
+
+	if (m->has_crank_rev) {
+		dict_append_entry(&dict, "CrankRevolutions",
+					DBUS_TYPE_UINT16, &m->crank_rev);
+		dict_append_entry(&dict, "LastCrankEventTime",
+					DBUS_TYPE_UINT16, &m->last_crank_time);
+	}
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	dbus_message_set_no_reply(msg, TRUE);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
+}
+
+static void process_measurement(struct csc *csc, const uint8_t *pdu,
+								uint16_t len)
+{
+	struct measurement m;
+	uint8_t flags;
+
+	flags = *pdu;
+
+	pdu++;
+	len--;
+
+	memset(&m, 0, sizeof(m));
+
+	if ((flags & WHEEL_REV_PRESENT) && (csc->feature & WHEEL_REV_SUPPORT)) {
+		if (len < 6) {
+			error("Wheel revolutions data fields missing");
+			return;
+		}
+
+		m.has_wheel_rev = true;
+		m.wheel_rev = att_get_u32(pdu);
+		m.last_wheel_time = att_get_u16(pdu + 4);
+		pdu += 6;
+		len -= 6;
+	}
+
+	if ((flags & CRANK_REV_PRESENT) && (csc->feature & CRANK_REV_SUPPORT)) {
+		if (len < 4) {
+			error("Crank revolutions data fields missing");
+			return;
+		}
+
+		m.has_crank_rev = true;
+		m.crank_rev = att_get_u16(pdu);
+		m.last_crank_time = att_get_u16(pdu + 2);
+		pdu += 4;
+		len -= 4;
+	}
+
+	/* Notify all registered watchers */
+	m.csc = csc;
+	g_slist_foreach(csc->cadapter->watchers, update_watcher, &m);
+}
+
+static void measurement_notify_handler(const uint8_t *pdu, uint16_t len,
+							gpointer user_data)
+{
+	struct csc *csc = user_data;
+
+	/* should be at least opcode (1b) + handle (2b) */
+	if (len < 3) {
+		error("Invalid PDU received");
+		return;
+	}
+
+	process_measurement(csc, pdu + 3, len - 3);
+}
+
+
 static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 {
 	struct csc *csc = user_data;
@@ -351,6 +478,11 @@ static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 				(chars->next ? chars->next->data : NULL);
 
 		if (g_strcmp0(c->uuid, CSC_MEASUREMENT_UUID) == 0) {
+			csc->attio_measurement_id =
+				g_attrib_register(csc->attrib,
+					ATT_OP_HANDLE_NOTIFY, c->value_handle,
+					measurement_notify_handler, csc, NULL);
+
 			discover_desc(csc, c, c_next);
 		} else if (g_strcmp0(c->uuid, CSC_FEATURE_UUID) == 0) {
 			feature_val_handle = c->value_handle;
@@ -423,6 +555,11 @@ static void attio_disconnected_cb(gpointer user_data)
 
 	DBG("");
 
+	if (csc->attio_measurement_id > 0) {
+		g_attrib_unregister(csc->attrib, csc->attio_measurement_id);
+		csc->attio_measurement_id = 0;
+	}
+
 	g_attrib_unref(csc->attrib);
 	csc->attrib = NULL;
 }
-- 
1.8.0


Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 2/6] Parse final measurement indication
Date: Mon, 14 Nov 2011 13:11:16 +0100
Message-Id: <1321272680-16286-3-git-send-email-sancane@gmail.com>
In-Reply-To: <1321272680-16286-2-git-send-email-sancane@gmail.com>
References: <1321272680-16286-1-git-send-email-sancane@gmail.com>
 <1321272680-16286-2-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |  163 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 162 insertions(+), 1 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 69ae708..b35c3aa 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -47,6 +47,13 @@
 #define INTERMEDIATE_TEMPERATURE_UUID	"00002a1e-0000-1000-8000-00805f9b34fb"
 #define MEASUREMENT_INTERVAL_UUID	"00002a21-0000-1000-8000-00805f9b34fb"
 
+/* Temperature measurement flag fields */
+#define TEMP_UNITS		0x01
+#define TEMP_TIME_STAMP		0x02
+#define TEMP_TYPE		0x04
+
+#define FLOAT_MAX_MANTISSA	16777216 /* 2^24 */
+
 struct thermometer {
 	DBusConnection		*conn;		/* The connection to the bus */
 	struct btd_device	*dev;		/* Device reference */
@@ -84,8 +91,40 @@ struct watcher {
 	gchar			*path;
 };
 
+struct measurement {
+	gint16		exp;
+	gint32		mant;
+	guint64		time;
+	gboolean	suptime;
+	gchar		*unit;
+	gchar		*type;
+	gchar		*value;
+};
+
 static GSList *thermometers = NULL;
 
+const char *temp_type[] = {
+	"<reserved>",
+	"Armpit",
+	"Body",
+	"Ear",
+	"Finger",
+	"Intestines",
+	"Mouth",
+	"Rectum",
+	"Toe",
+	"Tympanum"
+};
+
+static const gchar *temptype2str(uint8_t value)
+{
+	 if (value > 0 && value < G_N_ELEMENTS(temp_type))
+		return temp_type[value];
+
+	error("Temperature type %d reserved for future use", value);
+	return NULL;
+}
+
 static void destroy_watcher(gpointer user_data)
 {
 	struct watcher *watcher = user_data;
@@ -711,10 +750,132 @@ static GDBusSignalTable thermometer_signals[] = {
 	{ }
 };
 
+static void update_watcher(gpointer data, gpointer user_data)
+{
+	struct watcher *w = data;
+	struct measurement *m = user_data;
+	DBusConnection *conn = w->t->conn;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	DBusMessage *msg;
+
+	msg = dbus_message_new_method_call(w->srv, w->path,
+				"org.bluez.ThermometerWatcher",
+				"MeasurementReceived");
+	if (msg == NULL)
+		return;
+
+	dbus_message_iter_init_append(msg, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	dict_append_entry(&dict, "Exponent", DBUS_TYPE_INT16, &m->exp);
+	dict_append_entry(&dict, "Mantissa", DBUS_TYPE_INT32, &m->mant);
+	dict_append_entry(&dict, "Unit", DBUS_TYPE_STRING, &m->unit);
+
+	if (m->suptime)
+		dict_append_entry(&dict, "Time", DBUS_TYPE_UINT64, &m->time);
+
+	dict_append_entry(&dict, "Type", DBUS_TYPE_STRING, &m->type);
+	dict_append_entry(&dict, "Measurement", DBUS_TYPE_STRING, &m->value);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	dbus_message_set_no_reply(msg, TRUE);
+	g_dbus_send_message(conn, msg);
+}
+
+static void recv_measurement(struct thermometer *t, struct measurement *m)
+{
+	if (g_strcmp0(m->value, "Intermediate") == 0) {
+		DBG("Notification of intermediate measurement not implemented");
+		return;
+	}
+
+	g_slist_foreach(t->fwatchers, update_watcher, m);
+}
+
 static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
 						uint16_t len, gboolean final)
 {
-	DBG("TODO: Process measurement indication");
+	struct measurement m;
+	const gchar *type;
+	uint8_t flags;
+	uint32_t raw;
+
+	if (len < 4) {
+		DBG("Mandatory flags are not provided");
+		return;
+	}
+
+	flags = pdu[3];
+	if (flags & TEMP_UNITS)
+		m.unit = "Fahrenheit";
+	else
+		m.unit = "Celsius";
+
+	if (len < 8) {
+		DBG("Temperature measurement value is not provided");
+		return;
+	}
+
+	raw = att_get_u32(&pdu[4]);
+	m.mant = raw & 0x00FFFFFF;
+	m.exp = ((gint32) raw) >> 24;
+
+	if (m.mant & 0x00800000) {
+		/* convert to C2 negative value */
+		m.mant = m.mant - FLOAT_MAX_MANTISSA;
+	}
+
+	if (flags & TEMP_TIME_STAMP) {
+		struct tm ts;
+		time_t time;
+
+		if (len < 15) {
+			DBG("Can't get time stamp value");
+			return;
+		}
+
+		ts.tm_year = att_get_u16(&pdu[8]) - 1900;
+		ts.tm_mon = pdu[10];
+		ts.tm_mday = pdu[11];
+		ts.tm_hour = pdu[12];
+		ts.tm_min = pdu[13];
+		ts.tm_sec = pdu[14];
+		ts.tm_isdst = -1;
+
+		time = mktime(&ts);
+		m.time = (guint64) time;
+		m.suptime = TRUE;
+	} else
+		m.suptime = FALSE;
+
+	if (flags & TEMP_TYPE) {
+		if (len < 16) {
+			DBG("Can't get temperature type");
+			return;
+		}
+
+		type = temptype2str(pdu[15]);
+	} else if (t->has_type)
+		type = temptype2str(t->type);
+	else {
+		DBG("Can't get temperature type");
+		return;
+	}
+
+	if (type == NULL)
+		return;
+
+	m.type = g_strdup(type);
+	m.value = final ? "Final" : "Intermediate";
+
+	recv_measurement(t, &m);
+	g_free(m.type);
 }
 
 static void proc_measurement_interval(struct thermometer *t, const uint8_t *pdu,
-- 
1.7.7.3


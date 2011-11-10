Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 2/6] Parse final measurement indication
Date: Thu, 10 Nov 2011 12:36:58 +0100
Message-Id: <1320925022-21891-3-git-send-email-sancane@gmail.com>
In-Reply-To: <1320925022-21891-2-git-send-email-sancane@gmail.com>
References: <1320925022-21891-1-git-send-email-sancane@gmail.com>
 <1320925022-21891-2-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |  153 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 152 insertions(+), 1 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 69ae708..616c21d 100644
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
@@ -84,8 +91,36 @@ struct watcher {
 	gchar			*path;
 };
 
+struct measurement {
+	gint16		exp;
+	gint32		mant;
+	guint64		time;
+	gboolean	suptime;
+	gchar		*unit;
+	gchar		*type;
+	gchar		*msmnt;
+};
+
 static GSList *thermometers = NULL;
 
+static gchar *temptype2str(uint8_t value)
+{
+	switch (value) {
+	case 1: return "Armpit";
+	case 2: return "Body";
+	case 3: return "Ear";
+	case 4: return "Finger";
+	case 5: return "Intestines";
+	case 6: return "Mouth";
+	case 7: return "Rectum";
+	case 8: return "Toe";
+	case 9: return "Tympanum";
+	default:
+		error("Temperature type %d reserved for future use", value);
+		return NULL;
+	};
+}
+
 static void destroy_watcher(gpointer user_data)
 {
 	struct watcher *watcher = user_data;
@@ -711,10 +746,126 @@ static GDBusSignalTable thermometer_signals[] = {
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
+	dict_append_entry(&dict, "Measurement", DBUS_TYPE_STRING, &m->msmnt);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	dbus_message_set_no_reply(msg, TRUE);
+	g_dbus_send_message(conn, msg);
+}
+
+static void recv_measurement(struct thermometer *t, struct measurement *msmt)
+{
+	if (g_strcmp0(msmt->msmnt, "Intermediate") == 0) {
+		DBG("Notification of intermediate measurement not implemented");
+		return;
+	}
+
+	g_slist_foreach(t->fwatchers, update_watcher, msmt);
+}
+
 static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
 						uint16_t len, gboolean final)
 {
-	DBG("TODO: Process measurement indication");
+	struct measurement msmt;
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
+		msmt.unit = "Fahrenheit";
+	else
+		msmt.unit = "Celsius";
+
+	if (len < 8) {
+		DBG("Temperature measurement value is not provided");
+		return;
+	}
+
+	raw = att_get_u32(&pdu[4]);
+	msmt.mant = raw & 0x00FFFFFF;
+	msmt.exp = ((gint32) raw) >> 24;
+
+	if (msmt.mant & 0x00800000) {
+		/* convert to C2 negative value */
+		msmt.mant = msmt.mant - FLOAT_MAX_MANTISSA;
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
+		msmt.time = (guint64) time;
+		msmt.suptime = TRUE;
+	} else
+		msmt.suptime = FALSE;
+
+	if (flags & TEMP_TYPE) {
+		if (len < 16) {
+			DBG("Can't get temperature type");
+			return;
+		}
+
+		msmt.type = temptype2str(pdu[15]);
+	} else if (t->has_type)
+		msmt.type = temptype2str(t->type);
+	else {
+		DBG("Can't get temperature type");
+		return;
+	}
+
+	msmt.msmnt = final ? "Final" : "Intermediate";
+
+	recv_measurement(t, &msmt);
 }
 
 static void proc_measurement_interval(struct thermometer *t, const uint8_t *pdu,
-- 
1.7.7.3


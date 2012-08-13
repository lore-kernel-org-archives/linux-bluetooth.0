Return-Path: <cyrus@holtmann.org>
From: Rafal Garbat <rafal.garbat@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <rafal.garbat@tieto.com>
Subject: [PATCH v2 07/13] heartrate: Process Heart Rate Characteristics
Date: Mon, 13 Aug 2012 17:08:11 +0200
Message-ID: <1344870497-6929-8-git-send-email-rafal.garbat@tieto.com>
In-Reply-To: <1344870497-6929-1-git-send-email-rafal.garbat@tieto.com>
References: <1344870497-6929-1-git-send-email-rafal.garbat@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Read and store Sensor Location characteristic.

---
 lib/uuid.h                     |    2 ++
 profiles/heartrate/heartrate.c |   46 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 5d81856..5d1e091 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -65,6 +65,8 @@ extern "C" {
 
 #define HEART_RATE_UUID		"0000180d-0000-1000-8000-00805f9b34fb"
 #define HEART_RATE_MEASUREMENT_UUID	"00002a37-0000-1000-8000-00805f9b34fb"
+#define HEART_RATE_CONTROL_POINT_UUID	"00002a39-0000-1000-8000-00805f9b34fb"
+#define BODY_SENSOR_LOCATION_UUID	"00002a38-0000-1000-8000-00805f9b34fb"
 
 #define HEALTH_THERMOMETER_UUID		"00001809-0000-1000-8000-00805f9b34fb"
 #define TEMPERATURE_MEASUREMENT_UUID	"00002a1c-0000-1000-8000-00805f9b34fb"
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 31b4232..d0bcd57 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -42,6 +42,8 @@
 
 #define HEART_RATE_INTERFACE "org.bluez.HeartRate"
 
+#define SENSOR_LOCATION_SIZE 1
+
 struct heartrate {
 	struct btd_device	*dev;  /*Device reference*/
 	DBusConnection		*conn; /*DBus conn*/
@@ -50,6 +52,8 @@ struct heartrate {
 	struct att_range	*svc_range; /*Heart Rate range*/
 	GSList			*chars; /*Characteristics*/
 	GSList			*watchers; /*Watchers*/
+	gboolean		has_location;
+	uint8_t		location; /*Body Sensor location*/
 };
 
 struct characteristic {
@@ -238,6 +242,46 @@ static const GDBusMethodTable heartrate_methods[] = {
 	{ }
 };
 
+static void read_sensor_location_cb(guint8 status, const guint8 *pdu,
+						guint16 len, gpointer user_data)
+{
+	struct characteristic *ch = user_data;
+	struct heartrate *hr = ch->hr;
+	uint8_t value[SENSOR_LOCATION_SIZE];
+	ssize_t vlen;
+
+	if (status != 0) {
+		error("Body Sensor Location value read failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	vlen = dec_read_resp(pdu, len, value, sizeof(value));
+	if (vlen < 0) {
+		error("Protocol error.");
+		return;
+	}
+
+	if (vlen != 1) {
+		error("Invalid length for Body Sensor Location");
+		return;
+	}
+
+	hr->has_location = TRUE;
+	hr->location = value[0];
+}
+
+static void process_heartrate_char(struct characteristic *ch)
+{
+	if (g_strcmp0(ch->attr.uuid,
+				HEART_RATE_CONTROL_POINT_UUID) == 0)
+		DBG("Heart Rate Control Point reset not supported by client");
+	 else if (g_strcmp0(ch->attr.uuid,
+					BODY_SENSOR_LOCATION_UUID) == 0)
+		gatt_read_char(ch->hr->attrib, ch->attr.value_handle, 0,
+						read_sensor_location_cb, ch);
+}
+
 static void process_heartrate_desc(struct descriptor *desc)
 {
 	struct characteristic *ch = desc->ch;
@@ -325,6 +369,8 @@ static void configure_heartrate_cb(GSList *characteristics, guint8 status,
 
 		hr->chars = g_slist_append(hr->chars, ch);
 
+		process_heartrate_char(ch);
+
 		start = c->value_handle + 1;
 
 		if (l->next != NULL) {
-- 
1.7.9.5


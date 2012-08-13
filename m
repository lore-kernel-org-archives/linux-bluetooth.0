Return-Path: <cyrus@holtmann.org>
From: Rafal Garbat <rafal.garbat@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <rafal.garbat@tieto.com>
Subject: [PATCH v2 10/13] heartrate: Add support for Control Point Reset
Date: Mon, 13 Aug 2012 17:08:14 +0200
Message-ID: <1344870497-6929-11-git-send-email-rafal.garbat@tieto.com>
In-Reply-To: <1344870497-6929-1-git-send-email-rafal.garbat@tieto.com>
References: <1344870497-6929-1-git-send-email-rafal.garbat@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handle Control Point reset if server supports it.

---
 profiles/heartrate/heartrate.c |   50 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 587438b..267ad54 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -63,6 +63,7 @@ struct heartrate {
 	GSList			*watchers; /*Watchers*/
 	gboolean		has_location;
 	uint8_t		location; /*Body Sensor location*/
+	gboolean		cp_reset; /*Control Point Reset support*/
 };
 
 struct characteristic {
@@ -378,6 +379,43 @@ static DBusMessage *watcher_unregister(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+static gint process_att_reset(struct heartrate *hr)
+{
+	struct characteristic *ch;
+	char *msg;
+	uint8_t atval;
+
+	if (hr->attrib == NULL)
+		return -1;
+
+	ch = get_characteristic(hr, HEART_RATE_CONTROL_POINT_UUID);
+	if (ch == NULL)
+		return -1;
+
+	atval = 0x01;
+	msg = g_strdup("Reset Control Point");
+
+	gatt_write_char(hr->attrib, ch->attr.value_handle, &atval, 1,
+						measurement_cb, msg);
+	return 0;
+}
+
+static DBusMessage *control_point_reset(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct heartrate *hr = data;
+
+	if (!hr->cp_reset)
+		return btd_error_not_supported(msg);
+
+	if (process_att_reset(hr) < 0)
+		return btd_error_not_available(msg);
+
+	DBG("Energy Expended Value has been reset");
+
+	return dbus_message_new_method_return(msg);
+}
+
 static const GDBusMethodTable heartrate_methods[] = {
 	{ GDBUS_METHOD("RegisterWatcher",
 			GDBUS_ARGS({ "agent", "o" }), NULL,
@@ -385,6 +423,8 @@ static const GDBusMethodTable heartrate_methods[] = {
 	{ GDBUS_METHOD("UnregisterWatcher",
 			GDBUS_ARGS({ "agent", "o" }), NULL,
 			watcher_unregister) },
+	{ GDBUS_METHOD("Reset", NULL, NULL,
+			control_point_reset) },
 	{ }
 };
 
@@ -420,12 +460,14 @@ static void read_sensor_location_cb(guint8 status, const guint8 *pdu,
 static void process_heartrate_char(struct characteristic *ch)
 {
 	if (g_strcmp0(ch->attr.uuid,
-				HEART_RATE_CONTROL_POINT_UUID) == 0)
-		DBG("Heart Rate Control Point reset not supported by client");
-	 else if (g_strcmp0(ch->attr.uuid,
-					BODY_SENSOR_LOCATION_UUID) == 0)
+				HEART_RATE_CONTROL_POINT_UUID) == 0) {
+		ch->hr->cp_reset = TRUE;
+		DBG("Heart Rate Control Point reset supported by server");
+	 } else if (g_strcmp0(ch->attr.uuid,
+					BODY_SENSOR_LOCATION_UUID) == 0) {
 		gatt_read_char(ch->hr->attrib, ch->attr.value_handle, 0,
 						read_sensor_location_cb, ch);
+	 }
 }
 
 static void process_heartrate_desc(struct descriptor *desc)
-- 
1.7.9.5


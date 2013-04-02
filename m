Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 11/18] attrib: Avoid passing raw ATT PDU to gatt_read_char() callback
Date: Tue,  2 Apr 2013 12:50:58 -0400
Message-Id: <1364921465-31182-12-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead, pass the attribute value/length. This simplifies error
handling and reduces memory copying.
---
 attrib/gatt.c                        |   24 +++++++++----
 attrib/gatt.h                        |    6 ++--
 attrib/gatttool.c                    |   13 ++-----
 attrib/interactive.c                 |   14 ++------
 profiles/cyclingspeed/cyclingspeed.c |   30 ++++------------
 profiles/deviceinfo/deviceinfo.c     |   14 ++------
 profiles/heartrate/heartrate.c       |   16 +++------
 profiles/input/hog.c                 |   65 ++++++++++++----------------------
 profiles/proximity/monitor.c         |   15 ++------
 profiles/thermometer/thermometer.c   |   42 +++++-----------------
 10 files changed, 76 insertions(+), 163 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index ef24adc..315dc77 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -604,8 +604,8 @@ guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
 
 struct read_long_data {
 	GAttrib *attrib;
-	GAttribResultFunc func;
-	gpointer user_data;
+	gatt_read_char_cb_t func;
+	void *user_data;
 	guint8 *buffer;
 	guint16 size;
 	guint16 handle;
@@ -669,8 +669,11 @@ static void read_blob_helper(guint8 status, const guint8 *rpdu, guint16 rlen,
 	status = ATT_ECODE_IO;
 
 done:
-	long_read->func(status, long_read->buffer, long_read->size,
-							long_read->user_data);
+	if (status != 0)
+		long_read->func(status, NULL, 0, long_read->user_data);
+	else
+		long_read->func(status, long_read->buffer + 1,
+				long_read->size - 1, long_read->user_data);
 }
 
 static void read_char_helper(guint8 status, const guint8 *rpdu,
@@ -706,11 +709,18 @@ static void read_char_helper(guint8 status, const guint8 *rpdu,
 	status = ATT_ECODE_IO;
 
 done:
-	long_read->func(status, rpdu, rlen, long_read->user_data);
+	if (dec_read_resp(rpdu, rlen, NULL, 0) < 0)
+		status = ATT_ECODE_INVALID_PDU;
+
+	if (status != 0)
+		long_read->func(status, NULL, 0, long_read->user_data);
+	else
+		long_read->func(status, rpdu + 1, rlen - 1,
+							long_read->user_data);
 }
 
-guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
-							gpointer user_data)
+guint gatt_read_char(GAttrib *attrib, uint16_t handle, gatt_read_char_cb_t func,
+							void *user_data)
 {
 	uint8_t *buf;
 	size_t buflen;
diff --git a/attrib/gatt.h b/attrib/gatt.h
index e09970f..f1516f4 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -56,6 +56,8 @@
 typedef bool (*gatt_cb_t) (GSList *l, guint8 status, gpointer user_data);
 typedef void (*gatt_exchange_mtu_cb_t) (uint8_t status, uint16_t mtu,
 							void *user_data);
+typedef void (*gatt_read_char_cb_t) (uint8_t status, const uint8_t *value,
+						size_t vlen, void *user_data);
 
 struct gatt_primary {
 	char uuid[MAX_LEN_UUID_STR + 1];
@@ -86,8 +88,8 @@ guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 					bt_uuid_t *uuid, gatt_cb_t func,
 					gpointer user_data);
 
-guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
-							gpointer user_data);
+guint gatt_read_char(GAttrib *attrib, uint16_t handle, gatt_read_char_cb_t func,
+							void *user_data);
 
 guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
 					size_t vlen, GAttribResultFunc func,
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 11269c7..4163876 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -231,12 +231,10 @@ static gboolean characteristics(gpointer user_data)
 	return FALSE;
 }
 
-static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void char_read_cb(uint8_t status, const uint8_t *value, size_t vlen,
+								void *user_data)
 {
-	uint8_t value[plen];
-	ssize_t vlen;
-	int i;
+	unsigned int i;
 
 	if (status != 0) {
 		g_printerr("Characteristic value/descriptor read failed: %s\n",
@@ -244,11 +242,6 @@ static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		goto done;
 	}
 
-	vlen = dec_read_resp(pdu, plen, value, sizeof(value));
-	if (vlen < 0) {
-		g_printerr("Protocol error\n");
-		goto done;
-	}
 	g_print("Characteristic value/descriptor: ");
 	for (i = 0; i < vlen; i++)
 		g_print("%02x ", value[i]);
diff --git a/attrib/interactive.c b/attrib/interactive.c
index f8f4fff..2fab052 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -320,12 +320,10 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		rl_forced_update_display();
 }
 
-static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void char_read_cb(uint8_t status, const uint8_t *value, size_t vlen,
+								void *user_data)
 {
-	uint8_t value[plen];
-	ssize_t vlen;
-	int i;
+	unsigned int i;
 
 	if (status != 0) {
 		printf("Characteristic value/descriptor read failed: %s\n",
@@ -333,12 +331,6 @@ static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		return;
 	}
 
-	vlen = dec_read_resp(pdu, plen, value, sizeof(value));
-	if (vlen < 0) {
-		printf("Protocol error\n");
-		return;
-	}
-
 	printf("\nCharacteristic value/descriptor: ");
 	for (i = 0; i < vlen; i++)
 		printf("%02x ", value[i]);
diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 605bb6c..dd8ce3a 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -356,25 +356,17 @@ static void read_supported_locations(struct csc *csc)
 					controlpoint_write_cb, req);
 }
 
-static void read_feature_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
+static void read_feature_cb(uint8_t status, const uint8_t *value, size_t vlen,
+								void *user_data)
 {
 	struct csc *csc = user_data;
-	uint8_t value[2];
-	ssize_t vlen;
 
 	if (status) {
 		error("CSC Feature read failed: %s", att_ecode2str(status));
 		return;
 	}
 
-	vlen = dec_read_resp(pdu, len, value, sizeof(value));
-	if (vlen < 0) {
-		error("Protocol error");
-		return;
-	}
-
-	if (vlen != sizeof(value)) {
+	if (vlen != 2) {
 		error("Invalid value length for CSC Feature");
 		return;
 	}
@@ -386,31 +378,23 @@ static void read_feature_cb(guint8 status, const guint8 *pdu, guint16 len,
 		read_supported_locations(csc);
 }
 
-static void read_location_cb(guint8 status, const guint8 *pdu,
-						guint16 len, gpointer user_data)
+static void read_location_cb(uint8_t status, const uint8_t *value, size_t vlen,
+								void *user_data)
 {
 	struct csc *csc = user_data;
-	uint8_t value;
-	ssize_t vlen;
 
 	if (status) {
 		error("Sensor Location read failed: %s", att_ecode2str(status));
 		return;
 	}
 
-	vlen = dec_read_resp(pdu, len, &value, sizeof(value));
-	if (vlen < 0) {
-		error("Protocol error");
-		return;
-	}
-
-	if (vlen != sizeof(value)) {
+	if (vlen != 1) {
 		error("Invalid value length for Sensor Location");
 		return;
 	}
 
 	csc->has_location = TRUE;
-	csc->location = value;
+	csc->location = value[0];
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 					device_get_path(csc->dev),
diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index d926367..f0de29a 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -85,25 +85,17 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
-static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
+static void read_pnpid_cb(uint8_t status, const uint8_t *value, size_t vlen,
+								void *user_data)
 {
 	struct characteristic *ch = user_data;
-	uint8_t value[PNP_ID_SIZE];
-	ssize_t vlen;
 
 	if (status != 0) {
 		error("Error reading PNP_ID value: %s", att_ecode2str(status));
 		return;
 	}
 
-	vlen = dec_read_resp(pdu, len, value, sizeof(value));
-	if (vlen < 0) {
-		error("Error reading PNP_ID: Protocol error");
-		return;
-	}
-
-	if (vlen < 7) {
+	if (vlen < PNP_ID_SIZE) {
 		error("Error reading PNP_ID: Invalid pdu length received");
 		return;
 	}
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 2fe8b0f..74302f0 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -221,12 +221,10 @@ static void destroy_heartrate_adapter(gpointer user_data)
 	g_free(hradapter);
 }
 
-static void read_sensor_location_cb(guint8 status, const guint8 *pdu,
-						guint16 len, gpointer user_data)
+static void read_sensor_location_cb(uint8_t status, const uint8_t *value,
+						size_t vlen, void *user_data)
 {
 	struct heartrate *hr = user_data;
-	uint8_t value;
-	ssize_t vlen;
 
 	if (status != 0) {
 		error("Body Sensor Location read failed: %s",
@@ -234,19 +232,13 @@ static void read_sensor_location_cb(guint8 status, const guint8 *pdu,
 		return;
 	}
 
-	vlen = dec_read_resp(pdu, len, &value, sizeof(value));
-	if (vlen < 0) {
-		error("Protocol error");
-		return;
-	}
-
-	if (vlen != sizeof(value)) {
+	if (vlen != 1) {
 		error("Invalid length for Body Sensor Location");
 		return;
 	}
 
 	hr->has_location = TRUE;
-	hr->location = value;
+	hr->location = value[0];
 }
 
 static void char_write_cb(guint8 status, const guint8 *pdu, guint16 len,
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index feee24d..e53bbd8 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -171,8 +171,8 @@ static void write_ccc(uint16_t handle, gpointer user_data)
 					report_ccc_written_cb, report);
 }
 
-static void report_reference_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static void report_reference_cb(uint8_t status, const uint8_t *value,
+						size_t vlen, void *user_data)
 {
 	struct report *report = user_data;
 
@@ -182,18 +182,18 @@ static void report_reference_cb(guint8 status, const guint8 *pdu,
 		return;
 	}
 
-	if (plen != 3) {
+	if (vlen != 2) {
 		error("Malformed ATT read response");
 		return;
 	}
 
-	report->id = pdu[1];
-	report->type = pdu[2];
-	DBG("Report ID: 0x%02x Report type: 0x%02x", pdu[1], pdu[2]);
+	report->id = value[0];
+	report->type = value[1];
+	DBG("Report ID: 0x%02x Report type: 0x%02x", value[0], value[1]);
 }
 
-static void external_report_reference_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data);
+static void external_report_reference_cb(uint8_t status, const uint8_t *value,
+						size_t vlen, void *user_data);
 
 
 static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
@@ -318,8 +318,8 @@ static bool external_service_char_cb(GSList *chars, guint8 status,
 	return true;
 }
 
-static void external_report_reference_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static void external_report_reference_cb(uint8_t status, const uint8_t *value,
+						size_t vlen, void *user_data)
 {
 	struct hog_device *hogdev = user_data;
 	uint16_t uuid16;
@@ -331,12 +331,12 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 		return;
 	}
 
-	if (plen != 3) {
+	if (vlen != 2) {
 		error("Malformed ATT read response");
 		return;
 	}
 
-	uuid16 = att_get_u16(&pdu[1]);
+	uuid16 = att_get_u16(&value[0]);
 	DBG("External report reference read, external report characteristic "
 						"UUID: 0x%04x", uuid16);
 	bt_uuid16_create(&uuid, uuid16);
@@ -344,27 +344,19 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 					external_service_char_cb, hogdev);
 }
 
-static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void report_map_read_cb(uint8_t status, const uint8_t *value,
+						size_t vlen, void *user_data)
 {
 	struct hog_device *hogdev = user_data;
-	uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
 	struct uhid_event ev;
 	uint16_t vendor_src, vendor, product, version;
-	ssize_t vlen;
-	int i;
+	unsigned int i;
 
 	if (status != 0) {
 		error("Report Map read failed: %s", att_ecode2str(status));
 		return;
 	}
 
-	vlen = dec_read_resp(pdu, plen, value, sizeof(value));
-	if (vlen < 0) {
-		error("ATT protocol error");
-		return;
-	}
-
 	DBG("Report MAP:");
 	for (i = 0; i < vlen; i++) {
 		switch (value[i]) {
@@ -398,19 +390,17 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	ev.u.create.version = version;
 	ev.u.create.country = hogdev->bcountrycode;
 	ev.u.create.bus = BUS_BLUETOOTH;
-	ev.u.create.rd_data = value;
+	ev.u.create.rd_data = (uint8_t *) value;
 	ev.u.create.rd_size = vlen;
 
 	if (write(hogdev->uhid_fd, &ev, sizeof(ev)) < 0)
 		error("Failed to create uHID device: %s", strerror(errno));
 }
 
-static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void info_read_cb(uint8_t status, const uint8_t *value, size_t vlen,
+								void *user_data)
 {
 	struct hog_device *hogdev = user_data;
-	uint8_t value[HID_INFO_SIZE];
-	ssize_t vlen;
 
 	if (status != 0) {
 		error("HID Information read failed: %s",
@@ -418,8 +408,7 @@ static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		return;
 	}
 
-	vlen = dec_read_resp(pdu, plen, value, sizeof(value));
-	if (vlen != 4) {
+	if (vlen != HID_INFO_SIZE) {
 		error("ATT protocol error");
 		return;
 	}
@@ -432,12 +421,10 @@ static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 			hogdev->bcdhid, hogdev->bcountrycode, hogdev->flags);
 }
 
-static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void proto_mode_read_cb(uint8_t status, const uint8_t *value,
+						size_t vlen, void *user_data)
 {
 	struct hog_device *hogdev = user_data;
-	uint8_t value;
-	ssize_t vlen;
 
 	if (status != 0) {
 		error("Protocol Mode characteristic read failed: %s",
@@ -445,13 +432,7 @@ static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		return;
 	}
 
-	vlen = dec_read_resp(pdu, plen, &value, sizeof(value));
-	if (vlen < 0) {
-		error("ATT protocol error");
-		return;
-	}
-
-	if (value == HOG_PROTO_MODE_BOOT) {
+	if (value[0] == HOG_PROTO_MODE_BOOT) {
 		uint8_t nval = HOG_PROTO_MODE_REPORT;
 
 		DBG("HoG device 0x%04X is operating in Boot Procotol Mode",
@@ -459,7 +440,7 @@ static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 		gatt_write_char(hogdev->attrib, hogdev->proto_mode_handle, &nval,
 						sizeof(nval), NULL, NULL);
-	} else if (value == HOG_PROTO_MODE_REPORT)
+	} else if (value[0] == HOG_PROTO_MODE_REPORT)
 		DBG("HoG device 0x%04X is operating in Report Protocol Mode",
 								hogdev->id);
 }
diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index 91e0c69..cda47a3 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -228,24 +228,15 @@ static int write_alert_level(struct monitor *monitor)
 	return 0;
 }
 
-static void tx_power_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void tx_power_read_cb(uint8_t status, const uint8_t *value, size_t vlen,
+								void *user_data)
 {
-	uint8_t value[TX_POWER_SIZE];
-	ssize_t vlen;
-
 	if (status != 0) {
 		DBG("Tx Power Level read failed: %s", att_ecode2str(status));
 		return;
 	}
 
-	vlen = dec_read_resp(pdu, plen, value, sizeof(value));
-	if (vlen < 0) {
-		DBG("Protocol error");
-		return;
-	}
-
-	if (vlen != 1) {
+	if (vlen != TX_POWER_SIZE) {
 		DBG("Invalid length for TX Power value: %zd", vlen);
 		return;
 	}
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 6580867..fcb88df 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -475,13 +475,11 @@ static void interval_ind_handler(const uint8_t *pdu, uint16_t len,
 		g_attrib_send(t->attrib, 0, opdu, olen, NULL, NULL, NULL);
 }
 
-static void valid_range_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
+static void valid_range_desc_cb(uint8_t status, const uint8_t *value,
+						size_t vlen, void *user_data)
 {
 	struct thermometer *t = user_data;
-	uint8_t value[VALID_RANGE_DESC_SIZE];
 	uint16_t max, min;
-	ssize_t vlen;
 
 	if (status != 0) {
 		DBG("Valid Range descriptor read failed: %s",
@@ -489,13 +487,7 @@ static void valid_range_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 		return;
 	}
 
-	vlen = dec_read_resp(pdu, len, value, sizeof(value));
-	if (vlen < 0) {
-		DBG("Protocol error\n");
-		return;
-	}
-
-	if (vlen < 4) {
+	if (vlen < VALID_RANGE_DESC_SIZE) {
 		DBG("Invalid range received");
 		return;
 	}
@@ -635,12 +627,10 @@ static void discover_desc(struct thermometer *t, struct gatt_char *c,
 	gatt_discover_char_desc(t->attrib, start, end, discover_desc_cb, ch);
 }
 
-static void read_temp_type_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
+static void read_temp_type_cb(uint8_t status, const uint8_t *value, size_t vlen,
+								void *user_data)
 {
 	struct thermometer *t = user_data;
-	uint8_t value[TEMPERATURE_TYPE_SIZE];
-	ssize_t vlen;
 
 	if (status != 0) {
 		DBG("Temperature Type value read failed: %s",
@@ -648,13 +638,7 @@ static void read_temp_type_cb(guint8 status, const guint8 *pdu, guint16 len,
 		return;
 	}
 
-	vlen = dec_read_resp(pdu, len, value, sizeof(value));
-	if (vlen < 0) {
-		DBG("Protocol error.");
-		return;
-	}
-
-	if (vlen != 1) {
+	if (vlen != TEMPERATURE_TYPE_SIZE) {
 		DBG("Invalid length for Temperature type");
 		return;
 	}
@@ -663,13 +647,11 @@ static void read_temp_type_cb(guint8 status, const guint8 *pdu, guint16 len,
 	t->type = value[0];
 }
 
-static void read_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
+static void read_interval_cb(uint8_t status, const uint8_t *value, size_t vlen,
+								void *user_data)
 {
 	struct thermometer *t = user_data;
-	uint8_t value[MEASUREMENT_INTERVAL_SIZE];
 	uint16_t interval;
-	ssize_t vlen;
 
 	if (status != 0) {
 		DBG("Measurement Interval value read failed: %s",
@@ -677,13 +659,7 @@ static void read_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
 		return;
 	}
 
-	vlen = dec_read_resp(pdu, len, value, sizeof(value));
-	if (vlen < 0) {
-		DBG("Protocol error\n");
-		return;
-	}
-
-	if (vlen < 2) {
+	if (vlen < MEASUREMENT_INTERVAL_SIZE) {
 		DBG("Invalid Interval received");
 		return;
 	}
-- 
1.7.9.5


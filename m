Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 15/18] attrib: Avoid passing raw ATT PDU to gatt_write_char() callback
Date: Tue,  2 Apr 2013 12:51:02 -0400
Message-Id: <1364921465-31182-16-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead, pass only status and user data. The ATT PDU validation is now
done internally by GATT API.
---
 attrib/gatt.c                        |   66 +++++++++++++++++++++++++++++-----
 attrib/gatt.h                        |    7 ++--
 attrib/gatttool.c                    |    8 +----
 attrib/interactive.c                 |    8 +----
 profiles/cyclingspeed/cyclingspeed.c |    6 ++--
 profiles/gatt/gas.c                  |    3 +-
 profiles/heartrate/heartrate.c       |    3 +-
 profiles/input/hog.c                 |    6 ++--
 profiles/proximity/monitor.c         |    8 +----
 profiles/scanparam/scan.c            |    3 +-
 profiles/thermometer/thermometer.c   |   11 ++----
 11 files changed, 73 insertions(+), 56 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 5835e83..d68b26c 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -754,17 +754,38 @@ guint gatt_read_char(GAttrib *attrib, uint16_t handle, gatt_read_char_cb_t func,
 
 struct write_long_data {
 	GAttrib *attrib;
-	GAttribResultFunc func;
-	gpointer user_data;
+	gatt_write_char_cb_t func;
+	void *user_data;
 	guint16 handle;
 	uint16_t offset;
 	uint8_t *value;
 	size_t vlen;
 };
 
+struct gatt_write_char_data {
+	gatt_write_char_cb_t func;
+	void *user_data;
+};
+
+static void execute_write_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct gatt_write_char_data *data = user_data;
+
+	if (status != 0)
+		goto done;
+
+	if (dec_exec_write_resp(pdu, plen) == 0)
+		status = ATT_ECODE_IO;
+
+done:
+	data->func(status, data->user_data);
+}
+
 static guint execute_write(GAttrib *attrib, uint8_t flags,
-				GAttribResultFunc func, gpointer user_data)
+				gatt_write_char_cb_t func, void *user_data)
 {
+	struct gatt_write_char_data *data;
 	uint8_t *buf;
 	size_t buflen;
 	guint16 plen;
@@ -774,7 +795,12 @@ static guint execute_write(GAttrib *attrib, uint8_t flags,
 	if (plen == 0)
 		return 0;
 
-	return g_attrib_send(attrib, 0, buf, plen, func, user_data, NULL);
+	data = g_new0(struct gatt_write_char_data, 1);
+	data->func = func;
+	data->user_data = user_data;
+
+	return g_attrib_send(attrib, 0, buf, plen, execute_write_cb, data,
+									g_free);
 }
 
 static guint prepare_write(struct write_long_data *long_write);
@@ -785,7 +811,7 @@ static void prepare_write_cb(guint8 status, const guint8 *rpdu, guint16 rlen,
 	struct write_long_data *long_write = user_data;
 
 	if (status != 0) {
-		long_write->func(status, rpdu, rlen, long_write->user_data);
+		long_write->func(status, long_write->user_data);
 		return;
 	}
 
@@ -823,8 +849,24 @@ static guint prepare_write(struct write_long_data *long_write)
 									NULL);
 }
 
-guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
-			size_t vlen, GAttribResultFunc func, gpointer user_data)
+static void gatt_write_char_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct gatt_write_char_data *data = user_data;
+
+	if (status != 0)
+		goto done;
+
+	if (dec_write_resp(pdu, plen) == 0)
+		status = ATT_ECODE_IO;
+
+done:
+	data->func(status, data->user_data);
+}
+
+guint gatt_write_char(GAttrib *attrib, uint16_t handle, const uint8_t *value,
+					size_t vlen, gatt_write_char_cb_t func,
+					void *user_data)
 {
 	uint8_t *buf;
 	size_t buflen;
@@ -835,14 +877,20 @@ guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
 	/* Use Write Request if payload fits on a single transfer, including 3
 	 * bytes for the header. */
 	if (vlen <= buflen - 3) {
+		struct gatt_write_char_data *data;
+
 		uint16_t plen;
 
 		plen = enc_write_req(handle, value, vlen, buf, buflen);
 		if (plen == 0)
 			return 0;
 
-		return g_attrib_send(attrib, 0, buf, plen, func, user_data,
-									NULL);
+		data = g_new0(struct gatt_write_char_data, 1);
+		data->func = func;
+		data->user_data = user_data;
+
+		return g_attrib_send(attrib, 0, buf, plen, gatt_write_char_cb,
+								data, g_free);
 	}
 
 	/* Write Long Characteristic Values */
diff --git a/attrib/gatt.h b/attrib/gatt.h
index f1516f4..097d30d 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -58,6 +58,7 @@ typedef void (*gatt_exchange_mtu_cb_t) (uint8_t status, uint16_t mtu,
 							void *user_data);
 typedef void (*gatt_read_char_cb_t) (uint8_t status, const uint8_t *value,
 						size_t vlen, void *user_data);
+typedef void (*gatt_write_char_cb_t) (uint8_t status, void *user_data);
 
 struct gatt_primary {
 	char uuid[MAX_LEN_UUID_STR + 1];
@@ -91,9 +92,9 @@ guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 guint gatt_read_char(GAttrib *attrib, uint16_t handle, gatt_read_char_cb_t func,
 							void *user_data);
 
-guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
-					size_t vlen, GAttribResultFunc func,
-					gpointer user_data);
+guint gatt_write_char(GAttrib *attrib, uint16_t handle, const uint8_t *value,
+					size_t vlen, gatt_write_char_cb_t func,
+					void *user_data);
 
 guint gatt_discover_char_desc(GAttrib *attrib, uint16_t start, uint16_t end,
 				GAttribResultFunc func, gpointer user_data);
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 4163876..433a494 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -361,8 +361,7 @@ error:
 	return FALSE;
 }
 
-static void char_write_req_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void char_write_req_cb(uint8_t status, void *user_data)
 {
 	if (status != 0) {
 		g_printerr("Characteristic Write Request failed: "
@@ -370,11 +369,6 @@ static void char_write_req_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		goto done;
 	}
 
-	if (!dec_write_resp(pdu, plen) && !dec_exec_write_resp(pdu, plen)) {
-		g_printerr("Protocol error\n");
-		goto done;
-	}
-
 	g_print("Characteristic value was written successfully\n");
 
 done:
diff --git a/attrib/interactive.c b/attrib/interactive.c
index ae6e88d..02c8167 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -635,8 +635,7 @@ static void cmd_read_uuid(int argcp, char **argvp)
 					char_read_by_uuid_cb, char_data);
 }
 
-static void char_write_req_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void char_write_req_cb(uint8_t status, void *user_data)
 {
 	if (status != 0) {
 		printf("Characteristic Write Request failed: "
@@ -644,11 +643,6 @@ static void char_write_req_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		return;
 	}
 
-	if (!dec_write_resp(pdu, plen) && !dec_exec_write_resp(pdu, plen)) {
-		printf("Protocol error\n");
-		return;
-	}
-
 	printf("Characteristic value was written successfully\n");
 }
 
diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index dd8ce3a..a845a1b 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -273,8 +273,7 @@ static void destroy_csc(gpointer user_data)
 	g_free(csc);
 }
 
-static void char_write_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
+static void char_write_cb(uint8_t status, void *user_data)
 {
 	char *msg = user_data;
 
@@ -309,8 +308,7 @@ static gboolean controlpoint_timeout(gpointer user_data)
 	return FALSE;
 }
 
-static void controlpoint_write_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
+static void controlpoint_write_cb(uint8_t status, void *user_data)
 {
 	struct controlpoint_req *req = user_data;
 
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 8390f4a..7b23a87 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -196,8 +196,7 @@ static void indication_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
 	btd_device_gatt_set_service_changed(gas->device, start, end);
 }
 
-static void ccc_written_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void ccc_written_cb(uint8_t status, void *user_data)
 {
 	struct gas *gas = user_data;
 
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 74302f0..e4b06ed 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -241,8 +241,7 @@ static void read_sensor_location_cb(uint8_t status, const uint8_t *value,
 	hr->location = value[0];
 }
 
-static void char_write_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
+static void char_write_cb(uint8_t status, void *user_data)
 {
 	char *msg = user_data;
 
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 204f92b..33c3aed 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -141,8 +141,7 @@ static void report_value_cb(const uint8_t *pdu, uint16_t len,
 						hogdev->id, hogdev->uhid_fd);
 }
 
-static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static void report_ccc_written_cb(uint8_t status, void *user_data)
 {
 	struct report *report = user_data;
 	struct hog_device *hogdev = report->hogdev;
@@ -515,8 +514,7 @@ static bool char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 	return true;
 }
 
-static void output_written_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static void output_written_cb(uint8_t status, void *user_data)
 {
 	if (status != 0) {
 		error("Write output report failed: %s", att_ecode2str(status));
diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index cda47a3..bdf6b8b 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -158,8 +158,7 @@ static uint8_t str2level(const char *level)
 	return ALERT_NONE;
 }
 
-static void linkloss_written(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void linkloss_written(uint8_t status, void *user_data)
 {
 	struct monitor *monitor = user_data;
 	struct btd_device *device = monitor->device;
@@ -171,11 +170,6 @@ static void linkloss_written(guint8 status, const guint8 *pdu, guint16 plen,
 		return;
 	}
 
-	if (!dec_write_resp(pdu, plen)) {
-		error("Link Loss Write Request: protocol error");
-		return;
-	}
-
 	DBG("Link Loss Alert Level written");
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(), path,
diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index d7ebf74..8412d67 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -94,8 +94,7 @@ static void refresh_value_cb(const uint8_t *pdu, uint16_t len,
 		write_scan_params(scan->attrib, scan->iwhandle);
 }
 
-static void ccc_written_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static void ccc_written_cb(uint8_t status, void *user_data)
 {
 	struct scan *scan = user_data;
 
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index fcb88df..f506c69 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -504,8 +504,7 @@ static void valid_range_desc_cb(uint8_t status, const uint8_t *value,
 	change_property(t, "Minimum", &min);
 }
 
-static void write_ccc_cb(guint8 status, const guint8 *pdu,
-						guint16 len, gpointer user_data)
+static void write_ccc_cb(uint8_t status, void *user_data)
 {
 	char *msg = user_data;
 
@@ -734,8 +733,7 @@ static bool configure_thermometer_cb(GSList *characteristics, guint8 status,
 	return true;
 }
 
-static void write_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
+static void write_interval_cb(uint8_t status, void *user_data)
 {
 	struct tmp_interval_data *data = user_data;
 
@@ -745,11 +743,6 @@ static void write_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
 		goto done;
 	}
 
-	if (!dec_write_resp(pdu, len)) {
-		error("Interval Write Request: protocol error");
-		goto done;
-	}
-
 	change_property(data->thermometer, "Interval", &data->interval);
 
 done:
-- 
1.7.9.5


Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ] gatt: Remove offset parameter from gatt_read_char
Date: Fri, 28 Sep 2012 16:34:44 -0400
Message-Id: <1348864484-30206-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Core spec allows to implement Read Long Characteristic Value as a
Read Request, followed by zero or more Read Blob Requests, therefore the
offset parameter is unnecessary and is always 0 for normal use.
---
 attrib/client.c                    | 12 ++++++------
 attrib/gatt.c                      | 15 ++++-----------
 attrib/gatt.h                      |  4 ++--
 attrib/gatttool.c                  |  5 +----
 attrib/interactive.c               | 16 ++--------------
 profiles/deviceinfo/deviceinfo.c   |  2 +-
 profiles/heartrate/heartrate.c     |  2 +-
 profiles/input/hog_device.c        | 12 ++++++------
 profiles/proximity/monitor.c       |  4 ++--
 profiles/thermometer/thermometer.c |  8 ++++----
 10 files changed, 29 insertions(+), 51 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 2423fad..ece16bf 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -782,7 +782,7 @@ static void update_char_desc(guint8 status, const guint8 *pdu, guint16 len,
 		if (bt_io_set(io, NULL,
 				BT_IO_OPT_SEC_LEVEL, level,
 				BT_IO_OPT_INVALID)) {
-			gatt_read_char(gatt->attrib, current->handle, 0,
+			gatt_read_char(gatt->attrib, current->handle,
 					update_char_desc, current);
 			return;
 		}
@@ -833,7 +833,7 @@ static void update_char_value(guint8 status, const guint8 *pdu,
 		if (bt_io_set(io, NULL,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_HIGH,
 				BT_IO_OPT_INVALID)) {
-			gatt_read_char(gatt->attrib, chr->handle, 0,
+			gatt_read_char(gatt->attrib, chr->handle,
 					update_char_value, current);
 			return;
 		}
@@ -894,12 +894,12 @@ static void descriptor_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 		if (uuid_desc16_cmp(&uuid, GATT_CHARAC_USER_DESC_UUID) == 0) {
 			query_list_append(gatt, qfmt);
-			gatt_read_char(gatt->attrib, handle, 0, update_char_desc,
+			gatt_read_char(gatt->attrib, handle, update_char_desc,
 									qfmt);
 		} else if (uuid_desc16_cmp(&uuid, GATT_CHARAC_FMT_UUID) == 0) {
 			query_list_append(gatt, qfmt);
-			gatt_read_char(gatt->attrib, handle, 0,
-						update_char_format, qfmt);
+			gatt_read_char(gatt->attrib, handle, update_char_format,
+									qfmt);
 		} else
 			g_free(qfmt);
 	}
@@ -931,7 +931,7 @@ static void update_all_chars(gpointer data, gpointer user_data)
 
 	query_list_append(gatt, qvalue);
 
-	gatt_read_char(gatt->attrib, chr->handle, 0, update_char_value, qvalue);
+	gatt_read_char(gatt->attrib, chr->handle, update_char_value, qvalue);
 }
 
 static DBusMessage *create_discover_char_reply(DBusMessage *msg, GSList *chars)
diff --git a/attrib/gatt.c b/attrib/gatt.c
index 6880e2d..882f3c1 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -481,8 +481,8 @@ done:
 	long_read->func(status, rpdu, rlen, long_read->user_data);
 }
 
-guint gatt_read_char(GAttrib *attrib, uint16_t handle, uint16_t offset,
-				GAttribResultFunc func, gpointer user_data)
+guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
+							gpointer user_data)
 {
 	uint8_t *buf;
 	size_t buflen;
@@ -501,16 +501,9 @@ guint gatt_read_char(GAttrib *attrib, uint16_t handle, uint16_t offset,
 	long_read->handle = handle;
 
 	buf = g_attrib_get_buffer(attrib, &buflen);
-	if (offset > 0) {
-		plen = enc_read_blob_req(long_read->handle, offset, buf,
-									buflen);
-		id = g_attrib_send(attrib, 0, ATT_OP_READ_BLOB_REQ, buf, plen,
-				read_blob_helper, long_read, read_long_destroy);
-	} else {
-		plen = enc_read_req(handle, buf, buflen);
-		id = g_attrib_send(attrib, 0, ATT_OP_READ_REQ, buf, plen,
+	plen = enc_read_req(handle, buf, buflen);
+	id = g_attrib_send(attrib, 0, ATT_OP_READ_REQ, buf, plen,
 				read_char_helper, long_read, read_long_destroy);
-	}
 
 	if (id == 0)
 		g_free(long_read);
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 6bb6f0f..3862011 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -75,8 +75,8 @@ guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 					bt_uuid_t *uuid, gatt_cb_t func,
 					gpointer user_data);
 
-guint gatt_read_char(GAttrib *attrib, uint16_t handle, uint16_t offset,
-				GAttribResultFunc func, gpointer user_data);
+guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
+							gpointer user_data);
 
 guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
 					size_t vlen, GAttribResultFunc func,
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 416bb71..3b0ebbc 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -53,7 +53,6 @@ static int opt_end = 0xffff;
 static int opt_handle = -1;
 static int opt_mtu = 0;
 static int opt_psm = 0;
-static int opt_offset = 0;
 static gboolean opt_primary = FALSE;
 static gboolean opt_characteristics = FALSE;
 static gboolean opt_char_read = FALSE;
@@ -318,7 +317,7 @@ static gboolean characteristics_read(gpointer user_data)
 		return FALSE;
 	}
 
-	gatt_read_char(attrib, opt_handle, opt_offset, char_read_cb, attrib);
+	gatt_read_char(attrib, opt_handle, char_read_cb, attrib);
 
 	return FALSE;
 }
@@ -498,8 +497,6 @@ static GOptionEntry char_rw_options[] = {
 	{ "value", 'n' , 0, G_OPTION_ARG_STRING, &opt_value,
 		"Write characteristic value (required for write operation)",
 		"0x0001" },
-	{ "offset", 'o', 0, G_OPTION_ARG_INT, &opt_offset,
-		"Offset to long read characteristic by handle", "N"},
 	{NULL},
 };
 
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 38ac30f..8d9531f 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -503,7 +503,6 @@ static void cmd_char_desc(int argcp, char **argvp)
 static void cmd_read_hnd(int argcp, char **argvp)
 {
 	int handle;
-	int offset = 0;
 
 	if (conn_state != STATE_CONNECTED) {
 		printf("Command failed: disconnected\n");
@@ -521,18 +520,7 @@ static void cmd_read_hnd(int argcp, char **argvp)
 		return;
 	}
 
-	if (argcp > 2) {
-		char *e;
-
-		errno = 0;
-		offset = strtol(argvp[2], &e, 0);
-		if (errno != 0 || *e != '\0') {
-			printf("Invalid offset: %s\n", argvp[2]);
-			return;
-		}
-	}
-
-	gatt_read_char(attrib, handle, offset, char_read_cb, attrib);
+	gatt_read_char(attrib, handle, char_read_cb, attrib);
 }
 
 static void cmd_read_uuid(int argcp, char **argvp)
@@ -759,7 +747,7 @@ static struct {
 		"Characteristics Discovery" },
 	{ "char-desc",		cmd_char_desc,	"[start hnd] [end hnd]",
 		"Characteristics Descriptor Discovery" },
-	{ "char-read-hnd",	cmd_read_hnd,	"<handle> [offset]",
+	{ "char-read-hnd",	cmd_read_hnd,	"<handle>",
 		"Characteristics Value/Descriptor Read by handle" },
 	{ "char-read-uuid",	cmd_read_uuid,	"<UUID> [start hnd] [end hnd]",
 		"Characteristics Value/Descriptor Read by UUID" },
diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index e7c442f..57652a0 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -113,7 +113,7 @@ static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
 static void process_deviceinfo_char(struct characteristic *ch)
 {
 	if (g_strcmp0(ch->attr.uuid, PNPID_UUID) == 0)
-		gatt_read_char(ch->d->attrib, ch->attr.value_handle, 0,
+		gatt_read_char(ch->d->attrib, ch->attr.value_handle,
 							read_pnpid_cb, ch);
 }
 
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 4b95c5d..94d4b8d 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -355,7 +355,7 @@ static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 		} else if (g_strcmp0(c->uuid, BODY_SENSOR_LOCATION_UUID) == 0) {
 			DBG("Body Sensor Location supported");
 
-			gatt_read_char(hr->attrib, c->value_handle, 0,
+			gatt_read_char(hr->attrib, c->value_handle,
 						read_sensor_location_cb, hr);
 		} else if (g_strcmp0(c->uuid,
 					HEART_RATE_CONTROL_POINT_UUID) == 0) {
diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index d0912f5..a8cc568 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -233,12 +233,12 @@ static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
 			break;
 		case GATT_REPORT_REFERENCE:
 			report = user_data;
-			gatt_read_char(report->hogdev->attrib, handle, 0,
+			gatt_read_char(report->hogdev->attrib, handle,
 						report_reference_cb, report);
 			break;
 		case GATT_EXTERNAL_REPORT_REFERENCE:
 			hogdev = user_data;
-			gatt_read_char(hogdev->attrib, handle, 0,
+			gatt_read_char(hogdev->attrib, handle,
 					external_report_reference_cb, hogdev);
 			break;
 		}
@@ -479,7 +479,7 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 								report);
 			discover_descriptor(hogdev->attrib, chr, next, report);
 		} else if (bt_uuid_cmp(&uuid, &report_map_uuid) == 0) {
-			gatt_read_char(hogdev->attrib, chr->value_handle, 0,
+			gatt_read_char(hogdev->attrib, chr->value_handle,
 						report_map_read_cb, hogdev);
 			discover_descriptor(hogdev->attrib, chr, next, hogdev);
 		} else if (bt_uuid_cmp(&uuid, &info_uuid) == 0)
@@ -492,13 +492,13 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 
 	if (proto_mode_handle) {
 		hogdev->proto_mode_handle = proto_mode_handle;
-		gatt_read_char(hogdev->attrib, proto_mode_handle, 0,
+		gatt_read_char(hogdev->attrib, proto_mode_handle,
 						proto_mode_read_cb, hogdev);
 	}
 
 	if (info_handle)
-		gatt_read_char(hogdev->attrib, info_handle, 0,
-							info_read_cb, hogdev);
+		gatt_read_char(hogdev->attrib, info_handle, info_read_cb,
+									hogdev);
 }
 
 static void output_written_cb(guint8 status, const guint8 *pdu,
diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index a791916..6444a75 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -250,7 +250,7 @@ static void tx_power_handle_cb(GSList *characteristics, guint8 status,
 
 	DBG("Tx Power handle: 0x%04x", monitor->txpowerhandle);
 
-	gatt_read_char(monitor->attrib, monitor->txpowerhandle, 0,
+	gatt_read_char(monitor->attrib, monitor->txpowerhandle,
 							tx_power_read_cb, monitor);
 }
 
@@ -260,7 +260,7 @@ static void read_tx_power(struct monitor *monitor)
 	bt_uuid_t uuid;
 
 	if (monitor->txpowerhandle != 0) {
-		gatt_read_char(monitor->attrib, monitor->txpowerhandle, 0,
+		gatt_read_char(monitor->attrib, monitor->txpowerhandle,
 						tx_power_read_cb, monitor);
 		return;
 	}
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 77dcb26..3506ba7 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -393,8 +393,8 @@ static void process_thermometer_desc(struct descriptor *desc)
 
 	if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0 && g_strcmp0(ch->attr.uuid,
 					MEASUREMENT_INTERVAL_UUID) == 0) {
-		gatt_read_char(ch->t->attrib, desc->handle, 0,
-						valid_range_desc_cb, desc);
+		gatt_read_char(ch->t->attrib, desc->handle, valid_range_desc_cb,
+									desc);
 		return;
 	}
 
@@ -508,10 +508,10 @@ static void process_thermometer_char(struct characteristic *ch)
 		change_property(ch->t, "Intermediate", &intermediate);
 		return;
 	} else if (g_strcmp0(ch->attr.uuid, TEMPERATURE_TYPE_UUID) == 0)
-		gatt_read_char(ch->t->attrib, ch->attr.value_handle, 0,
+		gatt_read_char(ch->t->attrib, ch->attr.value_handle,
 							read_temp_type_cb, ch);
 	else if (g_strcmp0(ch->attr.uuid, MEASUREMENT_INTERVAL_UUID) == 0)
-		gatt_read_char(ch->t->attrib, ch->attr.value_handle, 0,
+		gatt_read_char(ch->t->attrib, ch->attr.value_handle,
 							read_interval_cb, ch);
 }
 
-- 
1.7.12.1


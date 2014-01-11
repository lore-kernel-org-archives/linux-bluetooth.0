Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 01/11] attrib: Modify gatt_cb_t signature
Date: Sat, 11 Jan 2014 00:47:17 -0400
Message-Id: <1389415647-25831-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use standard C types instead of GLib ones (which are unnecessary here)
and move the "status" parameter to the first position, so it is
consistent with other callbacks.
---
 attrib/gatt.c                        | 10 +++++-----
 attrib/gatt.h                        |  2 +-
 attrib/gatttool.c                    |  9 ++++-----
 attrib/interactive.c                 |  9 ++++-----
 profiles/cyclingspeed/cyclingspeed.c |  2 +-
 profiles/deviceinfo/deviceinfo.c     |  4 ++--
 profiles/gatt/gas.c                  |  4 ++--
 profiles/heartrate/heartrate.c       |  2 +-
 profiles/input/hog.c                 |  6 +++---
 profiles/proximity/monitor.c         | 12 ++++++------
 profiles/scanparam/scan.c            |  7 +++----
 profiles/thermometer/thermometer.c   |  4 ++--
 src/device.c                         |  5 ++---
 13 files changed, 36 insertions(+), 40 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index bb2cae1..9ed588b 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -90,9 +90,9 @@ static void isd_unref(struct included_discovery *isd)
 		return;
 
 	if (isd->err)
-		isd->cb(NULL, isd->err, isd->user_data);
+		isd->cb(isd->err, NULL, isd->user_data);
 	else
-		isd->cb(isd->includes, isd->err, isd->user_data);
+		isd->cb(isd->err, isd->includes, isd->user_data);
 
 	g_slist_free_full(isd->includes, g_free);
 	g_attrib_unref(isd->attrib);
@@ -183,7 +183,7 @@ static void primary_by_uuid_cb(guint8 status, const guint8 *ipdu,
 	return;
 
 done:
-	dp->cb(dp->primaries, err, dp->user_data);
+	dp->cb(err, dp->primaries, dp->user_data);
 	discover_primary_free(dp);
 }
 
@@ -252,7 +252,7 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	}
 
 done:
-	dp->cb(dp->primaries, err, dp->user_data);
+	dp->cb(err, dp->primaries, dp->user_data);
 	discover_primary_free(dp);
 }
 
@@ -517,7 +517,7 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 done:
 	err = (dc->characteristics ? 0 : err);
 
-	dc->cb(dc->characteristics, err, dc->user_data);
+	dc->cb(err, dc->characteristics, dc->user_data);
 	discover_char_free(dc);
 }
 
diff --git a/attrib/gatt.h b/attrib/gatt.h
index e5abd85..0f113e7 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -53,7 +53,7 @@
 #define GATT_CLIENT_CHARAC_CFG_NOTIF_BIT	0x0001
 #define GATT_CLIENT_CHARAC_CFG_IND_BIT		0x0002
 
-typedef void (*gatt_cb_t) (GSList *l, guint8 status, gpointer user_data);
+typedef void (*gatt_cb_t) (uint8_t status, GSList *l, void *user_data);
 
 struct gatt_primary {
 	char uuid[MAX_LEN_UUID_STR + 1];
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index f211dcd..ebc8123 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -137,7 +137,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	operation(attrib);
 }
 
-static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
+static void primary_all_cb(uint8_t status, GSList *services, void *user_data)
 {
 	GSList *l;
 
@@ -157,8 +157,7 @@ done:
 	g_main_loop_quit(event_loop);
 }
 
-static void primary_by_uuid_cb(GSList *ranges, guint8 status,
-							gpointer user_data)
+static void primary_by_uuid_cb(uint8_t status, GSList *ranges, void *user_data)
 {
 	GSList *l;
 
@@ -191,8 +190,8 @@ static gboolean primary(gpointer user_data)
 	return FALSE;
 }
 
-static void char_discovered_cb(GSList *characteristics, guint8 status,
-							gpointer user_data)
+static void char_discovered_cb(uint8_t status, GSList *characteristics,
+								void *user_data)
 {
 	GSList *l;
 
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 5bd27af..9826a4b 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -180,7 +180,7 @@ static void disconnect_io()
 	set_state(STATE_DISCONNECTED);
 }
 
-static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
+static void primary_all_cb(uint8_t status, GSList *services, void *user_data)
 {
 	GSList *l;
 
@@ -202,8 +202,7 @@ static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
 	}
 }
 
-static void primary_by_uuid_cb(GSList *ranges, guint8 status,
-							gpointer user_data)
+static void primary_by_uuid_cb(uint8_t status, GSList *ranges, void *user_data)
 {
 	GSList *l;
 
@@ -225,7 +224,7 @@ static void primary_by_uuid_cb(GSList *ranges, guint8 status,
 	}
 }
 
-static void included_cb(GSList *includes, guint8 status, gpointer user_data)
+static void included_cb(uint8_t status, GSList *includes, void *user_data)
 {
 	GSList *l;
 
@@ -249,7 +248,7 @@ static void included_cb(GSList *includes, guint8 status, gpointer user_data)
 	}
 }
 
-static void char_cb(GSList *characteristics, guint8 status, gpointer user_data)
+static void char_cb(uint8_t status, GSList *characteristics, void *user_data)
 {
 	GSList *l;
 
diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 6ecc985..b6d881a 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -759,7 +759,7 @@ done:
 		g_attrib_send(csc->attrib, 0, opdu, olen, NULL, NULL, NULL);
 }
 
-static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
+static void discover_char_cb(uint8_t status, GSList *chars, void *user_data)
 {
 	struct csc *csc = user_data;
 	uint16_t feature_val_handle = 0;
diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index 8343bb5..bfecfc2 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -107,8 +107,8 @@ static void process_deviceinfo_char(struct characteristic *ch)
 							read_pnpid_cb, ch);
 }
 
-static void configure_deviceinfo_cb(GSList *characteristics, guint8 status,
-							gpointer user_data)
+static void configure_deviceinfo_cb(uint8_t status, GSList *characteristics,
+								void *user_data)
 {
 	struct deviceinfo *d = user_data;
 	GSList *l;
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 5d6880f..de07464 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -271,8 +271,8 @@ done:
 	att_data_list_free(list);
 }
 
-static void gatt_characteristic_cb(GSList *characteristics, guint8 status,
-							gpointer user_data)
+static void gatt_characteristic_cb(uint8_t status, GSList *characteristics,
+								void *user_data)
 {
 	struct gas *gas = user_data;
 	struct gatt_char *chr;
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index d87f0ff..3be8f9e 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -464,7 +464,7 @@ static void discover_measurement_ccc(struct heartrate *hr,
 	gatt_discover_char_desc(hr->attrib, start, end, discover_ccc_cb, hr);
 }
 
-static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
+static void discover_char_cb(uint8_t status, GSList *chars, void *user_data)
 {
 	struct heartrate *hr = user_data;
 
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 4647fef..e357aa0 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -283,8 +283,8 @@ static void discover_descriptor(GAttrib *attrib, uint16_t start, uint16_t end,
 								ddcb_data);
 }
 
-static void external_service_char_cb(GSList *chars, guint8 status,
-							gpointer user_data)
+static void external_service_char_cb(uint8_t status, GSList *chars,
+								void *user_data)
 {
 	struct hog_device *hogdev = user_data;
 	struct gatt_primary *prim = hogdev->hog_primary;
@@ -463,7 +463,7 @@ static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 								hogdev->id);
 }
 
-static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
+static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 {
 	struct hog_device *hogdev = user_data;
 	struct gatt_primary *prim = hogdev->hog_primary;
diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index eaa5b0d..e78bfc3 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -190,8 +190,8 @@ static void linkloss_written(guint8 status, const guint8 *pdu, guint16 plen,
 				PROXIMITY_INTERFACE, "LinkLossAlertLevel");
 }
 
-static void char_discovered_cb(GSList *characteristics, guint8 status,
-							gpointer user_data)
+static void char_discovered_cb(uint8_t status, GSList *characteristics,
+								void *user_data)
 {
 	struct monitor *monitor = user_data;
 	struct gatt_char *chr;
@@ -259,8 +259,8 @@ static void tx_power_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	DBG("Tx Power Level: %02x", (int8_t) value[0]);
 }
 
-static void tx_power_handle_cb(GSList *characteristics, guint8 status,
-							gpointer user_data)
+static void tx_power_handle_cb(uint8_t status, GSList *characteristics,
+								void *user_data)
 {
 	struct monitor *monitor = user_data;
 	struct gatt_char *chr;
@@ -346,8 +346,8 @@ static void write_immediate_alert(struct monitor *monitor)
 						immediate_written, monitor);
 }
 
-static void immediate_handle_cb(GSList *characteristics, guint8 status,
-							gpointer user_data)
+static void immediate_handle_cb(uint8_t status, GSList *characteristics,
+								void *user_data)
 {
 	struct monitor *monitor = user_data;
 	struct gatt_char *chr;
diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 0236af6..d3f3aa5 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -132,8 +132,8 @@ done:
 	att_data_list_free(list);
 }
 
-static void refresh_discovered_cb(GSList *chars, guint8 status,
-						gpointer user_data)
+static void refresh_discovered_cb(uint8_t status, GSList *chars,
+								void *user_data)
 {
 	struct scan *scan = user_data;
 	struct gatt_char *chr;
@@ -165,8 +165,7 @@ static void refresh_discovered_cb(GSList *chars, guint8 status,
 					discover_descriptor_cb, user_data);
 }
 
-static void iwin_discovered_cb(GSList *chars, guint8 status,
-						gpointer user_data)
+static void iwin_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 {
 	struct scan *scan = user_data;
 	struct gatt_char *chr;
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index bd8413d..85cca03 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -737,8 +737,8 @@ static void process_thermometer_char(struct thermometer *t,
 	}
 }
 
-static void configure_thermometer_cb(GSList *characteristics, guint8 status,
-							gpointer user_data)
+static void configure_thermometer_cb(uint8_t status, GSList *characteristics,
+								void *user_data)
 {
 	struct thermometer *t = user_data;
 	GSList *l;
diff --git a/src/device.c b/src/device.c
index 6fec701..aa663f7 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3151,8 +3151,7 @@ static int service_by_range_cmp(gconstpointer a, gconstpointer b)
 	return memcmp(&prim->range, range, sizeof(*range));
 }
 
-static void find_included_cb(GSList *includes, uint8_t status,
-						gpointer user_data)
+static void find_included_cb(uint8_t status, GSList *includes, void *user_data)
 {
 	struct included_search *search = user_data;
 	struct btd_device *device = search->req->device;
@@ -3222,7 +3221,7 @@ static void find_included_services(struct browse_req *req, GSList *services)
 					find_included_cb, search);
 }
 
-static void primary_cb(GSList *services, guint8 status, gpointer user_data)
+static void primary_cb(uint8_t status, GSList *services, void *user_data)
 {
 	struct browse_req *req = user_data;
 
-- 
1.8.3.2


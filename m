Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 04/18] attrib: Modify gatt_cb_t to return bool
Date: Tue,  2 Apr 2013 12:50:51 -0400
Message-Id: <1364921465-31182-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The boolean return value will have the same semantics as GLib watches:
returning "true" will keep the GATT procedure going; returning "false"
will interrupt it (either due to an error or because the desired
information was found.)

This "early interruption" of GATT procedures is allowed by the spec and
avoids unnecessary data transfers, specially on large attribute
databases and when using small MTU values.
---
 attrib/gatt.h                        |    2 +-
 attrib/gatttool.c                    |   12 +++++++++---
 attrib/interactive.c                 |   22 +++++++++++++++-------
 profiles/cyclingspeed/cyclingspeed.c |    6 ++++--
 profiles/deviceinfo/deviceinfo.c     |    6 ++++--
 profiles/gatt/gas.c                  |    8 +++++---
 profiles/heartrate/heartrate.c       |    6 ++++--
 profiles/input/hog.c                 |   12 ++++++++----
 profiles/proximity/monitor.c         |   18 ++++++++++++------
 profiles/scanparam/scan.c            |   16 ++++++++++------
 profiles/thermometer/thermometer.c   |    6 ++++--
 src/device.c                         |   12 ++++++++----
 12 files changed, 84 insertions(+), 42 deletions(-)

diff --git a/attrib/gatt.h b/attrib/gatt.h
index c0bdcc6..e09970f 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -53,7 +53,7 @@
 #define GATT_CLIENT_CHARAC_CFG_NOTIF_BIT	0x0001
 #define GATT_CLIENT_CHARAC_CFG_IND_BIT		0x0002
 
-typedef void (*gatt_cb_t) (GSList *l, guint8 status, gpointer user_data);
+typedef bool (*gatt_cb_t) (GSList *l, guint8 status, gpointer user_data);
 typedef void (*gatt_exchange_mtu_cb_t) (uint8_t status, uint16_t mtu,
 							void *user_data);
 
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index c7539e7..11269c7 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -138,7 +138,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	operation(attrib);
 }
 
-static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
+static bool primary_all_cb(GSList *services, guint8 status, gpointer user_data)
 {
 	GSList *l;
 
@@ -156,9 +156,11 @@ static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
 
 done:
 	g_main_loop_quit(event_loop);
+
+	return true;
 }
 
-static void primary_by_uuid_cb(GSList *ranges, guint8 status,
+static bool primary_by_uuid_cb(GSList *ranges, guint8 status,
 							gpointer user_data)
 {
 	GSList *l;
@@ -177,6 +179,8 @@ static void primary_by_uuid_cb(GSList *ranges, guint8 status,
 
 done:
 	g_main_loop_quit(event_loop);
+
+	return true;
 }
 
 static gboolean primary(gpointer user_data)
@@ -192,7 +196,7 @@ static gboolean primary(gpointer user_data)
 	return FALSE;
 }
 
-static void char_discovered_cb(GSList *characteristics, guint8 status,
+static bool char_discovered_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
 {
 	GSList *l;
@@ -213,6 +217,8 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 
 done:
 	g_main_loop_quit(event_loop);
+
+	return true;
 }
 
 static gboolean characteristics(gpointer user_data)
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 6bc3b4e..f8f4fff 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -175,14 +175,14 @@ static void disconnect_io()
 	set_state(STATE_DISCONNECTED);
 }
 
-static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
+static bool primary_all_cb(GSList *services, guint8 status, gpointer user_data)
 {
 	GSList *l;
 
 	if (status) {
 		printf("Discover all primary services failed: %s\n",
 							att_ecode2str(status));
-		return;
+		return false;
 	}
 
 	printf("\n");
@@ -193,9 +193,11 @@ static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
 	}
 
 	rl_forced_update_display();
+
+	return true;
 }
 
-static void primary_by_uuid_cb(GSList *ranges, guint8 status,
+static bool primary_by_uuid_cb(GSList *ranges, guint8 status,
 							gpointer user_data)
 {
 	GSList *l;
@@ -203,7 +205,7 @@ static void primary_by_uuid_cb(GSList *ranges, guint8 status,
 	if (status) {
 		printf("Discover primary services by UUID failed: %s\n",
 							att_ecode2str(status));
-		return;
+		return false;
 	}
 
 	printf("\n");
@@ -214,9 +216,11 @@ static void primary_by_uuid_cb(GSList *ranges, guint8 status,
 	}
 
 	rl_forced_update_display();
+
+	return true;
 }
 
-static void included_cb(GSList *includes, guint8 status, gpointer user_data)
+static bool included_cb(GSList *includes, guint8 status, gpointer user_data)
 {
 	GSList *l;
 
@@ -242,16 +246,18 @@ static void included_cb(GSList *includes, guint8 status, gpointer user_data)
 
 done:
 	rl_forced_update_display();
+
+	return true;
 }
 
-static void char_cb(GSList *characteristics, guint8 status, gpointer user_data)
+static bool char_cb(GSList *characteristics, guint8 status, gpointer user_data)
 {
 	GSList *l;
 
 	if (status) {
 		printf("Discover all characteristics failed: %s\n",
 							att_ecode2str(status));
-		return;
+		return false;
 	}
 
 	printf("\n");
@@ -265,6 +271,8 @@ static void char_cb(GSList *characteristics, guint8 status, gpointer user_data)
 	}
 
 	rl_forced_update_display();
+
+	return true;
 }
 
 static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 7bec0fa..605bb6c 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -758,7 +758,7 @@ done:
 		g_attrib_send(csc->attrib, 0, opdu, olen, NULL, NULL, NULL);
 }
 
-static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
+static bool discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 {
 	struct csc *csc = user_data;
 	uint16_t feature_val_handle = 0;
@@ -766,7 +766,7 @@ static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 	if (status) {
 		error("Discover CSCS characteristics: %s",
 							att_ecode2str(status));
-		return;
+		return false;
 	}
 
 	for (; chars; chars = chars->next) {
@@ -803,6 +803,8 @@ static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 	if (feature_val_handle > 0)
 		gatt_read_char(csc->attrib, feature_val_handle,
 							read_feature_cb, csc);
+
+	return true;
 }
 
 static void enable_measurement(gpointer data, gpointer user_data)
diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index 471241b..d926367 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -119,7 +119,7 @@ static void process_deviceinfo_char(struct characteristic *ch)
 							read_pnpid_cb, ch);
 }
 
-static void configure_deviceinfo_cb(GSList *characteristics, guint8 status,
+static bool configure_deviceinfo_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
 {
 	struct deviceinfo *d = user_data;
@@ -128,7 +128,7 @@ static void configure_deviceinfo_cb(GSList *characteristics, guint8 status,
 	if (status != 0) {
 		error("Discover deviceinfo characteristics: %s",
 							att_ecode2str(status));
-		return;
+		return false;
 	}
 
 	for (l = characteristics; l; l = l->next) {
@@ -146,6 +146,8 @@ static void configure_deviceinfo_cb(GSList *characteristics, guint8 status,
 
 		process_deviceinfo_char(ch);
 	}
+
+	return true;
 }
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 48d5a2d..8390f4a 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -262,7 +262,7 @@ done:
 	att_data_list_free(list);
 }
 
-static void gatt_characteristic_cb(GSList *characteristics, guint8 status,
+static bool gatt_characteristic_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
 {
 	struct gas *gas = user_data;
@@ -271,7 +271,7 @@ static void gatt_characteristic_cb(GSList *characteristics, guint8 status,
 
 	if (status) {
 		error("Discover Service Changed handle: %s", att_ecode2str(status));
-		return;
+		return false;
 	}
 
 	chr = characteristics->data;
@@ -281,12 +281,14 @@ static void gatt_characteristic_cb(GSList *characteristics, guint8 status,
 
 	if (start > end) {
 		error("Inconsistent database: Service Changed CCC missing");
-		return;
+		return false;
 	}
 
 	gas->changed_handle = chr->value_handle;
 	gatt_discover_char_desc(gas->attrib, start, end, gatt_descriptors_cb,
 									gas);
+
+	return true;
 }
 
 static void exchange_mtu_cb(uint8_t status, uint16_t mtu, void *user_data)
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 6522a90..2fe8b0f 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -463,14 +463,14 @@ static void discover_measurement_ccc(struct heartrate *hr,
 	gatt_discover_char_desc(hr->attrib, start, end, discover_ccc_cb, hr);
 }
 
-static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
+static bool discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 {
 	struct heartrate *hr = user_data;
 
 	if (status) {
 		error("Discover HRS characteristics failed: %s",
 							att_ecode2str(status));
-		return;
+		return false;
 	}
 
 	for (; chars; chars = chars->next) {
@@ -497,6 +497,8 @@ static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 			hr->hrcp_val_handle = c->value_handle;
 		}
 	}
+
+	return true;
 }
 
 static void enable_measurement(gpointer data, gpointer user_data)
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 5c90a92..feee24d 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -282,7 +282,7 @@ static void discover_descriptor(GAttrib *attrib, uint16_t start, uint16_t end,
 								ddcb_data);
 }
 
-static void external_service_char_cb(GSList *chars, guint8 status,
+static bool external_service_char_cb(GSList *chars, guint8 status,
 							gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
@@ -293,7 +293,7 @@ static void external_service_char_cb(GSList *chars, guint8 status,
 	if (status != 0) {
 		const char *str = att_ecode2str(status);
 		DBG("Discover external service characteristic failed: %s", str);
-		return;
+		return false;
 	}
 
 	for (l = chars; l; l = g_slist_next(l)) {
@@ -314,6 +314,8 @@ static void external_service_char_cb(GSList *chars, guint8 status,
 		end = (next ? next->handle - 1 : prim->range.end);
 		discover_descriptor(hogdev->attrib, start, end, report);
 	}
+
+	return true;
 }
 
 static void external_report_reference_cb(guint8 status, const guint8 *pdu,
@@ -462,7 +464,7 @@ static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 								hogdev->id);
 }
 
-static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
+static bool char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
 	struct gatt_primary *prim = hogdev->hog_primary;
@@ -475,7 +477,7 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 	if (status != 0) {
 		const char *str = att_ecode2str(status);
 		DBG("Discover all characteristics failed: %s", str);
-		return;
+		return false;
 	}
 
 	bt_uuid16_create(&report_uuid, HOG_REPORT_UUID);
@@ -528,6 +530,8 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 	if (info_handle)
 		gatt_read_char(hogdev->attrib, info_handle, info_read_cb,
 									hogdev);
+
+	return true;
 }
 
 static void output_written_cb(guint8 status, const guint8 *pdu,
diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index 48f877d..91e0c69 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -182,7 +182,7 @@ static void linkloss_written(guint8 status, const guint8 *pdu, guint16 plen,
 				PROXIMITY_INTERFACE, "LinkLossAlertLevel");
 }
 
-static void char_discovered_cb(GSList *characteristics, guint8 status,
+static bool char_discovered_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
 {
 	struct monitor *monitor = user_data;
@@ -191,7 +191,7 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 
 	if (status) {
 		error("Discover Link Loss handle: %s", att_ecode2str(status));
-		return;
+		return false;
 	}
 
 	DBG("Setting alert level \"%s\" on Reporter", monitor->linklosslevel);
@@ -202,6 +202,8 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 
 	gatt_write_char(monitor->attrib, monitor->linklosshandle, &value, 1,
 						linkloss_written, monitor);
+
+	return true;
 }
 
 static int write_alert_level(struct monitor *monitor)
@@ -251,7 +253,7 @@ static void tx_power_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	DBG("Tx Power Level: %02x", (int8_t) value[0]);
 }
 
-static void tx_power_handle_cb(GSList *characteristics, guint8 status,
+static bool tx_power_handle_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
 {
 	struct monitor *monitor = user_data;
@@ -259,7 +261,7 @@ static void tx_power_handle_cb(GSList *characteristics, guint8 status,
 
 	if (status) {
 		error("Discover Tx Power handle: %s", att_ecode2str(status));
-		return;
+		return false;
 	}
 
 	chr = characteristics->data;
@@ -269,6 +271,8 @@ static void tx_power_handle_cb(GSList *characteristics, guint8 status,
 
 	gatt_read_char(monitor->attrib, monitor->txpowerhandle,
 							tx_power_read_cb, monitor);
+
+	return true;
 }
 
 static void read_tx_power(struct monitor *monitor)
@@ -338,7 +342,7 @@ static void write_immediate_alert(struct monitor *monitor)
 						immediate_written, monitor);
 }
 
-static void immediate_handle_cb(GSList *characteristics, guint8 status,
+static bool immediate_handle_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
 {
 	struct monitor *monitor = user_data;
@@ -347,7 +351,7 @@ static void immediate_handle_cb(GSList *characteristics, guint8 status,
 	if (status) {
 		error("Discover Immediate Alert handle: %s",
 						att_ecode2str(status));
-		return;
+		return false;
 	}
 
 	chr = characteristics->data;
@@ -357,6 +361,8 @@ static void immediate_handle_cb(GSList *characteristics, guint8 status,
 
 	if (monitor->fallbacklevel)
 		write_immediate_alert(monitor);
+
+	return true;
 }
 
 static void discover_immediate_handle(struct monitor *monitor)
diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 374ae65..1c7be37 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -143,7 +143,7 @@ done:
 	att_data_list_free(list);
 }
 
-static void refresh_discovered_cb(GSList *chars, guint8 status,
+static bool refresh_discovered_cb(GSList *chars, guint8 status,
 						gpointer user_data)
 {
 	struct scan *scan = user_data;
@@ -152,12 +152,12 @@ static void refresh_discovered_cb(GSList *chars, guint8 status,
 
 	if (status) {
 		error("Scan Refresh %s", att_ecode2str(status));
-		return;
+		return false;
 	}
 
 	if (!chars) {
 		DBG("Scan Refresh not supported");
-		return;
+		return false;
 	}
 
 	chr = chars->data;
@@ -168,15 +168,17 @@ static void refresh_discovered_cb(GSList *chars, guint8 status,
 	end = scan->range.end;
 
 	if (start >= end)
-		return;
+		return false;
 
 	scan->refresh_handle = chr->value_handle;
 
 	gatt_discover_char_desc(scan->attrib, start, end,
 					discover_descriptor_cb, user_data);
+
+	return true;
 }
 
-static void iwin_discovered_cb(GSList *chars, guint8 status,
+static bool iwin_discovered_cb(GSList *chars, guint8 status,
 						gpointer user_data)
 {
 	struct scan *scan = user_data;
@@ -185,7 +187,7 @@ static void iwin_discovered_cb(GSList *chars, guint8 status,
 	if (status) {
 		error("Discover Scan Interval Window: %s",
 						att_ecode2str(status));
-		return;
+		return false;
 	}
 
 	chr = chars->data;
@@ -194,6 +196,8 @@ static void iwin_discovered_cb(GSList *chars, guint8 status,
 	DBG("Scan Interval Window handle: 0x%04x", scan->iwhandle);
 
 	write_scan_params(scan->attrib, scan->iwhandle);
+
+	return true;
 }
 
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 7795792..6580867 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -736,7 +736,7 @@ static void process_thermometer_char(struct thermometer *t,
 	}
 }
 
-static void configure_thermometer_cb(GSList *characteristics, guint8 status,
+static bool configure_thermometer_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
 {
 	struct thermometer *t = user_data;
@@ -745,7 +745,7 @@ static void configure_thermometer_cb(GSList *characteristics, guint8 status,
 	if (status != 0) {
 		error("Discover thermometer characteristics: %s",
 							att_ecode2str(status));
-		return;
+		return false;
 	}
 
 	for (l = characteristics; l; l = l->next) {
@@ -754,6 +754,8 @@ static void configure_thermometer_cb(GSList *characteristics, guint8 status,
 
 		process_thermometer_char(t, c, c_next);
 	}
+
+	return true;
 }
 
 static void write_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
diff --git a/src/device.c b/src/device.c
index ee17514..b2a7ade 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3026,7 +3026,7 @@ static int service_by_range_cmp(gconstpointer a, gconstpointer b)
 	return memcmp(&prim->range, range, sizeof(*range));
 }
 
-static void find_included_cb(GSList *includes, uint8_t status,
+static bool find_included_cb(GSList *includes, uint8_t status,
 						gpointer user_data)
 {
 	struct included_search *search = user_data;
@@ -3063,12 +3063,14 @@ done:
 		register_all_services(search->req, search->services);
 		g_slist_free(search->services);
 		g_free(search);
-		return;
+		return true;
 	}
 
 	prim = search->current->data;
 	gatt_find_included(device->attrib, prim->range.start, prim->range.end,
 					find_included_cb, search);
+
+	return true;
 }
 
 static void find_included_services(struct browse_req *req, GSList *services)
@@ -3091,7 +3093,7 @@ static void find_included_services(struct browse_req *req, GSList *services)
 
 }
 
-static void primary_cb(GSList *services, guint8 status, gpointer user_data)
+static bool primary_cb(GSList *services, guint8 status, gpointer user_data)
 {
 	struct browse_req *req = user_data;
 
@@ -3107,10 +3109,12 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 
 		device->browse = NULL;
 		browse_request_free(req);
-		return;
+		return false;
 	}
 
 	find_included_services(req, services);
+
+	return true;
 }
 
 static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
-- 
1.7.9.5


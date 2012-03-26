Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v2 2/2] GATT: replace start/end with att_range
Date: Mon, 26 Mar 2012 09:35:59 +0200
Message-Id: <1332747359-15647-3-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1332747359-15647-1-git-send-email-chen.ganir@ti.com>
References: <1332747359-15647-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Use att_range struct instead of individual start/end handles in
gatt_primary structure
---
 attrib/client.c           |   10 +++++-----
 attrib/gatt.c             |    4 ++--
 attrib/gatt.h             |    3 +--
 attrib/gatttool.c         |    2 +-
 attrib/interactive.c      |    2 +-
 proximity/monitor.c       |   12 ++++++------
 src/adapter.c             |    4 ++--
 src/device.c              |    6 +++---
 thermometer/thermometer.c |    4 ++--
 9 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 7c01514..c0e00c1 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -860,10 +860,10 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 	}
 
 	if (previous_end)
-		*previous_end = prim->end;
+		*previous_end = prim->range.end;
 
 	gatt_get_address(gatt, &sba, &dba);
-	store_characteristics(&sba, &dba, prim->start, gatt->chars);
+	store_characteristics(&sba, &dba, prim->range.start, gatt->chars);
 
 	g_slist_foreach(gatt->chars, register_characteristic, gatt->path);
 
@@ -899,7 +899,7 @@ static void send_discover(GAttrib *attrib, gpointer user_data)
 
 	gatt->attrib = g_attrib_ref(attrib);
 
-	gatt_discover_char(gatt->attrib, prim->start, prim->end, NULL,
+	gatt_discover_char(gatt->attrib, prim->range.start, prim->range.end, NULL,
 						char_discovered_cb, qchr);
 }
 
@@ -1009,12 +1009,12 @@ static struct gatt_service *primary_register(DBusConnection *conn,
 	gatt->psm = psm;
 	gatt->conn = dbus_connection_ref(conn);
 	gatt->path = g_strdup_printf("%s/service%04x", device_path,
-								prim->start);
+								prim->range.start);
 
 	g_dbus_register_interface(gatt->conn, gatt->path,
 					CHAR_INTERFACE, prim_methods,
 					NULL, NULL, gatt, NULL);
-	gatt->chars = load_characteristics(gatt, prim->start);
+	gatt->chars = load_characteristics(gatt, prim->range.start);
 	g_slist_foreach(gatt->chars, register_characteristic, gatt->path);
 
 	return gatt;
diff --git a/attrib/gatt.c b/attrib/gatt.c
index 7cf718d..1c3ff78 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -193,8 +193,8 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 			err = ATT_ECODE_INSUFF_RESOURCES;
 			goto done;
 		}
-		primary->start = start;
-		primary->end = end;
+		primary->range.start = start;
+		primary->range.end = end;
 		bt_uuid_to_string(&uuid, primary->uuid, sizeof(primary->uuid));
 		dp->primaries = g_slist_append(dp->primaries, primary);
 	}
diff --git a/attrib/gatt.h b/attrib/gatt.h
index cf37914..1732270 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -27,8 +27,7 @@ typedef void (*gatt_cb_t) (GSList *l, guint8 status, gpointer user_data);
 
 struct gatt_primary {
 	char uuid[MAX_LEN_UUID_STR + 1];
-	uint16_t start;
-	uint16_t end;
+	struct att_range range;
 };
 
 struct gatt_char {
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 24a85a4..21514af 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -148,7 +148,7 @@ static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
 	for (l = services; l; l = l->next) {
 		struct gatt_primary *prim = l->data;
 		g_print("attr handle = 0x%04x, end grp handle = 0x%04x "
-			"uuid: %s\n", prim->start, prim->end, prim->uuid);
+			"uuid: %s\n", prim->range.start, prim->range.end, prim->uuid);
 	}
 
 done:
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 2d650d6..5941811 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -163,7 +163,7 @@ static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
 	for (l = services; l; l = l->next) {
 		struct gatt_primary *prim = l->data;
 		printf("attr handle: 0x%04x, end grp handle: 0x%04x "
-			"uuid: %s\n", prim->start, prim->end, prim->uuid);
+			"uuid: %s\n", prim->range.start, prim->range.end, prim->uuid);
 	}
 
 	rl_forced_update_display();
diff --git a/proximity/monitor.c b/proximity/monitor.c
index f3d5b2d..687b41c 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -617,8 +617,8 @@ int monitor_register(DBusConnection *conn, struct btd_device *device,
 
 	if (linkloss && enabled->linkloss) {
 		monitor->linkloss = g_new0(struct att_range, 1);
-		monitor->linkloss->start = linkloss->start;
-		monitor->linkloss->end = linkloss->end;
+		monitor->linkloss->start = linkloss->range.start;
+		monitor->linkloss->end = linkloss->range.end;
 
 		monitor->enabled.linkloss = TRUE;
 	}
@@ -626,16 +626,16 @@ int monitor_register(DBusConnection *conn, struct btd_device *device,
 	if (immediate) {
 		if (txpower && enabled->pathloss) {
 			monitor->txpower = g_new0(struct att_range, 1);
-			monitor->txpower->start = txpower->start;
-			monitor->txpower->end = txpower->end;
+			monitor->txpower->start = txpower->range.start;
+			monitor->txpower->end = txpower->range.end;
 
 			monitor->enabled.pathloss = TRUE;
 		}
 
 		if (enabled->pathloss || enabled->findme) {
 			monitor->immediate = g_new0(struct att_range, 1);
-			monitor->immediate->start = immediate->start;
-			monitor->immediate->end = immediate->end;
+			monitor->immediate->start = immediate->range.start;
+			monitor->immediate->end = immediate->range.end;
 		}
 
 		monitor->enabled.findme = enabled->findme;
diff --git a/src/adapter.c b/src/adapter.c
index c66968d..fa879af 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1899,8 +1899,8 @@ static GSList *string_to_primary_list(char *str)
 
 		prim = g_new0(struct gatt_primary, 1);
 
-		ret = sscanf(services[i], "%04hX#%04hX#%s", &prim->start,
-							&prim->end, prim->uuid);
+		ret = sscanf(services[i], "%04hX#%04hX#%s", &prim->range.start,
+							&prim->range.end, prim->uuid);
 
 		if (ret < 3) {
 			g_free(prim);
diff --git a/src/device.c b/src/device.c
index c470ab1..eab7e4c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1546,8 +1546,8 @@ GSList *device_services_from_record(struct btd_device *device, GSList *profiles)
 			continue;
 
 		prim = g_new0(struct gatt_primary, 1);
-		prim->start = start;
-		prim->end = end;
+		prim->range.start = start;
+		prim->range.end = end;
 		sdp_uuid2strn(&prim_uuid, prim->uuid, sizeof(prim->uuid));
 
 		prim_list = g_slist_append(prim_list, prim);
@@ -1706,7 +1706,7 @@ static char *primary_list_to_string(GSList *primary_list)
 		memset(service, 0, sizeof(service));
 
 		snprintf(service, sizeof(service), "%04X#%04X#%s ",
-				primary->start, primary->end, primary->uuid);
+				primary->range.start, primary->range.end, primary->uuid);
 
 		services = g_string_append(services, service);
 	}
diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index de4e647..a64ed54 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -1220,8 +1220,8 @@ int thermometer_register(DBusConnection *connection, struct btd_device *device,
 	t->conn = dbus_connection_ref(connection);
 	t->dev = btd_device_ref(device);
 	t->svc_range = g_new0(struct att_range, 1);
-	t->svc_range->start = tattr->start;
-	t->svc_range->end = tattr->end;
+	t->svc_range->start = tattr->range.start;
+	t->svc_range->end = tattr->range.end;
 
 	if (!g_dbus_register_interface(t->conn, path, THERMOMETER_INTERFACE,
 				thermometer_methods, thermometer_signals,
-- 
1.7.4.1


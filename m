Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 02/11] attrib: Rename gatt_find_info() to gatt_discover_char_desc()
Date: Fri, 19 Jul 2013 13:34:08 -0400
Message-Id: <1374255257-8753-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1374255257-8753-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1374255257-8753-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The old name referred to the underlying ATT PDU (Find Information
Request and Find Information Response) and not to the actual GATT
procedure (Discover All Characteristic Descriptors).
---
 attrib/gatt.c                        |    2 +-
 attrib/gatt.h                        |    2 +-
 attrib/gatttool.c                    |    2 +-
 attrib/interactive.c                 |    5 +++--
 profiles/cyclingspeed/cyclingspeed.c |    2 +-
 profiles/gatt/gas.c                  |    3 ++-
 profiles/heartrate/heartrate.c       |    2 +-
 profiles/input/hog.c                 |    7 ++++---
 profiles/scanparam/scan.c            |    4 ++--
 profiles/thermometer/thermometer.c   |    2 +-
 10 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 9482e07..d21dd39 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -832,7 +832,7 @@ guint gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu, GAttribResultFunc func,
 	return g_attrib_send(attrib, 0, buf, plen, func, user_data, NULL);
 }
 
-guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
+guint gatt_discover_char_desc(GAttrib *attrib, uint16_t start, uint16_t end,
 				GAttribResultFunc func, gpointer user_data)
 {
 	uint8_t *buf;
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 305b4c6..e5abd85 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -91,7 +91,7 @@ guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
 					size_t vlen, GAttribResultFunc func,
 					gpointer user_data);
 
-guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
+guint gatt_discover_char_desc(GAttrib *attrib, uint16_t start, uint16_t end,
 				GAttribResultFunc func, gpointer user_data);
 
 guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value, int vlen,
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 319419a..f211dcd 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -446,7 +446,7 @@ static gboolean characteristics_desc(gpointer user_data)
 {
 	GAttrib *attrib = user_data;
 
-	gatt_find_info(attrib, opt_start, opt_end, char_desc_cb, NULL);
+	gatt_discover_char_desc(attrib, opt_start, opt_end, char_desc_cb, NULL);
 
 	return FALSE;
 }
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 23132cd..1f3122f 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -307,7 +307,8 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	att_data_list_free(list);
 
 	if (handle != 0xffff && handle < end)
-		gatt_find_info(attrib, handle + 1, end, char_desc_cb, NULL);
+		gatt_discover_char_desc(attrib, handle + 1, end, char_desc_cb,
+									NULL);
 }
 
 static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
@@ -558,7 +559,7 @@ static void cmd_char_desc(int argcp, char **argvp)
 	} else
 		end = 0xffff;
 
-	gatt_find_info(attrib, start, end, char_desc_cb, NULL);
+	gatt_discover_char_desc(attrib, start, end, char_desc_cb, NULL);
 }
 
 static void cmd_read_hnd(int argcp, char **argvp)
diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index ea6076c..6ecc985 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -506,7 +506,7 @@ static void discover_desc(struct csc *csc, struct gatt_char *c,
 	ch->csc = csc;
 	memcpy(ch->uuid, c->uuid, sizeof(c->uuid));
 
-	gatt_find_info(csc->attrib, start, end, discover_desc_cb, ch);
+	gatt_discover_char_desc(csc->attrib, start, end, discover_desc_cb, ch);
 }
 
 static void update_watcher(gpointer data, gpointer user_data)
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 2ed837f..5d6880f 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -294,7 +294,8 @@ static void gatt_characteristic_cb(GSList *characteristics, guint8 status,
 	}
 
 	gas->changed_handle = chr->value_handle;
-	gatt_find_info(gas->attrib, start, end, gatt_descriptors_cb, gas);
+	gatt_discover_char_desc(gas->attrib, start, end, gatt_descriptors_cb,
+									gas);
 }
 
 static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 34ec9bc..d87f0ff 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -461,7 +461,7 @@ static void discover_measurement_ccc(struct heartrate *hr,
 		return;
 	}
 
-	gatt_find_info(hr->attrib, start, end, discover_ccc_cb, hr);
+	gatt_discover_char_desc(hr->attrib, start, end, discover_ccc_cb, hr);
 }
 
 static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index cab70e9..6bbf35f 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -261,8 +261,8 @@ done:
 	att_data_list_free(list);
 
 	if (handle != 0xffff && handle < end)
-		gatt_find_info(attrib, handle + 1, end, discover_descriptor_cb,
-								ddcb_data);
+		gatt_discover_char_desc(attrib, handle + 1, end,
+					discover_descriptor_cb, ddcb_data);
 	else
 		g_free(ddcb_data);
 }
@@ -279,7 +279,8 @@ static void discover_descriptor(GAttrib *attrib, uint16_t start, uint16_t end,
 	ddcb_data->end = end;
 	ddcb_data->data = user_data;
 
-	gatt_find_info(attrib, start, end, discover_descriptor_cb, ddcb_data);
+	gatt_discover_char_desc(attrib, start, end, discover_descriptor_cb,
+								ddcb_data);
 }
 
 static void external_service_char_cb(GSList *chars, guint8 status,
diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index fc4779f..5982c38 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -163,8 +163,8 @@ static void refresh_discovered_cb(GSList *chars, guint8 status,
 
 	scan->refresh_handle = chr->value_handle;
 
-	gatt_find_info(scan->attrib, start, end,
-				discover_descriptor_cb, user_data);
+	gatt_discover_char_desc(scan->attrib, start, end,
+					discover_descriptor_cb, user_data);
 }
 
 static void iwin_discovered_cb(GSList *chars, guint8 status,
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index c2ca251..bd8413d 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -633,7 +633,7 @@ static void discover_desc(struct thermometer *t, struct gatt_char *c,
 	ch->t = t;
 	memcpy(ch->uuid, c->uuid, sizeof(c->uuid));
 
-	gatt_find_info(t->attrib, start, end, discover_desc_cb, ch);
+	gatt_discover_char_desc(t->attrib, start, end, discover_desc_cb, ch);
 }
 
 static void read_temp_type_cb(guint8 status, const guint8 *pdu, guint16 len,
-- 
1.7.9.5


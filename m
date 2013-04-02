Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 03/18] attrib: Rename gatt_find_info() to gatt_discover_char_desc()
Date: Tue,  2 Apr 2013 12:50:50 -0400
Message-Id: <1364921465-31182-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
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
index 024d148..7a96c67 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -863,7 +863,7 @@ guint gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu,
 									g_free);
 }
 
-guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
+guint gatt_discover_char_desc(GAttrib *attrib, uint16_t start, uint16_t end,
 				GAttribResultFunc func, gpointer user_data)
 {
 	uint8_t *buf;
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 691be80..c0bdcc6 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -93,7 +93,7 @@ guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
 					size_t vlen, GAttribResultFunc func,
 					gpointer user_data);
 
-guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
+guint gatt_discover_char_desc(GAttrib *attrib, uint16_t start, uint16_t end,
 				GAttribResultFunc func, gpointer user_data);
 
 guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value, int vlen,
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 44c9ccf..c7539e7 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -461,7 +461,7 @@ static gboolean characteristics_desc(gpointer user_data)
 {
 	GAttrib *attrib = user_data;
 
-	gatt_find_info(attrib, opt_start, opt_end, char_desc_cb, NULL);
+	gatt_discover_char_desc(attrib, opt_start, opt_end, char_desc_cb, NULL);
 
 	return FALSE;
 }
diff --git a/attrib/interactive.c b/attrib/interactive.c
index e1af871..6bc3b4e 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -306,7 +306,8 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	att_data_list_free(list);
 
 	if (handle != 0xffff && handle < end)
-		gatt_find_info(attrib, handle + 1, end, char_desc_cb, NULL);
+		gatt_discover_char_desc(attrib, handle + 1, end, char_desc_cb,
+									NULL);
 	else
 		rl_forced_update_display();
 }
@@ -560,7 +561,7 @@ static void cmd_char_desc(int argcp, char **argvp)
 	} else
 		end = 0xffff;
 
-	gatt_find_info(attrib, start, end, char_desc_cb, NULL);
+	gatt_discover_char_desc(attrib, start, end, char_desc_cb, NULL);
 }
 
 static void cmd_read_hnd(int argcp, char **argvp)
diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 125007e..7bec0fa 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -505,7 +505,7 @@ static void discover_desc(struct csc *csc, struct gatt_char *c,
 	ch->csc = csc;
 	memcpy(ch->uuid, c->uuid, sizeof(c->uuid));
 
-	gatt_find_info(csc->attrib, start, end, discover_desc_cb, ch);
+	gatt_discover_char_desc(csc->attrib, start, end, discover_desc_cb, ch);
 }
 
 static void update_watcher(gpointer data, gpointer user_data)
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 9ff89b0..48d5a2d 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -285,7 +285,8 @@ static void gatt_characteristic_cb(GSList *characteristics, guint8 status,
 	}
 
 	gas->changed_handle = chr->value_handle;
-	gatt_find_info(gas->attrib, start, end, gatt_descriptors_cb, gas);
+	gatt_discover_char_desc(gas->attrib, start, end, gatt_descriptors_cb,
+									gas);
 }
 
 static void exchange_mtu_cb(uint8_t status, uint16_t mtu, void *user_data)
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 0520f5c..6522a90 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -460,7 +460,7 @@ static void discover_measurement_ccc(struct heartrate *hr,
 		return;
 	}
 
-	gatt_find_info(hr->attrib, start, end, discover_ccc_cb, hr);
+	gatt_discover_char_desc(hr->attrib, start, end, discover_ccc_cb, hr);
 }
 
 static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index eadc860..5c90a92 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -260,8 +260,8 @@ done:
 	att_data_list_free(list);
 
 	if (handle != 0xffff && handle < end)
-		gatt_find_info(attrib, handle + 1, end, discover_descriptor_cb,
-								ddcb_data);
+		gatt_discover_char_desc(attrib, handle + 1, end,
+					discover_descriptor_cb, ddcb_data);
 	else
 		g_free(ddcb_data);
 }
@@ -278,7 +278,8 @@ static void discover_descriptor(GAttrib *attrib, uint16_t start, uint16_t end,
 	ddcb_data->end = end;
 	ddcb_data->data = user_data;
 
-	gatt_find_info(attrib, start, end, discover_descriptor_cb, ddcb_data);
+	gatt_discover_char_desc(attrib, start, end, discover_descriptor_cb,
+								ddcb_data);
 }
 
 static void external_service_char_cb(GSList *chars, guint8 status,
diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index abbd129..374ae65 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -172,8 +172,8 @@ static void refresh_discovered_cb(GSList *chars, guint8 status,
 
 	scan->refresh_handle = chr->value_handle;
 
-	gatt_find_info(scan->attrib, start, end,
-				discover_descriptor_cb, user_data);
+	gatt_discover_char_desc(scan->attrib, start, end,
+					discover_descriptor_cb, user_data);
 }
 
 static void iwin_discovered_cb(GSList *chars, guint8 status,
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 8550500..7795792 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -632,7 +632,7 @@ static void discover_desc(struct thermometer *t, struct gatt_char *c,
 	ch->t = t;
 	memcpy(ch->uuid, c->uuid, sizeof(c->uuid));
 
-	gatt_find_info(t->attrib, start, end, discover_desc_cb, ch);
+	gatt_discover_char_desc(t->attrib, start, end, discover_desc_cb, ch);
 }
 
 static void read_temp_type_cb(guint8 status, const guint8 *pdu, guint16 len,
-- 
1.7.9.5


Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/12] android/scpp: Add bt_scpp_set_interval and bt_scpp_set_window
Date: Tue, 24 Jun 2014 11:36:15 +0300
Message-Id: <1403598979-31032-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1403598979-31032-1-git-send-email-luiz.dentz@gmail.com>
References: <1403598979-31032-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These functions can be used to change the current values.
---
 android/scpp.c | 43 +++++++++++++++++++++++++++++++++++++------
 android/scpp.h |  3 +++
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/android/scpp.c b/android/scpp.c
index c73a015..751d3f2 100644
--- a/android/scpp.c
+++ b/android/scpp.c
@@ -77,6 +77,9 @@ struct bt_scpp *bt_scpp_new(void *primary)
 	if (!scan)
 		return NULL;
 
+	scan->interval = SCAN_INTERVAL;
+	scan->window = SCAN_WINDOW;
+
 	if (primary)
 		scan->primary = g_memdup(primary, sizeof(*scan->primary));
 
@@ -104,12 +107,13 @@ void bt_scpp_unref(struct bt_scpp *scan)
 	scpp_free(scan);
 }
 
-static void write_scan_params(GAttrib *attrib, uint16_t handle)
+static void write_scan_params(GAttrib *attrib, uint16_t handle,
+					uint16_t interval, uint16_t window)
 {
 	uint8_t value[4];
 
-	put_le16(SCAN_INTERVAL, &value[0]);
-	put_le16(SCAN_WINDOW, &value[2]);
+	put_le16(interval, &value[0]);
+	put_le16(window, &value[2]);
 
 	gatt_write_cmd(attrib, handle, value, sizeof(value), NULL, NULL);
 }
@@ -122,7 +126,8 @@ static void refresh_value_cb(const uint8_t *pdu, uint16_t len,
 	DBG("Server requires refresh: %d", pdu[3]);
 
 	if (pdu[3] == SERVER_REQUIRES_REFRESH)
-		write_scan_params(scan->attrib, scan->iwhandle);
+		write_scan_params(scan->attrib, scan->iwhandle, scan->interval,
+								scan->window);
 }
 
 static void ccc_written_cb(guint8 status, const guint8 *pdu,
@@ -215,7 +220,8 @@ static void iwin_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 
 	DBG("Scan Interval Window handle: 0x%04x", scan->iwhandle);
 
-	write_scan_params(scan->attrib, scan->iwhandle);
+	write_scan_params(scan->attrib, scan->iwhandle, scan->interval,
+								scan->window);
 }
 
 bool bt_scpp_attach(struct bt_scpp *scan, void *attrib)
@@ -228,7 +234,8 @@ bool bt_scpp_attach(struct bt_scpp *scan, void *attrib)
 	scan->attrib = g_attrib_ref(attrib);
 
 	if (scan->iwhandle) {
-		write_scan_params(scan->attrib, scan->iwhandle);
+		write_scan_params(scan->attrib, scan->iwhandle, scan->interval,
+								scan->window);
 		return true;
 	}
 
@@ -254,3 +261,27 @@ void bt_scpp_detach(struct bt_scpp *scan)
 	g_attrib_unref(scan->attrib);
 	scan->attrib = NULL;
 }
+
+bool bt_scpp_set_interval(struct bt_scpp *scan, uint16_t value)
+{
+	if (!scan)
+		return false;
+
+	/* TODO: Check valid range */
+
+	scan->interval = value;
+
+	return true;
+}
+
+bool bt_scpp_set_window(struct bt_scpp *scan, uint16_t value)
+{
+	if (!scan)
+		return false;
+
+	/* TODO: Check valid range */
+
+	scan->window = value;
+
+	return true;
+}
diff --git a/android/scpp.h b/android/scpp.h
index f374cee..048fb9f 100644
--- a/android/scpp.h
+++ b/android/scpp.h
@@ -30,3 +30,6 @@ void bt_scpp_unref(struct bt_scpp *scan);
 
 bool bt_scpp_attach(struct bt_scpp *scan, void *gatt);
 void bt_scpp_detach(struct bt_scpp *scan);
+
+bool bt_scpp_set_interval(struct bt_scpp *scan, uint16_t value);
+bool bt_scpp_set_window(struct bt_scpp *scan, uint16_t value);
-- 
1.9.3


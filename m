Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 7/8] scan: Write parameters when requested
Date: Wed, 22 Aug 2012 16:45:22 -0300
Message-Id: <1345664723-30814-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345664723-30814-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345664723-30814-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the update procedure of the scan parameters
when the Scan Server requests. The Scan Refresh characteristic is
used to inform the Scan Client(BlueZ) that the Scan Server requires
the most recent scan settings.
---
 profiles/scanparam/scan.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 36e21f3..f292eb1 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -43,6 +43,7 @@
 
 #define SCAN_INTERVAL		0x0060
 #define SCAN_WINDOW		0x0030
+#define SERVER_REQUIRES_REFRESH	0x00
 
 struct scan {
 	struct btd_device *device;
@@ -51,6 +52,7 @@ struct scan {
 	guint attioid;
 	uint16_t interval;
 	uint16_t window;
+	uint16_t iwhandle;
 	uint16_t refresh_handle;
 	uint16_t refresh_cb_id;
 };
@@ -65,6 +67,16 @@ static gint scan_device_cmp(gconstpointer a, gconstpointer b)
 	return (device == scan->device ? 0 : -1);
 }
 
+static void write_scan_params(GAttrib *attrib, uint16_t handle)
+{
+	uint8_t value[4];
+
+	att_put_u16(SCAN_INTERVAL, &value[0]);
+	att_put_u16(SCAN_WINDOW, &value[2]);
+
+	gatt_write_char(attrib, handle, value, sizeof(value), NULL, NULL);
+}
+
 static void refresh_value_cb(const uint8_t *pdu, uint16_t len,
 						gpointer user_data)
 {
@@ -82,6 +94,9 @@ static void refresh_value_cb(const uint8_t *pdu, uint16_t len,
 		return;
 
 	DBG("Server requires refresh: %d", pdu[3]);
+
+	if (pdu[3] == SERVER_REQUIRES_REFRESH)
+		write_scan_params(scan->attrib, scan->iwhandle);
 }
 
 static void ccc_written_cb(guint8 status, const guint8 *pdu,
@@ -171,7 +186,6 @@ static void iwin_discovered_cb(GSList *chars, guint8 status,
 {
 	struct scan *scan = user_data;
 	struct gatt_char *chr;
-	uint8_t value[4];
 
 	if (status) {
 		error("Discover Scan Interval Window: %s",
@@ -180,15 +194,11 @@ static void iwin_discovered_cb(GSList *chars, guint8 status,
 	}
 
 	chr = chars->data;
+	scan->iwhandle = chr->value_handle;
 
-	DBG("Scan Interval Window handle: 0x%04x",
-						chr->value_handle);
-
-	att_put_u16(SCAN_INTERVAL, &value[0]);
-	att_put_u16(SCAN_WINDOW, &value[2]);
+	DBG("Scan Interval Window handle: 0x%04x", scan->iwhandle);
 
-	gatt_write_char(scan->attrib, chr->value_handle, value,
-						sizeof(value), NULL, NULL);
+	write_scan_params(scan->attrib, scan->iwhandle);
 }
 
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
-- 
1.7.12


Return-Path: <cyrus@holtmann.org>
From: Rafal Garbat <rafal.garbat@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <rafal.garbat@tieto.com>
Subject: [PATCH v2 08/13] heartrate: Add notification support
Date: Mon, 13 Aug 2012 17:08:12 +0200
Message-ID: <1344870497-6929-9-git-send-email-rafal.garbat@tieto.com>
In-Reply-To: <1344870497-6929-1-git-send-email-rafal.garbat@tieto.com>
References: <1344870497-6929-1-git-send-email-rafal.garbat@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add handling notification event.

---
 profiles/heartrate/heartrate.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index d0bcd57..e88d4bc 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -42,6 +42,8 @@
 
 #define HEART_RATE_INTERFACE "org.bluez.HeartRate"
 
+#define MIN_NOTIFICATION_LEN 3  /* 1-byte opcode + 2-byte handle */
+
 #define SENSOR_LOCATION_SIZE 1
 
 struct heartrate {
@@ -49,6 +51,7 @@ struct heartrate {
 	DBusConnection		*conn; /*DBus conn*/
 	GAttrib			*attrib; /*GATT connection*/
 	guint			attioid; /*ATT watcher id*/
+	guint			attionotid; /*ATT notification watcher id*/
 	struct att_range	*svc_range; /*Heart Rate range*/
 	GSList			*chars; /*Characteristics*/
 	GSList			*watchers; /*Watchers*/
@@ -136,8 +139,10 @@ static void heartrate_destroy(gpointer user_data)
 	if (hr->attioid > 0)
 		btd_device_remove_attio_callback(hr->dev, hr->attioid);
 
-	if (hr->attrib != NULL)
+	if (hr->attrib != NULL) {
+		g_attrib_unregister(hr->attrib, hr->attionotid);
 		g_attrib_unref(hr->attrib);
+	}
 
 	if (hr->watchers != NULL)
 		g_slist_free_full(hr->watchers, watcher_remove);
@@ -388,6 +393,14 @@ static void configure_heartrate_cb(GSList *characteristics, guint8 status,
 	}
 }
 
+static void notify_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
+{
+	if (len < MIN_NOTIFICATION_LEN) {
+		error("Bad pdu received");
+		return;
+	}
+}
+
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct heartrate *hr = user_data;
@@ -396,6 +409,9 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 
 	hr->attrib = g_attrib_ref(attrib);
 
+	hr->attionotid = g_attrib_register(hr->attrib,
+			ATT_OP_HANDLE_NOTIFY, notify_handler, hr , NULL);
+
 	if (hr->chars == NULL)
 		gatt_discover_char(hr->attrib, hr->svc_range->start,
 						hr->svc_range->end, NULL,
@@ -408,6 +424,8 @@ static void attio_disconnected_cb(gpointer user_data)
 
 	DBG("GATT Disconnected");
 
+	g_attrib_unregister(hr->attrib, hr->attionotid);
+	hr->attionotid = 0;
 	g_attrib_unref(hr->attrib);
 	hr->attrib = NULL;
 }
-- 
1.7.9.5


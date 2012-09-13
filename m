Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v4 12/17] heartrate: Handle characteristics value changed notification
Date: Thu, 13 Sep 2012 14:13:16 +0200
Message-ID: <1347538401-6417-13-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1347538401-6417-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1347538401-6417-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds stub for handling characteristics value changed notification.

Change-Id: Ic975d16327cfa32361fa590195b1d2b58fe5da03
---
 profiles/heartrate/heartrate.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index a0e0113..dec09d0 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -43,6 +43,8 @@
 
 #define HEART_RATE_MANAGER_IFACE "org.bluez.HeartRateManager"
 
+#define MIN_NOTIFICATION_LEN 3  /* 1-byte opcode + 2-byte handle */
+
 #define SENSOR_LOCATION_SIZE 1
 
 struct heartrate_adapter {
@@ -56,6 +58,7 @@ struct heartrate_device {
 	struct heartrate_adapter	*hr;
 	GAttrib				*attrib;
 	guint				attioid;
+	guint				attionotid;
 	struct att_range		*svc_range;
 	GSList				*chars;
 	gboolean			has_location;
@@ -178,8 +181,10 @@ static void destroy_heartrate_device(gpointer user_data)
 	if (hrdev->attioid > 0)
 		btd_device_remove_attio_callback(hrdev->dev, hrdev->attioid);
 
-	if (hrdev->attrib != NULL)
+	if (hrdev->attrib != NULL) {
+		g_attrib_unregister(hrdev->attrib, hrdev->attionotid);
 		g_attrib_unref(hrdev->attrib);
+	}
 
 	if (hrdev->chars != NULL)
 		g_slist_free_full(hrdev->chars, destroy_char);
@@ -551,6 +556,14 @@ static void configure_heartrate_cb(GSList *characteristics, guint8 status,
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
 	struct heartrate_device *hrdev = user_data;
@@ -559,6 +572,9 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 
 	hrdev->attrib = g_attrib_ref(attrib);
 
+	hrdev->attionotid = g_attrib_register(hrdev->attrib,
+			ATT_OP_HANDLE_NOTIFY, notify_handler, hrdev, NULL);
+
 	gatt_discover_char(hrdev->attrib, hrdev->svc_range->start,
 					hrdev->svc_range->end, NULL,
 					configure_heartrate_cb, hrdev);
@@ -570,6 +586,11 @@ static void attio_disconnected_cb(gpointer user_data)
 
 	DBG("GATT Disconnected");
 
+	if (hrdev->attionotid > 0) {
+		g_attrib_unregister(hrdev->attrib, hrdev->attionotid);
+		hrdev->attionotid = 0;
+	}
+
 	g_attrib_unref(hrdev->attrib);
 	hrdev->attrib = NULL;
 }
-- 
1.7.11.3


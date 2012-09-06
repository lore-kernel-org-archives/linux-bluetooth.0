Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 12/17] heartrate: Handle characteristics value changed notification
Date: Thu, 6 Sep 2012 13:32:46 +0200
Message-ID: <1346931171-18968-13-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1346931171-18968-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1346931171-18968-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds stub for handling characteristics value changed notification.

---
 profiles/heartrate/heartrate.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 4591e56..f78d91d 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -43,6 +43,8 @@
 
 #define HEART_RATE_MANAGER_IFACE "org.bluez.HeartRateManager"
 
+#define MIN_NOTIFICATION_LEN 3  /* 1-byte opcode + 2-byte handle */
+
 struct heartrate_adapter {
 	struct btd_adapter	*adapter;
 	GSList			*devices;
@@ -54,6 +56,7 @@ struct heartrate {
 	struct heartrate_adapter	*hra;
 	GAttrib				*attrib;
 	guint				attioid;
+	guint				attionotid;
 	struct att_range		*svc_range;
 	GSList				*chars;
 	gboolean			has_location;
@@ -176,8 +179,10 @@ static void destroy_heartrate_device(gpointer user_data)
 	if (hr->attioid > 0)
 		btd_device_remove_attio_callback(hr->dev, hr->attioid);
 
-	if (hr->attrib != NULL)
+	if (hr->attrib != NULL) {
+		g_attrib_unregister(hr->attrib, hr->attionotid);
 		g_attrib_unref(hr->attrib);
+	}
 
 	if (hr->chars != NULL)
 		g_slist_free_full(hr->chars, destroy_char);
@@ -547,6 +552,14 @@ static void configure_heartrate_cb(GSList *characteristics, guint8 status,
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
@@ -555,6 +568,9 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 
 	hr->attrib = g_attrib_ref(attrib);
 
+	hr->attionotid = g_attrib_register(hr->attrib,
+			ATT_OP_HANDLE_NOTIFY, notify_handler, hr, NULL);
+
 	gatt_discover_char(hr->attrib, hr->svc_range->start,
 					hr->svc_range->end, NULL,
 					configure_heartrate_cb, hr);
@@ -566,6 +582,11 @@ static void attio_disconnected_cb(gpointer user_data)
 
 	DBG("GATT Disconnected");
 
+	if (hr->attionotid > 0) {
+		g_attrib_unregister(hr->attrib, hr->attionotid);
+		hr->attionotid = 0;
+	}
+
 	g_attrib_unref(hr->attrib);
 	hr->attrib = NULL;
 }
-- 
1.7.11.3


Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Rafal Garbat <rafal.garbat@tieto.com>
Subject: [PATCH v7 06/13] heartrate: Read Body Sensor Location characteristics
Date: Fri, 21 Sep 2012 17:16:03 +0200
Message-ID: <1348240570-7532-7-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348240570-7532-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348240570-7532-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Rafal Garbat <rafal.garbat@tieto.com>

This patch adds support to read and store Body Sensor Location
characteristic value.
---
 profiles/heartrate/heartrate.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index d3d6d43..2547f9b 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -54,6 +54,9 @@ struct heartrate {
 	uint16_t			measurement_val_handle;
 	uint16_t			measurement_ccc_handle;
 	uint16_t			hrcp_val_handle;
+
+	gboolean			has_location;
+	uint8_t				location;
 };
 
 static GSList *heartrate_adapters = NULL;
@@ -113,6 +116,34 @@ static void destroy_heartrate_adapter(gpointer user_data)
 	g_free(hradapter);
 }
 
+static void read_sensor_location_cb(guint8 status, const guint8 *pdu,
+						guint16 len, gpointer user_data)
+{
+	struct heartrate *hr = user_data;
+	uint8_t value;
+	ssize_t vlen;
+
+	if (status != 0) {
+		error("Body Sensor Location read failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	vlen = dec_read_resp(pdu, len, &value, sizeof(value));
+	if (vlen < 0) {
+		error("Protocol error");
+		return;
+	}
+
+	if (vlen != sizeof(value)) {
+		error("Invalid length for Body Sensor Location");
+		return;
+	}
+
+	hr->has_location = TRUE;
+	hr->location = value;
+}
+
 static void discover_ccc_cb(guint8 status, const guint8 *pdu,
 						guint16 len, gpointer user_data)
 {
@@ -194,7 +225,9 @@ static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 			discover_measurement_ccc(hr, c, c_next);
 		} else if (g_strcmp0(c->uuid, BODY_SENSOR_LOCATION_UUID) == 0) {
 			DBG("Body Sensor Location supported");
-			/* TODO: read characterictic value */
+
+			gatt_read_char(hr->attrib, c->value_handle, 0,
+						read_sensor_location_cb, hr);
 		} else if (g_strcmp0(c->uuid,
 					HEART_RATE_CONTROL_POINT_UUID) == 0) {
 			DBG("Heart Rate Control Point supported");
-- 
1.7.11.3


Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [RFC 05/18] cyclingspeed: Read CSC Feature characteristic value
Date: Thu, 25 Oct 2012 16:43:35 +0200
Message-ID: <1351176228-5789-6-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/cyclingspeed/cyclingspeed.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 0191f1b..fa97911 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -54,6 +54,8 @@ struct csc {
 
 	uint16_t		measurement_ccc_handle;
 	uint16_t		controlpoint_val_handle;
+
+	uint16_t		feature;
 };
 
 struct characteristic {
@@ -117,6 +119,32 @@ static void destroy_csc(gpointer user_data)
 	g_free(csc);
 }
 
+static void read_feature_cb(guint8 status, const guint8 *pdu,
+						guint16 len, gpointer user_data)
+{
+	struct csc *csc = user_data;
+	uint8_t value[2];
+	ssize_t vlen;
+
+	if (status) {
+		error("CSC Feature read failed: %s", att_ecode2str(status));
+		return;
+	}
+
+	vlen = dec_read_resp(pdu, len, value, sizeof(value));
+	if (vlen < 0) {
+		error("Protocol error");
+		return;
+	}
+
+	if (vlen != sizeof(value)) {
+		error("Invalid value length for CSC Feature");
+		return;
+	}
+
+	csc->feature = att_get_u16(value);
+}
+
 static void discover_desc_cb(guint8 status, const guint8 *pdu,
 					guint16 len, gpointer user_data)
 {
@@ -190,6 +218,7 @@ static void discover_desc(struct csc *csc, struct gatt_char *c,
 static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 {
 	struct csc *csc = user_data;
+	uint16_t feature_val_handle = 0;
 
 	if (status) {
 		error("Discover CSCS characteristics: %s",
@@ -205,7 +234,7 @@ static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 		if (g_strcmp0(c->uuid, CSC_MEASUREMENT_UUID) == 0) {
 			discover_desc(csc, c, c_next);
 		} else if (g_strcmp0(c->uuid, CSC_FEATURE_UUID) == 0) {
-			/* TODO: read characterictic value */
+			feature_val_handle = c->value_handle;
 		} else if (g_strcmp0(c->uuid, SENSOR_LOCATION_UUID) == 0) {
 			DBG("Sensor Location supported");
 			/* TODO: read characterictic value */
@@ -215,6 +244,10 @@ static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 			discover_desc(csc, c, c_next);
 		}
 	}
+
+	if (feature_val_handle > 0)
+		gatt_read_char(csc->attrib, feature_val_handle,
+							read_feature_cb, csc);
 }
 
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
-- 
1.8.0


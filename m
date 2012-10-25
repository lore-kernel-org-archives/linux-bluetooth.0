Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [RFC 06/18] cyclingspeed: Read Sensor Location characteristic value
Date: Thu, 25 Oct 2012 16:43:36 +0200
Message-ID: <1351176228-5789-7-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/cyclingspeed/cyclingspeed.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index fa97911..67963d1 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -56,6 +56,8 @@ struct csc {
 	uint16_t		controlpoint_val_handle;
 
 	uint16_t		feature;
+	gboolean		has_location;
+	uint8_t			location;
 };
 
 struct characteristic {
@@ -145,6 +147,33 @@ static void read_feature_cb(guint8 status, const guint8 *pdu,
 	csc->feature = att_get_u16(value);
 }
 
+static void read_location_cb(guint8 status, const guint8 *pdu,
+						guint16 len, gpointer user_data)
+{
+	struct csc *csc = user_data;
+	uint8_t value;
+	ssize_t vlen;
+
+	if (status) {
+		error("Sensor Location read failed: %s", att_ecode2str(status));
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
+		error("Invalid value length for Sensor Location");
+		return;
+	}
+
+	csc->has_location = TRUE;
+	csc->location = value;
+}
+
 static void discover_desc_cb(guint8 status, const guint8 *pdu,
 					guint16 len, gpointer user_data)
 {
@@ -237,7 +266,8 @@ static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 			feature_val_handle = c->value_handle;
 		} else if (g_strcmp0(c->uuid, SENSOR_LOCATION_UUID) == 0) {
 			DBG("Sensor Location supported");
-			/* TODO: read characterictic value */
+			gatt_read_char(csc->attrib, c->value_handle,
+							read_location_cb, csc);
 		} else if (g_strcmp0(c->uuid, SC_CONTROL_POINT_UUID) == 0) {
 			DBG("SC Control Point supported");
 			csc->controlpoint_val_handle = c->value_handle;
-- 
1.8.0


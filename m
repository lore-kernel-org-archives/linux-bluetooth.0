Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v8 05/13] heartrate: Discover Heart Rate Measurement CCC
Date: Tue, 25 Sep 2012 16:27:38 +0200
Message-ID: <1348583267-16816-6-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348583267-16816-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348583267-16816-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support to discover CCC descriptor for Heart Rate
Measurement characteristic.
---
 profiles/heartrate/heartrate.c | 66 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index a6733d3..d3d6d43 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -52,6 +52,7 @@ struct heartrate {
 	struct att_range		*svc_range;	/* primary svc range */
 
 	uint16_t			measurement_val_handle;
+	uint16_t			measurement_ccc_handle;
 	uint16_t			hrcp_val_handle;
 };
 
@@ -112,6 +113,65 @@ static void destroy_heartrate_adapter(gpointer user_data)
 	g_free(hradapter);
 }
 
+static void discover_ccc_cb(guint8 status, const guint8 *pdu,
+						guint16 len, gpointer user_data)
+{
+	struct heartrate *hr = user_data;
+	struct att_data_list *list;
+	uint8_t format;
+	int i;
+
+	if (status != 0) {
+		error("Discover Heart Rate Measurement descriptors failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	list = dec_find_info_resp(pdu, len, &format);
+	if (list == NULL)
+		return;
+
+	if (format != ATT_FIND_INFO_RESP_FMT_16BIT)
+		goto done;
+
+	for (i = 0; i < list->num; i++) {
+		uint8_t *value;
+		uint16_t handle, uuid;
+
+		value = list->data[i];
+		handle = att_get_u16(value);
+		uuid = att_get_u16(value + 2);
+
+		if (uuid == GATT_CLIENT_CHARAC_CFG_UUID) {
+			hr->measurement_ccc_handle = handle;
+			break;
+		}
+	}
+
+done:
+	att_data_list_free(list);
+}
+
+static void discover_measurement_ccc(struct heartrate *hr,
+				struct gatt_char *c, struct gatt_char *c_next)
+{
+	uint16_t start, end;
+
+	start = c->value_handle + 1;
+
+	if (c_next != NULL) {
+		if (start == c_next->handle)
+			return;
+		end = c_next->handle - 1;
+	} else if (c->value_handle != hr->svc_range->end) {
+		end = hr->svc_range->end;
+	} else {
+		return;
+	}
+
+	gatt_find_info(hr->attrib, start, end, discover_ccc_cb, hr);
+}
+
 static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 {
 	struct heartrate *hr = user_data;
@@ -126,8 +186,12 @@ static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 		struct gatt_char *c = chars->data;
 
 		if (g_strcmp0(c->uuid, HEART_RATE_MEASUREMENT_UUID) == 0) {
+			struct gatt_char *c_next =
+				(chars->next ? chars->next->data : NULL);
+
 			hr->measurement_val_handle = c->value_handle;
-			/* TODO: discover CCC handle */
+
+			discover_measurement_ccc(hr, c, c_next);
 		} else if (g_strcmp0(c->uuid, BODY_SENSOR_LOCATION_UUID) == 0) {
 			DBG("Body Sensor Location supported");
 			/* TODO: read characterictic value */
-- 
1.7.11.3


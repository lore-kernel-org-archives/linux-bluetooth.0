Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Rafal Garbat <rafal.garbat@tieto.com>
Subject: [PATCH v3 10/17] heartrate: Read Body Sensor Location characteristics
Date: Thu, 6 Sep 2012 13:32:44 +0200
Message-ID: <1346931171-18968-11-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1346931171-18968-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1346931171-18968-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Rafal Garbat <rafal.garbat@tieto.com>

This patch reads and stores Body Sensor Location characteristics value.

---
 profiles/heartrate/heartrate.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 9d29ee0..150a675 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -56,6 +56,8 @@ struct heartrate {
 	guint				attioid;
 	struct att_range		*svc_range;
 	GSList				*chars;
+	gboolean			has_location;
+	uint8_t				location;
 };
 
 struct characteristic {
@@ -385,12 +387,44 @@ static const GDBusMethodTable heartrate_manager_methods[] = {
 	{ }
 };
 
+static void read_sensor_location_cb(guint8 status, const guint8 *pdu,
+						guint16 len, gpointer user_data)
+{
+	struct characteristic *ch = user_data;
+	struct heartrate *hr = ch->hr;
+	uint8_t value;
+	ssize_t vlen;
+
+	if (status != 0) {
+		error("Body Sensor Location value read failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	vlen = dec_read_resp(pdu, len, &value, sizeof(value));
+	if (vlen < 0) {
+		error("Protocol error.");
+		return;
+	}
+
+	if (vlen != 1) {
+		error("Invalid length for Body Sensor Location");
+		return;
+	}
+
+	hr->has_location = TRUE;
+	hr->location = value;
+}
+
 static void process_heartrate_char(struct characteristic *ch)
 {
-	if (g_strcmp0(ch->attr.uuid, HEART_RATE_CONTROL_POINT_UUID) == 0)
-		DBG("Heart Rate Control Point supported by client");
-	 else if (g_strcmp0(ch->attr.uuid, BODY_SENSOR_LOCATION_UUID) == 0)
+	if (g_strcmp0(ch->attr.uuid, HEART_RATE_CONTROL_POINT_UUID) == 0) {
+		DBG("Heart Rate Control Point reset supported by client");
+	} else if (g_strcmp0(ch->attr.uuid, BODY_SENSOR_LOCATION_UUID) == 0) {
 		DBG("Body Sensor Location supported by client");
+		gatt_read_char(ch->hr->attrib, ch->attr.value_handle, 0,
+						read_sensor_location_cb, ch);
+	}
 }
 
 static void process_heartrate_desc(struct descriptor *desc)
-- 
1.7.11.3


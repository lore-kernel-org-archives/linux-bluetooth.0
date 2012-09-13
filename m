Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Rafal Garbat <rafal.garbat@tieto.com>
Subject: [PATCH v4 10/17] heartrate: Read Body Sensor Location characteristics
Date: Thu, 13 Sep 2012 14:13:14 +0200
Message-ID: <1347538401-6417-11-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1347538401-6417-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1347538401-6417-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Rafal Garbat <rafal.garbat@tieto.com>

This patch reads and stores Body Sensor Location characteristics value.

Change-Id: Ia20235206869479e478bab2705d43e9a694d554a
---
 profiles/heartrate/heartrate.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 97d3c17..aaadee1 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -43,6 +43,8 @@
 
 #define HEART_RATE_MANAGER_IFACE "org.bluez.HeartRateManager"
 
+#define SENSOR_LOCATION_SIZE 1
+
 struct heartrate_adapter {
 	struct btd_adapter	*adapter;
 	GSList			*devices;
@@ -56,6 +58,8 @@ struct heartrate_device {
 	guint				attioid;
 	struct att_range		*svc_range;
 	GSList				*chars;
+	gboolean			has_location;
+	uint8_t				location;
 };
 
 struct characteristic {
@@ -386,12 +390,44 @@ static const GDBusMethodTable heartrate_manager_methods[] = {
 	{ }
 };
 
+static void read_sensor_location_cb(guint8 status, const guint8 *pdu,
+						guint16 len, gpointer user_data)
+{
+	struct characteristic *ch = user_data;
+	struct heartrate_device *hrdev = ch->hrdev;
+	uint8_t value[SENSOR_LOCATION_SIZE];
+	ssize_t vlen;
+
+	if (status != 0) {
+		error("Body Sensor Location value read failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	vlen = dec_read_resp(pdu, len, value, sizeof(value));
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
+	hrdev->has_location = TRUE;
+	hrdev->location = value[0];
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
+		gatt_read_char(ch->hrdev->attrib, ch->attr.value_handle, 0,
+						read_sensor_location_cb, ch);
+	}
 }
 
 static void process_heartrate_desc(struct descriptor *desc)
-- 
1.7.11.3


Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Rafal Garbat <rafal.garbat@tieto.com>
Subject: [PATCH v2 05/17] heartrate: Process characteristics
Date: Wed, 5 Sep 2012 15:05:36 +0200
Message-ID: <1346850348-21176-6-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1346850348-21176-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1346850348-21176-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Rafal Garbat <rafal.garbat@tieto.com>

This patch adds stub to process discovered characteristics.

---
 lib/uuid.h                     |  2 ++
 profiles/heartrate/heartrate.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 3488e66..0a9db51 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -64,6 +64,8 @@ extern "C" {
 #define SAP_UUID		"0000112D-0000-1000-8000-00805f9b34fb"
 
 #define HEART_RATE_UUID			"0000180d-0000-1000-8000-00805f9b34fb"
+#define HEART_RATE_CONTROL_POINT_UUID	"00002a39-0000-1000-8000-00805f9b34fb"
+#define BODY_SENSOR_LOCATION_UUID	"00002a38-0000-1000-8000-00805f9b34fb"
 
 #define HEALTH_THERMOMETER_UUID		"00001809-0000-1000-8000-00805f9b34fb"
 #define TEMPERATURE_MEASUREMENT_UUID	"00002a1c-0000-1000-8000-00805f9b34fb"
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index e4147cf..02a4617 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -120,6 +120,14 @@ static void destroy_heartrate_adapter(gpointer user_data)
 	g_free(hra);
 }
 
+static void process_heartrate_char(struct characteristic *ch)
+{
+	if (g_strcmp0(ch->attr.uuid, HEART_RATE_CONTROL_POINT_UUID) == 0)
+		DBG("Heart Rate Control Point supported by client");
+	 else if (g_strcmp0(ch->attr.uuid, BODY_SENSOR_LOCATION_UUID) == 0)
+		DBG("Body Sensor Location supported by client");
+}
+
 static void configure_heartrate_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
 {
@@ -144,6 +152,8 @@ static void configure_heartrate_cb(GSList *characteristics, guint8 status,
 		ch->hr = hr;
 
 		hr->chars = g_slist_append(hr->chars, ch);
+
+		process_heartrate_char(ch);
 	}
 }
 
-- 
1.7.11.3


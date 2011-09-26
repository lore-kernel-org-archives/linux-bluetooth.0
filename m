Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH RFC BlueZ 2/4] GATT Time Server: add Reference Time Update service
Date: Mon, 26 Sep 2011 17:01:35 -0400
Message-Id: <1317070897-17508-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1317070897-17508-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1317070897-17508-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 time/server.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/time/server.c b/time/server.c
index 5001874..fbe5b23 100644
--- a/time/server.c
+++ b/time/server.c
@@ -40,7 +40,10 @@
 
 /* UUIDs not yet approved by Bluetooth SIG */
 #define CURRENT_TIME_SVC_UUID		0x1805
+#define REF_TIME_UPDATE_SVC_UUID	0x1806
 
+#define TIME_UPDATE_CTRL_CHR_UUID	0x2A16
+#define TIME_UPDATE_STAT_CHR_UUID	0x2A17
 #define CT_TIME_CHR_UUID		0x2A2B
 
 static uint8_t current_time_read(struct attribute *a, gpointer user_data)
@@ -88,12 +91,54 @@ static void register_current_time_service(void)
 							ATT_CHAR_PROPER_NOTIFY,
 				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 							current_time_read,
+
+				GATT_OPT_INVALID);
+}
+
+static uint8_t time_update_control(struct attribute *a, gpointer user_data)
+{
+	DBG("handle 0x%04x", a->handle);
+
+	return 0;
+}
+
+static uint8_t time_update_status(struct attribute *a, gpointer user_data)
+{
+	uint8_t value[2];
+
+	DBG("handle 0x%04x", a->handle);
+
+	value[0] = 0x00; /* Current State: Idle */
+	value[1] = 0x00; /* Result: Successful */
+	attrib_db_update(a->handle, NULL, value, sizeof(value), NULL);
+
+	return 0;
+}
+
+static void register_reference_time_update_service(void)
+{
+	/* Reference Time Update service */
+	gatt_service_add(GATT_PRIM_SVC_UUID, REF_TIME_UPDATE_SVC_UUID,
+				/* Time Update control point */
+				GATT_OPT_CHR_UUID, TIME_UPDATE_CTRL_CHR_UUID,
+				GATT_OPT_CHR_PROPS,
+					ATT_CHAR_PROPER_WRITE_WITHOUT_RESP,
+				GATT_OPT_CHR_VALUE_CB, ATTRIB_WRITE,
+							time_update_control,
+
+				/* Time Update status */
+				GATT_OPT_CHR_UUID, TIME_UPDATE_STAT_CHR_UUID,
+				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
+				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
+							time_update_status,
+
 				GATT_OPT_INVALID);
 }
 
 int time_server_init(void)
 {
 	register_current_time_service();
+	register_reference_time_update_service();
 
 	return 0;
 }
-- 
1.7.0.4


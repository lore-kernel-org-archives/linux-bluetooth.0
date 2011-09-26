Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH RFC BlueZ 3/4] Time Server: Local Time Information characteristic
Date: Mon, 26 Sep 2011 17:01:36 -0400
Message-Id: <1317070897-17508-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1317070897-17508-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1317070897-17508-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 time/server.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/time/server.c b/time/server.c
index fbe5b23..5079f35 100644
--- a/time/server.c
+++ b/time/server.c
@@ -42,6 +42,7 @@
 #define CURRENT_TIME_SVC_UUID		0x1805
 #define REF_TIME_UPDATE_SVC_UUID	0x1806
 
+#define LOCAL_TIME_INFO_CHR_UUID	0x2A0F
 #define TIME_UPDATE_CTRL_CHR_UUID	0x2A16
 #define TIME_UPDATE_STAT_CHR_UUID	0x2A17
 #define CT_TIME_CHR_UUID		0x2A2B
@@ -81,6 +82,19 @@ static uint8_t current_time_read(struct attribute *a, gpointer user_data)
 	return 0;
 }
 
+static uint8_t local_time_info_read(struct attribute *a, gpointer user_data)
+{
+	uint8_t value[2];
+
+	DBG("a=%p", a);
+
+	value[0] = 0xff; /* DST Offset (255: unknown) */
+	value[1] = 0x80; /* Time Zone (-128: unknown) */
+	attrib_db_update(a->handle, NULL, value, sizeof(value), NULL);
+
+	return 0;
+}
+
 static void register_current_time_service(void)
 {
 	/* Current Time service */
@@ -92,6 +106,12 @@ static void register_current_time_service(void)
 				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 							current_time_read,
 
+				/* Local Time Information characteristic */
+				GATT_OPT_CHR_UUID, LOCAL_TIME_INFO_CHR_UUID,
+				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
+				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
+							local_time_info_read,
+
 				GATT_OPT_INVALID);
 }
 
-- 
1.7.0.4


Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH RFC BlueZ 03/16] Phone Alert: add Ringer Setting characteristic
Date: Mon, 26 Sep 2011 15:13:29 -0400
Message-Id: <1317064422-1654-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

---
 alert/server.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/alert/server.c b/alert/server.c
index 6d02adb..1135ca0 100644
--- a/alert/server.c
+++ b/alert/server.c
@@ -39,6 +39,7 @@
 #define PHONE_ALERT_STATUS_SVC_UUID		0x180E
 
 #define RINGER_CP_CHR_UUID		0x2A40
+#define RINGER_SETTING_CHR_UUID		0x2A41
 
 static uint8_t control_point_write(struct attribute *a, gpointer user_data)
 {
@@ -47,6 +48,13 @@ static uint8_t control_point_write(struct attribute *a, gpointer user_data)
 	return 0;
 }
 
+static uint8_t ringer_setting_read(struct attribute *a, gpointer user_data)
+{
+	DBG("a = %p", a);
+
+	return 0;
+}
+
 static void register_phone_alert_service(void)
 {
 	/* Phone Alert Status Service */
@@ -56,6 +64,12 @@ static void register_phone_alert_service(void)
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_WRITE,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_WRITE,
 			control_point_write,
+			/* Ringer Setting characteristic */
+			GATT_OPT_CHR_UUID, RINGER_SETTING_CHR_UUID,
+			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
+							ATT_CHAR_PROPER_NOTIFY,
+			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
+			ringer_setting_read,
 			GATT_OPT_INVALID);
 }
 
-- 
1.7.0.4


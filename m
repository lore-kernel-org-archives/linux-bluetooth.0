Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH RFC BlueZ 02/16] Phone Alert: add Ringer Control Point characteristic
Date: Mon, 26 Sep 2011 15:13:28 -0400
Message-Id: <1317064422-1654-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

---
 alert/server.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/alert/server.c b/alert/server.c
index a4b301d..6d02adb 100644
--- a/alert/server.c
+++ b/alert/server.c
@@ -38,10 +38,24 @@
 
 #define PHONE_ALERT_STATUS_SVC_UUID		0x180E
 
+#define RINGER_CP_CHR_UUID		0x2A40
+
+static uint8_t control_point_write(struct attribute *a, gpointer user_data)
+{
+	DBG("a = %p", a);
+
+	return 0;
+}
+
 static void register_phone_alert_service(void)
 {
 	/* Phone Alert Status Service */
 	gatt_service_add(GATT_PRIM_SVC_UUID, PHONE_ALERT_STATUS_SVC_UUID,
+			/* Ringer Control Point characteristic */
+			GATT_OPT_CHR_UUID, RINGER_CP_CHR_UUID,
+			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_WRITE,
+			GATT_OPT_CHR_VALUE_CB, ATTRIB_WRITE,
+			control_point_write,
 			GATT_OPT_INVALID);
 }
 
-- 
1.7.0.4


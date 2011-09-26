Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH RFC BlueZ 09/16] Phone Alert: add Alert Status characteristic
Date: Mon, 26 Sep 2011 15:13:35 -0400
Message-Id: <1317064422-1654-10-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

---
 alert/server.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/alert/server.c b/alert/server.c
index d5b1e7b..2466f8b 100644
--- a/alert/server.c
+++ b/alert/server.c
@@ -41,6 +41,7 @@
 
 #define PHONE_ALERT_STATUS_SVC_UUID		0x180E
 
+#define ALERT_STATUS_CHR_UUID		0x2A3F
 #define RINGER_CP_CHR_UUID		0x2A40
 #define RINGER_SETTING_CHR_UUID		0x2A41
 
@@ -178,6 +179,13 @@ static void get_silent_mode(DBusConnection *conn, void *user_data)
 	dbus_pending_call_set_notify(call, get_silent_reply, NULL, NULL);
 }
 
+static uint8_t alert_status_read(struct attribute *a, gpointer user_data)
+{
+	DBG("a = %p", a);
+
+	return 0;
+}
+
 static uint8_t ringer_setting_read(struct attribute *a, gpointer user_data)
 {
 	if (ringer_setting == 0xff) {
@@ -199,6 +207,12 @@ static void register_phone_alert_service(void)
 {
 	/* Phone Alert Status Service */
 	gatt_service_add(GATT_PRIM_SVC_UUID, PHONE_ALERT_STATUS_SVC_UUID,
+			/* Alert Status characteristic */
+			GATT_OPT_CHR_UUID, ALERT_STATUS_CHR_UUID,
+			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
+							ATT_CHAR_PROPER_NOTIFY,
+			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
+			alert_status_read,
 			/* Ringer Control Point characteristic */
 			GATT_OPT_CHR_UUID, RINGER_CP_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_WRITE,
-- 
1.7.0.4


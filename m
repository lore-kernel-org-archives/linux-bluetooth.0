Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/2] Time Profile: add Local Time Information characteristic
Date: Fri,  4 Nov 2011 11:59:28 -0400
Message-Id: <1320422368-23820-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1320422368-23820-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1320422368-23820-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an optional characteristic from the Current Time Service. From
the spec:

"The Local Time Information characteristic returns the local time
information that includes time zone and DST offset when read using the
GATT Read Characteristic Value sub-procedure."
---
 time/server.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/time/server.c b/time/server.c
index 0e2de2a..48a06c0 100644
--- a/time/server.c
+++ b/time/server.c
@@ -40,6 +40,7 @@
 
 #define CURRENT_TIME_SVC_UUID		0x1805
 
+#define LOCAL_TIME_INFO_CHR_UUID	0x2A0F
 #define CT_TIME_CHR_UUID		0x2A2B
 
 static int encode_current_time(uint8_t value[10])
@@ -88,6 +89,27 @@ static uint8_t current_time_read(struct attribute *a, gpointer user_data)
 	return 0;
 }
 
+static uint8_t local_time_info_read(struct attribute *a, gpointer user_data)
+{
+	uint8_t value[2];
+
+	DBG("a=%p", a);
+
+	tzset();
+
+	/* FIXME: POSIX "daylight" variable only indicates whether there is DST
+	 * for the local time or not. The offset is unknown. */
+	value[0] = daylight ? 0xff : 0x00;
+
+	/* Convert POSIX "timezone" (seconds West of GMT) to Time Profile
+	 * format (offset from UTC in number of 15 minutes increments). */
+	value[1] = (uint8_t) (-1 * timezone / (60 * 15));
+
+	attrib_db_update(a->handle, NULL, value, sizeof(value), NULL);
+
+	return 0;
+}
+
 static void register_current_time_service(void)
 {
 	/* Current Time service */
@@ -98,6 +120,13 @@ static void register_current_time_service(void)
 							ATT_CHAR_PROPER_NOTIFY,
 				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 							current_time_read,
+
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

